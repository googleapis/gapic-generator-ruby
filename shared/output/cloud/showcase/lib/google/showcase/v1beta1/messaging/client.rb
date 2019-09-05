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

require "gapic/common"
require "gapic/config"
require "gapic/config/method"

require "google/showcase"
require "google/showcase/version"
require "google/showcase/v1beta1/messaging_pb"
require "google/showcase/v1beta1/messaging/credentials"
require "google/showcase/v1beta1/messaging/paths"
require "google/showcase/v1beta1/messaging/operations"

module Google
  module Showcase
    module V1beta1
      module Messaging
        # Service that implements Messaging API.
        class Client
          include Paths

          # @private
          attr_reader :messaging_stub

          ##
          # Configuration for the Messaging Client API.
          #
          # @yield [config] Configure the Client client.
          # @yieldparam config [Client::Configuration]
          #
          # @return [Client::Configuration]
          #
          def self.configure
            @configure ||= Client::Configuration.new Google::Showcase.configure
            yield @configure if block_given?
            @configure
          end

          ##
          # Configure the Messaging Client instance.
          #
          # The configuration is set to the derived mode, meaning that values can be changed,
          # but structural changes (adding new fields, etc.) are not allowed. Structural changes
          # should be made on {Client.configure}.
          #
          # @yield [config] Configure the Client client.
          # @yieldparam config [Client::Configuration]
          #
          # @return [Client::Configuration]
          #
          def configure
            yield @config if block_given?
            @config
          end

          ##
          # Create a new Client client object.
          #
          # @yield [config] Configure the Client client.
          # @yieldparam config [Client::Configuration]
          #
          def initialize
            # These require statements are intentionally placed here to initialize
            # the gRPC module only when it's required.
            # See https://github.com/googleapis/toolkit/issues/446
            require "gapic/grpc"
            require "google/showcase/v1beta1/messaging_services_pb"

            # Create the configuration object
            @config = Configuration.new Client.configure

            # Yield the configuration if needed
            yield @config if block_given?

            # Create credentials
            credentials = @config.credentials
            credentials ||= Credentials.default scope: @config.scope
            if credentials.is_a?(String) || credentials.is_a?(Hash)
              credentials = Credentials.new credentials, scope: @config.scope
            end

            @operations_client = Operations.new do |config|
              config.credentials = credentials
            end

            @messaging_stub = Gapic::ServiceStub.new(
              Google::Showcase::V1beta1::Messaging::Stub,
              credentials:  credentials,
              endpoint:     @config.endpoint,
              channel_args: @config.channel_args,
              interceptors: @config.interceptors
            )
          end

          # Service calls

          ##
          # Creates a room.
          #
          # @overload create_room(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::CreateRoomRequest | Hash]
          #     Creates a room.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload create_room(room: nil)
          #   @param room [Google::Showcase::V1beta1::Room | Hash]
          #     The room to create.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::Room]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::Room]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def create_room request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::CreateRoomRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.create_room.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            options.apply_defaults timeout:      @config.rpcs.create_room.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.create_room.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @messaging_stub.call_rpc :create_room, request, options: options, operation_callback: block
          end

          ##
          # Retrieves the Room with the given resource name.
          #
          # @overload get_room(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::GetRoomRequest | Hash]
          #     Retrieves the Room with the given resource name.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload get_room(name: nil)
          #   @param name [String]
          #     The resource name of the requested room.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::Room]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::Room]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def get_room request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::GetRoomRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.get_room.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.get_room.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.get_room.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @messaging_stub.call_rpc :get_room, request, options: options, operation_callback: block
          end

          ##
          # Updates a room.
          #
          # @overload update_room(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::UpdateRoomRequest | Hash]
          #     Updates a room.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload update_room(room: nil, update_mask: nil)
          #   @param room [Google::Showcase::V1beta1::Room | Hash]
          #     The room to update.
          #   @param update_mask [Google::Protobuf::FieldMask | Hash]
          #     The field mask to determine wich fields are to be updated. If empty, the
          #     server will assume all fields are to be updated.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::Room]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::Room]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def update_room request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::UpdateRoomRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.update_room.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "room.name" => request.room.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.update_room.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.update_room.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @messaging_stub.call_rpc :update_room, request, options: options, operation_callback: block
          end

          ##
          # Deletes a room and all of its blurbs.
          #
          # @overload delete_room(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::DeleteRoomRequest | Hash]
          #     Deletes a room and all of its blurbs.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload delete_room(name: nil)
          #   @param name [String]
          #     The resource name of the requested room.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Protobuf::Empty]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Protobuf::Empty]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def delete_room request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::DeleteRoomRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.delete_room.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.delete_room.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.delete_room.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @messaging_stub.call_rpc :delete_room, request, options: options, operation_callback: block
          end

          ##
          # Lists all chat rooms.
          #
          # @overload list_rooms(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::ListRoomsRequest | Hash]
          #     Lists all chat rooms.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload list_rooms(page_size: nil, page_token: nil)
          #   @param page_size [Integer]
          #     The maximum number of rooms return. Server may return fewer rooms
          #     than requested. If unspecified, server will pick an appropriate default.
          #   @param page_token [String]
          #     The value of google.showcase.v1beta1.ListRoomsResponse.next_page_token
          #     returned from the previous call to
          #     `google.showcase.v1beta1.Messaging\ListRooms` method.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Gapic::PagedEnumerable<Google::Showcase::V1beta1::Room>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Gapic::PagedEnumerable<Google::Showcase::V1beta1::Room>]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def list_rooms request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::ListRoomsRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.list_rooms.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            options.apply_defaults timeout:      @config.rpcs.list_rooms.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.list_rooms.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            paged_response = nil
            paged_operation_callback = lambda do |response, operation|
              paged_response = Gapic::PagedEnumerable.new @messaging_stub, :list_rooms, request, response, operation, options
              yield paged_response, operation if block
            end
            @messaging_stub.call_rpc :list_rooms, request, options: options, operation_callback: paged_operation_callback
            paged_response
          end

          ##
          # Creates a blurb. If the parent is a room, the blurb is understood to be a
          # message in that room. If the parent is a profile, the blurb is understood
          # to be a post on the profile.
          #
          # @overload create_blurb(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::CreateBlurbRequest | Hash]
          #     Creates a blurb. If the parent is a room, the blurb is understood to be a
          #     message in that room. If the parent is a profile, the blurb is understood
          #     to be a post on the profile.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload create_blurb(parent: nil, blurb: nil)
          #   @param parent [String]
          #     The resource name of the chat room or user profile that this blurb will
          #     be tied to.
          #   @param blurb [Google::Showcase::V1beta1::Blurb | Hash]
          #     The blurb to create.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::Blurb]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::Blurb]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def create_blurb request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::CreateBlurbRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.create_blurb.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "parent" => request.parent
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.create_blurb.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.create_blurb.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @messaging_stub.call_rpc :create_blurb, request, options: options, operation_callback: block
          end

          ##
          # Retrieves the Blurb with the given resource name.
          #
          # @overload get_blurb(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::GetBlurbRequest | Hash]
          #     Retrieves the Blurb with the given resource name.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload get_blurb(name: nil)
          #   @param name [String]
          #     The resource name of the requested blurb.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::Blurb]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::Blurb]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def get_blurb request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::GetBlurbRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.get_blurb.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.get_blurb.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.get_blurb.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @messaging_stub.call_rpc :get_blurb, request, options: options, operation_callback: block
          end

          ##
          # Updates a blurb.
          #
          # @overload update_blurb(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::UpdateBlurbRequest | Hash]
          #     Updates a blurb.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload update_blurb(blurb: nil, update_mask: nil)
          #   @param blurb [Google::Showcase::V1beta1::Blurb | Hash]
          #     The blurb to update.
          #   @param update_mask [Google::Protobuf::FieldMask | Hash]
          #     The field mask to determine wich fields are to be updated. If empty, the
          #     server will assume all fields are to be updated.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::Blurb]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::Blurb]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def update_blurb request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::UpdateBlurbRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.update_blurb.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "blurb.name" => request.blurb.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.update_blurb.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.update_blurb.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @messaging_stub.call_rpc :update_blurb, request, options: options, operation_callback: block
          end

          ##
          # Deletes a blurb.
          #
          # @overload delete_blurb(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::DeleteBlurbRequest | Hash]
          #     Deletes a blurb.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload delete_blurb(name: nil)
          #   @param name [String]
          #     The resource name of the requested blurb.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Protobuf::Empty]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Protobuf::Empty]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def delete_blurb request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::DeleteBlurbRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.delete_blurb.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.delete_blurb.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.delete_blurb.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @messaging_stub.call_rpc :delete_blurb, request, options: options, operation_callback: block
          end

          ##
          # Lists blurbs for a specific chat room or user profile depending on the
          # parent resource name.
          #
          # @overload list_blurbs(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::ListBlurbsRequest | Hash]
          #     Lists blurbs for a specific chat room or user profile depending on the
          #     parent resource name.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload list_blurbs(parent: nil, page_size: nil, page_token: nil)
          #   @param parent [String]
          #     The resource name of the requested room or profile whos blurbs to list.
          #   @param page_size [Integer]
          #     The maximum number of blurbs to return. Server may return fewer
          #     blurbs than requested. If unspecified, server will pick an appropriate
          #     default.
          #   @param page_token [String]
          #     The value of google.showcase.v1beta1.ListBlurbsResponse.next_page_token
          #     returned from the previous call to
          #     `google.showcase.v1beta1.Messaging\ListBlurbs` method.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Gapic::PagedEnumerable<Google::Showcase::V1beta1::Blurb>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Gapic::PagedEnumerable<Google::Showcase::V1beta1::Blurb>]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def list_blurbs request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::ListBlurbsRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.list_blurbs.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "parent" => request.parent
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.list_blurbs.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.list_blurbs.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            paged_response = nil
            paged_operation_callback = lambda do |response, operation|
              paged_response = Gapic::PagedEnumerable.new @messaging_stub, :list_blurbs, request, response, operation, options
              yield paged_response, operation if block
            end
            @messaging_stub.call_rpc :list_blurbs, request, options: options, operation_callback: paged_operation_callback
            paged_response
          end

          ##
          # This method searches through all blurbs across all rooms and profiles
          # for blurbs containing to words found in the query. Only posts that
          # contain an exact match of a queried word will be returned.
          #
          # @overload search_blurbs(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::SearchBlurbsRequest | Hash]
          #     This method searches through all blurbs across all rooms and profiles
          #     for blurbs containing to words found in the query. Only posts that
          #     contain an exact match of a queried word will be returned.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload search_blurbs(query: nil, parent: nil, page_size: nil, page_token: nil)
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
          #     google.showcase.v1beta1.SearchBlurbsResponse.next_page_token
          #     returned from the previous call to
          #     `google.showcase.v1beta1.Messaging\SearchBlurbs` method.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Gapic::Operation]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Gapic::Operation]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def search_blurbs request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::SearchBlurbsRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.search_blurbs.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "parent" => request.parent
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.search_blurbs.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.search_blurbs.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            wrap_gax_operation = ->(response) { Gapic::Operation.new response, @operations_client }
            @messaging_stub.call_rpc :search_blurbs, request, options: options, operation_callback: block, format_response: wrap_gax_operation
          end

          ##
          # This returns a stream that emits the blurbs that are created for a
          # particular chat room or user profile.
          #
          # @overload stream_blurbs(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::StreamBlurbsRequest | Hash]
          #     This returns a stream that emits the blurbs that are created for a
          #     particular chat room or user profile.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload stream_blurbs(name: nil, expire_time: nil)
          #   @param name [String]
          #     The resource name of a chat room or user profile whose blurbs to stream.
          #   @param expire_time [Google::Protobuf::Timestamp | Hash]
          #     The time at which this stream will close.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Enumerable<Google::Showcase::V1beta1::StreamBlurbsResponse>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Enumerable<Google::Showcase::V1beta1::StreamBlurbsResponse>]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def stream_blurbs request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::StreamBlurbsRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.stream_blurbs.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.stream_blurbs.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.stream_blurbs.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @messaging_stub.call_rpc :stream_blurbs, request, options: options, operation_callback: block
          end

          ##
          # This is a stream to create multiple blurbs. If an invalid blurb is
          # requested to be created, the stream will close with an error.
          #
          # @param request [Gapic::StreamInput, Enumerable<Google::Showcase::V1beta1::CreateBlurbRequest | Hash>]
          #   An enumerable of {Google::Showcase::V1beta1::CreateBlurbRequest} instances.
          # @param options [Gapic::CallOptions, Hash]
          #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::SendBlurbsResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::SendBlurbsResponse]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def send_blurbs request, options = nil, &block
            unless request.is_a? Enumerable
              if request.respond_to? :to_enum
                request = request.to_enum
              else
                raise ArgumentError, "request must be an Enumerable"
              end
            end

            request = request.lazy.map do |req|
              Gapic::Protobuf.coerce req, to: Google::Showcase::V1beta1::CreateBlurbRequest
            end

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.send_blurbs.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "parent" => request.parent
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.send_blurbs.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.send_blurbs.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @messaging_stub.call_rpc :send_blurbs, request, options: options, operation_callback: block
          end

          ##
          # This method starts a bidirectional stream that receives all blurbs that
          # are being created after the stream has started and sends requests to create
          # blurbs. If an invalid blurb is requested to be created, the stream will
          # close with an error.
          #
          # @param request [Gapic::StreamInput, Enumerable<Google::Showcase::V1beta1::ConnectRequest | Hash>]
          #   An enumerable of {Google::Showcase::V1beta1::ConnectRequest} instances.
          # @param options [Gapic::CallOptions, Hash]
          #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Enumerable<Google::Showcase::V1beta1::StreamBlurbsResponse>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Enumerable<Google::Showcase::V1beta1::StreamBlurbsResponse>]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def connect request, options = nil, &block
            unless request.is_a? Enumerable
              if request.respond_to? :to_enum
                request = request.to_enum
              else
                raise ArgumentError, "request must be an Enumerable"
              end
            end

            request = request.lazy.map do |req|
              Gapic::Protobuf.coerce req, to: Google::Showcase::V1beta1::ConnectRequest
            end

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.connect.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            options.apply_defaults timeout:      @config.rpcs.connect.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.connect.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @messaging_stub.call_rpc :connect, request, options: options, operation_callback: block
          end

          class Configuration
            extend Gapic::Config

            config_attr :endpoint,     "localhost:7469", String
            config_attr :credentials,  nil do |value|
              allowed = [::String, ::Hash, ::Proc, ::Google::Auth::Credentials, ::Signet::OAuth2::Client, nil]
              allowed += [::GRPC::Core::Channel, ::GRPC::Core::ChannelCredentials] if defined? ::GRPC
              allowed.any? { |klass| klass === value }
            end
            config_attr :scope,        nil, String, Array, nil
            config_attr :lib_name,     nil, String, nil
            config_attr :lib_version,  nil, String, nil
            config_attr(:channel_args, { "grpc.service_config_disable_resolution"=>1 }, Hash, nil)
            config_attr :interceptors, nil, Array, nil
            config_attr :timeout,      nil, Numeric, nil
            config_attr :metadata,     nil, Hash, nil
            config_attr :retry_policy, nil, Hash, Proc, nil

            def initialize parent_config = nil
              @parent_config = parent_config unless parent_config.nil?

              yield self if block_given?
            end

            def rpcs
              @rpcs ||= begin
                parent_rpcs = nil
                parent_rpcs = @parent_config.rpcs if @parent_config&.respond_to? :rpcs
                Rpcs.new parent_rpcs
              end
            end

            class Rpcs
              attr_reader :create_room
              attr_reader :get_room
              attr_reader :update_room
              attr_reader :delete_room
              attr_reader :list_rooms
              attr_reader :create_blurb
              attr_reader :get_blurb
              attr_reader :update_blurb
              attr_reader :delete_blurb
              attr_reader :list_blurbs
              attr_reader :search_blurbs
              attr_reader :stream_blurbs
              attr_reader :send_blurbs
              attr_reader :connect

              def initialize parent_rpcs = nil
                create_room_config = nil
                create_room_config = parent_rpcs&.create_room if parent_rpcs&.respond_to? :create_room
                @create_room = Gapic::Config::Method.new create_room_config
                get_room_config = nil
                get_room_config = parent_rpcs&.get_room if parent_rpcs&.respond_to? :get_room
                @get_room = Gapic::Config::Method.new get_room_config
                update_room_config = nil
                update_room_config = parent_rpcs&.update_room if parent_rpcs&.respond_to? :update_room
                @update_room = Gapic::Config::Method.new update_room_config
                delete_room_config = nil
                delete_room_config = parent_rpcs&.delete_room if parent_rpcs&.respond_to? :delete_room
                @delete_room = Gapic::Config::Method.new delete_room_config
                list_rooms_config = nil
                list_rooms_config = parent_rpcs&.list_rooms if parent_rpcs&.respond_to? :list_rooms
                @list_rooms = Gapic::Config::Method.new list_rooms_config
                create_blurb_config = nil
                create_blurb_config = parent_rpcs&.create_blurb if parent_rpcs&.respond_to? :create_blurb
                @create_blurb = Gapic::Config::Method.new create_blurb_config
                get_blurb_config = nil
                get_blurb_config = parent_rpcs&.get_blurb if parent_rpcs&.respond_to? :get_blurb
                @get_blurb = Gapic::Config::Method.new get_blurb_config
                update_blurb_config = nil
                update_blurb_config = parent_rpcs&.update_blurb if parent_rpcs&.respond_to? :update_blurb
                @update_blurb = Gapic::Config::Method.new update_blurb_config
                delete_blurb_config = nil
                delete_blurb_config = parent_rpcs&.delete_blurb if parent_rpcs&.respond_to? :delete_blurb
                @delete_blurb = Gapic::Config::Method.new delete_blurb_config
                list_blurbs_config = nil
                list_blurbs_config = parent_rpcs&.list_blurbs if parent_rpcs&.respond_to? :list_blurbs
                @list_blurbs = Gapic::Config::Method.new list_blurbs_config
                search_blurbs_config = nil
                search_blurbs_config = parent_rpcs&.search_blurbs if parent_rpcs&.respond_to? :search_blurbs
                @search_blurbs = Gapic::Config::Method.new search_blurbs_config
                stream_blurbs_config = nil
                stream_blurbs_config = parent_rpcs&.stream_blurbs if parent_rpcs&.respond_to? :stream_blurbs
                @stream_blurbs = Gapic::Config::Method.new stream_blurbs_config
                send_blurbs_config = nil
                send_blurbs_config = parent_rpcs&.send_blurbs if parent_rpcs&.respond_to? :send_blurbs
                @send_blurbs = Gapic::Config::Method.new send_blurbs_config
                connect_config = nil
                connect_config = parent_rpcs&.connect if parent_rpcs&.respond_to? :connect
                @connect = Gapic::Config::Method.new connect_config

                yield self if block_given?
              end
            end
          end
        end
      end
    end
  end
end

# rubocop:disable Lint/HandleExceptions

# Once client is loaded, load helpers.rb if it exists.
begin
  require "google/showcase/v1beta1/messaging/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
