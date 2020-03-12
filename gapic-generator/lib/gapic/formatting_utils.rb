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
    @brace_detector = /\A([^`]*(`[^`]*`[^`]*)*[^`\\])?\{([\w,]+)\}(.*)\z/m
    @list_element_detector = /\A\s*(\*|\+|-|[0-9a-zA-Z]+\.)\s/

    class << self
      ##
      # Given an enumerable of lines, escape braces that look like yardoc type
      # links. Tries to be smart about handling only braces that would be
      # interpreted by yard (i.e. those that are not part of preformatted text
      # blocks).
      #
      # @param lines [Enumerable<String>]
      # @return [Enumerable<String>]
      #
      def escape_braces lines
        # This looks for braces that:
        # * Are opened and closed on the same line
        # * Are not nested
        # * Are not located between backticks
        # * Are not in a preformatted block
        #
        # To detect preformatted blocks, this tracks the "expected" base indent
        # according to Markdown. Specifically, this is the effective indent of
        # previous block, which is normally 0 except if we're in a list item.
        # Then, if a block is indented at least 4 spaces past that expected
        # indent (and as long as it remains so), those lines are considered
        # preformatted.
        in_block = nil
        base_indent = 0
        lines.map do |line|
          indent = line_indent line
          if indent.nil?
            in_block = nil
          else
            in_block, base_indent = update_indent_state in_block, base_indent, line, indent
            line = escape_line_braces line if in_block == false
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
          line = "#{m[1]}\\\\{#{m[3]}}#{m[4]}"
        end
        line
      end
    end
  end
end
