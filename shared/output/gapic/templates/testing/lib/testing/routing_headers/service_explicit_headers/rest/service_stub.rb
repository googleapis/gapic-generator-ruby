# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright <YEAR> <COPYRIGHT HOLDER>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!

require "testing/routing_headers/routing_headers_pb"

module Testing
  module RoutingHeaders
    module ServiceExplicitHeaders
      module Rest
        ##
        # REST service stub for the ServiceExplicitHeaders service.
        # Service stub contains baseline method implementations
        # including transcoding, making the REST call, and deserialing the response.
        #
        class ServiceStub
          def initialize endpoint:, credentials:
            # These require statements are intentionally placed here to initialize
            # the REST modules only when it's required.
            require "gapic/rest"

            @client_stub = ::Gapic::Rest::ClientStub.new endpoint: endpoint, credentials: credentials,
                                                         numeric_enums: false
          end

          ##
          # Baseline implementation for the plain_no_template REST call
          #
          # @param request_pb [::Testing::RoutingHeaders::Request]
          #   A request object representing the call parameters. Required.
          # @param options [::Gapic::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Testing::RoutingHeaders::Response]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Testing::RoutingHeaders::Response]
          #   A result object deserialized from the server's reply
          def plain_no_template request_pb, options = nil
            raise ::ArgumentError, "request must be provided" if request_pb.nil?

            verb, uri, query_string_params, body = transcode_plain_no_template_request request_pb
            query_string_params = if query_string_params.any?
                                    query_string_params.to_h { |p| p.split("=", 2) }
                                  else
                                    {}
                                  end

            response = @client_stub.make_http_request(
              verb,
              uri:     uri,
              body:    body || "",
              params:  query_string_params,
              options: options
            )
            result = ::Testing::RoutingHeaders::Response.decode_json response.body, ignore_unknown_fields: true

            yield result, response if block_given?
            result
          end

          ##
          # Baseline implementation for the plain_full_field REST call
          #
          # @param request_pb [::Testing::RoutingHeaders::Request]
          #   A request object representing the call parameters. Required.
          # @param options [::Gapic::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Testing::RoutingHeaders::Response]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Testing::RoutingHeaders::Response]
          #   A result object deserialized from the server's reply
          def plain_full_field request_pb, options = nil
            raise ::ArgumentError, "request must be provided" if request_pb.nil?

            verb, uri, query_string_params, body = transcode_plain_full_field_request request_pb
            query_string_params = if query_string_params.any?
                                    query_string_params.to_h { |p| p.split("=", 2) }
                                  else
                                    {}
                                  end

            response = @client_stub.make_http_request(
              verb,
              uri:     uri,
              body:    body || "",
              params:  query_string_params,
              options: options
            )
            result = ::Testing::RoutingHeaders::Response.decode_json response.body, ignore_unknown_fields: true

            yield result, response if block_given?
            result
          end

          ##
          # Baseline implementation for the plain_extract REST call
          #
          # @param request_pb [::Testing::RoutingHeaders::Request]
          #   A request object representing the call parameters. Required.
          # @param options [::Gapic::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Testing::RoutingHeaders::Response]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Testing::RoutingHeaders::Response]
          #   A result object deserialized from the server's reply
          def plain_extract request_pb, options = nil
            raise ::ArgumentError, "request must be provided" if request_pb.nil?

            verb, uri, query_string_params, body = transcode_plain_extract_request request_pb
            query_string_params = if query_string_params.any?
                                    query_string_params.to_h { |p| p.split("=", 2) }
                                  else
                                    {}
                                  end

            response = @client_stub.make_http_request(
              verb,
              uri:     uri,
              body:    body || "",
              params:  query_string_params,
              options: options
            )
            result = ::Testing::RoutingHeaders::Response.decode_json response.body, ignore_unknown_fields: true

            yield result, response if block_given?
            result
          end

          ##
          # Baseline implementation for the complex REST call
          #
          # @param request_pb [::Testing::RoutingHeaders::Request]
          #   A request object representing the call parameters. Required.
          # @param options [::Gapic::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Testing::RoutingHeaders::Response]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Testing::RoutingHeaders::Response]
          #   A result object deserialized from the server's reply
          def complex request_pb, options = nil
            raise ::ArgumentError, "request must be provided" if request_pb.nil?

            verb, uri, query_string_params, body = transcode_complex_request request_pb
            query_string_params = if query_string_params.any?
                                    query_string_params.to_h { |p| p.split("=", 2) }
                                  else
                                    {}
                                  end

            response = @client_stub.make_http_request(
              verb,
              uri:     uri,
              body:    body || "",
              params:  query_string_params,
              options: options
            )
            result = ::Testing::RoutingHeaders::Response.decode_json response.body, ignore_unknown_fields: true

            yield result, response if block_given?
            result
          end

          ##
          # Baseline implementation for the with_sub_message REST call
          #
          # @param request_pb [::Testing::RoutingHeaders::Request]
          #   A request object representing the call parameters. Required.
          # @param options [::Gapic::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Testing::RoutingHeaders::Response]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Testing::RoutingHeaders::Response]
          #   A result object deserialized from the server's reply
          def with_sub_message request_pb, options = nil
            raise ::ArgumentError, "request must be provided" if request_pb.nil?

            verb, uri, query_string_params, body = transcode_with_sub_message_request request_pb
            query_string_params = if query_string_params.any?
                                    query_string_params.to_h { |p| p.split("=", 2) }
                                  else
                                    {}
                                  end

            response = @client_stub.make_http_request(
              verb,
              uri:     uri,
              body:    body || "",
              params:  query_string_params,
              options: options
            )
            result = ::Testing::RoutingHeaders::Response.decode_json response.body, ignore_unknown_fields: true

            yield result, response if block_given?
            result
          end


          private

          ##
          # @private
          #
          # GRPC transcoding helper method for the plain_no_template REST call
          #
          # @param request_pb [::Testing::RoutingHeaders::Request]
          #   A request object representing the call parameters. Required.
          # @return [Array(String, [String, nil], Hash{String => String})]
          #   Uri, Body, Query string parameters
          def transcode_plain_no_template_request request_pb
            transcoder = Gapic::Rest::GrpcTranscoder.new
                                                    .with_bindings(
                                                      uri_method: :get,
                                                      uri_template: "/v2/{table_name}:sampleRowKeys",
                                                      matches: [
                                                        ["table_name",
                                                         %r{^projects/[^/]+/instances/[^/]+/tables/[^/]+/?$}, false]
                                                      ]
                                                    )
            transcoder.transcode request_pb
          end

          ##
          # @private
          #
          # GRPC transcoding helper method for the plain_full_field REST call
          #
          # @param request_pb [::Testing::RoutingHeaders::Request]
          #   A request object representing the call parameters. Required.
          # @return [Array(String, [String, nil], Hash{String => String})]
          #   Uri, Body, Query string parameters
          def transcode_plain_full_field_request request_pb
            transcoder = Gapic::Rest::GrpcTranscoder.new
                                                    .with_bindings(
                                                      uri_method: :get,
                                                      uri_template: "/v2/{table_name}:sampleRowKeys",
                                                      matches: [
                                                        ["table_name",
                                                         %r{^projects/[^/]+/instances/[^/]+/tables/[^/]+/?$}, false]
                                                      ]
                                                    )
            transcoder.transcode request_pb
          end

          ##
          # @private
          #
          # GRPC transcoding helper method for the plain_extract REST call
          #
          # @param request_pb [::Testing::RoutingHeaders::Request]
          #   A request object representing the call parameters. Required.
          # @return [Array(String, [String, nil], Hash{String => String})]
          #   Uri, Body, Query string parameters
          def transcode_plain_extract_request request_pb
            transcoder = Gapic::Rest::GrpcTranscoder.new
                                                    .with_bindings(
                                                      uri_method: :get,
                                                      uri_template: "/v2/{table_name}:sampleRowKeys",
                                                      matches: [
                                                        ["table_name",
                                                         %r{^projects/[^/]+/instances/[^/]+/tables/[^/]+/?$}, false]
                                                      ]
                                                    )
            transcoder.transcode request_pb
          end

          ##
          # @private
          #
          # GRPC transcoding helper method for the complex REST call
          #
          # @param request_pb [::Testing::RoutingHeaders::Request]
          #   A request object representing the call parameters. Required.
          # @return [Array(String, [String, nil], Hash{String => String})]
          #   Uri, Body, Query string parameters
          def transcode_complex_request request_pb
            transcoder = Gapic::Rest::GrpcTranscoder.new
                                                    .with_bindings(
                                                      uri_method: :get,
                                                      uri_template: "/v2/{table_name}:sampleRowKeys",
                                                      matches: [
                                                        ["table_name",
                                                         %r{^projects/[^/]+/instances/[^/]+/tables/[^/]+/?$}, false]
                                                      ]
                                                    )
            transcoder.transcode request_pb
          end

          ##
          # @private
          #
          # GRPC transcoding helper method for the with_sub_message REST call
          #
          # @param request_pb [::Testing::RoutingHeaders::Request]
          #   A request object representing the call parameters. Required.
          # @return [Array(String, [String, nil], Hash{String => String})]
          #   Uri, Body, Query string parameters
          def transcode_with_sub_message_request request_pb
            transcoder = Gapic::Rest::GrpcTranscoder.new
                                                    .with_bindings(
                                                      uri_method: :get,
                                                      uri_template: "/v2/{resource.resource_name}:withSubMessage",
                                                      matches: [
                                                        ["resource.resource_name",
                                                         %r{^projects/[^/]+/instances/[^/]+/tables/[^/]+/?$}, false]
                                                      ]
                                                    )
            transcoder.transcode request_pb
          end
        end
      end
    end
  end
end
