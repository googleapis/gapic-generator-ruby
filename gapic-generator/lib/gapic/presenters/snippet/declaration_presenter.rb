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
require "google/cloud/tools/snippetgen/configlanguage/v1/snippet_config_language.pb"
require "gapic/presenters/snippet/expression_presenter"

module Gapic
  module Presenters
    class SnippetPresenter
      ##
      # Presentation information about a declaration
      #
      class DeclarationPresenter
        ##
        # Create a declaration presenter.
        #
        # @param proto [Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Declaration]
        #     The protobuf representation of the declaration
        # @param json [String]
        #     The JSON representation of the declaration
        #
        def initialize proto, json
          @render = @render_lines = @name = @description = @has_value = nil
          return unless proto && json
          @name = proto.name
          @description = proto.description unless proto.description.empty?
          @render_lines = @description ? ["# #{@description}"] : []
          expr = ExpressionPresenter.new proto.value, json["value"]
          @has_value = expr.exist?
          if @has_value
            expr_lines = expr.render_lines
            expr_lines[0] = "#{proto.name} = #{expr_lines.first}"
            @render_lines += expr_lines
          end
          @render = @render_lines.join "\n"
        end

        ##
        # The name of the variable being declared
        # @return [String]
        #
        attr_reader :name

        ##
        # The description, or nil if none
        # @return [String,nil]
        #
        attr_reader :description

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
        # Whether the declaration could be interpreted.
        # @return [Boolean]
        #
        def exist?
          !render_lines.nil?
        end

        ##
        # Whether the declaration includes a value.
        # @return [Boolean]
        #
        def value?
          @has_value
        end
      end
    end
  end
end
