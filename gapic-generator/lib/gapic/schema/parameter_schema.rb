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
      attr_accessor :bool_params, :string_params, :array_params, :map_params

      def initialize bool_params = {}, string_params = {}, array_params = {}, map_params = {}
        @bool_params = bool_params
        @bool_params.map { |_, val| val unless @bool_params.key? val }.each { |v| @bool_params[v] = v }

        @string_params = string_params
        @string_params.map { |_, val| val unless @string_params.key? val }.each { |v| @string_params[v] = v }

        @array_params = array_params
        @array_params.map { |_, val| val unless @array_params.key? val }.each { |v| @array_params[v] = v }

        @map_params = map_params
        @map_params.map { |_, val| val unless @map_params.key? val }.each { |v| @map_params[v] = v }

        yield self if block_given?
      end

      # @param param_name [String]
      # @return [Label]
      def schema_name_type_for param_name
        if @bool_params.key?(param_name)
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
