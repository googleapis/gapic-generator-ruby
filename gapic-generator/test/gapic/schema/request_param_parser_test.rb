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
  def test_request_param_parsing
    params2decoded = {
      "a=b\\\\\\,\\=" => { "a" => "b\\,=" },
      "c=d=e"         => { "c" => ["d", "e"] },
      ":f="           => { f: nil },
      ":g=h="         => { g: ["h"] }
    }

    parameter = params2decoded.keys.join ","
    parsed_parameters = Gapic::Schema::RequestParamParser.parse_parameter parameter

    assert_equal params2decoded.length, parsed_parameters.length,
                 "Should parse same amount of parameters as we submit"
    parsed_parameters.each do |parsed_param|
      assert params2decoded.key?(parsed_param.input_str),
             "Parsed input string #{parsed_param.input_str} should be equal to intended"
      assert_equal params2decoded[parsed_param.input_str], parsed_param.to_input_h,
                   "Parameter parsed from the string #{parsed_param.input_str} should be as intended"
    end
  end
end
