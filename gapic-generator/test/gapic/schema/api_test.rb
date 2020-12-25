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
require "gapic/schema/api_test_resources"

class ApiTest < Minitest::Test
  API_INFO = ApiTestResources::API_INFO
  CONFIG_EXPECTED = ApiTestResources::CONFIG_EXPECTED

  # Verify that the full range of API parameters options
  # are parsed correctly into the configuration structure
  def test_parse_parameters
    literal_params = [
      [":gem.:free_tier", API_INFO[:free_tier]],
      [":gem.:yard_strict", API_INFO[:yard_strict]],
      [":gem.:generic_endpoint", API_INFO[:generic_endpoint]],

      [":gem.:name", API_INFO[:name]],
      [":gem.:namespace", API_INFO[:namespace]],
      [":gem.:title", API_INFO[:title]],
      [":gem.:description", API_INFO[:description]],
      [":gem.:summary", API_INFO[:summary]],
      [":gem.:homepage", API_INFO[:homepage]],
      [":gem.:env_prefix", API_INFO[:env_prefix]],
      [":gem.:version_dependencies", API_INFO[:wrapper_of]],
      [":gem.:migration_version", API_INFO[:migration_version]],
      [":gem.:product_documentation_url", API_INFO[:product_url]],
      [":gem.:issue_tracker_url", API_INFO[:issues_url]],
      [":gem.:api_id", API_INFO[:api_id]],
      [":gem.:api_shortname", API_INFO[:api_shortname]],
      [":gem.:factory_method_suffix", API_INFO[:factory_method_suffix]],
      ["grpc_service_config", API_INFO[:grpc_service_config]],

      # arrays of values are joined with the ';' symbol
      [":common_services", API_INFO[:common_services].join(";")]
    ]

    # maps of values are split into separate command-line parameters (one parameter per map key).
    literal_params += create_map_params API_INFO[:path_override], ":overrides.:file_path"
    literal_params += create_map_params API_INFO[:namespace_override], ":overrides.:namespace"
    literal_params += create_map_params API_INFO[:service_override], ":overrides.:service"
    literal_params += create_map_params API_INFO[:extra_dependencies], ":gem.:extra_dependencies"

    literal_param_str = literal_params.map { |k, v| "#{k}=#{v}" }.join(",")
    request = OpenStruct.new parameter: literal_param_str, proto_file: []
    api = Gapic::Schema::Api.new request

    assert_equal CONFIG_EXPECTED, api.configuration
  end

  def test_parameter_reconstruction
    parameter = "a=b\\\\\\,\\=,c=d=e,:f="
    request = OpenStruct.new parameter: parameter, proto_file: []
    api = Gapic::Schema::Api.new request
    assert_equal parameter, api.protoc_parameter
  end

  private

  def create_map_params param_map, prefix
    param_map.map { |k, v| ["#{prefix}.#{k}", v] }
  end
end
