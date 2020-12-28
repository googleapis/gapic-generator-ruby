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
    # Encapsulates information that is parsed from a single command line parameter
    # from the plugin_opt command line
    class RequestParameter
      attr_reader :input_str, :input_name, :input_value, :config_name, :config_value

      # @param input_str [String] the input string containing parameter and value
      #   that the parameter and value were parsed from
      # @param input_name [String] the name of the parameter as found in the input
      #   can be an alias to a known config parameter name
      # @param input_value [String] the unescaped input value of the parameter as found in the input
      # @param config_name [String] the known config parameter name as matched during parsing
      # @param config_value [String,Array,Hash] the parsed and deserialized config value
      def initialize input_str, input_name, input_value, config_name, config_value
        @input_str = input_str
        @input_name = input_name
        @input_value = input_value
        @config_name = config_name
        @config_value = config_value
      end

      # The hash of input name-value
      # @return [Hash {String => String}]
      def to_input_h
        { input_name => input_value }
      end

      # The hash of config name-value
      # @return [Hash {String => String, Array, Hash}]
      def to_config_h
        { config_name => config_value }
      end
    end
  end
end
