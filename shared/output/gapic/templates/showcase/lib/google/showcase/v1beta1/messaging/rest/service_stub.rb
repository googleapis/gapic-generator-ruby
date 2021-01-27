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

require "gapic/rest"
require "google/showcase/v1beta1/messaging_pb"

module Google
  module Showcase
    module V1beta1
      module Messaging
        module Rest
          ##
          # REST service stub for the Messaging service.
          #
          class ServiceStub
            ##
            # Create a new Messaging REST service stub object.
            #
            # @param endpoint [String]
            #   The hostname or hostname:port of the service endpoint.
            #   Defaults to `"localhost:7469"`.
            #
            # @param credentials [Google::Auth::Credentials]
            #   Credentials to send with calls in form of a googleauth credentials object.
            #   (see the [googleauth docs](https://googleapis.dev/ruby/googleauth/latest/index.html))
            #
            def initialize endpoint:, credentials:
              @client_stub = ::Gapic::Rest::ClientStub.new endpoint: endpoint, credentials: credentials
            end

            # Service calls

            ##
            # Creates a room.
            #
            # @param request_pb [::Google::Showcase::V1beta1::CreateRoomRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            # @return [::Google::Showcase::V1beta1::Room]
            def create_room request_pb, options:, &block
              request_json = JSON.parse ::Google::Showcase::V1beta1::CreateRoomRequest.encode_json(request_pb)

              uri = "/v1beta1/rooms"
              body = request_pb.to_json

              result_json = @client_stub.make_post_request(
                uri:     uri,
                body:    body,
                options: options,
                &block
              )

              ::Google::Showcase::V1beta1::Room.decode_json result_json[:body]
            end

            ##
            # Retrieves the Room with the given resource name.
            #
            # @param request_pb [::Google::Showcase::V1beta1::GetRoomRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            # @return [::Google::Showcase::V1beta1::Room]
            def get_room request_pb, options:, &block
              request_json = JSON.parse ::Google::Showcase::V1beta1::GetRoomRequest.encode_json(request_pb)

              uri = "/v1beta1/#{request_pb.name}"

              result_json = @client_stub.make_get_request(
                uri:     uri,
                options: options,
                &block
              )

              ::Google::Showcase::V1beta1::Room.decode_json result_json[:body]
            end

            ##
            # Updates a room.
            #
            # @param request_pb [::Google::Showcase::V1beta1::UpdateRoomRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            # @return [::Google::Showcase::V1beta1::Room]
            def update_room request_pb, options:, &block
              request_json = JSON.parse ::Google::Showcase::V1beta1::UpdateRoomRequest.encode_json(request_pb)

              uri = "/v1beta1/#{request_pb.room.name}"
              body = request_pb.to_json

              result_json = @client_stub.make_patch_request(
                uri:     uri,
                body:    body,
                options: options,
                &block
              )

              ::Google::Showcase::V1beta1::Room.decode_json result_json[:body]
            end

            ##
            # Deletes a room and all of its blurbs.
            #
            # @param request_pb [::Google::Showcase::V1beta1::DeleteRoomRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            # @return [::Google::Protobuf::Empty]
            def delete_room request_pb, options:, &block
              request_json = JSON.parse ::Google::Showcase::V1beta1::DeleteRoomRequest.encode_json(request_pb)

              uri = "/v1beta1/#{request_pb.name}"

              result_json = @client_stub.make_delete_request(
                uri:     uri,
                options: options,
                &block
              )

              ::Google::Protobuf::Empty.decode_json result_json[:body]
            end

            ##
            # Lists all chat rooms.
            #
            # @param request_pb [::Google::Showcase::V1beta1::ListRoomsRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            # @return [::Google::Showcase::V1beta1::ListRoomsResponse]
            def list_rooms request_pb, options:, &block
              request_json = JSON.parse ::Google::Showcase::V1beta1::ListRoomsRequest.encode_json(request_pb)

              uri = "/v1beta1/rooms"

              result_json = @client_stub.make_get_request(
                uri:     uri,
                options: options,
                &block
              )

              ::Google::Showcase::V1beta1::ListRoomsResponse.decode_json result_json[:body]
            end

            ##
            # Creates a blurb. If the parent is a room, the blurb is understood to be a
            # message in that room. If the parent is a profile, the blurb is understood
            # to be a post on the profile.
            #
            # @param request_pb [::Google::Showcase::V1beta1::CreateBlurbRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            # @return [::Google::Showcase::V1beta1::Blurb]
            def create_blurb request_pb, options:, &block
              request_json = JSON.parse ::Google::Showcase::V1beta1::CreateBlurbRequest.encode_json(request_pb)

              uri = "/v1beta1/#{request_pb.parent}/blurbs"
              body = request_pb.to_json

              result_json = @client_stub.make_post_request(
                uri:     uri,
                body:    body,
                options: options,
                &block
              )

              ::Google::Showcase::V1beta1::Blurb.decode_json result_json[:body]
            end

            ##
            # Retrieves the Blurb with the given resource name.
            #
            # @param request_pb [::Google::Showcase::V1beta1::GetBlurbRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            # @return [::Google::Showcase::V1beta1::Blurb]
            def get_blurb request_pb, options:, &block
              request_json = JSON.parse ::Google::Showcase::V1beta1::GetBlurbRequest.encode_json(request_pb)

              uri = "/v1beta1/#{request_pb.name}"

              result_json = @client_stub.make_get_request(
                uri:     uri,
                options: options,
                &block
              )

              ::Google::Showcase::V1beta1::Blurb.decode_json result_json[:body]
            end

            ##
            # Updates a blurb.
            #
            # @param request_pb [::Google::Showcase::V1beta1::UpdateBlurbRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            # @return [::Google::Showcase::V1beta1::Blurb]
            def update_blurb request_pb, options:, &block
              request_json = JSON.parse ::Google::Showcase::V1beta1::UpdateBlurbRequest.encode_json(request_pb)

              uri = "/v1beta1/#{request_pb.blurb.name}"
              body = request_pb.to_json

              result_json = @client_stub.make_patch_request(
                uri:     uri,
                body:    body,
                options: options,
                &block
              )

              ::Google::Showcase::V1beta1::Blurb.decode_json result_json[:body]
            end

            ##
            # Deletes a blurb.
            #
            # @param request_pb [::Google::Showcase::V1beta1::DeleteBlurbRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            # @return [::Google::Protobuf::Empty]
            def delete_blurb request_pb, options:, &block
              request_json = JSON.parse ::Google::Showcase::V1beta1::DeleteBlurbRequest.encode_json(request_pb)

              uri = "/v1beta1/#{request_pb.name}"

              result_json = @client_stub.make_delete_request(
                uri:     uri,
                options: options,
                &block
              )

              ::Google::Protobuf::Empty.decode_json result_json[:body]
            end

            ##
            # Lists blurbs for a specific chat room or user profile depending on the
            # parent resource name.
            #
            # @param request_pb [::Google::Showcase::V1beta1::ListBlurbsRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            # @return [::Google::Showcase::V1beta1::ListBlurbsResponse]
            def list_blurbs request_pb, options:, &block
              request_json = JSON.parse ::Google::Showcase::V1beta1::ListBlurbsRequest.encode_json(request_pb)

              uri = "/v1beta1/#{request_pb.parent}/blurbs"

              result_json = @client_stub.make_get_request(
                uri:     uri,
                options: options,
                &block
              )

              ::Google::Showcase::V1beta1::ListBlurbsResponse.decode_json result_json[:body]
            end

            ##
            # This method searches through all blurbs across all rooms and profiles
            # for blurbs containing to words found in the query. Only posts that
            # contain an exact match of a queried word will be returned.
            #
            # @param request_pb [::Google::Showcase::V1beta1::SearchBlurbsRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            # @return [::Google::Longrunning::Operation]
            def search_blurbs request_pb, options:, &block
              request_json = JSON.parse ::Google::Showcase::V1beta1::SearchBlurbsRequest.encode_json(request_pb)

              uri = "/v1beta1/#{request_pb.parent}/blurbs:search"
              body = request_pb.to_json

              result_json = @client_stub.make_post_request(
                uri:     uri,
                body:    body,
                options: options,
                &block
              )

              ::Google::Longrunning::Operation.decode_json result_json[:body]
            end

            ##
            # This returns a stream that emits the blurbs that are created for a
            # particular chat room or user profile.
            #
            # @param request_pb [::Google::Showcase::V1beta1::StreamBlurbsRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            # @return [::Google::Showcase::V1beta1::StreamBlurbsResponse]
            def stream_blurbs request_pb, options:, &block
              request_json = JSON.parse ::Google::Showcase::V1beta1::StreamBlurbsRequest.encode_json(request_pb)

              uri = "/v1beta1/#{request_pb.name}/blurbs:stream"
              body = request_pb.to_json

              result_json = @client_stub.make_post_request(
                uri:     uri,
                body:    body,
                options: options,
                &block
              )

              ::Google::Showcase::V1beta1::StreamBlurbsResponse.decode_json result_json[:body]
            end

            ##
            # This is a stream to create multiple blurbs. If an invalid blurb is
            # requested to be created, the stream will close with an error.
            #
            # @param request_pb [::Google::Showcase::V1beta1::CreateBlurbRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            # @return [::Google::Showcase::V1beta1::SendBlurbsResponse]
            def send_blurbs request_pb, options:, &block
              request_json = JSON.parse ::Google::Showcase::V1beta1::CreateBlurbRequest.encode_json(request_pb)

              uri = "/v1beta1/#{request_pb.parent}/blurbs:send"
              body = request_pb.to_json

              result_json = @client_stub.make_post_request(
                uri:     uri,
                body:    body,
                options: options,
                &block
              )

              ::Google::Showcase::V1beta1::SendBlurbsResponse.decode_json result_json[:body]
            end

            ##
            # This method starts a bidirectional stream that receives all blurbs that
            # are being created after the stream has started and sends requests to create
            # blurbs. If an invalid blurb is requested to be created, the stream will
            # close with an error.
            #
            # @param request_pb [::Google::Showcase::V1beta1::ConnectRequest]
            #   A request object representing the call parameters. Required.
            # @param options [::Gapic::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            # @return [::Google::Showcase::V1beta1::StreamBlurbsResponse]
            def connect request_pb, options:, &block
              request_json = JSON.parse ::Google::Showcase::V1beta1::ConnectRequest.encode_json(request_pb)

              uri = ""

              result_json = @client_stub.make__request(
                uri:     uri,
                options: options,
                &block
              )

              ::Google::Showcase::V1beta1::StreamBlurbsResponse.decode_json result_json[:body]
            end
          end
        end
      end
    end
  end
end