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

require "google/showcase/v1beta1/testing_pb"

module Google
  module Showcase
    module V1beta1
      module Testing
        module Rest
          ##
          # REST service stub for the Testing service.
          # service stub contains baseline method implementations
          # including transcoding, making the REST call and deserialing the response
          #
          class ServiceStub
            def initialize endpoint:, credentials:
              # These require statements are intentionally placed here to initialize
              # the REST modules only when it's required.
              require "gapic/rest"

              @client_stub = ::Gapic::Rest::ClientStub.new endpoint: endpoint, credentials: credentials
            end

            ##
            # Baseline implementation for the create_session REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::CreateSessionRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::Session]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::Session]
            #   A result object deserialized from the server's reply
            def create_session request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = transcode_create_session_request request_pb
              query_string_params = if query_string_params.any?
                                      query_string_params.map { |p| p.split("=", 2) }.to_h
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
              result = ::Google::Showcase::V1beta1::Session.decode_json response.body, ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the get_session REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::GetSessionRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::Session]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::Session]
            #   A result object deserialized from the server's reply
            def get_session request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = transcode_get_session_request request_pb
              query_string_params = if query_string_params.any?
                                      query_string_params.map { |p| p.split("=", 2) }.to_h
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
              result = ::Google::Showcase::V1beta1::Session.decode_json response.body, ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the list_sessions REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::ListSessionsRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::ListSessionsResponse]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::ListSessionsResponse]
            #   A result object deserialized from the server's reply
            def list_sessions request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = transcode_list_sessions_request request_pb
              query_string_params = if query_string_params.any?
                                      query_string_params.map { |p| p.split("=", 2) }.to_h
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
              result = ::Google::Showcase::V1beta1::ListSessionsResponse.decode_json response.body,
                                                                                     ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the delete_session REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::DeleteSessionRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Protobuf::Empty]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Protobuf::Empty]
            #   A result object deserialized from the server's reply
            def delete_session request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = transcode_delete_session_request request_pb
              query_string_params = if query_string_params.any?
                                      query_string_params.map { |p| p.split("=", 2) }.to_h
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
              result = ::Google::Protobuf::Empty.decode_json response.body, ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the report_session REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::ReportSessionRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::ReportSessionResponse]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::ReportSessionResponse]
            #   A result object deserialized from the server's reply
            def report_session request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = transcode_report_session_request request_pb
              query_string_params = if query_string_params.any?
                                      query_string_params.map { |p| p.split("=", 2) }.to_h
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
              result = ::Google::Showcase::V1beta1::ReportSessionResponse.decode_json response.body,
                                                                                      ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the list_tests REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::ListTestsRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::ListTestsResponse]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::ListTestsResponse]
            #   A result object deserialized from the server's reply
            def list_tests request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = transcode_list_tests_request request_pb
              query_string_params = if query_string_params.any?
                                      query_string_params.map { |p| p.split("=", 2) }.to_h
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
              result = ::Google::Showcase::V1beta1::ListTestsResponse.decode_json response.body,
                                                                                  ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the delete_test REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::DeleteTestRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Protobuf::Empty]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Protobuf::Empty]
            #   A result object deserialized from the server's reply
            def delete_test request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = transcode_delete_test_request request_pb
              query_string_params = if query_string_params.any?
                                      query_string_params.map { |p| p.split("=", 2) }.to_h
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
              result = ::Google::Protobuf::Empty.decode_json response.body, ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the verify_test REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::VerifyTestRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::VerifyTestResponse]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::VerifyTestResponse]
            #   A result object deserialized from the server's reply
            def verify_test request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = transcode_verify_test_request request_pb
              query_string_params = if query_string_params.any?
                                      query_string_params.map { |p| p.split("=", 2) }.to_h
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
              result = ::Google::Showcase::V1beta1::VerifyTestResponse.decode_json response.body,
                                                                                   ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end


            private

            ##
            # @private
            #
            # GRPC transcoding helper method for the create_session REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::CreateSessionRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def transcode_create_session_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :post,
                                                        uri_template: "/v1beta1/sessions",
                                                        body: "session",
                                                        matches: []
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the get_session REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::GetSessionRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def transcode_get_session_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :get,
                                                        uri_template: "/v1beta1/{name}",
                                                        matches: [
                                                          ["name", %r{sessions/[^/]+}, false]
                                                        ]
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the list_sessions REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::ListSessionsRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def transcode_list_sessions_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :get,
                                                        uri_template: "/v1beta1/sessions",
                                                        matches: []
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the delete_session REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::DeleteSessionRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def transcode_delete_session_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :delete,
                                                        uri_template: "/v1beta1/{name}",
                                                        matches: [
                                                          ["name", %r{sessions/[^/]+}, false]
                                                        ]
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the report_session REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::ReportSessionRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def transcode_report_session_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :post,
                                                        uri_template: "/v1beta1/{name}:report",
                                                        matches: [
                                                          ["name", %r{sessions/[^/]+}, false]
                                                        ]
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the list_tests REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::ListTestsRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def transcode_list_tests_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :get,
                                                        uri_template: "/v1beta1/{parent}/tests",
                                                        matches: [
                                                          ["parent", %r{sessions/[^/]+}, false]
                                                        ]
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the delete_test REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::DeleteTestRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def transcode_delete_test_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :delete,
                                                        uri_template: "/v1beta1/{name}",
                                                        matches: [
                                                          ["name", %r{sessions/[^/]+/tests/[^/]+}, false]
                                                        ]
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the verify_test REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::VerifyTestRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def transcode_verify_test_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :post,
                                                        uri_template: "/v1beta1/{name}:check",
                                                        matches: [
                                                          ["name", %r{sessions/[^/]+/tests/[^/]+}, false]
                                                        ]
                                                      )
              transcoder.transcode request_pb
            end
          end
        end
      end
    end
  end
end
