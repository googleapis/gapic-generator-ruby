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
    result = Gapic::FormattingUtils.format_doc_lines nil, []
    assert_equal [], result
  end

  def test_escape_braces_no_brace_line
    result = Gapic::FormattingUtils.format_doc_lines nil, ["hello world\n"]
    assert_equal ["hello world\n"], result
  end

  def test_escape_braces_simple_brace_line
    result = Gapic::FormattingUtils.format_doc_lines nil, ["hello {ruby} world\n"]
    assert_equal ["hello \\\\{ruby} world\n"], result
  end

  def test_escape_braces_simple_brace_onechar_line
    result = Gapic::FormattingUtils.format_doc_lines nil, ["hello {r} world\n"]
    assert_equal ["hello \\\\{r} world\n"], result
  end

  def test_escape_braces_backtick_brace_line
    result = Gapic::FormattingUtils.format_doc_lines nil, ["hello `{ruby}` world\n"]
    assert_equal ["hello `{ruby}` world\n"], result
  end

  def test_escape_braces_unmatched_brace_line
    result = Gapic::FormattingUtils.format_doc_lines nil, ["hello {ruby world\n"]
    assert_equal ["hello {ruby world\n"], result
  end

  def test_escape_braces_escaped_brace_line
    result = Gapic::FormattingUtils.format_doc_lines nil, ["hello \\{ruby world}\n"]
    assert_equal ["hello \\{ruby world}\n"], result
  end

  def test_escape_braces_multiple_backtick_brace_line
    result = Gapic::FormattingUtils.format_doc_lines nil, ["hello `stuff` `{ruby}` world\n"]
    assert_equal ["hello `stuff` `{ruby}` world\n"], result
  end

  def test_escape_braces_multiple_brace_line
    result = Gapic::FormattingUtils.format_doc_lines nil, ["hello {ruby} {world} with {cheese}\n"]
    assert_equal ["hello \\\\{ruby} \\\\{world} with \\\\{cheese}\n"], result
  end

  def test_escape_braces_line_starting_with_brace
    result = Gapic::FormattingUtils.format_doc_lines nil, ["{hello} world\n"]
    assert_equal ["\\\\{hello} world\n"], result
  end

  def test_escape_braces_with_normal_blocks
    result = Gapic::FormattingUtils.format_doc_lines nil, [
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
    result = Gapic::FormattingUtils.format_doc_lines nil, [
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
    result = Gapic::FormattingUtils.format_doc_lines nil, [
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
    result = Gapic::FormattingUtils.format_doc_lines nil, [
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
    result = Gapic::FormattingUtils.format_doc_lines nil, [
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
    result = Gapic::FormattingUtils.format_doc_lines nil, [
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
    result = Gapic::FormattingUtils.format_doc_lines nil, [
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
    result = Gapic::FormattingUtils.format_doc_lines nil, [
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
    result = Gapic::FormattingUtils.format_doc_lines nil, [
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
    result = Gapic::FormattingUtils.format_doc_lines nil, [
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
    result = Gapic::FormattingUtils.format_doc_lines nil, [
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

  # the other escape method is space after the bracket: { something}
  def test_dont_escape_open_space_bracket
    result = Gapic::FormattingUtils.format_doc_lines nil, ["hello { ruby world}\n"]
    assert_equal ["hello { ruby world}\n"], result
  end

  # yard will fail these separators unescaped whether the first word is capitalized or not
  def test_escape_braces_separators
    separators = ["-", "|", "%", "$", "^", "~", "*", ":"]

    separators.each do |separator|
      result = Gapic::FormattingUtils.format_doc_lines nil, ["hello {ruby#{separator}world}\n"]
      assert_equal ["hello \\\\{ruby#{separator}world}\n"], result
    end
  end

  # yard will fail these separators unescaped but only if the first word in the sequence is capitalized
  # e.g. {Ruby::world} will fail but {ruby::world} will not (at the current version)
  def test_escape_braces_separators_capitalized
    separators = ["#", "::"]

    separators.each do |separator|
      result = Gapic::FormattingUtils.format_doc_lines nil, ["hello {Ruby#{separator}world}\n"]
      assert_equal ["hello \\\\{Ruby#{separator}world}\n"], result
    end
  end

  def test_escape_braces_yardexample_object
    result = Gapic::FormattingUtils.format_doc_lines nil, ["hello {ObjectName#method OPTIONAL_TITLE}\n"]
    assert_equal ["hello \\\\{ObjectName#method OPTIONAL_TITLE}\n"], result
  end

  def test_escape_braces_yardexample_class
    result = Gapic::FormattingUtils.format_doc_lines nil, ["hello {Class::CONSTANT My constant's title}\n"]
    assert_equal ["hello \\\\{Class::CONSTANT My constant's title}\n"], result
  end
  
  def test_escape_braces_yardexample_method
    result = Gapic::FormattingUtils.format_doc_lines nil, ["hello {#method_inside_current_namespace}\n"]
    assert_equal ["hello \\\\{#method_inside_current_namespace}\n"], result
  end

  def test_xref_message
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example" do
        api.add_message! "Earth"
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [World][google.cloud.example.Earth]!\n"]
    assert_equal ["Hello, {Google::Cloud::Example::Earth World}!\n"], result
  end

  def test_xref_message_with_ruby_package
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example", "Google::Cloud::MyExample" do
        api.add_message! "Earth"
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [World][google.cloud.example.Earth]!\n"]
    assert_equal ["Hello, {Google::Cloud::MyExample::Earth World}!\n"], result
  end

  def test_xref_multiple_messages
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example" do
        api.add_message! "Earth"
        api.add_message! "Ruby"
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api,
      ["Hello, [Ruby][google.cloud.example.Ruby] [World][google.cloud.example.Earth]!\n"]
    assert_equal ["Hello, {Google::Cloud::Example::Ruby Ruby} {Google::Cloud::Example::Earth World}!\n"], result
  end

  def test_xref_nested_message
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example" do
        api.add_message! "Earth" do
          api.add_message! "Continent"
        end
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [World][google.cloud.example.Earth.Continent]!\n"]
    assert_equal ["Hello, {Google::Cloud::Example::Earth::Continent World}!\n"], result
  end

  def test_xref_field
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example" do
        api.add_message! "Earth" do
          api.add_field! "population"
        end
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [World][google.cloud.example.Earth.population]!\n"]
    assert_equal ["Hello, {Google::Cloud::Example::Earth#population World}!\n"], result
  end

  def test_xref_enum
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example" do
        api.add_enum! "CloudProvider" do
          api.add_value! "GOOGLE_CLOUD_PLATFORM"
        end
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [GCP][google.cloud.example.CloudProvider]!\n"]
    assert_equal ["Hello, {Google::Cloud::Example::CloudProvider GCP}!\n"], result
  end

  def test_xref_enum_value
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example" do
        api.add_enum! "CloudProvider" do
          api.add_value! "GOOGLE_CLOUD_PLATFORM"
        end
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [GCP][google.cloud.example.CloudProvider.GOOGLE_CLOUD_PLATFORM]!\n"]
    assert_equal ["Hello, {Google::Cloud::Example::CloudProvider::GOOGLE_CLOUD_PLATFORM GCP}!\n"], result
  end

  def test_xref_proto_not_found
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example" do
        api.add_message! "Earth"
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [Ruby][google.cloud.example.Ruby]!\n"]
    assert_equal ["Hello, [Ruby][google.cloud.example.Ruby]!\n"], result
  end

  def test_xref_service
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example" do
        api.add_service! "Earth"
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [World][google.cloud.example.Earth]!\n"]
    assert_equal ["Hello, {Google::Cloud::Example::Earth::Client World}!\n"], result
  end

  def test_xref_with_method
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example" do
        api.add_service! "Earth" do
          api.add_method! "get_name"
        end
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [World][google.cloud.example.Earth.get_name]!\n"]
    assert_equal ["Hello, {Google::Cloud::Example::Earth::Client#get_name World}!\n"], result
  end

  def test_xref_operations_service
    api = FakeApi.new do |api|
      api.add_file! "google.longrunning" do
        api.add_service! "Operations"
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [World][google.longrunning.Operations]!\n"]
    assert_equal ["Hello, World!\n"], result
  end

  def test_xref_operations_method
    api = FakeApi.new do |api|
      api.add_file! "google.longrunning" do
        api.add_service! "Operations" do
          api.add_method! "get_operation"
        end
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [World][google.longrunning.Operations.get_operation]!\n"]
    assert_equal ["Hello, World!\n"], result
  end

  def test_xref_text_characters
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example" do
        api.add_message! "Earth"
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [`One` and two-three][google.cloud.example.Earth]!\n"]
    assert_equal ["Hello, {Google::Cloud::Example::Earth `One` and two-three}!\n"], result
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
