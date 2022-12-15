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

require "gapic/schema/parameter_schema"

module Gapic
  module Generators
    # Contains the default generator's parameters
    module DefaultGeneratorParameters
      BOOL_PARAMETERS = [
        ":gem.:free_tier",
        ":gem.:yard_strict",
        ":gem.:generic_endpoint",
        ":gem.:is_cloud_product",
        ":gem.:rest_numeric_enums",
        ":generate_metadata",
        ":generate_standalone_snippets",
        ":generate_yardoc_snippets"
      ].freeze

      STRING_PARAMETERS = [
        ":gem.:name",
        ":gem.:namespace",
        ":gem.:title",
        ":gem.:description",
        ":gem.:summary",
        ":gem.:homepage",
        ":gem.:env_prefix",
        ":gem.:version_dependencies",
        ":gem.:migration_version",
        ":gem.:product_documentation_url",
        ":gem.:issue_tracker_url",
        ":gem.:api_id",
        ":gem.:api_shortname",
        ":gem.:factory_method_suffix",
        ":defaults.:service.:default_host",
        "grpc_service_config",
        ":service_yaml",
        ":overrides.:wrapper_gem_name",
        ":snippet_configs_path"
      ].freeze

      ARRAY_PARAMETERS = [
        ":defaults.:service.:oauth_scopes",
        ":transports"
      ].freeze

      MAP_PARAMETERS = [
        ":common_services",
        ":overrides.:file_path",
        ":overrides.:namespace",
        ":overrides.:service",
        ":gem.:extra_dependencies"
      ].freeze

      BOOL_PARAMETERS_ALIASES = {
        "gem-free-tier"        => ":gem.:free_tier",
        "gem-yard-strict"      => ":gem.:yard_strict",
        "gem-generic-endpoint" => ":gem.:generic_endpoint",
        "gem-is-cloud-product" => ":gem.:is_cloud_product",
        "rest-numeric-enums"   => ":gem.:rest_numeric_enums"
      }.freeze

      STRING_PARAMETERS_ALIASES = {
        "gem-name"                  => ":gem.:name",
        "gem-namespace"             => ":gem.:namespace",
        "gem-title"                 => ":gem.:title",
        "gem-description"           => ":gem.:description",
        "gem-summary"               => ":gem.:summary",
        "gem-homepage"              => ":gem.:homepage",
        "gem-env-prefix"            => ":gem.:env_prefix",
        "gem-wrapper-of"            => ":gem.:version_dependencies",
        "gem-migration-version"     => ":gem.:migration_version",
        "gem-product-url"           => ":gem.:product_documentation_url",
        "gem-issues-url"            => ":gem.:issue_tracker_url",
        "gem-api-id"                => ":gem.:api_id",
        "gem-api-shortname"         => ":gem.:api_shortname",
        "gem-factory-method-suffix" => ":gem.:factory_method_suffix",
        "default-service-host"      => ":defaults.:service.:default_host",
        "grpc-service-config"       => "grpc_service_config",
        "service-yaml"              => ":service_yaml",
        "snippet-configs-path"      => ":snippet_configs_path"
      }.freeze

      ARRAY_PARAMETERS_ALIASES = {
        "default-oauth-scopes" => ":defaults.:service.:oauth_scopes",
        "transports" => ":transports"
      }.freeze

      MAP_PARAMETERS_ALIASES = {
        "common-services"        => ":common_services",
        "file-path-override"     => ":overrides.:file_path",
        "namespace-override"     => ":overrides.:namespace",
        "service-override"       => ":overrides.:service",
        "gem-extra-dependencies" => ":gem.:extra_dependencies"
      }.freeze

      def self.default_schema
        base_schema = Gapic::Schema::ParameterSchema.create(
          bool_params_list:   BOOL_PARAMETERS,
          string_params_list: STRING_PARAMETERS,
          array_params_list:  ARRAY_PARAMETERS,
          map_params_list:    MAP_PARAMETERS
        )

        base_schema.extend_with_aliases(
          bool_aliases:   BOOL_PARAMETERS_ALIASES,
          string_aliases: STRING_PARAMETERS_ALIASES,
          array_aliases:  ARRAY_PARAMETERS_ALIASES,
          map_aliases:    MAP_PARAMETERS_ALIASES
        )
      end
    end
  end
end
