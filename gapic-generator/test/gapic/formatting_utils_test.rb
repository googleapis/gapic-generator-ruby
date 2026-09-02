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
    assert_equal ["hello \\\\{ruby world\n"], result
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
    assert_equal ["Hello, {::Google::Cloud::Example::Earth World}!\n"], result
  end

  def test_xref_message_with_ruby_package
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example", "Google::Cloud::MyExample" do
        api.add_message! "Earth"
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [World][google.cloud.example.Earth]!\n"]
    assert_equal ["Hello, {::Google::Cloud::MyExample::Earth World}!\n"], result
  end

  def test_xref_message_with_namespace_mapping
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example" do
        api.add_service! "World"
        api.add_message! "Earth"
      end
      api.add_namespace_mapping! "Example", "RealExample"
      api.add_namespace_mapping! "World", "WorldService"
    end
    result = Gapic::FormattingUtils.format_doc_lines api,
      ["Hello, [World][google.cloud.example.World] [Earth][google.cloud.example.Earth]!\n"]
    assert_equal ["Hello, {::Google::Cloud::RealExample::WorldService::Client World} {::Google::Cloud::RealExample::Earth Earth}!\n"], result
  end

  def test_xref_message_with_service_mapping
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example" do
        api.add_service! "World"
        api.add_message! "Earth"
      end
      api.add_service_mapping! "Example", "RealExample"
      api.add_service_mapping! "World", "WorldService"
    end
    result = Gapic::FormattingUtils.format_doc_lines api,
      ["Hello, [World][google.cloud.example.World] [Earth][google.cloud.example.Earth]!\n"]
    assert_equal ["Hello, {::Google::Cloud::Example::WorldService::Client World} {::Google::Cloud::Example::Earth Earth}!\n"], result
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
    assert_equal ["Hello, {::Google::Cloud::Example::Ruby Ruby} {::Google::Cloud::Example::Earth World}!\n"], result
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
    assert_equal ["Hello, {::Google::Cloud::Example::Earth::Continent World}!\n"], result
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
    assert_equal ["Hello, {::Google::Cloud::Example::Earth#population World}!\n"], result
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
    assert_equal ["Hello, {::Google::Cloud::Example::CloudProvider GCP}!\n"], result
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
    assert_equal ["Hello, {::Google::Cloud::Example::CloudProvider::GOOGLE_CLOUD_PLATFORM GCP}!\n"], result
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
    assert_equal ["Hello, {::Google::Cloud::Example::Earth::Client World}!\n"], result
  end

  def test_disable_xref_for_service
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example" do
        api.add_service! "Earth"
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [World][google.cloud.example.Earth]!\n"], disable_xrefs: true
    assert_equal ["Hello, World!\n"], result
  end

  def test_xref_service_rest
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example" do
        api.add_service! "Earth"
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [World][google.cloud.example.Earth]!\n"], transport: :rest
    assert_equal ["Hello, {::Google::Cloud::Example::Earth::Rest::Client World}!\n"], result
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
    assert_equal ["Hello, {::Google::Cloud::Example::Earth::Client#get_name World}!\n"], result
  end

  def test_xref_with_method_rest
    api = FakeApi.new do |api|
      api.add_file! "google.cloud.example" do
        api.add_service! "Earth" do
          api.add_method! "get_name"
        end
      end
    end
    result = Gapic::FormattingUtils.format_doc_lines api, ["Hello, [World][google.cloud.example.Earth.get_name]!\n"], transport: :rest
    assert_equal ["Hello, {::Google::Cloud::Example::Earth::Rest::Client#get_name World}!\n"], result
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
    assert_equal ["Hello, {::Google::Cloud::Example::Earth `One` and two-three}!\n"], result
  end

  def test_remove_inputoutput_tags
    lines = ["hello world\n", "@InputOnly\n", "\n", "@OutputOnly\n", "ruby\n", "@InputOnly\n", "rulz\n"]
    result = Gapic::FormattingUtils.format_doc_lines nil, lines
    assert_equal ["hello world\n", "\n", "ruby\n", "rulz\n"], result
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

  def test_escape_braces_multiline_unmatched
    result = Gapic::FormattingUtils.format_doc_lines nil, [
      "Formatted as an array of inclusive ranges {min: min-value, max:\n",
      "max-value}. For example, [{min: 123, max: 123}, {min: 64512, max: 65534}]\n"
    ]
    assert_equal [
      "Formatted as an array of inclusive ranges \\\\{min: min-value, max:\n",
      "max-value}. For example, [\\\\{min: 123, max: 123}, \\\\{min: 64512, max: 65534}]\n"
    ], result
  end

  def test_escape_braces_multiline_unmatched_json
    result = Gapic::FormattingUtils.format_doc_lines nil, [
      "port number. Named ports can also contain multiple ports. " \
      "For example:[{name: \"app1\", port: 8080}, {name:\n",
      "\"app1\", port: 8081}, {name: \"app2\", port:\n",
      "8082}]\n"
    ]
    assert_equal [
      "port number. Named ports can also contain multiple ports. " \
      "For example:[\\\\{name: \"app1\", port: 8080}, \\\\{name:\n",
      "\"app1\", port: 8081}, \\\\{name: \"app2\", port:\n",
      "8082}]\n"
    ], result
  end

  def test_sanitize_unknown_tags
    result = Gapic::FormattingUtils.format_doc_lines nil, [
      "@pattern: \\d+(?:-\\d+)?\n",
      "@required compute.instancegroups.addInstances\n",
      "RFC1035 @pattern [a-z](?:[-a-z0-9]\\{0,61}[a-z0-9])?\n"
    ]
    assert_equal [
      "`@pattern`: \\d+(?:-\\d+)?\n",
      "`@required` compute.instancegroups.addInstances\n",
      "RFC1035 `@pattern` [a-z](?:[-a-z0-9]\\{0,61}[a-z0-9])?\n"
    ], result
  end

  def test_dont_sanitize_known_yard_tags
    result = Gapic::FormattingUtils.format_doc_lines nil, [
      "@param foo [String]\n",
      "@return [Integer]\n",
      "@deprecated Do not use\n",
      "@see http://example.com\n",
      "@attr [String] name description\n",
      "@attr_reader [String] name description\n",
      "@attr_writer [String] name description\n",
      "@!attribute [rw] foo\n"
    ]
    assert_equal [
      "@param foo [String]\n",
      "@return [Integer]\n",
      "@deprecated Do not use\n",
      "@see http://example.com\n",
      "@attr [String] name description\n",
      "@attr_reader [String] name description\n",
      "@attr_writer [String] name description\n",
      "@!attribute [rw] foo\n"
    ], result
  end

  def test_dont_sanitize_email_addresses
    result = Gapic::FormattingUtils.format_doc_lines nil, [
      "Contact support@example.com for help\n"
    ]
    assert_equal [
      "Contact support@example.com for help\n"
    ], result
  end

  def test_dont_sanitize_already_backticked_tags
    result = Gapic::FormattingUtils.format_doc_lines nil, [
      "Use `@pattern` to specify format\n"
    ]
    assert_equal [
      "Use `@pattern` to specify format\n"
    ], result
  end

  def test_escape_braces_followed_by_backtick
    result = Gapic::FormattingUtils.format_doc_lines nil, [
      "must be one of {`training`, `validation`, `test`}, and it defines\n"
    ]
    assert_equal [
      "must be one of \\\\{`training`, `validation`, `test`}, and it defines\n"
    ], result
  end

  def test_fenced_code_block_preserves_braces_and_tags
    lines = [
      "For example, the following JSON creates a divider:\n",
      "\n",
      "```\n",
      "\"divider\": {}\n",
      "Hello @FooBot how are you!\n",
      "```\n",
      "\n",
      "Choose from {100, 200, 300}.\n"
    ]
    result = Gapic::FormattingUtils.format_doc_lines nil, lines
    assert_equal [
      "For example, the following JSON creates a divider:\n",
      "\n",
      "```\n",
      "\"divider\": {}\n",
      "Hello @FooBot how are you!\n",
      "```\n",
      "\n",
      "Choose from \\\\{100, 200, 300}.\n"
    ], result
  end

  def test_fenced_code_block_with_language_tag
    lines = [
      "Example with language:\n",
      "```json\n",
      "{\"name\": \"app\", \"ports\": [{8080}]}\n",
      "```\n"
    ]
    result = Gapic::FormattingUtils.format_doc_lines nil, lines
    assert_equal lines, result
  end

  def test_fenced_code_block_with_tilde
    lines = [
      "Example with tilde:\n",
      "~~~\n",
      "{\"name\": \"app\", \"ports\": [{8080}]}\n",
      "~~~\n"
    ]
    result = Gapic::FormattingUtils.format_doc_lines nil, lines
    assert_equal lines, result
  end

  def test_multiline_inline_code_span_preserves_braces
    lines = [
      "Value format:\n",
      "`projects/{project}/locations/{location}/featurestores/\n",
      "{featurestore}/entityTypes/{entityType}`. For example,\n",
      "choose from {100, 200}.\n"
    ]
    result = Gapic::FormattingUtils.format_doc_lines nil, lines
    assert_equal [
      "Value format:\n",
      "`projects/{project}/locations/{location}/featurestores/\n",
      "{featurestore}/entityTypes/{entityType}`. For example,\n",
      "choose from \\\\{100, 200}.\n"
    ], result
  end

  def test_multiline_inline_code_span_preserves_tags
    lines = [
      "Here is an example:\n",
      "`Hello @FooBot\n",
      "@BarBot` in code\n",
      "@FooBot outside code\n"
    ]
    result = Gapic::FormattingUtils.format_doc_lines nil, lines
    assert_equal [
      "Here is an example:\n",
      "`Hello @FooBot\n",
      "@BarBot` in code\n",
      "`@FooBot` outside code\n"
    ], result
  end

  def test_multiline_inline_code_span_three_lines
    lines = [
      "Start `code line 1 {foo}\n",
      "code line 2 {bar}\n",
      "code line 3 {baz}` end {qux}\n"
    ]
    result = Gapic::FormattingUtils.format_doc_lines nil, lines
    assert_equal [
      "Start `code line 1 {foo}\n",
      "code line 2 {bar}\n",
      "code line 3 {baz}` end \\\\{qux}\n"
    ], result
  end

  def test_multiline_code_span_resets_on_blank_line
    lines = [
      "Unclosed `code span\n",
      "\n",
      "New paragraph with {100, 200}\n"
    ]
    result = Gapic::FormattingUtils.format_doc_lines nil, lines
    assert_equal [
      "Unclosed `code span\n",
      "\n",
      "New paragraph with \\\\{100, 200}\n"
    ], result
  end
end
