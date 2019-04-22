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

require "json"
require "pathname"

require "google/gax"
require "google/gax/operation"
require "google/longrunning/operations_client"

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
          # @param timeout [Numeric]
          #   The default timeout, in seconds, for calls made through this client.
          # @param metadata [Hash]
          #   Default metadata to be sent with each request. This can be overridden on a
          #   per call basis.
          #
          def initialize \
              credentials: nil,
              scopes: ALL_SCOPES,
              timeout: DEFAULT_TIMEOUT,
              metadata: nil,
              lib_name: nil,
              lib_version: ""
            # These require statements are intentionally placed here to initialize
            # the gRPC module only when it's required.
            # See https://github.com/googleapis/toolkit/issues/446
            require "google/gax/grpc"
            require "google/showcase/v1alpha3/identity_services_pb"

            credentials ||= Credentials.default scope: scopes

            @operations_client = OperationsClient.new(
              credentials: credentials,
              scopes:      scopes,
              timeout:     timeout,
              lib_name:    lib_name,
              lib_version: lib_version
            )
            @identity_stub = create_stub credentials, scopes

            @timeout = timeout
            @metadata = metadata.to_h
            @metadata["x-goog-api-client"] ||= x_goog_api_client_header lib_name, lib_version
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
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::CreateUserRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @metadata.dup
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.apply_defaults timeout: @timeout, metadata: metadata, retry_policy: retry_policy

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
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::GetUserRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata = @metadata.merge "x-goog-request-params" => request_params_header
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.apply_defaults timeout: @timeout, metadata: metadata, retry_policy: retry_policy

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
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::UpdateUserRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            header_params = {
              "user.name" => request.user.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata = @metadata.merge "x-goog-request-params" => request_params_header
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.apply_defaults timeout: @timeout, metadata: metadata, retry_policy: retry_policy

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
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::DeleteUserRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata = @metadata.merge "x-goog-request-params" => request_params_header
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.apply_defaults timeout: @timeout, metadata: metadata, retry_policy: retry_policy

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
          # @yieldparam response [Google::Showcase::V1alpha3::ListUsersResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::ListUsersResponse]
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
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::ListUsersRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @metadata.dup
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.apply_defaults timeout: @timeout, metadata: metadata, retry_policy: retry_policy

            @list_users ||= Google::Gax::ApiCall.new @identity_stub.method :list_users
            @list_users.call request, options: options, operation_callback: block
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
            stub_new = Google::Showcase::V1alpha3::Identity::Stub.method :new
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

          def x_goog_api_client_header lib_name, lib_version
            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{lib_name}/#{lib_version}" if lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            x_goog_api_client_header.join " "
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
