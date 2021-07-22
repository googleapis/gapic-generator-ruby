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
require "gapic/uri_template"

module Gapic
  module Presenters
    ##
    # A presenter for rpc methods (REST submethods)
    #
    class MethodRestPresenter
      # @return [Gapic::Presenters::Method::RestPaginationInfo]
      attr_reader :pagination

      def initialize main_method
        @main_method = main_method
        @proto_method = main_method.method

        @pagination = Gapic::Presenters::Method::RestPaginationInfo.new @proto_method
      end

      ##
      # @return [Boolean] Whether a http verb is present for this method
      #
      def verb?
        !verb.nil?
      end

      ##
      # @return [Symbol] a http verb for this method
      #
      def verb
        return nil if @proto_method.http.nil?

        method = {
          get:    @proto_method.http.get,
          post:   @proto_method.http.post,
          put:    @proto_method.http.put,
          patch:  @proto_method.http.patch,
          delete: @proto_method.http.delete
        }.find { |_, value| !value.empty? }

        method[0] unless method.nil?
      end

      ##
      # @return [Boolean] Whether a method path is present and non-empty
      #
      def path?
        !path.empty?
      end

      ##
      # @return [String] A method path or an empty string if not present
      #
      def path
        return "" if @proto_method.http.nil?

        verb_path = [
          @proto_method.http.get, @proto_method.http.post, @proto_method.http.put,
          @proto_method.http.patch, @proto_method.http.delete
        ].find { |x| !x.empty? }

        verb_path || @proto_method.http.custom&.path || ""
      end

      ##
      # @return [Boolean] Whether any routing params are present
      #
      def routing_params?
        routing_params.any?
      end

      ##
      # @return [Array<String>] The segment key names.
      #
      def routing_params
        Gapic::UriTemplate.parse_arguments path
      end

      ##
      # Performs a limited version of grpc transcoding to create a string that will interpolate
      # the values from the request object to create a request URI at runtime.
      # Currently only supports "value" into "request_object.value"
      # @param [String] request_obj_name the name of the request object for the interpolation
      #   defaults to "request_pb"
      # @return [String] A string to interpolate values from the request object into URI
      #
      def uri_interpolated request_obj_name = "request_pb"
        return path unless routing_params?

        routing_params.reduce path do |uri, param|
          param_esc = Regexp.escape param
          uri.gsub(/{#{param_esc}[^}]*}/, "\#{#{request_obj_name}.#{param}}")
        end
      end

      ##
      # @return [Boolean] Whether method has body specified in proto
      #
      def body?
        return false if @proto_method.http.nil?

        !@proto_method.http.body.empty?
      end

      ##
      # Name of the variable to use for storing the body result of the transcoding call
      # Normally "body" but use "_body" for discarding the result for
      # the calls that do not send body
      # @return [String]
      def body_var_name
        body? ? "body" : "_body"
      end

      ##
      # @return [String] A body specified for the given method in proto or an empty string if not specified
      #
      def body
        @proto_method.http&.body || ""
      end

      ##
      # @return [Boolean] True if body contains full request object (`*` in the annotation), false otherwise
      #
      def body_is_request_object?
        body == "*"
      end

      ##
      # Performs a limited version of grpc transcoding to create a string that will interpolate
      # the values from the request object to create a request body at runtime.
      # Currently only supports either "*" for "the whole request object" or
      # "value" for "request_object.value"
      #
      # @param [String] request_obj_name the name of the request object for the interpolation
      #   defaults to "request_pb"
      #
      # @return [String] A string to interpolate values from the request object into body
      #
      def body_interpolated request_obj_name = "request_pb"
        return "\"\"" unless body?

        return "#{request_obj_name}.to_json" if body_is_request_object?

        "#{request_obj_name}.#{body}.to_json"
      end

      ##
      # @return [Boolean] whether any query string parameters are present
      #
      def query_string_params?
        query_string_params.any?
      end

      # @return [Array<String>]
      def query_string_params
        return [] if body_is_request_object?

        routing_params_set = routing_params.to_set
        @main_method.arguments
                    .reject { |arg| routing_params_set.include? arg.name }
                    .reject { |arg| body == arg.name }
                    .reject(&:message?)
                    .reject { |arg| arg.default_value_for_type.nil? }
      end

      ##
      # Name of the variable to use for storing the query_string_params result of the transcoding call
      # Normally "query_string_params" but use "_query_string_params" for discarding the result for
      # the calls that do not sent query_string_params
      # @return [String]
      def query_string_params_var_name
        query_string_params? ? "query_string_params" : "_query_string_params"
      end

      ##
      # Name for the GRPC transcoding helper method
      #
      # @return [String]
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

      ##
      # Full class name of the request type
      #
      # @return [String]
      #
      def request_type
        @main_method.request_type
      end

      ##
      # Whether the REGAPIC method should be rendered as paged
      #
      # @return [Boolean]
      #
      def paged?
        @pagination.paged?
      end
    end
  end
end
