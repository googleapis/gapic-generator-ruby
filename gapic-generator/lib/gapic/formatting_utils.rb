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
    @xref_detector = /\A(?<pre>[^`]*(?:`[^`]*`[^`]*)*)?\[(?<text>[\w. `-]+)\]\[(?<addr>[\w.]+)\](?<post>.*)\z/m
    @list_element_detector = /\A\s*(?:\*|\+|-|[0-9a-zA-Z]+\.)\s/
    @omit_lines = ["@InputOnly\n", "@OutputOnly\n"]
    # Built-in YARD meta-data tags as documented in:
    # https://rubydoc.info/gems/yard/file/docs/Tags.md#Tag_List
    @known_yard_tags = [
      "abstract", "api", "attr", "attr_reader", "attr_writer", "author", "deprecated", "example",
      "note", "option", "overload", "param", "private", "raise", "return", "see", "since", "todo",
      "version", "yield", "yieldparam", "yieldreturn"
    ].freeze

    class << self
      ##
      # Given an enumerable of lines, performs yardoc formatting, including:
      # * Interpreting cross-references identified as described in AIP 192
      # * Escaping literal braces that look like yardoc type links
      # * Backticking unknown doc tags so they are not parsed as YARD tags
      #
      # Tries to be smart about exempting preformatted text blocks.
      #
      # @param api [Gapic::Schema::Api]
      # @param lines [Enumerable<String>]
      # @param disable_xrefs [Boolean] (default is `false`) Disable linking to
      #   cross-references, and render them simply as text. This can be used if
      #   it is known that the targets are not present in the current library.
      # @param transport [:grpc,:rest] Whether xref links should go to REST or
      #   gRPC client classes. Uses the default transport if not provided.
      # @return [Enumerable<String>]
      #
      def format_doc_lines api, lines, disable_xrefs: false, transport: nil
        transport ||= api&.default_transport || :grpc
        # Tracks fenced blocks, multiline inline code spans, and indented code blocks.
        in_fence = false
        in_code_span = false
        in_block = nil
        base_indent = 0
        (lines - @omit_lines).map do |line|
          if line =~ /^\s*(?:```|~~~)/
            in_fence = !in_fence
            in_code_span = false
            in_block = nil
          elsif !in_fence
            indent = line_indent line
            if indent.nil?
              in_block = nil
              in_code_span = false
            else
              in_block, base_indent = update_indent_state in_block, base_indent, line, indent
              if in_block == false
                line, in_code_span = format_line_content line, in_code_span
                line = format_line_xrefs api, line, disable_xrefs, transport
              end
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
        re = /^(-?\d+)(\d\d\d)([_.][_.\d]+)?$/
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
        return nil unless m
        m[1].length
      end

      def format_line_content line, in_code_span
        parts = line.split("`", -1)
        formatted_parts = parts.each_with_index.map do |part, idx|
          if in_code_span
            in_code_span = false if idx < parts.length - 1
            part
          else
            is_followed_by_backtick = idx < parts.length - 1
            in_code_span = true if is_followed_by_backtick
            formatted = escape_prose_braces part, is_followed_by_backtick: is_followed_by_backtick
            sanitize_prose_tags formatted
          end
        end
        [formatted_parts.join("`"), in_code_span]
      end

      def escape_prose_braces text, is_followed_by_backtick: false
        # Matches unescaped `{` outside backtick spans followed by non-whitespace.
        # If `{` is at the end of a non-code chunk (is_followed_by_backtick: true), it is followed
        # immediately by a backticked code span (starting with a non-whitespace backtick),
        # so \z (end of string) is also matched.
        pattern = is_followed_by_backtick ? /(?<!\\)\{(?=[^\s]|\z)/ : /(?<!\\)\{(?=[^\s])/
        text.gsub(pattern) { "\\\\{" }
      end

      def sanitize_prose_tags text
        # Matches doc tags starting with `@` at the start of a line or preceded by whitespace.
        # Avoids matching `@` within email addresses (e.g. user@example.com) or quotes.
        # Any tag not in the YARD recognized list (or starting with `!`) is wrapped in backticks
        # so YARD renders it as literal text rather than an unrecognized tag directive.
        text.gsub(/(?<=\A|\s)@([a-zA-Z_]\w*)/) do |match|
          tag = Regexp.last_match 1
          @known_yard_tags.include?(tag) || tag.start_with?("!") ? match : "`#{match}`"
        end
      end

      def format_line_xrefs api, line, disable_xrefs, transport
        while (m = @xref_detector.match line)
          entity = api.lookup m[:addr]
          is_mixin_field_addr = Gapic::Model::Mixins.mixin_message_field_address?(
            m[:addr],
            gem_name: api.configuration.fetch(:gem, nil)&.fetch(:name, "")
          )
          return line if entity.nil? || is_mixin_field_addr

          text = m[:text]
          yard_link = disable_xrefs ? text : yard_link_for_entity(entity, text, transport)
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
      # @param transport [:rest,:grpc] The transport for client classes
      # @return [String] YARD cross-reference syntax
      #
      def yard_link_for_entity entity, text, transport
        # As a special case, omit the service "google.longrunning.Operations"
        # and its methods. This is because the generator creates
        # service-specific copies of the operations client, rather than a
        # Google::Longrunning::Operations::Client class, and there is in
        # general no way to tell what the actual service-specific namespace is.
        return text if entity.address[0, 3] == ["google", "longrunning", "Operations"]

        client_class = transport == :grpc ? "Client" : "Rest::Client"
        case entity
        when Gapic::Schema::Service
          "{::#{convert_address_to_ruby entity, service: true}::#{client_class} #{text}}"
        when Gapic::Schema::Method
          namespace = convert_address_to_ruby entity.parent, service: true
          method_name = entity.name.underscore
          "{::#{namespace}::#{client_class}##{method_name} #{text}}"
        when Gapic::Schema::Message, Gapic::Schema::Enum
          "{::#{convert_address_to_ruby entity} #{text}}"
        when Gapic::Schema::EnumValue
          "{::#{convert_address_to_ruby entity.parent}::#{entity.name} #{text}}"
        when Gapic::Schema::Field
          "{::#{convert_address_to_ruby entity.parent}##{entity.name} #{text}}"
        end
      end

      def convert_address_to_ruby entity, service: false
        file = entity.containing_file
        api = file.containing_api
        address = entity.address
        address = address.join "." if address.is_a? Array
        address = address.sub file.package, file.ruby_package if file.ruby_package&.present?
        address = address.split(/\.|::/).reject(&:empty?)
        last_index = address.size - 1 if service
        address.each_with_index.map do |node, index|
          node = node.camelize
          node = api.fix_service_name node if index == last_index
          api.fix_namespace node
        end.join "::"
      end
    end
  end
end
