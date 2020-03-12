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

require "test_helper"
require "gapic/formatting_utils"

class FormattingUtilsTest < Minitest::Test
  def test_escape_braces_empty
    result = Gapic::FormattingUtils.escape_braces []
    assert_equal [], result
  end

  def test_escape_braces_no_brace_line
    result = Gapic::FormattingUtils.escape_braces ["hello world\n"]
    assert_equal ["hello world\n"], result
  end

  def test_escape_braces_simple_brace_line
    result = Gapic::FormattingUtils.escape_braces ["hello {ruby} world\n"]
    assert_equal ["hello \\\\{ruby} world\n"], result
  end

  def test_escape_braces_backtick_brace_line
    result = Gapic::FormattingUtils.escape_braces ["hello `{ruby}` world\n"]
    assert_equal ["hello `{ruby}` world\n"], result
  end

  def test_escape_braces_unmatched_brace_line
    result = Gapic::FormattingUtils.escape_braces ["hello {ruby world\n"]
    assert_equal ["hello {ruby world\n"], result
  end

  def test_escape_braces_escaped_brace_line
    result = Gapic::FormattingUtils.escape_braces ["hello \\{ruby world}\n"]
    assert_equal ["hello \\{ruby world}\n"], result
  end

  def test_escape_braces_multiple_backtick_brace_line
    result = Gapic::FormattingUtils.escape_braces ["hello `stuff` `{ruby}` world\n"]
    assert_equal ["hello `stuff` `{ruby}` world\n"], result
  end

  def test_escape_braces_multiple_brace_line
    result = Gapic::FormattingUtils.escape_braces ["hello {ruby} {world} with {cheese}\n"]
    assert_equal ["hello \\\\{ruby} \\\\{world} with \\\\{cheese}\n"], result
  end

  def test_escape_braces_line_starting_with_brace
    result = Gapic::FormattingUtils.escape_braces ["{hello} world\n"]
    assert_equal ["\\\\{hello} world\n"], result
  end

  def test_escape_braces_with_normal_blocks
    result = Gapic::FormattingUtils.escape_braces [
      "hello {ruby}\n",
      "     hello {world}\n",
      "this {works}\n"
    ]
    assert_equal [
      "hello \\\\{ruby}\n",
      "     hello \\\\{world}\n",
      "this \\\\{works}\n"
    ], result
  end

  def test_escape_braces_with_pre_and_normal_blocks
    result = Gapic::FormattingUtils.escape_braces [
      "hello {ruby}\n",
      "\n",
      "    hello {world}\n",
      " this {works}\n"
    ]
    assert_equal [
      "hello \\\\{ruby}\n",
      "\n",
      "    hello {world}\n",
      " this \\\\{works}\n"
    ], result
  end

  def test_escape_braces_with_list_block
    result = Gapic::FormattingUtils.escape_braces [
      "* hello {ruby}\n",
      "\n",
      "    hello {ruby3}\n"
    ]
    assert_equal [
      "* hello \\\\{ruby}\n",
      "\n",
      "    hello \\\\{ruby3}\n"
    ], result
  end

  def test_escape_braces_with_list_and_pre_block
    result = Gapic::FormattingUtils.escape_braces [
      "* hello {ruby}\n",
      "\n",
      "        hello {ruby3}\n"
    ]
    assert_equal [
      "* hello \\\\{ruby}\n",
      "\n",
      "        hello {ruby3}\n"
    ], result
  end

  def test_escape_braces_with_indented_list_block
    result = Gapic::FormattingUtils.escape_braces [
      " * hello {ruby}\n",
      "\n",
      "       hello {ruby3}\n"
    ]
    assert_equal [
      " * hello \\\\{ruby}\n",
      "\n",
      "       hello \\\\{ruby3}\n"
    ], result
  end

  def test_escape_braces_with_indented_list_and_pre_block
    result = Gapic::FormattingUtils.escape_braces [
      " * hello {ruby}\n",
      "\n",
      "        hello {ruby3}\n"
    ]
    assert_equal [
      " * hello \\\\{ruby}\n",
      "\n",
      "        hello {ruby3}\n"
    ], result
  end

  def test_escape_braces_with_nested_list_blocks
    result = Gapic::FormattingUtils.escape_braces [
      "* hello {ruby}\n",
      " * hello {ruby2}\n",
      "\n",
      "        hello {ruby3}\n"
    ]
    assert_equal [
      "* hello \\\\{ruby}\n",
      " * hello \\\\{ruby2}\n",
      "\n",
      "        hello \\\\{ruby3}\n"
    ], result
  end

  def test_escape_braces_with_nested_list_and_pre_blocks
    result = Gapic::FormattingUtils.escape_braces [
      "* hello {ruby}\n",
      " * hello {ruby2}\n",
      "\n",
      "            hello {ruby3}\n"
    ]
    assert_equal [
      "* hello \\\\{ruby}\n",
      " * hello \\\\{ruby2}\n",
      "\n",
      "            hello {ruby3}\n"
    ], result
  end

  def test_escape_braces_with_plus_list_block
    result = Gapic::FormattingUtils.escape_braces [
      "+ hello {ruby}\n",
      "\n",
      "    hello {ruby3}\n"
    ]
    assert_equal [
      "+ hello \\\\{ruby}\n",
      "\n",
      "    hello \\\\{ruby3}\n"
    ], result
  end

  def test_escape_braces_with_minus_list_block
    result = Gapic::FormattingUtils.escape_braces [
      "- hello {ruby}\n",
      "\n",
      "    hello {ruby3}\n"
    ]
    assert_equal [
      "- hello \\\\{ruby}\n",
      "\n",
      "    hello \\\\{ruby3}\n"
    ], result
  end

  def test_escape_braces_with_ordered_list_block
    result = Gapic::FormattingUtils.escape_braces [
      "12. hello {ruby}\n",
      "\n",
      "    hello {ruby3}\n"
    ]
    assert_equal [
      "12. hello \\\\{ruby}\n",
      "\n",
      "    hello \\\\{ruby3}\n"
    ], result
  end

  def test_format_number_small_integer
    str = Gapic::FormattingUtils.format_number 1
    assert_equal "1", str
  end

  def test_format_number_4digit_integer
    str = Gapic::FormattingUtils.format_number 1234
    assert_equal "1234", str
  end

  def test_format_number_5digit_integer
    str = Gapic::FormattingUtils.format_number 12_345
    assert_equal "12_345", str
  end

  def test_format_number_7digit_integer
    str = Gapic::FormattingUtils.format_number 1_234_567
    assert_equal "1_234_567", str
  end

  def test_format_number_negative_4digit_integer
    str = Gapic::FormattingUtils.format_number(-1234)
    assert_equal "-1234", str
  end

  def test_format_number_negative_5digit_integer
    str = Gapic::FormattingUtils.format_number(-12_345)
    assert_equal "-12_345", str
  end

  def test_format_number_negative_7digit_integer
    str = Gapic::FormattingUtils.format_number(-1_234_567)
    assert_equal "-1_234_567", str
  end

  def test_format_number_small_float
    str = Gapic::FormattingUtils.format_number 1.2345
    assert_equal "1.2345", str
  end

  def test_format_number_negative_small_float
    str = Gapic::FormattingUtils.format_number(-1.2345)
    assert_equal "-1.2345", str
  end

  def test_format_number_tiny_float
    str = Gapic::FormattingUtils.format_number 0.000123
    assert_equal "0.000123", str
  end

  def test_format_number_large_float
    str = Gapic::FormattingUtils.format_number 1_234_567.89
    assert_equal "1_234_567.89", str
  end

  def test_format_number_negative_large_float
    str = Gapic::FormattingUtils.format_number(-1_234_567.89)
    assert_equal "-1_234_567.89", str
  end
end
