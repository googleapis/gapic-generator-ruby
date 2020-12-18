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

# TODO: add the real generation strings to tests, including
# - paths
# - real hashes
# - that one grapheas string
# - wrapper libs in general
class ApiTest < Minitest::Test
  def test_split_by_unescaped
    input2expected = {
      "abc"                         => ["abc"],
      "a,bc"                        => ["a", "bc"],
      "ab\\,c"                      => ["ab\\,c"],
      "ab\\\\\\,,\\,c"              => ["ab\\\\\\,","\\,c"],
      "a\\.bc"                      => ["a\\.bc"],
      "a\\.bc\\,de,f\\,gh\\,,jk"    => ["a\\.bc\\,de", "f\\,gh\\,", "jk"],
      ",a\\.bc\\,de,f\\,gh\\,,jk,"  => ["", "a\\.bc\\,de", "f\\,gh\\,", "jk", ""]
    }

    input2expected.each do |input, expected|
      result = Gapic::Schema::RequestParamParser.split_by_unescaped input, ","
      assert_equal expected, result,
                   "Split of the input string #{input} should be as expected"
    end
  end

  def test_split_by_unescaped_maxsplits
    input2expected = {
        "abc"                         => ["abc"],
        "a,bc"                        => ["a", "bc"],
        "a,b,c"                       => ["a", "b,c"],
        ",a\\.bc\\,de,f\\,gh\\,,jk,"  => ["", "a\\.bc\\,de,f\\,gh\\,,jk,"]
    }

    input2expected.each do |input, expected|
      result = Gapic::Schema::RequestParamParser.split_by_unescaped input, ",", 1
      assert_equal expected, result,
                   "Split of the input string #{input} should be as expected"
    end
  end

  def test_unescape
    given = "\\a\\b\\,.c\\\\de"
    expected = "ab,.c\\de"
    result = Gapic::Schema::RequestParamParser.unescape given
    assert_equal expected, result
  end

  def test_request_param_parsing
    schema = Gapic::Schema::ParameterSchema.new do |sch|
      sch.bool_params = { "bool_param_input_name" => "bool_param_name" }
      sch.string_params = { "string_param_input_name" => "string_param_name" }
      sch.array_params = { "array_param_input_name" => "array_param_name" }
      sch.map_params = { "map_param_input_name" => "map_param_name" }
    end

    paramvals2expected = {
      ["unknown_param_input_name", "\\a\\b\\,.c\\\\de"]     => {"unknown_param_input_name" => "ab,.c\\de"},
      ["unknown_param\\.input_name.foo", "\\a\\b\\,.c\\\\de"]     => {"unknown_param.input_name.foo" => "ab,.c\\de"},
      ["bool_param_input_name", "true"]                     => {"bool_param_name" => "true"},
      ["string_param_input_name", "\\a\\b\\,.c\\\\de"]      => {"string_param_name" =>"ab,.c\\de" },
      ["array_param_input_name", "ab;c\\;d;e\\\\f"]         => {"array_param_name" => ["ab", "c;d", "e\\f"] },
      ["map_param_input_name", "a=b;c\\=d=e\\,f;gh=i\\;j"]  => { "map_param_name" =>
                                                                 {
                                                                   "a"=>"b",
                                                                   "c=d"=> "e,f",
                                                                   "gh"=>"i;j"
                                                                 }
      },
    }

    param_strings2expected = paramvals2expected.map { |key_arr, val| [key_arr.join("="), val] }.to_h
    parameter_string = param_strings2expected.keys.join ","
    parsed_parameters = Gapic::Schema::RequestParamParser.parse_parameters_string parameter_string, schema

    verify_parsing_result param_strings2expected, parsed_parameters
  end

  def test_container_analysis_processed
    ca_info = {
      name: "google-cloud-container_analysis-v1",
      title: "Container Analysis V1",
      desc: "The Container Analysis API is an implementation of Grafeas. It stores, and enables querying and retrieval of, critical metadata about all of your software artifacts.",
      env_prefix:  "CONTAINER_ANALYSIS",
      doc_url: "https://cloud.google.com/container-registry/docs/container-analysis",
      api_id: "containeranalysis.googleapis.com",
      api_shortname: "containeranalysis",
      extra_dep_name: "grafeas-v1",
      extra_dep_val: "~> 0.0",
      grpc_service_config: "google/devtools/containeranalysis/v1/containeranalysis_grpc_service_config.json",
    }

    schema = Gapic::Schema::RequestParamParser.get_default_schema

    paramvals = [
        [":gem.:name", ca_info[:name]],
        [":gem.:title", ca_info[:title]],
        [":gem.:description", ca_info[:desc]],
        [":gem.:env_prefix", ca_info[:env_prefix]],
        [":gem.:product_documentation_url", ca_info[:doc_url]],
        [":gem.:api_id", ca_info[:api_id]],
        [":gem.:api_shortname", ca_info[:api_shortname]],
        [":gem.:extra_dependencies.#{ca_info[:extra_dep_name]}", ca_info[:extra_dep_val]],
        ["grpc_service_config", ca_info[:grpc_service_config]],
    ]

    # since the strings in ca info are unescaped (unlike in the synthetic test above)
    # there is an additional step of escaping them when constructing the test input data
    # expected data is same as test data for the processed version
    paramvals2expected = paramvals.map do |paramval|
      [paramval.map{|s| escape(s)}, {paramval[0] => paramval[1]}]
    end.to_h

    param_strings2expected = paramvals2expected.map { |key_arr, val| [key_arr.join("="), val] }.to_h
    parameter_string = param_strings2expected.keys.join ","
    parsed_parameters = Gapic::Schema::RequestParamParser.parse_parameters_string parameter_string, schema

    verify_parsing_result param_strings2expected, parsed_parameters
  end

  def test_container_analysis_unprocessed
    ca_info = {
        name: "google-cloud-container_analysis-v1",
        title: "Container Analysis V1",
        desc: "The Container Analysis API is an implementation of Grafeas. It stores, and enables querying and retrieval of, critical metadata about all of your software artifacts.",
        env_prefix:  "CONTAINER_ANALYSIS",
        doc_url: "https://cloud.google.com/container-registry/docs/container-analysis",
        api_id: "containeranalysis.googleapis.com",
        api_shortname: "containeranalysis",
        extra_dep_name: "grafeas-v1",
        extra_dep_val: "~> 0.0",
        grpc_service_config: "google/devtools/containeranalysis/v1/containeranalysis_grpc_service_config.json",
    }

    ca_info_escaped = ca_info.map { |key, val| [key, escape(val)] }.to_h

    schema = Gapic::Schema::RequestParamParser.get_default_schema

    paramvals2expected = {
        ["ruby-cloud-gem-name", ca_info_escaped[:name]] => { ":gem.:name" => ca_info[:name] },
        ["ruby-cloud-title", ca_info_escaped[:title]] => { ":gem.:title" => ca_info[:title] },
        ["ruby-cloud-description", ca_info_escaped[:desc]] => { ":gem.:description" => ca_info[:desc] },
        ["ruby-cloud-env-prefix", ca_info_escaped[:desc]] => { ":gem.:env_prefix" => ca_info[:desc] },
        ["ruby-cloud-product-url", ca_info_escaped[:doc_url]] => { ":gem.:product_documentation_url" => ca_info[:doc_url] },
        ["ruby-cloud-api-id", ca_info_escaped[:api_id]] => { ":gem.:api_id" => ca_info[:api_id] },
        ["ruby-cloud-api-shortname", ca_info_escaped[:api_shortname]] => { ":gem.:api_shortname" => ca_info[:api_shortname]},
        ["ruby-cloud-extra-dependencies", "#{ca_info_escaped[:extra_dep_name]}=#{ca_info_escaped[:extra_dep_val]}"] =>
            {":gem.:extra_dependencies" => { "#{ca_info[:extra_dep_name]}" => ca_info[:extra_dep_val]} }
    }

    param_strings2expected = paramvals2expected.map { |key_arr, val| [key_arr.join("="), val] }.to_h
    parameter_string = param_strings2expected.keys.join ","
    parsed_parameters = Gapic::Schema::RequestParamParser.parse_parameters_string parameter_string, schema

    verify_parsing_result param_strings2expected, parsed_parameters
  end


  private

  def escape string
    string.gsub(",", "\\,").gsub("=", "\\=").gsub(";", "\\;")
  end

  def verify_parsing_result param_strings2expected, parsed_parameters

    assert_equal param_strings2expected.length, parsed_parameters.length,
                 "Should parse same amount of parameters as we submit"

    parsed_parameters.each do |parsed_param|
      assert param_strings2expected.key?(parsed_param.input_str),
             "Parsed input string #{parsed_param.input_str} should be equal to intended"

      assert_equal param_strings2expected[parsed_param.input_str], parsed_param.to_input_h,
                   "Parameter parsed from the string #{parsed_param.input_str} should be as intended"
    end
  end
end
