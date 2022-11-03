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

require "google/showcase/v1beta1/echo_pb"

module Google
  module Showcase
    module V1beta1
      module Echo
        module Rest
          ##
          # REST service stub for the Echo service.
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
            # Baseline implementation for the echo REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::EchoRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::EchoResponse]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::EchoResponse]
            #   A result object deserialized from the server's reply
            def echo request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = transcode_echo_request request_pb
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
              result = ::Google::Showcase::V1beta1::EchoResponse.decode_json response.body,
                                                                             ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the expand REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::ExpandRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::EchoResponse]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [Enumerable<::Google::Showcase::V1beta1::EchoResponse>]
            #   Enumerable of deserialized objects returned from server's stream
            def expand request_pb, options = nil, &block
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = transcode_expand_request request_pb
              query_string_params = if query_string_params.any?
                                      query_string_params.to_h { |p| p.split("=", 2) }
                                    else
                                      {}
                                    end

              @client_stub.make_http_request(
                verb,
                uri: uri,
                body: body || "",
                params: query_string_params,
                options: options,
                is_streaming: true,
                &block
              )
            end

            ##
            # Baseline implementation for the paged_expand REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::PagedExpandRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::PagedExpandResponse]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::PagedExpandResponse]
            #   A result object deserialized from the server's reply
            def paged_expand request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = transcode_paged_expand_request request_pb
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
              result = ::Google::Showcase::V1beta1::PagedExpandResponse.decode_json response.body,
                                                                                    ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the wait REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::WaitRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Longrunning::Operation]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Longrunning::Operation]
            #   A result object deserialized from the server's reply
            def wait request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = transcode_wait_request request_pb
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
              result = ::Google::Longrunning::Operation.decode_json response.body, ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the block REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::BlockRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::BlockResponse]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::BlockResponse]
            #   A result object deserialized from the server's reply
            def block request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = transcode_block_request request_pb
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
              result = ::Google::Showcase::V1beta1::BlockResponse.decode_json response.body,
                                                                              ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end


            private

            ##
            # @private
            #
            # GRPC transcoding helper method for the echo REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::EchoRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def transcode_echo_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :post,
                                                        uri_template: "/v1beta1/echo:echo",
                                                        body: "*",
                                                        matches: []
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the expand REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::ExpandRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def transcode_expand_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :post,
                                                        uri_template: "/v1beta1/echo:expand",
                                                        body: "*",
                                                        matches: []
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the paged_expand REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::PagedExpandRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def transcode_paged_expand_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :post,
                                                        uri_template: "/v1beta1/echo:pagedExpand",
                                                        body: "*",
                                                        matches: []
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the wait REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::WaitRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def transcode_wait_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :post,
                                                        uri_template: "/v1beta1/echo:wait",
                                                        body: "*",
                                                        matches: []
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the block REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::BlockRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def transcode_block_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :post,
                                                        uri_template: "/v1beta1/echo:block",
                                                        body: "*",
                                                        matches: []
                                                      )
              transcoder.transcode request_pb
            end
          end
        end
      end
    end
  end
end
