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

      ##
      # @param main_method [Gapic::Presenters::MethodPresenter] the main presenter for this method.
      # @param api [Gapic::Schema::Api]
      #
      def initialize main_method, api
        @api = api
        @main_method = main_method
        @proto_method = main_method.method
        @http = main_method.http

        @pagination = Gapic::Presenters::Method::RestPaginationInfo.new @proto_method, api
      end

      ##
      # @return [Boolean] Whether a http verb is present for this method
      #
      def verb?
        @http.verb?
      end

      ##
      # @return [Symbol] a http verb for this method
      #
      def verb
        @http.verb
      end

      ##
      # @return [Boolean] Whether a method path is present and non-empty
      #
      def path?
        @http.path?
      end

      ##
      # @return [Boolean] Whether any routing params are present
      #
      def routing_params?
        @http.routing_params?
      end

      ##
      # @return [Array<String>] The segment key names.
      #
      def routing_params
        @http.routing_params
      end

      ##
      # The strings to initialize the `matches` parameter when initializing a
      # grpc transcoder binding. The `matches` parameter is an array of arrays,
      # so every string here is in a ruby array syntax. All strings except for the
      # last one have a comma at the end.
      #
      # @return [Array<String>]
      #
      def routing_params_transcoder_matches_strings
        return [] if routing_params_with_regexes.empty?
        match_init_strings = routing_params_with_regexes.map do |name, regex, preserve_slashes|
          "[\"#{name}\", %r{#{regex}}, #{preserve_slashes}],"
        end
        match_init_strings << match_init_strings.pop.chop # remove the trailing comma for the last element
        match_init_strings
      end

      ##
      # @return [Boolean] Whether method has body specified in proto
      #
      def body?
        @http.body?
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
      # Performs a limited version of grpc transcoding to create a string that will interpolate
      # the values from the request object to create a request URI at runtime.
      # Currently only supports "value" into "request_object.value"
      # @param [String] request_obj_name the name of the request object for the interpolation
      #   defaults to "request_pb"
      # @return [String] A string to interpolate values from the request object into URI
      #
      def uri_for_transcoding
        return path unless routing_params?

        routing_params.reduce path do |uri, param|
          param_esc = Regexp.escape param
          uri.gsub(/{#{param_esc}[^}]*}/, "{#{param}}")
        end
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
      #
      # @return [String]
      #
      def query_string_params_var_name
        query_string_params? ? "query_string_params" : "_query_string_params"
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
      # @return [String] A body specified for the given method in proto or an empty string if not specified
      #
      def body
        @http.body
      end

      ##
      # Whether this method can be generated in REST clients
      # Only methods with http bindings can be generated, and
      # additionally only unary methods are currently supported.
      #
      # @return [Boolean]
      #
      def can_generate_rest?
        (@main_method.kind == :normal) && verb? && path?
      end

      ##
      # @private
      # @return [String] A method path or an empty string if not present
      #
      def path
        @http.path
      end

      private

      ##
      # The segment key names, the regexes for their patterns (including
      # the regexes for `*` patterns implied for the named segments without
      # pattern explicitly specified), and whether the slash `/` symbols in
      # the segment variable should be preserved (as opposed to percent-escaped).
      #
      # These are used to initialize the grpc transcoder `matches` binding parameter.
      #
      # @return [Array<Array<String|Boolean>>]
      #
      def routing_params_with_regexes
        @routing_params_with_regexes ||= begin
          @http.routing_params_with_patterns.map do |name, pattern|
            path_pattern = PathPattern.parse pattern
            [name, path_pattern.to_regex_str, path_pattern.ends_with_double_star_pattern?]
          end
        end
      end
    end
  end
end
