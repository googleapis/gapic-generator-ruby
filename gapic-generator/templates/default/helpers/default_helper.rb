# frozen_string_literal: true

# Copyright 2018 Google LLC
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

require "active_support/inflector"
require "gapic/formatting_utils"

module DefaultHelper
  def prepend_with input, prepend
    input
      .strip
      .each_line
      .map { |line| prepend + line }
      .map { |line| line.blank? ? "\n" : line }
      .join
  end

  def indent input, spacing
    spacing = " " * spacing unless spacing.is_a? String
    ret = prepend_with input, spacing
    # Remove trailing whitespace from each line end if present
    ret.split("\n").map(&:rstrip).join("\n")
  end

  def indent_tail input, spacing
    return input if input.lines.count < 2

    input.lines[0] + indent(input.lines[1..-1].join, spacing)
  end

  def format_number value
    Gapic::FormattingUtils.format_number value
  end

  def assert_locals *locals
    locals.each { |local| raise "missing local in template" if local.nil? }
  end
end
