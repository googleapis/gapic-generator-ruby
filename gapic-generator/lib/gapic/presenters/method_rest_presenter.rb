# frozen_string_literal: true

# Copyright 2021 Google LLC
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

require "gapic/presenters/method/rest_pagination_info"

module Gapic
  module Presenters
    ##
    # A presenter for rpc methods (REST submethods)
    #
    class MethodRestPresenter
      # @return [Gapic::Presenters::Method::RestPaginationInfo]
      attr_reader :pagination

      attr_reader :http_bindings

      ##
      # @param main_method [Gapic::Presenters::MethodPresenter] the main presenter for this method.
      # @param api [Gapic::Schema::Api]
      #
      def initialize main_method, api
        @main_method = main_method
        @http_bindings = main_method.http_bindings
        @pagination = Gapic::Presenters::Method::RestPaginationInfo.new main_method.method, api
      end

      ##
      # Name for the GRPC transcoding helper method
      #
      # @return [String]
      #
      def transcoding_helper_name
        "transcode_#{name}_request"
      end

      ##
      # Method name
      #
      # @return [String]
      #
      def name
        @main_method.name
      end

      # Fully qualified proto name of the method (namespace.PascalCase)
      # @return [String]
      def grpc_full_name
        @main_method.grpc.full_name
      end

      ##
      # Full class name of the request type
      #
      # @return [String]
      #
      def request_type
        @main_method.request_type
      end

      ##
      # Full class name of the raw return type of the RPC
      #
      # @return [String]
      #
      def return_type
        @main_method.return_type
      end

      ##
      # Full class name of the return type of the method
      # (including LRO and Paged cases)
      #
      # @return [String]
      #
      def doc_response_type
        return "::Gapic::Operation" if lro?
        return "::Gapic::Rest::PagedEnumerable<#{pagination.paged_element_doc_type}>" if paged?
        return "::Gapic::GenericLRO::Operation" if nonstandard_lro?
        return_type
      end

      ##
      # Whether the REGAPIC method should be rendered as paged
      #
      # @return [Boolean]
      #
      def paged?
        @pagination.paged?
      end

      def lro?
        @main_method.lro?
      end

      ##
      # Whether this method uses nonstandard LROs
      #
      # @return [Boolean]
      #
      def nonstandard_lro?
        @main_method.nonstandard_lro?
      end

      ##
      # The presenter for the nonstandard LRO client of the kind this method uses
      #
      # @return [Gapic::Presenters::Service::LroClientPresenter, nil]
      #
      def nonstandard_lro_client
        return unless nonstandard_lro?
        @main_method.service.rest.nonstandard_lros.find { |model| model.service == @main_method.lro.service_full_name }
      end

      ##
      # Whether this method can be generated in REST clients
      # Only methods with http bindings can be generated, and
      # additionally only unary methods are currently supported.
      #
      # @return [Boolean]
      #
      def can_generate_rest?
        [:normal, :server].include?(@main_method.kind) &&
          http_bindings.first&.verb? &&
          http_bindings.first&.path?
      end

      ##
      # Whether this method is a server-streaming method
      #
      # @return [Boolean]
      #
      def server_streaming?
        @main_method.server_streaming?
      end
    end
  end
end
