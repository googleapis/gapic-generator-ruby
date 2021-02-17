# frozen_string_literal: true

# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "bigdecimal"

module Gapic
  ##
  # Various string formatting utils
  #
  module FormattingUtils
    @brace_detector = /\A(?<pre>[^`]*(`[^`]*`[^`]*)*[^`\\])?\{(?<inside>[^\s][^}]*)\}(?<post>.*)\z/m
    @xref_detector = /\A(?<pre>[^`]*(`[^`]*`[^`]*)*)?\[(?<text>[\w\. `-]+)\]\[(?<addr>[\w\.]+)\](?<post>.*)\z/m
    @list_element_detector = /\A\s*(\*|\+|-|[0-9a-zA-Z]+\.)\s/
    @omit_lines = ["@InputOnly\n", "@OutputOnly\n"]

    class << self
      ##
      # Given an enumerable of lines, performs yardoc formatting, including:
      # * Interpreting cross-references identified as described in AIP 192
      # * Escaping literal braces that look like yardoc type links
      #
      # Tries to be smart about exempting preformatted text blocks.
      #
      # @param api [Gapic::Schema::Api]
      # @param lines [Enumerable<String>]
      # @param disable_xrefs [Boolean] (default is `false`) Disable linking to
      #   cross-references, and render them simply as text. This can be used if
      #   it is known that the targets are not present in the current library.
      # @return [Enumerable<String>]
      #
      def format_doc_lines api, lines, disable_xrefs: false
        # To detect preformatted blocks, this tracks the "expected" base indent
        # according to Markdown. Specifically, this is the effective indent of
        # previous block, which is normally 0 except if we're in a list item.
        # Then, if a block is indented at least 4 spaces past that expected
        # indent (and as long as it remains so), those lines are considered
        # preformatted.
        in_block = nil
        base_indent = 0
        (lines - @omit_lines).map do |line|
          indent = line_indent line
          if indent.nil?
            in_block = nil
          else
            in_block, base_indent = update_indent_state in_block, base_indent, line, indent
            if in_block == false
              line = escape_line_braces line
              line = format_line_xrefs api, line, disable_xrefs
            end
          end
          line
        end
      end

      ##
      # Given a number, format it in such a way that Rubocop will be happy.
      # Specifically, we add underscores if the magnitude is at least 10_000.
      # This works for both integers and floats.
      #
      # @param value [Numeric]
      # @return [String]
      #
      def format_number value
        return value.to_s if value.abs < 10_000
        str = value.is_a?(Integer) ? value.to_s : BigDecimal(value.to_f.to_s).to_s("F")
        re = /^(-?\d+)(\d\d\d)([_\.][_\.\d]+)?$/
        while (m = re.match str)
          str = "#{m[1]}_#{m[2]}#{m[3]}"
        end
        str
      end

      private

      def update_indent_state in_block, base_indent, line, indent
        if in_block != true && @list_element_detector =~ line
          in_block = false
          indent = base_indent if indent > base_indent
          base_indent = (indent + 7) / 4 * 4
        else
          in_block = indent >= base_indent + 4 unless in_block == false
          base_indent = indent / 4 * 4 if in_block == false && indent < base_indent
        end
        [in_block, base_indent]
      end

      def line_indent line
        m = /^( *)\S/.match line
        m.nil? ? nil : m[1].length
      end

      def escape_line_braces line
        while (m = @brace_detector.match line)
          line = "#{m[:pre]}\\\\{#{m[:inside]}}#{m[:post]}"
        end
        line
      end

      def format_line_xrefs api, line, disable_xrefs
        while (m = @xref_detector.match line)
          entity = api.lookup m[:addr]
          return line if entity.nil?
          text = m[:text]
          yard_link = disable_xrefs ? text : yard_link_for_entity(entity, text)
          return line if yard_link.nil?
          line = "#{m[:pre]}#{yard_link}#{m[:post]}"
        end
        line
      end

      ##
      # Generate a YARD-style cross-reference for the given entity.
      #
      # @param entity [Gapic::Schema::Proto] the entity to link to
      # @param text [String] the text for the link
      # @return [String] YARD cross-reference syntax
      #
      def yard_link_for_entity entity, text
        # As a special case, omit the service "google.longrunning.Operations"
        # and its methods. This is because the generator creates
        # service-specific copies of the operations client, rather than a
        # Google::Longrunning::Operations::Client class, and there is in
        # general no way to tell what the actual service-specific namespace is.
        return text if entity.address[0, 3] == ["google", "longrunning", "Operations"]

        case entity
        when Gapic::Schema::Service
          "{::#{convert_address_to_ruby entity}::Client #{text}}"
        when Gapic::Schema::Method
          "{::#{convert_address_to_ruby entity.parent}::Client##{entity.name.underscore} #{text}}"
        when Gapic::Schema::Message, Gapic::Schema::Enum
          "{::#{convert_address_to_ruby entity} #{text}}"
        when Gapic::Schema::EnumValue
          "{::#{convert_address_to_ruby entity.parent}::#{entity.name} #{text}}"
        when Gapic::Schema::Field
          "{::#{convert_address_to_ruby entity.parent}##{entity.name} #{text}}"
        end
      end

      def convert_address_to_ruby entity
        file = entity.containing_file
        api = file.containing_api
        address = entity.address
        address = address.join "." if address.is_a? Array
        address = address.sub file.package, file.ruby_package if file.ruby_package&.present?
        address.split(/\.|::/).reject(&:empty?).map(&:camelize).map { |node| api.fix_namespace node }.join("::")
      end
    end
  end
end
