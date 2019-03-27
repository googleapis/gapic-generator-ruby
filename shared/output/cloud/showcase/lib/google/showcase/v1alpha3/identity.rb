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
require "google/showcase/v1alpha3/identity_pb"
require "google/showcase/v1alpha3/identity/credentials"

module Google
  module Showcase
    module V1alpha3
      module Identity
        # Service that implements Identity API.
        class Client
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
            require "google/showcase/v1alpha3/identity_services_pb"

            credentials ||= Credentials.default

            @operations_client = OperationsClient.new(
              credentials:   credentials,
              scopes:        scopes,
              client_config: client_config,
              timeout:       timeout,
              lib_name:      lib_name,
              lib_version:   lib_version
            )
            @identity_stub = create_stub credentials, scopes

            defaults = default_settings client_config, timeout, metadata, lib_name, lib_version

            @create_user = Google::Gax.create_api_call(
              @identity_stub.method(:create_user),
              defaults,
              exception_transformer: exception_transformer
            )
            @get_user = Google::Gax.create_api_call(
              @identity_stub.method(:get_user),
              defaults,
              exception_transformer: exception_transformer
            )
            @update_user = Google::Gax.create_api_call(
              @identity_stub.method(:update_user),
              defaults,
              exception_transformer: exception_transformer
            )
            @delete_user = Google::Gax.create_api_call(
              @identity_stub.method(:delete_user),
              defaults,
              exception_transformer: exception_transformer
            )
            @list_users = Google::Gax.create_api_call(
              @identity_stub.method(:list_users),
              defaults,
              exception_transformer: exception_transformer
            )
          end

          # Service calls

          ##
          # Creates a user.
          #
          # @overload create_user(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::CreateUserRequest | Hash]
          #     Creates a user.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload create_user(user: nil, options: nil)
          #   @param user [Google::Showcase::V1alpha3::User | Hash]
          #     The user to create.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::User]
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

            @create_user.call(request, options, &block)
          end

          ##
          # Retrieves the User with the given uri.
          #
          # @overload get_user(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::GetUserRequest | Hash]
          #     Retrieves the User with the given uri.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload get_user(name: nil, options: nil)
          #   @param name [String]
          #     The resource name of the requested user.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::User]
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

            @get_user.call(request, options, &block)
          end

          ##
          # Updates a user.
          #
          # @overload update_user(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::UpdateUserRequest | Hash]
          #     Updates a user.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload update_user(user: nil, update_mask: nil, options: nil)
          #   @param user [Google::Showcase::V1alpha3::User | Hash]
          #     The user to update.
          #   @param update_mask [Google::Protobuf::FieldMask | Hash]
          #     The field mask to determine wich fields are to be updated. If empty, the
          #      server will assume all fields are to be updated.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::User]
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

            @update_user.call(request, options, &block)
          end

          ##
          # Deletes a user, their profile, and all of their authored messages.
          #
          # @overload delete_user(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::DeleteUserRequest | Hash]
          #     Deletes a user, their profile, and all of their authored messages.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload delete_user(name: nil, options: nil)
          #   @param name [String]
          #     The resource name of the user to delete.
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
          def delete_user request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::DeleteUserRequest

            @delete_user.call(request, options, &block)
          end

          ##
          # Lists all users.
          #
          # @overload list_users(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::ListUsersRequest | Hash]
          #     Lists all users.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload list_users(page_size: nil, page_token: nil, options: nil)
          #   @param page_size [Integer]
          #     The maximum number of users to return. Server may return fewer users
          #      than requested. If unspecified, server will pick an appropriate default.
          #   @param page_token [String]
          #     The value of google.showcase.v1alpha3.ListUsersResponse.next_page_token
          #      returned from the previous call to
          #      `google.showcase.v1alpha3.Identity\ListUsers` method.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::ListUsersResponse]
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

            @list_users.call(request, options, &block)
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
        def self.new *args
          Client.new *args
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
