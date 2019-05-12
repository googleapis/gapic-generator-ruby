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

require "google/gax"

require "google/showcase/version"
require "google/showcase/v1alpha3/identity_pb"
require "google/showcase/v1alpha3/identity/credentials"
require "google/showcase/v1alpha3/identity/paths"

module Google
  module Showcase
    module V1alpha3
      module Identity
        # Service that implements Identity API.
        class Client
          include Paths

          # @private
          attr_reader :identity_stub

          ##
          # Configuration for the Identity API.
          #
          def self.configure
            @configure ||= Google::Gax::Configuration.new do |config|
              default_scope = Google::Gax::Configuration.deferred do
                Credentials::SCOPE
              end
              config.add_field! :host,         "localhost", match: [String]
              config.add_field! :port,         7469, match: [Integer]
              config.add_field! :scope,        default_scope,                         match: [String, Array], allow_nil: true
              config.add_field! :lib_name,     nil,                                   match: [String],        allow_nil: true
              config.add_field! :lib_version,  nil,                                   match: [String],        allow_nil: true
              config.add_field! :interceptors, [],                                    match: [Array]

              config.add_field! :timeout,      60,  match: [Numeric]
              config.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
              config.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true

              config.add_config! :methods do |methods|
                methods.add_config! :create_user do |method|
                  method.add_field! :timeout,      nil, match: [Numeric],    allow_nil: true
                  method.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
                  method.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true
                end
                methods.add_config! :get_user do |method|
                  method.add_field! :timeout,      nil, match: [Numeric],    allow_nil: true
                  method.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
                  method.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true
                end
                methods.add_config! :update_user do |method|
                  method.add_field! :timeout,      nil, match: [Numeric],    allow_nil: true
                  method.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
                  method.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true
                end
                methods.add_config! :delete_user do |method|
                  method.add_field! :timeout,      nil, match: [Numeric],    allow_nil: true
                  method.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
                  method.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true
                end
                methods.add_config! :list_users do |method|
                  method.add_field! :timeout,      nil, match: [Numeric],    allow_nil: true
                  method.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
                  method.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true
                end
              end
            end
            yield @configure if block_given?
            @configure
          end

          ##
          # Configure the Client client.
          #
          def configure
            yield @config if block_given?
            @config
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
          # @param config [Google::Gax::Configuration]
          #   The configuration object to use in place of the default configuration. It is
          #   preferable to configure the default configuration using the
          #   {Client.configure} method or by passing a block instead. Optional.
          #
          #   The configuration is set to the derived mode, meaning that values can be changed,
          #   but structural changes (adding new fields, etc.) are not allowed. Structural changes
          #   should be made on {Client.configure}.
          #
          # @yield [config] Configure the Client client.
          # @yieldparam config [Google::Gax::Configuration]
          #
          def initialize credentials: nil, config: nil
            # These require statements are intentionally placed here to initialize
            # the gRPC module only when it's required.
            # See https://github.com/googleapis/toolkit/issues/446
            require "google/gax/grpc"
            require "google/showcase/v1alpha3/identity_services_pb"

            # Create the configuration object
            config ||= Client.configure
            config = config.derive! unless config.derived?

            # Yield the configuration if needed
            yield config if block_given?

            @config = config

            # Create credentials
            credentials ||= Credentials.default scope: @config.scope
            if credentials.is_a?(String) || credentials.is_a?(Hash)
              credentials = Credentials.new credentials, scope: @config.scope
            end


            @identity_stub = Google::Gax::Grpc::Stub.new(
              Google::Showcase::V1alpha3::Identity::Stub,
              credentials:  credentials,
              host:         @config.host,
              port:         @config.port,
              interceptors: @config.interceptors
            )
          end

          # Service calls

          ##
          # Creates a user.
          #
          # @overload create_user(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::CreateUserRequest | Hash]
          #     Creates a user.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload create_user(user: nil, options: nil)
          #   @param user [Google::Showcase::V1alpha3::User | Hash]
          #     The user to create.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::User]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::User]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def create_user request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::CreateUserRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.methods.create_user.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            options.apply_defaults timeout:      @config.methods.create_user.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.methods.create_user.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @create_user ||= Google::Gax::ApiCall.new @identity_stub.method :create_user

            @create_user.call request, options: options, operation_callback: block
          end

          ##
          # Retrieves the User with the given uri.
          #
          # @overload get_user(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::GetUserRequest | Hash]
          #     Retrieves the User with the given uri.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload get_user(name: nil, options: nil)
          #   @param name [String]
          #     The resource name of the requested user.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::User]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::User]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def get_user request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::GetUserRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.methods.get_user.metadata.to_h

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

            options.apply_defaults timeout:      @config.methods.get_user.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.methods.get_user.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @get_user ||= Google::Gax::ApiCall.new @identity_stub.method :get_user

            @get_user.call request, options: options, operation_callback: block
          end

          ##
          # Updates a user.
          #
          # @overload update_user(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::UpdateUserRequest | Hash]
          #     Updates a user.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload update_user(user: nil, update_mask: nil, options: nil)
          #   @param user [Google::Showcase::V1alpha3::User | Hash]
          #     The user to update.
          #   @param update_mask [Google::Protobuf::FieldMask | Hash]
          #     The field mask to determine wich fields are to be updated. If empty, the
          #     server will assume all fields are to be updated.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::User]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::User]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def update_user request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::UpdateUserRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.methods.update_user.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            header_params = {
              "user.name" => request.user.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.methods.update_user.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.methods.update_user.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @update_user ||= Google::Gax::ApiCall.new @identity_stub.method :update_user

            @update_user.call request, options: options, operation_callback: block
          end

          ##
          # Deletes a user, their profile, and all of their authored messages.
          #
          # @overload delete_user(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::DeleteUserRequest | Hash]
          #     Deletes a user, their profile, and all of their authored messages.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload delete_user(name: nil, options: nil)
          #   @param name [String]
          #     The resource name of the user to delete.
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
          def delete_user request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::DeleteUserRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.methods.delete_user.metadata.to_h

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

            options.apply_defaults timeout:      @config.methods.delete_user.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.methods.delete_user.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @delete_user ||= Google::Gax::ApiCall.new @identity_stub.method :delete_user

            @delete_user.call request, options: options, operation_callback: block
          end

          ##
          # Lists all users.
          #
          # @overload list_users(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::ListUsersRequest | Hash]
          #     Lists all users.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload list_users(page_size: nil, page_token: nil, options: nil)
          #   @param page_size [Integer]
          #     The maximum number of users to return. Server may return fewer users
          #     than requested. If unspecified, server will pick an appropriate default.
          #   @param page_token [String]
          #     The value of google.showcase.v1alpha3.ListUsersResponse.next_page_token
          #     returned from the previous call to
          #     `google.showcase.v1alpha3.Identity\ListUsers` method.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Gax::PagedEnumerable<Google::Showcase::V1alpha3::User>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Gax::PagedEnumerable<Google::Showcase::V1alpha3::User>]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def list_users request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::ListUsersRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.methods.list_users.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            options.apply_defaults timeout:      @config.methods.list_users.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.methods.list_users.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @list_users ||= Google::Gax::ApiCall.new @identity_stub.method :list_users

            wrap_paged_enum = ->(response) { Google::Gax::PagedEnumerable.new @list_users, request, response, options }

            @list_users.call request, options: options, operation_callback: block, format_response: wrap_paged_enum
          end
        end
      end
    end
  end
end

# rubocop:disable Lint/HandleExceptions

# Once client is loaded, load helpers.rb if it exists.
begin
  require "google/showcase/v1alpha3/identity/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
