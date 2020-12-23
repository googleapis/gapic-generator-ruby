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
  # an amalgam of the parameters the generator takes 
  # for both client libraries and wrappers
  API_INFO = {
    # bool parameters
    # any string value for a bool parameter is parsed into the configuration structure
    # and then rejected by the presenter layer
    free_tier: "invalid_value",
    yard_strict: "false",
    generic_endpoint: "true",

    # string parameters
    name: "google-cloud-container_analysis-v1",
    namespace: "Google::Cloud::AutoML",
    title: "Container Analysis V1",
    # escaping is required for commas and equal signs
    description: "The Container Analysis API is (foo\\=bar). It stores\\, and enables...",
    unescaped_description: "The Container Analysis API is (foo=bar). It stores, and enables...",
    summary: "API Client library",
    homepage: "https://github.com/googleapis/googleapis",
    env_prefix:  "CONTAINER_ANALYSIS",
    wrapper_of: "v1:0.0;v1beta1:0.0",
    migration_version: "0.20",
    product_url: "https://cloud.google.com/container-registry/docs/container-analysis",
    issues_url: "https://example.com/issues",
    api_id: "containeranalysis.googleapis.com",
    api_shortname: "containeranalysis",
    factory_method_suffix:  "_service",
    grpc_service_config: "google/devtools/containeranalysis/v1/containeranalysis_grpc_service_config.json",

    # array parameters
    common_services: ["google.iam.v1.IAMPolicy", "google.pubsub.v1.Publisher"],

    # map parameters
    path_override: { "pub_sub" => "pubsub", "auto_ml" => "automl" },
    namespace_override: { "Pubsub" => "PubSub", "AutoMl" => "AutoML" },
    service_override: { "Controller2" => "Controller", "Debugger2" => "Debugger" },
    extra_dependencies: {
      "grafeas-v1" => "~> 0.0",
      "foo"        => "~> bar"
    }
  }.freeze

  # a configuration that is expected to be parsed from the parameters above
  CONFIG_EXPECTED = {
    gem: {
      free_tier:                  API_INFO[:free_tier],
      yard_strict:                API_INFO[:yard_strict],
      generic_endpoint:           API_INFO[:generic_endpoint],
      name:                       API_INFO[:name],
      namespace:                  API_INFO[:namespace],
      title:                      API_INFO[:title],
      description:                API_INFO[:unescaped_description],
      summary:                    API_INFO[:summary],
      homepage:                   API_INFO[:homepage],
      env_prefix:                 API_INFO[:env_prefix],
      version_dependencies:       API_INFO[:wrapper_of],
      migration_version:          API_INFO[:migration_version],
      product_documentation_url:  API_INFO[:product_url],
      issue_tracker_url:          API_INFO[:issues_url],
      api_id:                     API_INFO[:api_id],
      api_shortname:              API_INFO[:api_shortname],
      factory_method_suffix:      API_INFO[:factory_method_suffix],
      extra_dependencies:         API_INFO[:extra_dependencies]
    },
    "grpc_service_config" => API_INFO[:grpc_service_config],
    common_services: API_INFO[:common_services],
    overrides: {
      file_path: API_INFO[:path_override],
      namespace: API_INFO[:namespace_override],
      service: API_INFO[:service_override]
    }
  }.freeze

  # Verify that the full range of API parameters options
  # are parsed correctly into the configuration structure
  def test_parse_protoc_options
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

      # arrays of values are joined with the '=' symbol
      [":common_services", API_INFO[:common_services].join("=")]
    ]
    
    # maps of values are split into separate command-line parameters (one parameter per map key).
    literal_params += API_INFO[:path_override].map { |k, v| [":overrides.:file_path.#{k}", v] }
    literal_params += API_INFO[:namespace_override].map { |k, v| [":overrides.:namespace.#{k}", v] }
    literal_params += API_INFO[:service_override].map { |k, v| [":overrides.:service.#{k}", v] }
    literal_params += API_INFO[:extra_dependencies].map { |k, v| [":gem.:extra_dependencies.#{k}", v] }

    literal_param_str = literal_params.map { |k, v| "#{k}=#{v}" }.join(",")
    request = OpenStruct.new parameter: literal_param_str, proto_file: []
    api = Gapic::Schema::Api.new request

    assert_equal CONFIG_EXPECTED, api.configuration
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
