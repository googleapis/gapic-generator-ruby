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
require "gapic/presenters/snippet/expression_presenter"
require "gapic/presenters/snippet/iteration_presenter"

module Gapic
  module Presenters
    class SnippetPresenter
      ##
      # Presentation information about an iteration
      #
      class IterationPresenter
        ##
        # Create an iteration presenter.
        #
        # @param proto [Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Statement::Iteration]
        #     The protobuf representation of the iteration
        # @param json [String]
        #     The JSON representation of the iteration
        #
        def initialize proto, json
          @prelude_render_lines, @postlude_render_lines =
            if json&.key? "repeatedIteration"
              parse_repeated_iteration proto.repeated_iteration, json["repeatedIteration"]
            elsif json&.key? "mapIteration"
              parse_map_iteration proto.map_iteration, json["mapIteration"]
            else
              # TODO: numeric sequence and bytes iteration
              [[], []]
            end
          if @prelude_render_lines.empty? && @postlude_render_lines.empty?
            @inner_render_lines = @render_lines = @render = nil
          else
            @inner_render_lines = parse_inner_lines proto&.statements, json&.fetch("statements", nil)
            @render_lines = @prelude_render_lines +
                            @inner_render_lines.map { |line| "  #{line}" } +
                            @postlude_render_lines
            @render = @render_lines.join "\n"
          end
        end

        ##
        # The iteration prelude lines
        # @return [Array<String>]
        #
        attr_reader :prelude_render_lines

        ##
        # The iteration postlude lines
        # @return [Array<String>]
        #
        attr_reader :postlude_render_lines

        ##
        # The inner statement lines
        # @return [Array<String>]
        #
        attr_reader :inner_render_lines

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
        # Whether the iteration could be interpreted.
        # @return [Boolean]
        #
        def exist?
          !render_lines.nil?
        end

        private

        def parse_repeated_iteration proto, json
          decl = DeclarationPresenter.new proto.repeated_elements, json["repeatedElements"]
          prelude = decl.render_lines + ["#{decl.name}.each do |#{proto.current_name}|"]
          [prelude, ["end"]]
        end

        def parse_map_iteration proto, json
          decl = DeclarationPresenter.new proto.map, json["map"]
          prelude = decl.render_lines +
                    ["#{decl.name}.each do |#{proto.current_key_name}, #{proto.current_value_name}|"]
          [prelude, ["end"]]
        end

        def parse_inner_lines protos, jsons
          lines = []
          protos.each_with_index do |statement, index|
            inner_statement = StatementPresenter.new statement, jsons[index]
            lines += inner_statement.render_lines
          end
          lines
        end
      end
    end
  end
end
