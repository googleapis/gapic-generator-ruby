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

require "gapic/schema/request_parameter"
require "gapic/schema/parameter_schema"

module Gapic
  module Schema
    # Contains logic for parsing protoc request parameters
    # from the plugin_opt command line
    module RequestParamParser
      @bool_option_map = {
        "ruby-cloud-free-tier" => ":gem.:free_tier",
        "ruby-cloud-yard-strict" => ":gem.:yard_strict",
        "ruby-cloud-generic-endpoint" => ":gem.:generic_endpoint"
      }

      @string_option_map = {
        "ruby-cloud-gem-name" => ":gem.:name",
        "ruby-cloud-gem-namespace" => ":gem.:namespace",
        "ruby-cloud-title" => ":gem.:title",
        "ruby-cloud-description" => ":gem.:description",
        "ruby-cloud-summary" => ":gem.:summary",
        "ruby-cloud-homepage" => ":gem.:homepage",
        "ruby-cloud-env-prefix" => ":gem.:env_prefix",
        "ruby-cloud-wrapper-of" => ":gem.:version_dependencies",
        "ruby-cloud-migration-version" => ":gem.:migration_version",
        "ruby-cloud-product-url" => ":gem.:product_documentation_url",
        "ruby-cloud-issues-url" => ":gem.:issue_tracker_url",
        "ruby-cloud-api-id" => ":gem.:api_id",
        "ruby-cloud-api-shortname" => ":gem.:api_shortname",
        "ruby-cloud-factory-method-suffix" => ":gem.:factory_method_suffix",
        "grpc_service_config" => "grpc_service_config",
        "ruby-cloud-grpc_service_config" => "grpc_service_config",
      }

      @array_option_map = {
        "ruby-cloud-common-services" => ":common_services" ,
      }

      @map_option_map = {
        "ruby-cloud-path-override" => ":overrides.:file_path",
        "ruby-cloud-namespace-override" => ":overrides.:namespace",
        "ruby-cloud-service-override" =>":overrides.:service",
        "ruby-cloud-extra-dependencies" => ":gem.:extra_dependencies"
      }

      class << self
        def get_default_schema
          Gapic::Schema::ParameterSchema.new do |sch|
            sch.bool_params = @bool_option_map
            sch.string_params = @string_option_map
            sch.array_params = @array_option_map
            sch.map_params = @map_option_map
          end
        end

        # Unescapes a symbol from the string
        # e.g. "a\.b", '.' => "a.b"
        # @param string [String]
        # @return String
        def unescape string
          string ? string.gsub(/\\./) { |escaped| escaped[1] } : string
        end

        # Splits a string by an unescaped symbol
        # e.g. "a\.b.c.d\.e", '.'  => ["a\.b","c", "d\.e"]
        # @param string [String]
        # @param symbol [String]
        # @param max_splits [Integer]
        # @return [Array<String>]
        def split_by_unescaped string, symbol, max_splits = -1
          splits = 0
          string.scan(/\\.|#{symbol}|[^#{symbol}\\]+/).each_with_object([String.new]) do |tok, arr|
            if tok == symbol && (max_splits < 0 || splits < max_splits)
              arr.append String.new
              splits += 1
            else
              arr.last << tok
            end
            arr
          end
        end

        # Parse a comma-delimited list of equals-delimited lists of strings, while
        # mapping backslash-escaped commas and equal signs to literal characters.
        # @param str [String]
        # @param param_schema [ParameterSchema]
        # @return [Array<RequestParameter>]
        def parse_parameters_string str, param_schema=nil
          param_schema ||= get_default_schema

          param_val_input_strings = split_by_unescaped str, ","
          param_val_input_strings.map do |param_val_input_str|
            param_name_input_esc, value_str = split_by_unescaped param_val_input_str, "=", 1
            param_name_input = unescape param_name_input_esc
            param_type, param_config_name = param_schema.schema_name_type_for param_name_input

            param_value = if param_type == :array
                            array_value_strings = split_by_unescaped value_str, ";"
                            array_value_strings.map { |s| unescape s }
                          elsif param_type == :map
                            keyvaluepair_strings = split_by_unescaped value_str, ";"
                            newhash = keyvaluepair_strings.map do |kvp_str|
                              split_by_unescaped(kvp_str, "=", 1).map { |s| unescape s }
                            end
                            newhash.to_h
                          else
                            unescape value_str
                          end

            RequestParameter.new param_val_input_str, param_config_name, param_value
          end
        end
      end
    end
  end
end
