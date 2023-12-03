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
require "gapic/presenters/snippet/statement_presenter"

module Gapic
  module Presenters
    class SnippetPresenter
      ##
      # Presentation information about simple request initialization
      #
      class SimpleRequestInitializationPresenter
        ##
        # Create a simple request init presenter.
        #
        # @param proto [Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::SimpleRequestInitialization]
        #     The protobuf representation
        # @param json [String]
        #     The JSON representation
        # @param request_type [String] The fully qualified request message class
        # @param phase1 [Boolean] True if this is a phase 1 snippet without config
        # @param default_request_name [String] Default name of request variable
        #
        def initialize proto, json, request_type:, phase1:, default_request_name: "request"
          @request_name = phase1 ? default_request_name : proto.request_name
          @render_precall_lines =
            if proto
              configured_lines proto, json, request_type
            else
              fallback_lines request_type
            end
          @render_precall = @render_precall_lines.join "\n"
          @render_postcall_lines = []
          @render_postcall = ""
        end

        ##
        # The lines of rendered code for before the rpc call
        # @return [Array<String>]
        #
        attr_reader :render_precall_lines

        ##
        # The pre-call rendered code as a single string, possibly with line breaks
        # @return [String]
        #
        attr_reader :render_precall

        ##
        # The lines of rendered code for after the rpc call
        # @return [Array<String>]
        #
        attr_reader :render_postcall_lines

        ##
        # The post-call rendered code as a single string, possibly with line breaks
        # @return [String]
        #
        attr_reader :render_postcall

        ##
        # The name of the request variable set
        # @return [String]
        #
        attr_reader :request_name

        private

        def fallback_lines request_type
          [
            "# Create a request. To set request fields, pass in keyword arguments.",
            "#{@request_name} = #{request_type}.new"
          ]
        end

        def configured_lines proto, json, request_type
          pre_lines = []
          if json.key? "preRequestInitialization"
            proto.pre_request_initialization&.each_with_index do |statement_proto, index|
              statement = StatementPresenter.new statement_proto, json["preRequestInitialization"][index]
              pre_lines += statement.render_lines
            end
          end
          expr = ExpressionPresenter.new proto.request_value, json["requestValue"]
          if expr.exist?
            request_lines = expr.render_lines
            request_lines[0] = "#{@request_name} = #{request_lines.first}"
          else
            request_lines = fallback_lines request_type
          end
          pre_lines + request_lines
        end
      end

      ##
      # Presentation information about client-streaming request initialization
      #
      class StreamingRequestInitializationPresenter
        ##
        # Create a streaming request init presenter.
        #
        # @param proto [Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::StreamingRequestInitialization]
        #     The protobuf representation
        # @param json [String]
        #     The JSON representation
        # @param request_name [String] The request variable name
        # @param request_type [String] The fully qualified request message class
        # @param phase1 [Boolean] True if this is a phase 1 snippet without config
        #
        def initialize proto, json, request_name:, request_type:, phase1:
          @request_name = request_name
          @render_precall_lines = []
          @render_precall_lines << "# Create an input stream." if phase1
          @render_precall_lines << "#{request_name} = Gapic::StreamInput.new"
          @render_precall = @render_precall_lines.join "\n"

          @render_postcall_lines =
            if proto && json
              configured_lines proto, json, request_name, request_type
            else
              fallback_lines request_name, request_type
            end
          @render_postcall = @render_postcall_lines.join "\n"
        end

        ##
        # The lines of rendered code for before the rpc call
        # @return [Array<String>]
        #
        attr_reader :render_precall_lines

        ##
        # The pre-call rendered code as a single string, possibly with line breaks
        # @return [String]
        #
        attr_reader :render_precall

        ##
        # The lines of rendered code for after the rpc call
        # @return [Array<String>]
        #
        attr_reader :render_postcall_lines

        ##
        # The post-call rendered code as a single string, possibly with line breaks
        # @return [String]
        #
        attr_reader :render_postcall

        ##
        # The name of the request variable set
        # @return [String]
        #
        attr_reader :request_name

        private

        def configured_lines proto, json, request_name, request_type
          lines = []
          if json.key? "firstStreamingRequest"
            first_request = SimpleRequestInitializationPresenter.new \
              proto.first_streaming_request, json["firstStreamingRequest"],
              default_request_name: "stream_item", request_type: request_type, phase1: false
            lines += first_request.render_precall_lines
            lines << "#{request_name} << #{first_request.request_name}"
          end
          next_request = SimpleRequestInitializationPresenter.new \
            proto.streaming_request, json["streamingRequest"],
            default_request_name: "stream_item", request_type: request_type, phase1: false
          iteration = IterationPresenter.new proto.iteration, json["iteration"]
          lines += iteration.prelude_render_lines
          lines += next_request.render_precall_lines.map { |line| "  #{line}" }
          lines << "  #{request_name} << #{next_request.request_name}"
          lines += iteration.postlude_render_lines
          lines + ["#{request_name}.close"]
        end

        def fallback_lines request_name, request_type
          [
            "# Send requests on the stream. For each request object, set fields by",
            "# passing keyword arguments. Be sure to close the stream when done.",
            "#{request_name} << #{request_type}.new",
            "#{request_name} << #{request_type}.new",
            "#{request_name}.close"
          ]
        end
      end
    end
  end
end
