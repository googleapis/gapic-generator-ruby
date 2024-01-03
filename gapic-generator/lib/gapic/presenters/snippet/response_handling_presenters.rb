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


module Gapic
  module Presenters
    class SnippetPresenter
      ##
      # Some common private methods for response handling presenters
      #
      module ResponseHandlingPresenterCommon
        private

        def compute_response_name proto, phase1
          return "result" if phase1
          return nil if proto&.response_name.to_s.empty?
          proto.response_name
        end
      end

      ##
      # Presentation information about simple response handling
      #
      class SimpleResponseHandlingPresenter
        include ResponseHandlingPresenterCommon

        ##
        # Create a simple response handling presenter
        #
        # @param proto [Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::SimpleResponseHandling]
        #     The protobuf representation
        # @param json [String]
        #     The JSON representation
        # @param response_type [String] The fully qualified response message class
        # @param phase1 [Boolean] True if this is a phase 1 snippet without config
        #
        def initialize proto, _json, response_type:, phase1:
          @response_name = compute_response_name proto, phase1
          @render_lines =
            if @response_name && phase1
              [
                "# The returned object is of type #{response_type}.",
                "p #{@response_name}"
              ]
            else
              []
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

        ##
        # The name of the response variable, or nil for no response handling
        # @return [String,nil]
        #
        attr_reader :response_name
      end

      ##
      # Presentation information about LRO response handling
      #
      class LroResponseHandlingPresenter
        include ResponseHandlingPresenterCommon

        ##
        # Create an LRO response handling presenter
        #
        # @param proto [Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::LroResponseHandling]
        #     The protobuf representation
        # @param json [String]
        #     The JSON representation
        # @param phase1 [Boolean] True if this is a phase 1 snippet without config
        #
        def initialize proto, _json, phase1:
          @response_name = compute_response_name proto, phase1
          @render_lines = []
          if @response_name
            if phase1
              @render_lines << "# The returned object is of type Gapic::Operation. You can use it to"
              @render_lines << "# check the status of an operation, cancel it, or wait for results."
            end
            case proto&.polling_type
            when :NONE
              # Do nothing
            when :ONCE
              @render_lines += check_once_lines phase1
            else
              @render_lines += wait_response_lines phase1
            end
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

        ##
        # The name of the response variable, or nil for no response handling
        # @return [String,nil]
        #
        attr_reader :response_name

        private

        def check_once_lines phase1
          lines = []
          lines << "# Here is how to check once for a response." if phase1
          lines + [
            "if #{@response_name}.response?",
            "  p #{@response_name}.response",
            "else",
            '  puts "Response not yet arrived."',
            "end"
          ]
        end

        def wait_response_lines phase1
          lines = []
          lines << "# Here is how to wait for a response." if phase1
          lines + [
            "#{@response_name}.wait_until_done! timeout: 60",
            "if #{@response_name}.response?",
            "  p #{@response_name}.response",
            "else",
            '  puts "No response received."',
            "end"
          ]
        end
      end

      ##
      # Presentation information about server-streaming response handling
      #
      class StreamingResponseHandlingPresenter
        ##
        # Create a server-streaming response handling presenter
        #
        # @param proto [Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::StreamingResponseHandling]
        #     The protobuf representation
        # @param json [String]
        #     The JSON representation
        # @param response_name [String] The name of the stream variable
        # @param base_response_type [String] The fully qualified message class
        #     for individual responses
        # @param phase1 [Boolean] True if this is a phase 1 snippet without config
        #
        def initialize proto, json, response_name:, base_response_type:, phase1:
          @response_name = response_name
          @render_lines = []
          if response_name
            if phase1 && base_response_type
              @render_lines << "# The returned object is a streamed enumerable yielding elements of type"
              @render_lines << "# #{base_response_type}"
            end
            @render_lines += per_stream_response_lines proto, json, response_name, phase1
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

        ##
        # The name of the response variable, or nil for no response handling
        # @return [String,nil]
        #
        attr_reader :response_name

        private

        def per_stream_response_lines proto, json, response_name, phase1
          lines = []
          item_name = phase1 ? "current_response" : proto.current_response_name
          lines << "#{response_name}.each do |#{item_name}|"
          if json&.key? "perStreamResponseStatements"
            proto.per_stream_response_statements&.each_with_index do |statement_proto, index|
              statement = StatementPresenter.new statement_proto, json["perStreamResponseStatements"][index]
              lines += statement.render_lines.map { |line| "  #{line}" }
            end
          else
            lines << "  p #{item_name}"
          end
          lines << "end"
          lines
        end
      end

      ##
      # Presentation information about paginated response handling
      #
      class PaginatedResponseHandlingPresenter
        include ResponseHandlingPresenterCommon

        ##
        # Create a paginated response handling presenter
        #
        # @param proto [Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::PaginatedResponseHandling]
        #     The protobuf representation
        # @param json [String]
        #     The JSON representation
        # @param paged_response_type [String] The fully qualified message class
        #     for individual responses
        # @param phase1 [Boolean] True if this is a phase 1 snippet without config
        #
        def initialize proto, json, paged_response_type:, phase1:
          @response_name = compute_response_name proto, phase1
          @render_lines = []
          if @response_name
            if phase1
              @render_lines << "# The returned object is of type Gapic::PagedEnumerable. You can iterate"
              @render_lines << "# over elements, and API calls will be issued to fetch pages as needed."
            end
            @render_lines +=
              if proto&.by_page
                by_page_lines proto, json, @response_name, paged_response_type, phase1
              elsif proto&.next_page_token
                next_page_token_lines proto, json
              else
                by_item_lines proto, json, @response_name, paged_response_type, phase1
              end
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

        ##
        # The name of the response variable, or nil for no response handling
        # @return [String,nil]
        #
        attr_reader :response_name

        private

        def by_item_lines proto, json, collection_name, paged_response_type, phase1
          lines = []
          proto = proto&.by_item
          json = json&.fetch "byItem", nil
          item_name = phase1 ? "item" : proto.item_name
          lines << "#{collection_name}.each do |#{item_name}|"
          if json&.key? "perItemStatements"
            proto.per_item_statements&.each_with_index do |item_proto, index|
              statement = StatementPresenter.new item_proto, json["perItemStatements"][index]
              lines += statement.render_lines.map { |line| "  #{line}" }
            end
          else
            lines << "  # Each element is of type #{paged_response_type}." if phase1
            lines << "  p #{item_name}"
          end
          lines << "end"
          lines
        end

        def by_page_lines proto, json, response_name, paged_response_type, phase1
          lines = []
          proto = proto.by_page
          json = json["byPage"]
          page_name = phase1 ? "page" : proto.page_name
          lines << "#{response_name}.each_page do |#{page_name}|"
          if json&.key? "perPageStatements"
            proto.per_page_statements&.each_with_index do |page_proto, index|
              statement = StatementPresenter.new page_proto, json["perPageStatements"][index]
              lines += statement.render_lines.map { |line| "  #{line}" }
            end
          end
          iteration_lines = by_item_lines proto, json, page_name, paged_response_type, phase1
          lines + iteration_lines.map { |line| "  #{line}" } + ["end"]
        end

        def next_page_token_lines _proto, _json
          # TODO
          []
        end
      end
    end
  end
end
