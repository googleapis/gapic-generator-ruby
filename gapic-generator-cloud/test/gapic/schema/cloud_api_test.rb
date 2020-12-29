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
require "gapic/generators/cloud_generator_parameters"

class CloudApiTest < Minitest::Test
  # an amalgam of the parameters the generator takes
  # for both client libraries and wrappers
  API_INFO = ApiTestResources::API_INFO

  # a configuration that is expected to be parsed from the parameters above
  CONFIG_EXPECTED = ApiTestResources::CONFIG_EXPECTED

  # Verify that the full range of API parameters options
  # are parsed correctly into the configuration structure
  # when provided with human-readable cloud-specific parameter aliases
  def test_parse_parameters_readable
    readable_params = [
      ["ruby-cloud-free-tier", API_INFO[:free_tier]],
      ["ruby-cloud-yard-strict", API_INFO[:yard_strict]],
      ["ruby-cloud-generic-endpoint", API_INFO[:generic_endpoint]],

      ["ruby-cloud-gem-name", API_INFO[:name]],
      ["ruby-cloud-gem-namespace", API_INFO[:namespace]],
      ["ruby-cloud-title", API_INFO[:title]],
      ["ruby-cloud-description", API_INFO[:description]],
      ["ruby-cloud-summary", API_INFO[:summary]],
      ["ruby-cloud-homepage", API_INFO[:homepage]],
      ["ruby-cloud-env-prefix", API_INFO[:env_prefix]],
      ["ruby-cloud-wrapper-of", API_INFO[:wrapper_of]],
      ["ruby-cloud-migration-version", API_INFO[:migration_version]],
      ["ruby-cloud-product-url", API_INFO[:product_url]],
      ["ruby-cloud-issues-url", API_INFO[:issues_url]],
      ["ruby-cloud-api-id", API_INFO[:api_id]],
      ["ruby-cloud-api-shortname", API_INFO[:api_shortname]],
      ["ruby-cloud-factory-method-suffix", API_INFO[:factory_method_suffix]],
      ["ruby-cloud-default-service-host", API_INFO[:default_host]],
      ["ruby-cloud-grpc-service-config", API_INFO[:grpc_service_config]],

      # arrays of values are joined with the ';' symbol
      ["ruby-cloud-common-services", API_INFO[:common_services].join(";")],
      ["ruby-cloud-default-oauth-scopes", API_INFO[:default_oauth_scopes].join(";")],

      # maps of key,values are joined pairwise with the '=' symbol then pairs are joined with the ';' symbol.
      ["ruby-cloud-path-override", API_INFO[:path_override].map { |k, v| "#{k}=#{v}" }.join(";")],
      ["ruby-cloud-namespace-override", API_INFO[:namespace_override].map { |k, v| "#{k}=#{v}" }.join(";")],
      ["ruby-cloud-service-override", API_INFO[:service_override].map { |k, v| "#{k}=#{v}" }.join(";")],
      ["ruby-cloud-extra-dependencies", API_INFO[:extra_dependencies].map { |k, v| "#{k}=#{v}" }.join(";")]
    ]

    readable_param_str = readable_params.map { |k, v| "#{k}=#{v}" }.join(",")
    request = OpenStruct.new parameter: readable_param_str, proto_file: []
    api = Gapic::Schema::Api.new request, parameter_schema: Gapic::Generators::CloudGeneratorParameters.default_schema

    assert_equal CONFIG_EXPECTED, api.configuration
  end
end
