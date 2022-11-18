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

require "google/showcase/v1beta1/messaging_pb"

module Google
  module Showcase
    module V1beta1
      module Messaging
        module Rest
          ##
          # REST service stub for the Messaging service.
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
            # Baseline implementation for the create_room REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::CreateRoomRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::Room]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::Room]
            #   A result object deserialized from the server's reply
            def create_room request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = ServiceStub.transcode_create_room_request request_pb
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
              result = ::Google::Showcase::V1beta1::Room.decode_json response.body, ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the get_room REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::GetRoomRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::Room]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::Room]
            #   A result object deserialized from the server's reply
            def get_room request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = ServiceStub.transcode_get_room_request request_pb
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
              result = ::Google::Showcase::V1beta1::Room.decode_json response.body, ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the update_room REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::UpdateRoomRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::Room]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::Room]
            #   A result object deserialized from the server's reply
            def update_room request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = ServiceStub.transcode_update_room_request request_pb
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
              result = ::Google::Showcase::V1beta1::Room.decode_json response.body, ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the delete_room REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::DeleteRoomRequest]
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
            def delete_room request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = ServiceStub.transcode_delete_room_request request_pb
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
              result = ::Google::Protobuf::Empty.decode_json response.body, ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the list_rooms REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::ListRoomsRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::ListRoomsResponse]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::ListRoomsResponse]
            #   A result object deserialized from the server's reply
            def list_rooms request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = ServiceStub.transcode_list_rooms_request request_pb
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
              result = ::Google::Showcase::V1beta1::ListRoomsResponse.decode_json response.body,
                                                                                  ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the create_blurb REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::CreateBlurbRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::Blurb]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::Blurb]
            #   A result object deserialized from the server's reply
            def create_blurb request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = ServiceStub.transcode_create_blurb_request request_pb
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
              result = ::Google::Showcase::V1beta1::Blurb.decode_json response.body, ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the get_blurb REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::GetBlurbRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::Blurb]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::Blurb]
            #   A result object deserialized from the server's reply
            def get_blurb request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = ServiceStub.transcode_get_blurb_request request_pb
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
              result = ::Google::Showcase::V1beta1::Blurb.decode_json response.body, ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the update_blurb REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::UpdateBlurbRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::Blurb]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::Blurb]
            #   A result object deserialized from the server's reply
            def update_blurb request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = ServiceStub.transcode_update_blurb_request request_pb
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
              result = ::Google::Showcase::V1beta1::Blurb.decode_json response.body, ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the delete_blurb REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::DeleteBlurbRequest]
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
            def delete_blurb request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = ServiceStub.transcode_delete_blurb_request request_pb
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
              result = ::Google::Protobuf::Empty.decode_json response.body, ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the list_blurbs REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::ListBlurbsRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Showcase::V1beta1::ListBlurbsResponse]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Showcase::V1beta1::ListBlurbsResponse]
            #   A result object deserialized from the server's reply
            def list_blurbs request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = ServiceStub.transcode_list_blurbs_request request_pb
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
              result = ::Google::Showcase::V1beta1::ListBlurbsResponse.decode_json response.body,
                                                                                   ignore_unknown_fields: true

              yield result, response if block_given?
              result
            end

            ##
            # Baseline implementation for the search_blurbs REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::SearchBlurbsRequest]
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
            def search_blurbs request_pb, options = nil
              raise ::ArgumentError, "request must be provided" if request_pb.nil?

              verb, uri, query_string_params, body = ServiceStub.transcode_search_blurbs_request request_pb
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
            # @private
            #
            # GRPC transcoding helper method for the create_room REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::CreateRoomRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def self.transcode_create_room_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :post,
                                                        uri_template: "/v1beta1/rooms",
                                                        body: "*",
                                                        matches: []
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the get_room REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::GetRoomRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def self.transcode_get_room_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :get,
                                                        uri_template: "/v1beta1/{name}",
                                                        matches: [
                                                          ["name", %r{^rooms/[^/]+/?$}, false]
                                                        ]
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the update_room REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::UpdateRoomRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def self.transcode_update_room_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :patch,
                                                        uri_template: "/v1beta1/{room.name}",
                                                        body: "*",
                                                        matches: [
                                                          ["room.name", %r{^rooms/[^/]+/?$}, false]
                                                        ]
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the delete_room REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::DeleteRoomRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def self.transcode_delete_room_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :delete,
                                                        uri_template: "/v1beta1/{name}",
                                                        matches: [
                                                          ["name", %r{^rooms/[^/]+/?$}, false]
                                                        ]
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the list_rooms REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::ListRoomsRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def self.transcode_list_rooms_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :get,
                                                        uri_template: "/v1beta1/rooms",
                                                        matches: []
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the create_blurb REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::CreateBlurbRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def self.transcode_create_blurb_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :post,
                                                        uri_template: "/v1beta1/{parent}/blurbs",
                                                        body: "*",
                                                        matches: [
                                                          ["parent", %r{^rooms/[^/]+/?$}, false]
                                                        ]
                                                      )
                                                      .with_bindings(
                                                        uri_method: :post,
                                                        uri_template: "/v1beta1/{parent}/blurbs",
                                                        body: "*",
                                                        matches: [
                                                          ["parent", %r{^users/[^/]+/profile/?$}, false]
                                                        ]
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the get_blurb REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::GetBlurbRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def self.transcode_get_blurb_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :get,
                                                        uri_template: "/v1beta1/{name}",
                                                        matches: [
                                                          ["name", %r{^rooms/[^/]+/blurbs/[^/]+/?$}, false]
                                                        ]
                                                      )
                                                      .with_bindings(
                                                        uri_method: :get,
                                                        uri_template: "/v1beta1/{name}",
                                                        matches: [
                                                          ["name", %r{^users/[^/]+/profile/blurbs/[^/]+/?$}, false]
                                                        ]
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the update_blurb REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::UpdateBlurbRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def self.transcode_update_blurb_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :patch,
                                                        uri_template: "/v1beta1/{blurb.name}",
                                                        body: "*",
                                                        matches: [
                                                          ["blurb.name", %r{^rooms/[^/]+/blurbs/[^/]+/?$}, false]
                                                        ]
                                                      )
                                                      .with_bindings(
                                                        uri_method: :patch,
                                                        uri_template: "/v1beta1/{blurb.name}",
                                                        body: "*",
                                                        matches: [
                                                          ["blurb.name", %r{^users/[^/]+/profile/blurbs/[^/]+/?$},
                                                           false]
                                                        ]
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the delete_blurb REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::DeleteBlurbRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def self.transcode_delete_blurb_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :delete,
                                                        uri_template: "/v1beta1/{name}",
                                                        matches: [
                                                          ["name", %r{^rooms/[^/]+/blurbs/[^/]+/?$}, false]
                                                        ]
                                                      )
                                                      .with_bindings(
                                                        uri_method: :delete,
                                                        uri_template: "/v1beta1/{name}",
                                                        matches: [
                                                          ["name", %r{^users/[^/]+/profile/blurbs/[^/]+/?$}, false]
                                                        ]
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the list_blurbs REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::ListBlurbsRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def self.transcode_list_blurbs_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :get,
                                                        uri_template: "/v1beta1/{parent}/blurbs",
                                                        matches: [
                                                          ["parent", %r{^rooms/[^/]+/?$}, false]
                                                        ]
                                                      )
                                                      .with_bindings(
                                                        uri_method: :get,
                                                        uri_template: "/v1beta1/{parent}/blurbs",
                                                        matches: [
                                                          ["parent", %r{^users/[^/]+/profile/?$}, false]
                                                        ]
                                                      )
              transcoder.transcode request_pb
            end

            ##
            # @private
            #
            # GRPC transcoding helper method for the search_blurbs REST call
            #
            # @param request_pb [::Google::Showcase::V1beta1::SearchBlurbsRequest]
            #   A request object representing the call parameters. Required.
            # @return [Array(String, [String, nil], Hash{String => String})]
            #   Uri, Body, Query string parameters
            def self.transcode_search_blurbs_request request_pb
              transcoder = Gapic::Rest::GrpcTranscoder.new
                                                      .with_bindings(
                                                        uri_method: :post,
                                                        uri_template: "/v1beta1/{parent}/blurbs:search",
                                                        body: "*",
                                                        matches: [
                                                          ["parent", %r{^rooms/-/?$}, false]
                                                        ]
                                                      )
                                                      .with_bindings(
                                                        uri_method: :post,
                                                        uri_template: "/v1beta1/{parent}/blurbs:search",
                                                        matches: [
                                                          ["parent", %r{^users/-/profile/?$}, false]
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
