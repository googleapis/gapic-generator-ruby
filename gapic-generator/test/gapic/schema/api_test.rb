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
require "api_test_resources"

class ApiTest < Minitest::Test
  API_INFO = ApiTestResources::API_INFO
  CONFIG_EXPECTED = ApiTestResources::CONFIG_EXPECTED

  # Verify that the full range of API parameters options
  # are parsed correctly into the configuration structure
  # when provided with literal configuration parameter names
  def test_parse_parameters_literal
    literal_params = [
      [":gem.:free_tier", API_INFO[:free_tier]],
      [":gem.:yard_strict", API_INFO[:yard_strict]],
      [":gem.:generic_endpoint", API_INFO[:generic_endpoint]],
      [":generate_metadata", API_INFO[:generate_metadata]],

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
      [":defaults.:service.:default_host", API_INFO[:default_host]],
      ["grpc_service_config", API_INFO[:grpc_service_config]],
      [":service_yaml", API_INFO[:service_yaml]],
      [":overrides.:wrapper_gem_name", API_INFO[:wrapper_gem_name_override]],

      # arrays of values are joined with the ';' symbol
      [":defaults.:service.:oauth_scopes", API_INFO[:default_oauth_scopes].join(";")],
      [":transports", API_INFO[:transports].join(";")]
    ]

    # maps of values are split into separate command-line parameters (one parameter per map key).
    literal_params += create_map_params API_INFO[:common_services], ":common_services"
    literal_params += create_map_params API_INFO[:path_override], ":overrides.:file_path"
    literal_params += create_map_params API_INFO[:namespace_override], ":overrides.:namespace"
    literal_params += create_map_params API_INFO[:service_override], ":overrides.:service"
    literal_params += create_map_params API_INFO[:extra_dependencies], ":gem.:extra_dependencies"

    literal_param_str = literal_params.map { |k, v| "#{k}=#{v}" }.join(",")
    request = OpenStruct.new parameter: literal_param_str, proto_file: []
    api = Gapic::Schema::Api.new request

    assert_equal CONFIG_EXPECTED, api.configuration
  end

  # Verify that the full range of API parameters options
  # are parsed correctly into the configuration structure
  # when provided with human-readable parameter aliases
  def test_parse_parameters_readable
    readable_params = [
      ["gem-free-tier", API_INFO[:free_tier]],
      ["gem-yard-strict", API_INFO[:yard_strict]],
      ["gem-generic-endpoint", API_INFO[:generic_endpoint]],
      # this parameter has no alias in gapic-generator-vanilla
      [":generate_metadata", API_INFO[:generate_metadata]],

      ["gem-name", API_INFO[:name]],
      ["gem-namespace", API_INFO[:namespace]],
      ["gem-title", API_INFO[:title]],
      ["gem-description", API_INFO[:description]],
      ["gem-summary", API_INFO[:summary]],
      ["gem-homepage", API_INFO[:homepage]],
      ["gem-env-prefix", API_INFO[:env_prefix]],
      ["gem-wrapper-of", API_INFO[:wrapper_of]],
      ["gem-migration-version", API_INFO[:migration_version]],
      ["gem-product-url", API_INFO[:product_url]],
      ["gem-issues-url", API_INFO[:issues_url]],
      ["gem-api-id", API_INFO[:api_id]],
      ["gem-api-shortname", API_INFO[:api_shortname]],
      ["gem-factory-method-suffix", API_INFO[:factory_method_suffix]],
      ["default-service-host", API_INFO[:default_host]],
      ["grpc-service-config", API_INFO[:grpc_service_config]],
      ["service-yaml", API_INFO[:service_yaml]],
      # this parameter has no alias in gapic-generator-vanilla
      [":overrides.:wrapper_gem_name", API_INFO[:wrapper_gem_name_override]],

      # arrays of values are joined with the ';' symbol
      ["default-oauth-scopes", API_INFO[:default_oauth_scopes].join(";")],
      ["transports", API_INFO[:transports].join(";")],

      # maps of key,values are joined pairwise with the '=' symbol then pairs are joined with the ';' symbol.

      # for the readable parameter there is no need to escape the '.' in the parameter name
      # because there will not be a map-unrolling of the parameter name
      # therefore we use API_INFO[:common_services_unescaped] for input
      ["common-services", API_INFO[:common_services_unescaped].map { |k, v| "#{k}=#{v}" }.join(";")],
      ["file-path-override", API_INFO[:path_override].map { |k, v| "#{k}=#{v}" }.join(";")],
      ["namespace-override", API_INFO[:namespace_override].map { |k, v| "#{k}=#{v}" }.join(";")],
      ["service-override", API_INFO[:service_override].map { |k, v| "#{k}=#{v}" }.join(";")],
      ["gem-extra-dependencies", API_INFO[:extra_dependencies].map { |k, v| "#{k}=#{v}" }.join(";")]
    ]

    readable_param_str = readable_params.map { |k, v| "#{k}=#{v}" }.join(",")
    request = OpenStruct.new parameter: readable_param_str, proto_file: []
    api = Gapic::Schema::Api.new request, parameter_schema: Gapic::Generators::DefaultGeneratorParameters.default_schema

    assert_equal CONFIG_EXPECTED, api.configuration
  end

  # Verify that reconstructing parameter string
  # from the parsed representation inside the Api works correctly
  def test_parameter_reconstruction
    parameter = "a=b\\\\\\,\\=,c=d=e,:f="
    request = OpenStruct.new parameter: parameter, proto_file: []
    api = Gapic::Schema::Api.new request
    assert_equal parameter, api.protoc_parameter
  end

  private

  # Create a list of parameters and values
  # for the default representation of map-typed parameters
  # @param param_map [Hash{String => String}]
  # @param prefix [String]
  # @return [Array<String>]
  def create_map_params param_map, prefix
    param_map.map { |k, v| ["#{prefix}.#{k}", v] }
  end
end
