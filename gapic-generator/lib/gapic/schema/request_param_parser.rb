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

      def initialize input_str, input_name, input_value
        @input_str = input_str
        @input_name = input_name
        @input_value = input_value
      end

      def to_input_h
        { @input_name => input_value }
      end
    end

    # Contains logic for parsing protoc request parameters
    # from the plugin_opt command line
    module RequestParamParser
      class << self
        # Constructs param from the token parser output
        # @param current_input_str [String]
        # @param current_values [[String]]
        # @return RequestParameter
        def construct_param current_input_str, current_values
          # Parameter name: first element of the current_values.
          # if it starts with `:` then convert to a symbol
          param_name = current_values.shift
          param_name = param_name[1..-1].to_sym if param_name[0] == ":"

          # Parameter value: all other members of the current_values.
          # If there is only one current value -- convert to scalar
          # If there is two strings in current values and the second one is empty, then it's a single-value array
          param_val = if current_values.length == 1
                        current_values[0] == "" ? nil : current_values[0]
                      elsif current_values.length == 2 && current_values[1] == ""
                        [current_values[0]]
                      else
                        current_values
                      end

          RequestParameter.new current_input_str, param_name, param_val
        end

        # Parse a comma-delimited list of equals-delimited lists of strings, while
        # mapping backslash-escaped commas and equal signs to literal characters.
        # @param str [String]
        # @return [[RequestParameter]]
        def parse_parameter str
          parameters = []
          current_input_str = String.new
          current_values = [String.new]
          str.scan(/\\.|,|=|[^\\,=]+/).each do |tok|
            current_input_str << tok unless tok == ","

            if tok == ","
              parameters.append construct_param(current_input_str, current_values)
              current_input_str = String.new
              current_values = [String.new]
            elsif tok == "="
              current_values.append String.new
            elsif tok.start_with? "\\"
              current_values.last << tok[1]
            else
              current_values.last << tok
            end
          end

          parameters.append construct_param(current_input_str, current_values)
          parameters
        end
      end
    end
  end
end
