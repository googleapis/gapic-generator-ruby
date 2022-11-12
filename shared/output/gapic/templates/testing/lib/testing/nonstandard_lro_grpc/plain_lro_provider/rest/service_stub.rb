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

require "testing/nonstandard_lro_grpc/nonstandard_lro_grpc_pb"

module Testing
  module NonstandardLroGrpc
    module PlainLroProvider
      module Rest
        ##
        # REST service stub for the PlainLroProvider service.
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
          # Baseline implementation for the get REST call
          #
          # @param request_pb [::Testing::NonstandardLroGrpc::LroGetRequest]
          #   A request object representing the call parameters. Required.
          # @param options [::Gapic::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Testing::NonstandardLroGrpc::NonstandardOperation]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Testing::NonstandardLroGrpc::NonstandardOperation]
          #   A result object deserialized from the server's reply
          def get request_pb, options = nil
            raise ::ArgumentError, "request must be provided" if request_pb.nil?

            verb, uri, query_string_params, body = transcode_get_request request_pb
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
            result = ::Testing::NonstandardLroGrpc::NonstandardOperation.decode_json response.body,
                                                                                     ignore_unknown_fields: true

            yield result, response if block_given?
            result
          end


          private

          ##
          # @private
          #
          # GRPC transcoding helper method for the get REST call
          #
          # @param request_pb [::Testing::NonstandardLroGrpc::LroGetRequest]
          #   A request object representing the call parameters. Required.
          # @return [Array(String, [String, nil], Hash{String => String})]
          #   Uri, Body, Query string parameters
          def transcode_get_request request_pb
            transcoder = Gapic::Rest::GrpcTranscoder.new
                                                    .with_bindings(
                                                      uri_method: :post,
                                                      uri_template: "/v1beta1/PlainLroProvider/Get",
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
