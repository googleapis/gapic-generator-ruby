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
      # Presentation information about client object initialization
      #
      class ClientInitializationPresenter
        ##
        # Create an client init presenter.
        #
        # @param proto [Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::ClientInitialization]
        #     The protobuf representation
        # @param json [String]
        #     The JSON representation
        # @param phase1 [Boolean] Whether to inject phase 1 content
        # @param client_type [String] The fully qualified class name of the client
        #
        def initialize proto, json, phase1:, client_type:
          @render_lines = []
          if json&.key? "preClientInitialization"
            proto.pre_client_initialization.each_with_index do |stmt_proto, index|
              statement = StatementPresenter.new stmt_proto, json["preClientInitialization"][index]
              @render_lines += statement.render_lines
            end
          elsif phase1
            @render_lines << "# Create a client object. The client can be reused for multiple calls."
          end
          @render_lines += build_create_code proto, client_type
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

        def build_create_code proto, client_type
          create_code = "client = #{client_type}.new"
          if proto&.custom_service_endpoint
            endpoint = build_endpoint proto.custom_service_endpoint
            [
              "#{create_code} do |config|",
              "  config.endpoint = #{endpoint.inspect}",
              "end"
            ]
          else
            [create_code]
          end
        end

        def build_endpoint proto
          init_module = Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::ClientInitialization
          schema = proto.schema == init_module::ServiceEndpoint::ServiceEndpointSchema::HTTP ? "http://" : "https://"
          region = proto.region.to_s.empty? ? "" : "#{proto.region}-"
          port = proto.port.zero? ? "" : ":#{proto.port}"
          [schema, region, proto.host, port].join
        end
      end
    end
  end
end
