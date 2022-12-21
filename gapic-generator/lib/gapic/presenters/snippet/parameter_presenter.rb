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
require "gapic/presenters/snippet/type_presenter"

module Gapic
  module Presenters
    class SnippetPresenter
      ##
      # Presentation information about a snippet method parameter
      #
      class ParameterPresenter
        ##
        # Create an expression presenter.
        #
        # @param proto [Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Declaration]
        #     The protobuf representation of the parameter
        # @param json [String]
        #     The JSON representation of the parameter
        #
        def initialize proto, json
          @name = proto.name
          @description = proto.description
          @description = nil if @description&.empty?
          @type = TypePresenter.new proto&.type, json&.fetch("type", nil)
          @example = ExpressionPresenter.new proto&.value, json&.fetch("value", nil)
        end

        ##
        # The name of this parameter
        # @return [String]
        #
        attr_reader :name

        ##
        # A description of this parameter, or nil if none.
        # @return [String,nil]
        #
        attr_reader :description

        ##
        # The type of this parameter, as a presenter.
        # @return [Gapic::Presenters::SnippetPresenter::TypePresenter]
        #
        attr_reader :type

        ##
        # The default/example value for this parameter, as a presenter.
        # @return [Gapic::Presenters::SnippetPresenter::ExpressionPresenter]
        #
        attr_reader :example
      end
    end
  end
end
