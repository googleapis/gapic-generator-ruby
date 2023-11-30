# frozen_string_literal: true

# Copyright 2022 Google LLC
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

require "active_support/inflector"
require "google/cloud/tools/snippetgen/configlanguage/v1/snippet_config_language_pb"

module Gapic
  module Presenters
    class SnippetPresenter
      ##
      # Presentation information about an expression
      #
      class ExpressionPresenter
        ##
        # Create an expression presenter.
        #
        # @param proto [Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Expression]
        #     The protobuf representation of the expression
        # @param json [String]
        #     The JSON representation of the expression
        #
        def initialize proto, json
          @render_lines =
            if json&.key? "stringValue"
              render_string proto
            elsif json&.key? "numberValue"
              render_number proto
            elsif json&.key? "booleanValue"
              render_boolean proto
            elsif json&.key? "nullValue"
              ["nil"]
            elsif json&.key? "nameValue"
              render_name proto.name_value
            elsif json&.key? "complexValue"
              render_complex proto.complex_value.properties, json["complexValue"]["properties"]
            elsif json&.key? "listValue"
              render_list proto.list_value.values, json["listValue"]["values"]
            elsif json&.key? "mapValue"
              render_map proto.map_value, json["mapValue"]
            end
          @render = @render_lines&.join " "
        end

        ##
        # The lines of rendered code
        # @return [Array<String>]
        #
        attr_reader :render_lines

        ##
        # The rendered code as a single string, possibly with line breaks
        # @return [String]
        #
        attr_reader :render

        ##
        # Whether the expression could be interpreted.
        # @return [Boolean]
        #
        def exist?
          !render_lines.nil?
        end

        private

        def render_string proto
          [proto.string_value.inspect]
        end

        def render_number proto
          value = proto.number_value
          value = value.to_i if value == value.to_i
          [value.inspect]
        end

        def render_boolean proto
          [proto.boolean_value.inspect]
        end

        def render_name proto
          line = ([proto.name] + Array(proto.path&.to_a)).join "."
          [line]
        end

        def render_complex proto, json
          lines = ["{"]
          proto.each do |key, value_expr|
            value_presenter = ExpressionPresenter.new value_expr, json[key]
            value_lines = value_presenter.render_lines
            next unless value_lines
            lines[lines.size - 1] = "#{lines.last}," if lines.size > 1
            value_lines[0] = "#{key}: #{value_lines.first}"
            lines += value_lines.map { |line| "  #{line}" }
          end
          lines + ["}"]
        end

        def render_list proto, json
          lines = ["["]
          proto.each_with_index do |item, index|
            expr = ExpressionPresenter.new item, json[index]
            value_lines = expr.render_lines
            lines[lines.size - 1] = "#{lines.last}," if lines.size > 1
            lines += value_lines.map { |line| "  #{line}" }
          end
          lines + ["]"]
        end

        def render_map proto, json
          lines = ["{"]
          proto.keys.zip(proto.values).each_with_index do |(key, value), index|
            key_lines = ExpressionPresenter.new(key, json["keys"][index]).render_lines
            value_lines = ExpressionPresenter.new(value, json["values"][index]).render_lines
            next unless key_lines && value_lines
            elem_lines = key_lines[0..-2] + ["#{key_lines.last} => #{value_lines.first}"] + value_lines[1..]
            lines[lines.size - 1] = "#{lines.last}," if lines.size > 1
            lines += elem_lines.map { |line| "  #{line}" }
          end
          lines + ["}"]
        end
      end
    end
  end
end
