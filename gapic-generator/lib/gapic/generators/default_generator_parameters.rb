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
        ":gem.:generic_endpoint"
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
        "grpc_service_config"
      ].freeze

      ARRAY_PARAMETERS = [
        ":common_services"
      ].freeze

      MAP_PARAMETERS = [
        ":overrides.:file_path",
        ":overrides.:namespace",
        ":overrides.:service",
        ":gem.:extra_dependencies"
      ].freeze

      def self.default_schema
        Gapic::Schema::ParameterSchema.create(
          bool_params_list:   BOOL_PARAMETERS,
          string_params_list: STRING_PARAMETERS,
          array_params_list:  ARRAY_PARAMETERS,
          map_params_list:    MAP_PARAMETERS
        )
      end
    end
  end
end
