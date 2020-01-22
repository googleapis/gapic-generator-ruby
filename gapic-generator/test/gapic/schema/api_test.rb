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
  def test_parse_protoc_options
    parameter = "a=b\\\\\\,\\=,c=d=e,:f="
    request = OpenStruct.new parameter: parameter, proto_file: []
    api = Gapic::Schema::Api.new request
    assert_equal({ "a" => "b\\,=", "c" => ["d", "e"], f: nil }, api.protoc_options)
  end

  def test_configuration_construction
    parameter = ":a.:b=1,:a.:c=2,:a.:c.:d=3"
    request = OpenStruct.new parameter: parameter, proto_file: []
    api = Gapic::Schema::Api.new request
    assert_equal({ a: { b: "1", c: { d: "3" } } }, api.configuration)
  end

  def test_parameter_reconstruction
    parameter = "a=b\\\\\\,\\=,c=d=e,:f="
    request = OpenStruct.new parameter: parameter, proto_file: []
    api = Gapic::Schema::Api.new request
    assert_equal parameter, api.protoc_parameter
  end
end
