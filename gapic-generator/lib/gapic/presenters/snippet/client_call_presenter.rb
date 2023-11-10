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
require "gapic/presenters/snippet/statement_presenter"

module Gapic
  module Presenters
    class SnippetPresenter
      ##
      # Presentation information about client call invocation
      #
      class ClientCallPresenter
        ##
        # Create a client call presenter
        #
        # @param proto [Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::ClientCall]
        #     The protobuf representation
        # @param json [String]
        #     The JSON representation
        # @param method_name [String] The method name
        # @param request_name [String] The request variable name
        # @param response_name [String,nil] The response variable name, or nil for no response handling
        # @param client_streaming [Boolean] True if the call is client streaming
        # @param server_streaming [Boolean] True if the call is server streaming
        # @param phase1 [Boolean] True if this is a phase 1 snippet without config
        #
        def initialize proto, json,
                       method_name:, request_name:, response_name:, client_streaming:, server_streaming:, phase1:
          @render_lines = pre_call_lines proto, json, method_name, client_streaming, server_streaming, phase1
          main_line = "client.#{method_name} #{request_name}"
          main_line = "#{response_name} = #{main_line}" if response_name
          @render_lines << main_line
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

        def pre_call_lines proto, json, method_name, client_streaming, server_streaming, phase1
          lines = []
          if json&.key? "preCall"
            proto.pre_call.each_with_index do |statement_proto, index|
              statement = StatementPresenter.new statement_proto, json["preCall"][index]
              lines += statement.render_lines
            end
          elsif phase1
            lines <<
              if client_streaming || server_streaming
                "# Call the #{method_name} method to start streaming."
              else
                "# Call the #{method_name} method."
              end
          end
          lines
        end
      end
    end
  end
end
