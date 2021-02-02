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

require "googleauth"

module Gapic
  module Rest
    ##
    # A class for making REST calls through Faraday
    # ClientStub's responsibilities:
    #   - wrap Faraday methods with a bounded explicit interface
    #   - store service endpoint and create full url for the request
    #   - store credentials and add auth information to the request
    #   - convert errors from HTTP responses into ::Gapic::Rest::Error
    #
    class ClientStub
      def initialize endpoint:, credentials:
        @endpoint = endpoint
        @endpoint = "https://#{endpoint}" unless /https?:/.match? endpoint
        @endpoint = @endpoint.chop if @endpoint.to_s.chars.last == "/"

        @credentials = credentials

        @connection = Faraday.new url: @endpoint do |conn|
          conn.headers = { "Content-Type" => "application/json" }
          conn.authorization :Bearer, @credentials.client.access_token
          conn.request :retry
          conn.response :raise_error
          conn.adapter :net_http
        end

        yield @connection if block_given?
      end

      # @param uri [String]
      # @return [Hash { Symbol => String }]
      def make_get_request uri:, params:{}, options:{}, &block
        make_http_request :get, uri: uri, body: nil, params: params, options: options, &block
      end

      # @param uri [String]
      # @return [Hash { Symbol => String }]
      def make_delete_request uri:, params:{}, options:{}, &block
        make_http_request :delete, uri: uri, body: nil, params: params, options: options, &block
      end

      # @param uri [String]
      # @param body [String]
      # @return [Hash { Symbol => String }]
      def make_post_request uri:, body:, params: {}, options: {}, &block
        make_http_request :post, uri: uri, body: body, params: params, options: options, &block
      end

      # @param uri [String]
      # @param body [String]
      # @return [Hash { Symbol => String }]
      def make_patch_request uri:, body:, params:{}, options:{}, &block
        make_http_request :patch, uri: uri, body: body, params: params, options: options, &block
      end

      protected

      def make_http_request verb, uri:, body:, params:, options:
        response = @connection.send verb, uri do |req|
          req.params = params if params.any?
          req.body = body unless body.nil?
        end

        yield response if block_given?

        response
      end
    end
  end
end