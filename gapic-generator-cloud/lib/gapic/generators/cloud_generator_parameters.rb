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

require "gapic/generators/default_generator_parameters"

module Gapic
  module Generators
    # Contains the cloud generator's parameters
    module CloudGeneratorParameters
      BOOL_PARAMETERS_ALIASES = {
        "ruby-cloud-free-tier"        => ":gem.:free_tier",
        "ruby-cloud-yard-strict"      => ":gem.:yard_strict",
        "ruby-cloud-generic-endpoint" => ":gem.:generic_endpoint"
      }.freeze

      STRING_PARAMETERS_ALIASES = {
        "ruby-cloud-gem-name"              => ":gem.:name",
        "ruby-cloud-gem-namespace"         => ":gem.:namespace",
        "ruby-cloud-title"                 => ":gem.:title",
        "ruby-cloud-description"           => ":gem.:description",
        "ruby-cloud-summary"               => ":gem.:summary",
        "ruby-cloud-homepage"              => ":gem.:homepage",
        "ruby-cloud-env-prefix"            => ":gem.:env_prefix",
        "ruby-cloud-wrapper-of"            => ":gem.:version_dependencies",
        "ruby-cloud-migration-version"     => ":gem.:migration_version",
        "ruby-cloud-product-url"           => ":gem.:product_documentation_url",
        "ruby-cloud-issues-url"            => ":gem.:issue_tracker_url",
        "ruby-cloud-api-id"                => ":gem.:api_id",
        "ruby-cloud-api-shortname"         => ":gem.:api_shortname",
        "ruby-cloud-factory-method-suffix" => ":gem.:factory_method_suffix",
        "ruby-cloud-default-service-host"  => ":defaults.:service.:default_host",
        "ruby-cloud-grpc_service_config"   => "grpc_service_config"
      }.freeze

      ARRAY_PARAMETERS_ALIASES = {
        "ruby-cloud-common-services"      => ":common_services",
        "ruby-cloud-default-oauth-scopes" => ":defaults.:service.:oauth_scopes"
      }.freeze

      MAP_PARAMETERS_ALIASES = {
        "ruby-cloud-path-override"      => ":overrides.:file_path",
        "ruby-cloud-namespace-override" => ":overrides.:namespace",
        "ruby-cloud-service-override"   => ":overrides.:service",
        "ruby-cloud-extra-dependencies" => ":gem.:extra_dependencies"
      }.freeze

      def self.default_schema
        Gapic::Generators::DefaultGeneratorParameters.default_schema.extend_with_aliases(
          bool_aliases:   BOOL_PARAMETERS_ALIASES,
          string_aliases: STRING_PARAMETERS_ALIASES,
          array_aliases:  ARRAY_PARAMETERS_ALIASES,
          map_aliases:    MAP_PARAMETERS_ALIASES
        )
      end
    end
  end
end
