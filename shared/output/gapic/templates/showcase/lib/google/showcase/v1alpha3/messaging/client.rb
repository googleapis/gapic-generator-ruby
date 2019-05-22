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

require "google/gax"
require "google/gax/config"
require "google/gax/config/method"

require "google/showcase/version"
require "google/showcase/v1alpha3/messaging_pb"
require "google/showcase/v1alpha3/messaging/credentials"
require "google/showcase/v1alpha3/messaging/paths"
require "google/showcase/v1alpha3/messaging/operations"

module Google
  module Showcase
    module V1alpha3
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
            @configure ||= Client::Configuration.new
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
            require "google/gax/grpc"
            require "google/showcase/v1alpha3/messaging_services_pb"

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

            @messaging_stub = Google::Gax::Grpc::Stub.new(
              Google::Showcase::V1alpha3::Messaging::Stub,
              credentials:  credentials,
              host:         @config.host,
              port:         @config.port,
              interceptors: @config.interceptors
            )
          end

          # Service calls

          ##
          # Creates a room.
          #
          # @overload create_room(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::CreateRoomRequest | Hash]
          #     Creates a room.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload create_room(room: nil, options: nil)
          #   @param room [Google::Showcase::V1alpha3::Room | Hash]
          #     The room to create.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::Room]
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
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::CreateRoomRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.create_room.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            options.apply_defaults timeout:      @config.rpcs.create_room.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.create_room.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @create_room ||= Google::Gax::ApiCall.new @messaging_stub.method :create_room

            @create_room.call request, options: options, operation_callback: block
          end

          ##
          # Retrieves the Room with the given resource name.
          #
          # @overload get_room(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::GetRoomRequest | Hash]
          #     Retrieves the Room with the given resource name.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload get_room(name: nil, options: nil)
          #   @param name [String]
          #     The resource name of the requested room.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::Room]
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
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::GetRoomRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.get_room.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.get_room.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.get_room.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @get_room ||= Google::Gax::ApiCall.new @messaging_stub.method :get_room

            @get_room.call request, options: options, operation_callback: block
          end

          ##
          # Updates a room.
          #
          # @overload update_room(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::UpdateRoomRequest | Hash]
          #     Updates a room.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload update_room(room: nil, update_mask: nil, options: nil)
          #   @param room [Google::Showcase::V1alpha3::Room | Hash]
          #     The room to update.
          #   @param update_mask [Google::Protobuf::FieldMask | Hash]
          #     The field mask to determine wich fields are to be updated. If empty, the
          #     server will assume all fields are to be updated.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::Room]
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
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::UpdateRoomRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.update_room.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            header_params = {
              "room.name" => request.room.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.update_room.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.update_room.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @update_room ||= Google::Gax::ApiCall.new @messaging_stub.method :update_room

            @update_room.call request, options: options, operation_callback: block
          end

          ##
          # Deletes a room and all of its blurbs.
          #
          # @overload delete_room(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::DeleteRoomRequest | Hash]
          #     Deletes a room and all of its blurbs.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload delete_room(name: nil, options: nil)
          #   @param name [String]
          #     The resource name of the requested room.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Protobuf::Empty]
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
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::DeleteRoomRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.delete_room.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.delete_room.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.delete_room.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @delete_room ||= Google::Gax::ApiCall.new @messaging_stub.method :delete_room

            @delete_room.call request, options: options, operation_callback: block
          end

          ##
          # Lists all chat rooms.
          #
          # @overload list_rooms(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::ListRoomsRequest | Hash]
          #     Lists all chat rooms.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
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
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Gax::PagedEnumerable<Google::Showcase::V1alpha3::Room>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Gax::PagedEnumerable<Google::Showcase::V1alpha3::Room>]
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
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::ListRoomsRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.list_rooms.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            options.apply_defaults timeout:      @config.rpcs.list_rooms.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.list_rooms.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @list_rooms ||= Google::Gax::ApiCall.new @messaging_stub.method :list_rooms

            wrap_paged_enum = ->(response) { Google::Gax::PagedEnumerable.new @list_rooms, request, response, options }

            @list_rooms.call request, options: options, operation_callback: block, format_response: wrap_paged_enum
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
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload create_blurb(parent: nil, blurb: nil, options: nil)
          #   @param parent [String]
          #     The resource name of the chat room or user profile that this blurb will
          #     be tied to.
          #   @param blurb [Google::Showcase::V1alpha3::Blurb | Hash]
          #     The blurb to create.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::Blurb]
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
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::CreateBlurbRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.create_blurb.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            header_params = {
              "parent" => request.parent
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.create_blurb.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.create_blurb.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @create_blurb ||= Google::Gax::ApiCall.new @messaging_stub.method :create_blurb

            @create_blurb.call request, options: options, operation_callback: block
          end

          ##
          # Retrieves the Blurb with the given resource name.
          #
          # @overload get_blurb(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::GetBlurbRequest | Hash]
          #     Retrieves the Blurb with the given resource name.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload get_blurb(name: nil, options: nil)
          #   @param name [String]
          #     The resource name of the requested blurb.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::Blurb]
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
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::GetBlurbRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.get_blurb.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.get_blurb.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.get_blurb.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @get_blurb ||= Google::Gax::ApiCall.new @messaging_stub.method :get_blurb

            @get_blurb.call request, options: options, operation_callback: block
          end

          ##
          # Updates a blurb.
          #
          # @overload update_blurb(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::UpdateBlurbRequest | Hash]
          #     Updates a blurb.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload update_blurb(blurb: nil, update_mask: nil, options: nil)
          #   @param blurb [Google::Showcase::V1alpha3::Blurb | Hash]
          #     The blurb to update.
          #   @param update_mask [Google::Protobuf::FieldMask | Hash]
          #     The field mask to determine wich fields are to be updated. If empty, the
          #     server will assume all fields are to be updated.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::Blurb]
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
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::UpdateBlurbRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.update_blurb.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            header_params = {
              "blurb.name" => request.blurb.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.update_blurb.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.update_blurb.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @update_blurb ||= Google::Gax::ApiCall.new @messaging_stub.method :update_blurb

            @update_blurb.call request, options: options, operation_callback: block
          end

          ##
          # Deletes a blurb.
          #
          # @overload delete_blurb(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::DeleteBlurbRequest | Hash]
          #     Deletes a blurb.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload delete_blurb(name: nil, options: nil)
          #   @param name [String]
          #     The resource name of the requested blurb.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Protobuf::Empty]
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
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::DeleteBlurbRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.delete_blurb.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.delete_blurb.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.delete_blurb.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @delete_blurb ||= Google::Gax::ApiCall.new @messaging_stub.method :delete_blurb

            @delete_blurb.call request, options: options, operation_callback: block
          end

          ##
          # Lists blurbs for a specific chat room or user profile depending on the
          # parent resource name.
          #
          # @overload list_blurbs(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::ListBlurbsRequest | Hash]
          #     Lists blurbs for a specific chat room or user profile depending on the
          #     parent resource name.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
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
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Gax::PagedEnumerable<Google::Showcase::V1alpha3::Blurb>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Gax::PagedEnumerable<Google::Showcase::V1alpha3::Blurb>]
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
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::ListBlurbsRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.list_blurbs.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            header_params = {
              "parent" => request.parent
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.list_blurbs.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.list_blurbs.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @list_blurbs ||= Google::Gax::ApiCall.new @messaging_stub.method :list_blurbs

            wrap_paged_enum = ->(response) { Google::Gax::PagedEnumerable.new @list_blurbs, request, response, options }

            @list_blurbs.call request, options: options, operation_callback: block, format_response: wrap_paged_enum
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
          #   @param options [Google::Gax::ApiCall::Options, Hash]
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
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Gax::Operation]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Gax::Operation]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def search_blurbs request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::SearchBlurbsRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.search_blurbs.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            header_params = {
              "parent" => request.parent
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.search_blurbs.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.search_blurbs.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @search_blurbs ||= Google::Gax::ApiCall.new @messaging_stub.method :search_blurbs

            wrap_gax_operation = ->(response) { Google::Gax::Operation.new response, @operations_client }

            @search_blurbs.call request, options: options, operation_callback: block, format_response: wrap_gax_operation
          end

          ##
          # This returns a stream that emits the blurbs that are created for a
          # particular chat room or user profile.
          #
          # @overload stream_blurbs(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::StreamBlurbsRequest | Hash]
          #     This returns a stream that emits the blurbs that are created for a
          #     particular chat room or user profile.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload stream_blurbs(name: nil, expire_time: nil, options: nil)
          #   @param name [String]
          #     The resource name of a chat room or user profile whose blurbs to stream.
          #   @param expire_time [Google::Protobuf::Timestamp | Hash]
          #     The time at which this stream will close.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response] Called on each streaming responses, when provided.
          # @yieldparam response [Google::Showcase::V1alpha3::StreamBlurbsResponse]
          #
          # @return [Enumerable<Google::Showcase::V1alpha3::StreamBlurbsResponse, Thread>]
          #   An enumerable of {Google::Showcase::V1alpha3::StreamBlurbsResponse} instances when a block is not provided.
          #   When a block is provided a thread running the block for every streamed response is returned.
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
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::StreamBlurbsRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.stream_blurbs.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.stream_blurbs.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.stream_blurbs.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @stream_blurbs ||= Google::Gax::ApiCall.new @messaging_stub.method :stream_blurbs
            @stream_blurbs.call request, options: options, stream_callback: block
          end

          ##
          # This is a stream to create multiple blurbs. If an invalid blurb is
          # requested to be created, the stream will close with an error.
          #
          # @param requests [Google::Gax::StreamInput, Enumerable<Google::Showcase::V1alpha3::CreateBlurbRequest | Hash>]
          #   An enumerable of {Google::Showcase::V1alpha3::CreateBlurbRequest} instances.
          # @param options [Google::Gax::ApiCall::Options, Hash]
          #   Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::SendBlurbsResponse]
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
              Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::CreateBlurbRequest
            end

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.send_blurbs.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            header_params = {
              "parent" => request.parent
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.send_blurbs.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.send_blurbs.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @send_blurbs ||= Google::Gax::ApiCall.new @messaging_stub.method :send_blurbs
            @send_blurbs.call requests, options: options, operation_callback: block
          end

          ##
          # This method starts a bidirectional stream that receives all blurbs that
          # are being created after the stream has started and sends requests to create
          # blurbs. If an invalid blurb is requested to be created, the stream will
          # close with an error.
          #
          # @param requests [Google::Gax::StreamInput, Enumerable<Google::Showcase::V1alpha3::ConnectRequest | Hash>]
          #   An enumerable of {Google::Showcase::V1alpha3::ConnectRequest} instances.
          # @param options [Google::Gax::ApiCall::Options, Hash]
          #   Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response] Called on each streaming responses, when provided.
          # @yieldparam response [Google::Showcase::V1alpha3::StreamBlurbsResponse]
          #
          # @return [Enumerable<Google::Showcase::V1alpha3::StreamBlurbsResponse, Thread>]
          #   An enumerable of {Google::Showcase::V1alpha3::StreamBlurbsResponse} instances when a block is not provided.
          #   When a block is provided a thread running the block for every streamed response is returned.
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
              Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::ConnectRequest
            end

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.connect.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            options.apply_defaults timeout:      @config.rpcs.connect.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.connect.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @connect ||= Google::Gax::ApiCall.new @messaging_stub.method :connect
            @connect.call requests, options: options, stream_callback: block
          end

          class Configuration
            extend Google::Gax::Config

            config_attr :host,         "localhost", String
            config_attr :port,         7469, Integer
            config_attr :credentials,  nil do |value|
              allowed = [::String, ::Hash, ::Proc, ::Google::Auth::Credentials]
              allowed += [::GRPC::Core::Channel, ::GRPC::Core::ChannelCredentials] if defined? ::GRPC
              allowed.any? { |klass| klass === value }
            end
            config_attr :scope,        nil,                                   String, Array, nil
            config_attr :lib_name,     nil,                                   String, nil
            config_attr :lib_version,  nil,                                   String, nil
            config_attr :interceptors, [],                                    Array
            config_attr :timeout,      nil,                                   Numeric, nil
            config_attr :metadata,     nil,                                   Hash, nil
            config_attr :retry_policy, nil,                                   Hash, Proc, nil

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
                @create_room = Google::Gax::Config::Method.new create_room_config
                get_room_config = nil
                get_room_config = parent_rpcs&.get_room if parent_rpcs&.respond_to? :get_room
                @get_room = Google::Gax::Config::Method.new get_room_config
                update_room_config = nil
                update_room_config = parent_rpcs&.update_room if parent_rpcs&.respond_to? :update_room
                @update_room = Google::Gax::Config::Method.new update_room_config
                delete_room_config = nil
                delete_room_config = parent_rpcs&.delete_room if parent_rpcs&.respond_to? :delete_room
                @delete_room = Google::Gax::Config::Method.new delete_room_config
                list_rooms_config = nil
                list_rooms_config = parent_rpcs&.list_rooms if parent_rpcs&.respond_to? :list_rooms
                @list_rooms = Google::Gax::Config::Method.new list_rooms_config
                create_blurb_config = nil
                create_blurb_config = parent_rpcs&.create_blurb if parent_rpcs&.respond_to? :create_blurb
                @create_blurb = Google::Gax::Config::Method.new create_blurb_config
                get_blurb_config = nil
                get_blurb_config = parent_rpcs&.get_blurb if parent_rpcs&.respond_to? :get_blurb
                @get_blurb = Google::Gax::Config::Method.new get_blurb_config
                update_blurb_config = nil
                update_blurb_config = parent_rpcs&.update_blurb if parent_rpcs&.respond_to? :update_blurb
                @update_blurb = Google::Gax::Config::Method.new update_blurb_config
                delete_blurb_config = nil
                delete_blurb_config = parent_rpcs&.delete_blurb if parent_rpcs&.respond_to? :delete_blurb
                @delete_blurb = Google::Gax::Config::Method.new delete_blurb_config
                list_blurbs_config = nil
                list_blurbs_config = parent_rpcs&.list_blurbs if parent_rpcs&.respond_to? :list_blurbs
                @list_blurbs = Google::Gax::Config::Method.new list_blurbs_config
                search_blurbs_config = nil
                search_blurbs_config = parent_rpcs&.search_blurbs if parent_rpcs&.respond_to? :search_blurbs
                @search_blurbs = Google::Gax::Config::Method.new search_blurbs_config
                stream_blurbs_config = nil
                stream_blurbs_config = parent_rpcs&.stream_blurbs if parent_rpcs&.respond_to? :stream_blurbs
                @stream_blurbs = Google::Gax::Config::Method.new stream_blurbs_config
                send_blurbs_config = nil
                send_blurbs_config = parent_rpcs&.send_blurbs if parent_rpcs&.respond_to? :send_blurbs
                @send_blurbs = Google::Gax::Config::Method.new send_blurbs_config
                connect_config = nil
                connect_config = parent_rpcs&.connect if parent_rpcs&.respond_to? :connect
                @connect = Google::Gax::Config::Method.new connect_config

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
  require "google/showcase/v1alpha3/messaging/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
