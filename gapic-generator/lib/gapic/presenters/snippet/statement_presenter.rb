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
require "gapic/presenters/snippet/declaration_presenter"
require "gapic/presenters/snippet/iteration_presenter"

module Gapic
  module Presenters
    class SnippetPresenter
      ##
      # Presentation information about a statement
      #
      class StatementPresenter
        ##
        # Create a statement presenter.
        #
        # @param proto [Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Statement]
        #     The protobuf representation of the statement
        # @param json [String]
        #     The JSON representation of the statement
        #
        def initialize proto, json
          @render_lines =
            if json&.key? "declaration"
              declaration_lines proto.declaration, json["declaration"]
            elsif json&.key? "standardOutput"
              output_lines proto.standard_output, json["standardOutput"]
            elsif json&.key? "return"
              return_lines proto.return, json["return"]
            elsif json&.key? "conditional"
              conditional_lines proto.conditional, json["conditional"]
            elsif json&.key? "iteration"
              iteration_lines proto.iteration, json["iteration"]
            else
              ["# Unknown statement omitted here."]
            end
          @render = @render_lines.join "\n"
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

        private

        def declaration_lines proto, json
          declaration = DeclarationPresenter.new proto, json
          if declaration.exist?
            declaration.render_lines
          else
            ["# Unknown declaration statement omitted here."]
          end
        end

        def output_lines proto, json
          expr = ExpressionPresenter.new proto.value, json["value"]
          return ["# Unknown output statement omitted here."] unless expr.exist?
          lines = expr.render_lines
          if lines.size == 1
            ["puts(#{lines.first})"]
          else
            ["puts("] + lines.map { |line| "  #{line}" } + [")"]
          end
        end

        def return_lines proto, json
          expr = ExpressionPresenter.new proto.result, json["result"]
          return ["# Unknown return statement omitted here."] unless expr.exist?
          lines = expr.render_lines
          lines[0] = "return #{lines.first}"
          lines
        end

        def conditional_lines proto, json
          expr = ExpressionPresenter.new proto.condition, json["condition"]
          return ["# Unknown conditional statement omitted here."] unless expr.exist?

          if json.key? "onTrue"
            conditional_lines_inner "if", expr, proto.on_true, json["onTrue"], proto.on_false, json["onFalse"]
          elsif json.key? "onFalse"
            conditional_lines_inner "unless", expr, proto.on_false, json["onFalse"], nil, nil
          else
            ["# Do nothing"]
          end
        end

        def conditional_lines_inner keyword, expr, if_protos, if_json, else_protos, else_json
          lines = ["#{keyword} #{expr.render}"]
          if_protos.each_with_index do |statement_proto, index|
            statement = StatementPresenter.new statement_proto, if_json[index]
            lines += statement.render_lines.map { |line| "  #{line}" }
          end
          if else_json
            lines << "else"
            else_protos.each_with_index do |statement_proto, index|
              statement = StatementPresenter.new statement_proto, else_json[index]
              lines += statement.render_lines.map { |line| "  #{line}" }
            end
          end
          lines << "end"
          lines
        end

        def iteration_lines proto, json
          iteration = IterationPresenter.new proto, json
          if iteration.exist?
            iteration.render_lines
          else
            ["# Unknown iteration statement omitted here."]
          end
        end
      end
    end
  end
end
