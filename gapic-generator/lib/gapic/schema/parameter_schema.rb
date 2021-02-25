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

module Gapic
  module Schema
    # Contains information about known parameter names
    # and the types expected to be parsed from the request options string
    class ParameterSchema
      attr_accessor :bool_params
      attr_accessor :string_params
      attr_accessor :array_params
      attr_accessor :map_params

      # Creates a schema with given alias-parameter maps
      # @param bool_params [Hash{String => String}]
      # @param string_params [Hash{String => String}]
      # @param array_params [Hash{String => String}]
      # @param map_params [Hash{String => String}]
      def initialize bool_params = {}, string_params = {}, array_params = {}, map_params = {}
        @bool_params = bool_params
        @string_params = string_params
        @array_params = array_params
        @map_params = map_params
      end

      # Creates a schema from given parameter lists
      # @param bool_params_list [Array<String>]
      # @param string_params_list [Array<String>]
      # @param array_params_list [Array<String>]
      # @param map_params_list [Array<String>]
      # @return Gapic::Schema::ParameterSchema
      def self.create bool_params_list: [], string_params_list: [], array_params_list: [], map_params_list: []
        bool_params = bool_params_list.map { |val| [val, val] }.to_h
        string_params = string_params_list.map { |val| [val, val] }.to_h
        array_params = array_params_list.map { |val| [val, val] }.to_h
        map_params = map_params_list.map { |val| [val, val] }.to_h

        ParameterSchema.new bool_params, string_params, array_params, map_params
      end

      # Creates a new schema from this by adding aliases to existing parameters
      # @param bool_aliases [Hash{String => String}]
      # @param string_aliases [Hash{String => String}]
      # @param array_aliases [Hash{String => String}]
      # @param map_aliases [Hash{String => String}]
      # @return Gapic::Schema::ParameterSchema
      def extend_with_aliases bool_aliases: {}, string_aliases: {}, array_aliases: {}, map_aliases: {}
        bool_params = @bool_params
        bool_aliases.each { |param_alias, param| bool_params[param_alias] = param if bool_params.key? param }

        string_params = @string_params
        string_aliases.each { |param_alias, param| string_params[param_alias] = param if string_params.key? param }

        array_params = @array_params
        array_aliases.each { |param_alias, param| array_params[param_alias] = param if array_params.key? param }

        map_params = @map_params
        map_aliases.each { |param_alias, param| map_params[param_alias] = param if map_params.key? param }

        ParameterSchema.new bool_params, string_params, array_params, map_params
      end

      # Looks up a parameter by name (including aliases)
      # and return a type label (or :unknown) and a configuration name
      # @param param_name [String] Input parameter name
      # @return [Array<Symbol, String>] An array of [:detected_type, config_parameter_name]
      def schema_name_type_for param_name
        if @bool_params.key? param_name
          [:bool, @bool_params[param_name]]
        elsif @string_params.key? param_name
          [:string, @string_params[param_name]]
        elsif @array_params.key? param_name
          [:array, @array_params[param_name]]
        elsif @map_params.key? param_name
          [:map, @map_params[param_name]]
        else
          [:unknown, param_name]
        end
      end
    end
  end
end
