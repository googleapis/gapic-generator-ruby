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

# Contains constants used in API parameters parsing tests
module ApiTestResources
  # an amalgam of the parameters the generator takes
  # for both client libraries and wrappers
  API_INFO = {
    # bool parameters
    # any string value for a bool parameter is parsed
    # into the configuration structure
    # and then rejected by the presenter layer
    free_tier: 'invalid_value',
    yard_strict: 'false',
    generic_endpoint: 'true',
    generate_metadata: 'true',

    # string parameters
    name: 'google-cloud-container_analysis-v1',
    namespace: 'Google::Cloud::AutoML',
    title: 'Container Analysis V1',
    # escaping is required for commas and equal signs
    description: 'The Container Analysis API is (foo\\=bar). It stores\\, and enables...',
    description_unescaped: 'The Container Analysis API is (foo=bar). It stores, and enables...',
    summary: 'API Client library',
    homepage: 'https://github.com/googleapis/googleapis',
    env_prefix: 'CONTAINER_ANALYSIS',
    wrapper_of: 'v1:0.0;v1beta1:0.0',
    migration_version: '0.20',
    product_url: 'https://cloud.google.com/container-registry/docs/container-analysis',
    issues_url: 'https://example.com/issues',
    api_id: 'containeranalysis.googleapis.com',
    api_shortname: 'containeranalysis',
    factory_method_suffix: '_service',
    default_host: 'default_host.example.com',
    grpc_service_config: 'google/devtools/containeranalysis/v1/containeranalysis_grpc_service_config.json',
    wrapper_gem_name_override: "wrapper-gem-name-override",
    service_yaml: 'google3/google/cloud/datastream/datastream.yaml',

    # array parameters
    default_oauth_scopes: ['https://www.googleapis.com/auth/cloud-platform'],
    transports: %w[grpc rest],

    # map parameters

    # the '.' in the map key is escaped twice -- one escaping will be removed during parameter parsing,
    # the second during the attempt to  map unroll the parameter name
    # without the second tier of escaping the resulting configuraton structure will be
    # {common_services => { google => { iam => ...}}}
    common_services: { 'google\\\\.iam\\\\.v1\\\\.IAMPolicy' => 'google.pubsub.v1.Publisher' },
    common_services_unescaped: { 'google.iam.v1.IAMPolicy' => 'google.pubsub.v1.Publisher' },
    path_override: { 'pub_sub' => 'pubsub', 'auto_ml' => 'automl' },
    namespace_override: { 'Pubsub' => 'PubSub', 'AutoMl' => 'AutoML' },
    service_override: { 'Controller2' => 'Controller', 'Debugger2' => 'Debugger' },
    extra_dependencies: {
      'grafeas-v1' => '~> 0.0',
      'foo' => '~> bar'
    }
  }.freeze

  # a configuration that is expected to be parsed from the parameters above
  CONFIG_EXPECTED = {
    gem: {
      yard_strict: API_INFO[:yard_strict],
      generic_endpoint: API_INFO[:generic_endpoint],
      name: API_INFO[:name],
      namespace: API_INFO[:namespace],
      title: API_INFO[:title],
      description: API_INFO[:description_unescaped],
      summary: API_INFO[:summary],
      homepage: API_INFO[:homepage],
      env_prefix: API_INFO[:env_prefix],
      version_dependencies: API_INFO[:wrapper_of],
      migration_version: API_INFO[:migration_version],
      product_documentation_url: API_INFO[:product_url],
      issue_tracker_url: API_INFO[:issues_url],
      api_id: API_INFO[:api_id],
      api_shortname: API_INFO[:api_shortname],
      factory_method_suffix: API_INFO[:factory_method_suffix],
      extra_dependencies: API_INFO[:extra_dependencies]
    },
    :defaults => {
      service: {
        default_host: API_INFO[:default_host],
        oauth_scopes: API_INFO[:default_oauth_scopes]
      }
    },
    'grpc_service_config' => API_INFO[:grpc_service_config],
    service_yaml: API_INFO[:service_yaml],
    common_services: API_INFO[:common_services_unescaped],
    overrides: {
      file_path: API_INFO[:path_override],
      namespace: API_INFO[:namespace_override],
      service: API_INFO[:service_override],
      wrapper_gem_name: API_INFO[:wrapper_gem_name_override]
    },
    transports: API_INFO[:transports],
    generate_metadata: API_INFO[:generate_metadata]
  }.freeze
end
