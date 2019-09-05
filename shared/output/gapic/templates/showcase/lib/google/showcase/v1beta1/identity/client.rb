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

require "gapic/common"
require "gapic/config"
require "gapic/config/method"

require "google/showcase/version"
require "google/showcase/v1beta1/identity_pb"
require "google/showcase/v1beta1/identity/credentials"
require "google/showcase/v1beta1/identity/paths"

module Google
  module Showcase
    module V1beta1
      module Identity
        # Service that implements Identity API.
        class Client
          include Paths

          # @private
          attr_reader :identity_stub

          ##
          # Configuration for the Identity Client API.
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
          # Configure the Identity Client instance.
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
            require "google/showcase/v1beta1/identity_services_pb"

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


            @identity_stub = Gapic::ServiceStub.new(
              Google::Showcase::V1beta1::Identity::Stub,
              credentials:  credentials,
              endpoint:     @config.endpoint,
              channel_args: @config.channel_args,
              interceptors: @config.interceptors
            )
          end

          # Service calls

          ##
          # Creates a user.
          #
          # @overload create_user(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::CreateUserRequest | Hash]
          #     Creates a user.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload create_user(user: nil)
          #   @param user [Google::Showcase::V1beta1::User | Hash]
          #     The user to create.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::User]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::User]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def create_user request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::CreateUserRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.create_user.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            options.apply_defaults timeout:      @config.rpcs.create_user.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.create_user.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @identity_stub.call_rpc :create_user, request, options: options, operation_callback: block
          end

          ##
          # Retrieves the User with the given uri.
          #
          # @overload get_user(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::GetUserRequest | Hash]
          #     Retrieves the User with the given uri.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload get_user(name: nil)
          #   @param name [String]
          #     The resource name of the requested user.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::User]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::User]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def get_user request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::GetUserRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.get_user.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.get_user.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.get_user.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @identity_stub.call_rpc :get_user, request, options: options, operation_callback: block
          end

          ##
          # Updates a user.
          #
          # @overload update_user(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::UpdateUserRequest | Hash]
          #     Updates a user.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload update_user(user: nil, update_mask: nil)
          #   @param user [Google::Showcase::V1beta1::User | Hash]
          #     The user to update.
          #   @param update_mask [Google::Protobuf::FieldMask | Hash]
          #     The field mask to determine wich fields are to be updated. If empty, the
          #     server will assume all fields are to be updated.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::User]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::User]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def update_user request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::UpdateUserRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.update_user.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "user.name" => request.user.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.update_user.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.update_user.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @identity_stub.call_rpc :update_user, request, options: options, operation_callback: block
          end

          ##
          # Deletes a user, their profile, and all of their authored messages.
          #
          # @overload delete_user(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::DeleteUserRequest | Hash]
          #     Deletes a user, their profile, and all of their authored messages.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload delete_user(name: nil)
          #   @param name [String]
          #     The resource name of the user to delete.
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
          def delete_user request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::DeleteUserRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.delete_user.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.delete_user.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.delete_user.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @identity_stub.call_rpc :delete_user, request, options: options, operation_callback: block
          end

          ##
          # Lists all users.
          #
          # @overload list_users(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::ListUsersRequest | Hash]
          #     Lists all users.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload list_users(page_size: nil, page_token: nil)
          #   @param page_size [Integer]
          #     The maximum number of users to return. Server may return fewer users
          #     than requested. If unspecified, server will pick an appropriate default.
          #   @param page_token [String]
          #     The value of google.showcase.v1beta1.ListUsersResponse.next_page_token
          #     returned from the previous call to
          #     `google.showcase.v1beta1.Identity\ListUsers` method.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Gapic::PagedEnumerable<Google::Showcase::V1beta1::User>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Gapic::PagedEnumerable<Google::Showcase::V1beta1::User>]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def list_users request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::ListUsersRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.list_users.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            options.apply_defaults timeout:      @config.rpcs.list_users.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.list_users.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            paged_response = nil
            paged_operation_callback = lambda do |response, operation|
              paged_response = Gapic::PagedEnumerable.new @identity_stub, :list_users, request, response, operation, options
              yield paged_response, operation if block
            end
            @identity_stub.call_rpc :list_users, request, options: options, operation_callback: paged_operation_callback
            paged_response
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
              attr_reader :create_user
              attr_reader :get_user
              attr_reader :update_user
              attr_reader :delete_user
              attr_reader :list_users

              def initialize parent_rpcs = nil
                create_user_config = nil
                create_user_config = parent_rpcs&.create_user if parent_rpcs&.respond_to? :create_user
                @create_user = Gapic::Config::Method.new create_user_config
                get_user_config = nil
                get_user_config = parent_rpcs&.get_user if parent_rpcs&.respond_to? :get_user
                @get_user = Gapic::Config::Method.new get_user_config
                update_user_config = nil
                update_user_config = parent_rpcs&.update_user if parent_rpcs&.respond_to? :update_user
                @update_user = Gapic::Config::Method.new update_user_config
                delete_user_config = nil
                delete_user_config = parent_rpcs&.delete_user if parent_rpcs&.respond_to? :delete_user
                @delete_user = Gapic::Config::Method.new delete_user_config
                list_users_config = nil
                list_users_config = parent_rpcs&.list_users if parent_rpcs&.respond_to? :list_users
                @list_users = Gapic::Config::Method.new list_users_config

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
  require "google/showcase/v1beta1/identity/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
