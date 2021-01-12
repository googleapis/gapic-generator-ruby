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
      class << self
        # Unescapes a symbol from the string
        # e.g. `'a\.b', '.' => 'a.b'`
        # @param string [String] String to unescape
        # @return [String] Unescaped string
        def unescape string
          string.gsub(/\\./) { |escaped| escaped[1] }
        end

        # Splits a string by an unescaped symbol
        # e.g. `'a\.b.c.d\.e', '.'  => ['a\.b', 'c', 'd\.e']`
        # @param string [String] String to split
        # @param symbol [String] Symbol to split by
        # @param max_splits [Integer] Maximum amount of splits to perform; -1 for no limit
        # @return [Array<String>] List of split string parts
        def split_by_unescaped string, symbol, max_splits = -1
          splits = 0
          escaped_symbol = Regexp.escape symbol
          string.scan(/\\.|#{escaped_symbol}|[^#{escaped_symbol}\\]+/).each_with_object([String.new]) do |tok, arr|
            if tok == symbol && (max_splits.negative? || splits < max_splits)
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
        # @param str [String] String to parse
        # @param param_schema [ParameterSchema] Parameter schema to use
        # @param error_output [IO] Stream to write outputs to.
        # @return [Array<RequestParameter>] List of parameters parsed
        def parse_parameters_string str, param_schema: nil, error_output: nil
          return [] if str.empty?
          param_schema ||= Gapic::Generators::DefaultGeneratorParameters.default_schema

          param_val_input_strings = split_by_unescaped str, ","
          param_val_input_strings.map do |param_val_input_str|
            param_name_input_esc, value_str = split_by_unescaped param_val_input_str, "=", 1
            param_name_input = unescape param_name_input_esc
            param_type, param_config_name = param_schema.schema_name_type_for param_name_input

            if param_type == :bool && !["true", "false"].include?(unescape(value_str))
              error_str = "WARNING: parameter #{param_name_input} (recognised as bool " \
                                          "#{param_config_name}) will be discarded because of " \
                                          "invalid value. Value should be either 'true' or 'false'."
              error_output&.puts error_str
            end

            param_value = parse_param_value param_type, value_str

            if param_value
              RequestParameter.new param_val_input_str, param_name_input_esc, value_str, param_config_name, param_value
            end
          end.compact # known bool parameters with invalid values will not be added so we have to compact
        end

        # Take a list of parameters and re-create an input string
        # that can be parsed into these parameters
        # @param parameters [Array<RequestParameter>] List of gapic-generator parameters
        # @return [String] an input string with parameters
        def reconstruct_parameters_string parameters
          parameters.map(&:input_str).join ","
        end

        private

        # Parses param value depending on type
        # @param param_type [Symbol]
        # @param value_str [String]
        # @return [String,Array<String>,Hash{String => String}]
        def parse_param_value param_type, value_str
          case param_type
          when :array
            # elements in the arrays are concatenated by `;`
            # e.g. foo;bar;baz
            array_value_strings = split_by_unescaped value_str, ";"
            array_value_strings.map { |s| unescape s }
          when :map
            # elements in the maps are `=` - separated key-value pairs, concatenated by ';'
            # e.g. foo=hoge;bar=piyo
            keyvaluepair_strings = split_by_unescaped value_str, ";"
            new_hash = keyvaluepair_strings.map do |kvp_str|
              split_by_unescaped(kvp_str, "=", 1).map { |s| unescape s }
            end
            new_hash.to_h
          when :bool
            # bools should be either `true` or `false`
            unesc_val = unescape value_str
            unesc_val if ["true", "false"].include? unesc_val
          else
            # if it's an unknown type, just escape it without attempting to parse anything
            unescape value_str
          end
        end
      end
    end
  end
end
