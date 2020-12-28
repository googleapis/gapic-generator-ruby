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

# Unit tests for the parameter parsing
class RequestParamParserTest < Minitest::Test

  # Testing splitting by the unescaped instances of symbol
  def test_split_by_unescaped
    input2expected = {
      "abc"                        => ["abc"],
      "a,bc"                       => ["a", "bc"],
      "ab\\,c"                     => ["ab\\,c"],
      "ab\\\\\\,,\\,c"             => ["ab\\\\\\,", "\\,c"],
      "a\\.bc"                     => ["a\\.bc"],
      "a\\.bc\\,de,f\\,gh\\,,jk"   => ["a\\.bc\\,de", "f\\,gh\\,", "jk"],
      ",a\\.bc\\,de,f\\,gh\\,,jk," => ["", "a\\.bc\\,de", "f\\,gh\\,", "jk", ""]
    }

    input2expected.each do |input, expected|
      result = Gapic::Schema::RequestParamParser.split_by_unescaped input, ","
      assert_equal expected, result,
                   "Split of the input string #{input} should be as expected"
    end
  end

  # Testing splitting by the unescaped instances of symbol
  # when max_splits parameter is provided
  def test_split_by_unescaped_maxsplits
    input2expected = {
      "abc"                        => ["abc"],
      "a,bc"                       => ["a", "bc"],
      "a,b,c"                      => ["a", "b,c"],
      ",a\\.bc\\,de,f\\,gh\\,,jk," => ["", "a\\.bc\\,de,f\\,gh\\,,jk,"]
    }

    input2expected.each do |input, expected|
      result = Gapic::Schema::RequestParamParser.split_by_unescaped input, ",", 1
      assert_equal expected, result,
                   "Split of the input string #{input} should be as expected"
    end
  end

  # testing unescaping the \-escaped symbols in the string
  def test_unescape
    given = "\\a\\b\\,.c\\\\de"
    expected = "ab,.c\\de"
    result = Gapic::Schema::RequestParamParser.unescape given
    assert_equal expected, result
  end

  # testing the parameter parsing with aliases
  def test_request_param_parsing
    bool_params = { "bool_param_input_name" => "bool_param_name" }
    string_params = { "string_param_input_name" => "string_param_name" }
    array_params = { "array_param_input_name" => "array_param_name" }
    map_params = { "map_param_input_name" => "map_param_name" }

    schema = Gapic::Schema::ParameterSchema.new bool_params, string_params, array_params, map_params

    paramvals2expected = {
      ["unknown_param_input_name", "\\a\\b\\,.c\\\\de"]     => { "unknown_param_input_name" => "ab,.c\\de" },
      ["unknown_param.input_name.foo", "\\a\\b\\,.c\\\\de"] => { "unknown_param.input_name.foo" => "ab,.c\\de" },
      ["bool_param_input_name", "true"]                     => { "bool_param_name" => "true" },
      ["string_param_input_name", "\\a\\b\\,.c\\\\de"]      => { "string_param_name" =>"ab,.c\\de" },
      ["array_param_input_name", "ab;c\\;d;e\\\\f"]         => { "array_param_name" => ["ab", "c;d", "e\\f"] },
      ["map_param_input_name", "a=b;c\\=d=e\\,f;gh=i\\;j"]  => { "map_param_name" =>
                                                                                     {
                                                                                       "a"   => "b",
                                                                                       "c=d" => "e,f",
                                                                                       "gh"  => "i;j"
                                                                                     } }
    }

    param_strings2expected = paramvals2expected.map { |key_arr, val| [key_arr.join("="), val] }.to_h
    parameter_string = param_strings2expected.keys.join ","
    parsed_parameters = Gapic::Schema::RequestParamParser.parse_parameters_string parameter_string, param_schema: schema

    verify_parsing_result param_strings2expected, parsed_parameters
  end

  private

  # @param param_strings2expected [Hash{String=>Object}]
  # @param parsed_parameters [Array<Gapic::Schema::RequestParameter>]
  def verify_parsing_result param_strings2expected, parsed_parameters
    assert_equal param_strings2expected.length, parsed_parameters.length,
                 "Should parse same amount of parameters as we submit"

    parsed_parameters.each do |parsed_param|
      assert param_strings2expected.key?(parsed_param.input_str),
             "Parsed input string #{parsed_param.input_str} should be equal to intended"

      assert_equal param_strings2expected[parsed_param.input_str], parsed_param.to_config_h,
                   "Parameter parsed from the string #{parsed_param.input_str} should be as intended"
    end
  end
end
