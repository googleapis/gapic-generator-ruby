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
      end

      # @param uri [String]
      # @return [Hash { Symbol => String }]
      def make_get_request uri:, options:
        request_url = create_request_url uri
        headers = {
          "Authorization" => "Bearer #{@credentials.client.access_token}"
        }

        response = Faraday.get request_url do |req|
          req.headers = headers
        end

        result = response.to_hash
        yield result, response.env if block_given?

        if result[:status] != 200
          raise ::Gapic::Rest::Error.new "An error has occurred when making a REST request", result: result
        end

        result
      end

      # @param uri [String]
      # @return [Hash { Symbol => String }]
      def make_delete_request uri:, options:
        request_url = create_request_url uri
        headers = {
          "Authorization" => "Bearer #{@credentials.client.access_token}"
        }

        response = Faraday.delete request_url do |req|
          req.headers = headers
        end

        result = response.to_hash
        yield result, response.env if block_given?

        if result[:status] != 200
          raise ::Gapic::Rest::Error.new "An error has occurred when making a REST request", result: result
        end

        result
      end

      # @param uri [String]
      # @param body [String]
      # @return [Hash { Symbol => String }]
      def make_post_request uri:, body:, options:
        request_url = create_request_url uri
        headers = {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{@credentials.client.access_token}"
        }

        response = Faraday.post(
          request_url,
          body,
          headers
        )
        result = response.to_hash
        yield result, response.env if block_given?

        if result[:status] != 200
          raise ::Gapic::Rest::Error.new "An error has occurred when making a REST request", result: result
        end

        result
      end

      # @param uri [String]
      # @param body [String]
      # @return [Hash { Symbol => String }]
      def make_patch_request uri:, body:, options:
        request_url = create_request_url uri
        headers = {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{@credentials.client.access_token}"
        }

        response = Faraday.put(
          request_url,
          body,
          headers
        )
        result = response.to_hash
        yield result, response.env if block_given?

        if result[:status] != 200
          raise ::Gapic::Rest::Error.new "An error has occurred when making a REST request", result: result
        end

        result
      end

      private

      ##
      # Combines endpoint and uri to make full request url
      #
      # @param uri [String]
      # @return [String]
      def create_request_url uri
        uri_noslash = uri.gsub %r{^/}, ""
        "#{@endpoint}/#{uri_noslash}"
      end
    end
  end
end