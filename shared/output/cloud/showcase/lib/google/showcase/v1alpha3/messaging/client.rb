# frozen_string_literal: true

# Copyright 2018 Google LLC
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

require "json"
require "pathname"

require "google/gax"
require "google/gax/operation"
require "google/longrunning/operations_client"

require "google/showcase/version"
require "google/showcase/v1alpha3/messaging_pb"
require "google/showcase/v1alpha3/messaging/credentials"
require "google/showcase/v1alpha3/messaging/paths"

module Google
  module Showcase
    module V1alpha3
      module Messaging
        # Service that implements Messaging API.
        class Client
          include Paths

          # @private
          attr_reader :messaging_stub

          # The default address of the service.
          SERVICE_ADDRESS = "localhost"

          # The default port of the service.
          DEFAULT_SERVICE_PORT = 7469

          # rubocop:disable Style/MutableConstant

          # The default set of gRPC interceptors.
          GRPC_INTERCEPTORS = []

          # rubocop:enable Style/MutableConstant

          DEFAULT_TIMEOUT = 30

          # The scopes needed to make gRPC calls to all of the methods defined
          # in this service.
          ALL_SCOPES = [].freeze

          # @private
          class OperationsClient < Google::Longrunning::OperationsClient
            SERVICE_ADDRESS = Client::SERVICE_ADDRESS
            GRPC_INTERCEPTORS = Client::GRPC_INTERCEPTORS.dup
          end

          ##
          # @param credentials [Google::Auth::Credentials, String, Hash,
          #   GRPC::Core::Channel, GRPC::Core::ChannelCredentials, Proc]
          #   Provides the means for authenticating requests made by the client. This
          #   parameter can be many types.
          #   A `Google::Auth::Credentials` uses a the properties of its represented
          #   keyfile for authenticating requests made by this client.
          #   A `String` will be treated as the path to the keyfile to be used for the
          #   construction of credentials for this client.
          #   A `Hash` will be treated as the contents of a keyfile to be used for the
          #   construction of credentials for this client.
          #   A `GRPC::Core::Channel` will be used to make calls through.
          #   A `GRPC::Core::ChannelCredentials` for the setting up the RPC client. The
          #   channel credentials should already be composed with a
          #   `GRPC::Core::CallCredentials` object.
          #   A `Proc` will be used as an updater_proc for the Grpc channel. The proc
          #   transforms the metadata for requests, generally, to give OAuth credentials.
          # @param scopes [Array<String>]
          #   The OAuth scopes for this service. This parameter is ignored if an
          #   updater_proc is supplied.
          # @param client_config [Hash]
          #   A Hash for call options for each method. See Google::Gax#construct_settings
          #   for the structure of this data. Falls back to the default config if not
          #   specified or the specified config is missing data points.
          # @param timeout [Numeric]
          #   The default timeout, in seconds, for calls made through this client.
          # @param metadata [Hash]
          #   Default metadata to be sent with each request. This can be overridden on a
          #   per call basis.
          # @param exception_transformer [Proc]
          #   An optional proc that intercepts any exceptions raised during an API call to
          #   inject custom error handling.
          #
          def initialize \
              credentials: nil,
              scopes: ALL_SCOPES,
              client_config: {},
              timeout: DEFAULT_TIMEOUT,
              metadata: nil,
              exception_transformer: nil,
              lib_name: nil,
              lib_version: ""
            # These require statements are intentionally placed here to initialize
            # the gRPC module only when it's required.
            # See https://github.com/googleapis/toolkit/issues/446
            require "google/gax/grpc"
            require "google/showcase/v1alpha3/messaging_services_pb"

            credentials ||= Credentials.default

            @operations_client = OperationsClient.new(
              credentials:   credentials,
              scopes:        scopes,
              client_config: client_config,
              timeout:       timeout,
              lib_name:      lib_name,
              lib_version:   lib_version
            )
            @messaging_stub = create_stub credentials, scopes

            defaults = default_settings client_config, timeout, metadata, lib_name, lib_version

            @create_room = Google::Gax.create_api_call(
              @messaging_stub.method(:create_room),
              defaults,
              exception_transformer: exception_transformer
            )
            @get_room = Google::Gax.create_api_call(
              @messaging_stub.method(:get_room),
              defaults,
              exception_transformer: exception_transformer
            )
            @update_room = Google::Gax.create_api_call(
              @messaging_stub.method(:update_room),
              defaults,
              exception_transformer: exception_transformer
            )
            @delete_room = Google::Gax.create_api_call(
              @messaging_stub.method(:delete_room),
              defaults,
              exception_transformer: exception_transformer
            )
            @list_rooms = Google::Gax.create_api_call(
              @messaging_stub.method(:list_rooms),
              defaults,
              exception_transformer: exception_transformer
            )
            @create_blurb = Google::Gax.create_api_call(
              @messaging_stub.method(:create_blurb),
              defaults,
              exception_transformer: exception_transformer
            )
            @get_blurb = Google::Gax.create_api_call(
              @messaging_stub.method(:get_blurb),
              defaults,
              exception_transformer: exception_transformer
            )
            @update_blurb = Google::Gax.create_api_call(
              @messaging_stub.method(:update_blurb),
              defaults,
              exception_transformer: exception_transformer
            )
            @delete_blurb = Google::Gax.create_api_call(
              @messaging_stub.method(:delete_blurb),
              defaults,
              exception_transformer: exception_transformer
            )
            @list_blurbs = Google::Gax.create_api_call(
              @messaging_stub.method(:list_blurbs),
              defaults,
              exception_transformer: exception_transformer
            )
            @search_blurbs = Google::Gax.create_api_call(
              @messaging_stub.method(:search_blurbs),
              defaults,
              exception_transformer: exception_transformer
            )
            @stream_blurbs = Google::Gax.create_api_call(
              @messaging_stub.method(:stream_blurbs),
              defaults,
              exception_transformer: exception_transformer
            )
            @send_blurbs = Google::Gax.create_api_call(
              @messaging_stub.method(:send_blurbs),
              defaults,
              exception_transformer: exception_transformer
            )
            @connect = Google::Gax.create_api_call(
              @messaging_stub.method(:connect),
              defaults,
              exception_transformer: exception_transformer
            )
          end

          # Service calls

          ##
          # Creates a room.
          #
          # @overload create_room(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::CreateRoomRequest | Hash]
          #     Creates a room.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload create_room(room: nil, options: nil)
          #   @param room [Google::Showcase::V1alpha3::Room | Hash]
          #     The room to create.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::Room]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::Room]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def create_room request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::CreateRoomRequest

            @create_room.call request, options, op_proc: block
          end

          ##
          # Retrieves the Room with the given resource name.
          #
          # @overload get_room(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::GetRoomRequest | Hash]
          #     Retrieves the Room with the given resource name.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload get_room(name: nil, options: nil)
          #   @param name [String]
          #     The resource name of the requested room.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::Room]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::Room]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def get_room request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::GetRoomRequest

            @get_room.call request, options, op_proc: block
          end

          ##
          # Updates a room.
          #
          # @overload update_room(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::UpdateRoomRequest | Hash]
          #     Updates a room.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload update_room(room: nil, update_mask: nil, options: nil)
          #   @param room [Google::Showcase::V1alpha3::Room | Hash]
          #     The room to update.
          #   @param update_mask [Google::Protobuf::FieldMask | Hash]
          #     The field mask to determine wich fields are to be updated. If empty, the
          #     server will assume all fields are to be updated.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::Room]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::Room]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def update_room request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::UpdateRoomRequest

            @update_room.call request, options, op_proc: block
          end

          ##
          # Deletes a room and all of its blurbs.
          #
          # @overload delete_room(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::DeleteRoomRequest | Hash]
          #     Deletes a room and all of its blurbs.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload delete_room(name: nil, options: nil)
          #   @param name [String]
          #     The resource name of the requested room.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Protobuf::Empty]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Protobuf::Empty]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def delete_room request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::DeleteRoomRequest

            @delete_room.call request, options, op_proc: block
          end

          ##
          # Lists all chat rooms.
          #
          # @overload list_rooms(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::ListRoomsRequest | Hash]
          #     Lists all chat rooms.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload list_rooms(page_size: nil, page_token: nil, options: nil)
          #   @param page_size [Integer]
          #     The maximum number of rooms return. Server may return fewer rooms
          #     than requested. If unspecified, server will pick an appropriate default.
          #   @param page_token [String]
          #     The value of google.showcase.v1alpha3.ListRoomsResponse.next_page_token
          #     returned from the previous call to
          #     `google.showcase.v1alpha3.Messaging\ListRooms` method.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::ListRoomsResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::ListRoomsResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def list_rooms request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::ListRoomsRequest

            @list_rooms.call request, options, op_proc: block
          end

          ##
          # Creates a blurb. If the parent is a room, the blurb is understood to be a
          # message in that room. If the parent is a profile, the blurb is understood
          # to be a post on the profile.
          #
          # @overload create_blurb(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::CreateBlurbRequest | Hash]
          #     Creates a blurb. If the parent is a room, the blurb is understood to be a
          #     message in that room. If the parent is a profile, the blurb is understood
          #     to be a post on the profile.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload create_blurb(parent: nil, blurb: nil, options: nil)
          #   @param parent [String]
          #     The resource name of the chat room or user profile that this blurb will
          #     be tied to.
          #   @param blurb [Google::Showcase::V1alpha3::Blurb | Hash]
          #     The blurb to create.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::Blurb]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::Blurb]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def create_blurb request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::CreateBlurbRequest

            @create_blurb.call request, options, op_proc: block
          end

          ##
          # Retrieves the Blurb with the given resource name.
          #
          # @overload get_blurb(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::GetBlurbRequest | Hash]
          #     Retrieves the Blurb with the given resource name.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload get_blurb(name: nil, options: nil)
          #   @param name [String]
          #     The resource name of the requested blurb.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::Blurb]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::Blurb]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def get_blurb request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::GetBlurbRequest

            @get_blurb.call request, options, op_proc: block
          end

          ##
          # Updates a blurb.
          #
          # @overload update_blurb(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::UpdateBlurbRequest | Hash]
          #     Updates a blurb.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload update_blurb(blurb: nil, update_mask: nil, options: nil)
          #   @param blurb [Google::Showcase::V1alpha3::Blurb | Hash]
          #     The blurb to update.
          #   @param update_mask [Google::Protobuf::FieldMask | Hash]
          #     The field mask to determine wich fields are to be updated. If empty, the
          #     server will assume all fields are to be updated.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::Blurb]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::Blurb]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def update_blurb request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::UpdateBlurbRequest

            @update_blurb.call request, options, op_proc: block
          end

          ##
          # Deletes a blurb.
          #
          # @overload delete_blurb(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::DeleteBlurbRequest | Hash]
          #     Deletes a blurb.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload delete_blurb(name: nil, options: nil)
          #   @param name [String]
          #     The resource name of the requested blurb.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Protobuf::Empty]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Protobuf::Empty]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def delete_blurb request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::DeleteBlurbRequest

            @delete_blurb.call request, options, op_proc: block
          end

          ##
          # Lists blurbs for a specific chat room or user profile depending on the
          # parent resource name.
          #
          # @overload list_blurbs(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::ListBlurbsRequest | Hash]
          #     Lists blurbs for a specific chat room or user profile depending on the
          #     parent resource name.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload list_blurbs(parent: nil, page_size: nil, page_token: nil, options: nil)
          #   @param parent [String]
          #     The resource name of the requested room or profile whos blurbs to list.
          #   @param page_size [Integer]
          #     The maximum number of blurbs to return. Server may return fewer
          #     blurbs than requested. If unspecified, server will pick an appropriate
          #     default.
          #   @param page_token [String]
          #     The value of google.showcase.v1alpha3.ListBlurbsResponse.next_page_token
          #     returned from the previous call to
          #     `google.showcase.v1alpha3.Messaging\ListBlurbs` method.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::ListBlurbsResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::ListBlurbsResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def list_blurbs request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::ListBlurbsRequest

            @list_blurbs.call request, options, op_proc: block
          end

          ##
          # This method searches through all blurbs across all rooms and profiles
          # for blurbs containing to words found in the query. Only posts that
          # contain an exact match of a queried word will be returned.
          #
          # @overload search_blurbs(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::SearchBlurbsRequest | Hash]
          #     This method searches through all blurbs across all rooms and profiles
          #     for blurbs containing to words found in the query. Only posts that
          #     contain an exact match of a queried word will be returned.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload search_blurbs(query: nil, parent: nil, page_size: nil, page_token: nil, options: nil)
          #   @param query [String]
          #     The query used to search for blurbs containing to words of this string.
          #     Only posts that contain an exact match of a queried word will be returned.
          #   @param parent [String]
          #     The rooms or profiles to search. If unset, `SearchBlurbs` will search all
          #     rooms and all profiles.
          #   @param page_size [Integer]
          #     The maximum number of blurbs return. Server may return fewer
          #     blurbs than requested. If unspecified, server will pick an appropriate
          #     default.
          #   @param page_token [String]
          #     The value of
          #     google.showcase.v1alpha3.SearchBlurbsResponse.next_page_token
          #     returned from the previous call to
          #     `google.showcase.v1alpha3.Messaging\SearchBlurbs` method.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [operation] Register a callback to be run when an operation is done.
          # @yieldparam operation [Google::Gax::Operation]
          #
          # @return [Google::Gax::Operation]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def search_blurbs request = nil, options: nil, **request_fields
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::SearchBlurbsRequest

            operation = Google::Gax::Operation.new(
              @search_blurbs.call(request, options),
              @operations_client,
              call_options: options
            )
            operation.on_done { |operation| yield operation } if block_given?
            operation
          end

          ##
          # This returns a stream that emits the blurbs that are created for a
          # particular chat room or user profile.
          #
          # @overload stream_blurbs(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::StreamBlurbsRequest | Hash]
          #     This returns a stream that emits the blurbs that are created for a
          #     particular chat room or user profile.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload stream_blurbs(name: nil, expire_time: nil, options: nil)
          #   @param name [String]
          #     The resource name of a chat room or user profile whose blurbs to stream.
          #   @param expire_time [Google::Protobuf::Timestamp | Hash]
          #     The time at which this stream will close.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response] Called on each streaming responses, when provided.
          # @yieldparam response [Google::Showcase::V1alpha3::StreamBlurbsResponse]
          #
          # @return [Enumerable<Google::Showcase::V1alpha3::StreamBlurbsResponse, nil>]
          #   An enumerable of {Google::Showcase::V1alpha3::StreamBlurbsResponse} instances when a block is not provided.
          #   When a block is provided `nil` is returned.
          #
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          #
          # @example
          #   TODO
          #
          def stream_blurbs request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::StreamBlurbsRequest

            @stream_blurbs.call request, options, enum_proc: block
          end

          ##
          # This is a stream to create multiple blurbs. If an invalid blurb is
          # requested to be created, the stream will close with an error.
          #
          # @param requests [Google::Gax::StreamInput, Enumerable<Google::Showcase::V1alpha3::CreateBlurbRequest | Hash>]
          #   An enumerable of {Google::Showcase::V1alpha3::CreateBlurbRequest} instances.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::SendBlurbsResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::SendBlurbsResponse]
          #
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          #
          # @example
          #   TODO
          #
          def send_blurbs requests, options: nil, &block
            unless requests.is_a? Enumerable
              if requests.respond_to? :to_enum
                requests = requests.to_enum
              else
                raise ArgumentError, "requests must be an Enumerable"
              end
            end

            requests = requests.lazy.map do |request|
              Google::Gax.to_proto request, Google::Showcase::V1alpha3::CreateBlurbRequest
            end

            @send_blurbs.call requests, options, op_proc: block
          end

          ##
          # This method starts a bidirectional stream that receives all blurbs that
          # are being created after the stream has started and sends requests to create
          # blurbs. If an invalid blurb is requested to be created, the stream will
          # close with an error.
          #
          # @param requests [Google::Gax::StreamInput, Enumerable<Google::Showcase::V1alpha3::ConnectRequest | Hash>]
          #   An enumerable of {Google::Showcase::V1alpha3::ConnectRequest} instances.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response] Called on each streaming responses, when provided.
          # @yieldparam response [Google::Showcase::V1alpha3::StreamBlurbsResponse]
          #
          # @return [Enumerable<Google::Showcase::V1alpha3::StreamBlurbsResponse, nil>]
          #   An enumerable of {Google::Showcase::V1alpha3::StreamBlurbsResponse} instances when a block is not provided.
          #   When a block is provided `nil` is returned.
          #
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          #
          # @example
          #   TODO
          #
          def connect requests, options: nil, &block
            unless requests.is_a? Enumerable
              if requests.respond_to? :to_enum
                requests = requests.to_enum
              else
                raise ArgumentError, "requests must be an Enumerable"
              end
            end

            requests = requests.lazy.map do |request|
              Google::Gax.to_proto request, Google::Showcase::V1alpha3::ConnectRequest
            end

            @connect.call requests, options, enum_proc: block
          end

          protected

          def create_stub credentials, scopes
            if credentials.is_a?(String) || credentials.is_a?(Hash)
              updater_proc = Credentials.new(credentials).updater_proc
            elsif credentials.is_a? GRPC::Core::Channel
              channel = credentials
            elsif credentials.is_a? GRPC::Core::ChannelCredentials
              chan_creds = credentials
            elsif credentials.is_a? Proc
              updater_proc = credentials
            elsif credentials.is_a? Google::Auth::Credentials
              updater_proc = credentials.updater_proc
            end

            # Allow overriding the service path/port in subclasses.
            service_path = self.class::SERVICE_ADDRESS
            port = self.class::DEFAULT_SERVICE_PORT
            interceptors = self.class::GRPC_INTERCEPTORS
            stub_new = Google::Showcase::V1alpha3::Messaging::Stub.method :new
            Google::Gax::Grpc.create_stub(
              service_path,
              port,
              chan_creds:   chan_creds,
              channel:      channel,
              updater_proc: updater_proc,
              scopes:       scopes,
              interceptors: interceptors,
              &stub_new
            )
          end

          def default_settings _client_config, _timeout, metadata, lib_name,
                               lib_version
            google_api_client = ["gl-ruby/#{RUBY_VERSION}"]
            google_api_client << "#{lib_name}/#{lib_version}" if lib_name
            google_api_client << "gapic/#{Google::Showcase::VERSION}"
            google_api_client << "gax/#{Google::Gax::VERSION}"
            google_api_client << "grpc/#{GRPC::VERSION}"
            google_api_client.join " "

            headers = { "x-goog-api-client": google_api_client }
            headers.merge! metadata unless metadata.nil?

            Google::Gax.const_get(:CallSettings).new metadata: headers
          end
        end
      end
    end
  end
end

# rubocop:disable Lint/HandleExceptions

# Once client is loaded, load helpers.rb if it exists.
begin
  require "google/showcase/v1alpha3/messaging/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
