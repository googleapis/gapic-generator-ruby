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

class ApiTest < Minitest::Test
  def test_params_transcoding
    param_name = "ruby-cloud-free-tier"
    config_name = ":gem.:free_tier"
    val = "value"

    parameter_str = "#{param_name}=#{val}"
    expected_results = { parameter_str => { config_name => val } }
    parsed_parameters = Gapic::Schema::RequestParamParser.parse_parameter parameter_str

    verify_parsing_result parsed_parameters, expected_results
  end

  def test_request_param_parsing
    params2decoded = {
      "a=b\\\\\\,\\=" => { "a" => "b\\,=" },
      "c=d=e"         => { "c" => ["d", "e"] },
      ":f="           => { ":f" => nil },
      ":g=h="         => { ":g" => ["h"] }
    }

    parameter = params2decoded.keys.join ","
    parsed_parameters = Gapic::Schema::RequestParamParser.parse_parameter parameter

    verify_parsing_result parsed_parameters, params2decoded
  end

  private

  def verify_parsing_result parsed_parameters, expected_results
    assert_equal expected_results.length, parsed_parameters.length,
                 "Should parse same amount of parameters as we submit"
    parsed_parameters.each do |parsed_param|
      assert expected_results.key?(parsed_param.input_str),
             "Parsed input string #{parsed_param.input_str} should be equal to intended"
      assert_equal expected_results[parsed_param.input_str], parsed_param.to_input_h,
                   "Parameter parsed from the string #{parsed_param.input_str} should be as intended"
    end
  end

end
