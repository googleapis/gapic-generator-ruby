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
require "google/showcase/v1alpha3/echo_pb"
require "google/showcase/v1alpha3/echo/credentials"

module Google
  module Showcase
    module V1alpha3
      module Echo
        # Service that implements Echo API.
        class Client
          # @private
          attr_reader :echo_stub

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
          # @param scope [String, Array<String>]
          #   The OAuth scope (or scopes) for this service. This parameter is ignored if
          #   an updater_proc is supplied.
          # @param timeout [Numeric]
          #   The default timeout, in seconds, for calls made through this client.
          # @param metadata [Hash]
          #   Default metadata to be sent with each request. This can be overridden on a
          #   per call basis.
          #
          def initialize \
              credentials: nil,
              scope: ALL_SCOPES,
              timeout: DEFAULT_TIMEOUT,
              metadata: nil,
              lib_name: nil,
              lib_version: ""
            # These require statements are intentionally placed here to initialize
            # the gRPC module only when it's required.
            # See https://github.com/googleapis/toolkit/issues/446
            require "google/gax/grpc"
            require "google/showcase/v1alpha3/echo_services_pb"

            credentials ||= Credentials.default scope: scope
            if credentials.is_a?(String) || credentials.is_a?(Hash)
              credentials = Credentials.new credentials, scope: scope
            end

            @operations_client = OperationsClient.new(
              credentials: credentials,
              scope:       scope,
              timeout:     timeout,
              lib_name:    lib_name,
              lib_version: lib_version
            )
            @echo_stub = Google::Gax::Grpc::Stub.new(
              Google::Showcase::V1alpha3::Echo::Stub,
              host:         self.class::SERVICE_ADDRESS,
              port:         self.class::DEFAULT_SERVICE_PORT,
              credentials:  credentials,
              interceptors: self.class::GRPC_INTERCEPTORS
            )

            @timeout = timeout
            @metadata = metadata.to_h
            @metadata["x-goog-api-client"] ||= x_goog_api_client_header lib_name, lib_version
          end

          # Service calls

          ##
          # This method simply echos the request. This method is showcases unary rpcs.
          #
          # @overload echo(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::EchoRequest | Hash]
          #     This method simply echos the request. This method is showcases unary rpcs.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload echo(content: nil, error: nil, options: nil)
          #   @param content [String]
          #     The content to be echoed by the server.
          #   @param error [Google::Rpc::Status | Hash]
          #     The error to be thrown by the server.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::EchoResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::EchoResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def echo request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::EchoRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @metadata.dup
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.apply_defaults timeout: @timeout, metadata: metadata, retry_policy: retry_policy

            @echo ||= Google::Gax::ApiCall.new @echo_stub.method :echo
            @echo.call request, options: options, operation_callback: block
          end

          ##
          # This method split the given content into words and will pass each word back
          # through the stream. This method showcases server-side streaming rpcs.
          #
          # @overload expand(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::ExpandRequest | Hash]
          #     This method split the given content into words and will pass each word back
          #     through the stream. This method showcases server-side streaming rpcs.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload expand(content: nil, error: nil, options: nil)
          #   @param content [String]
          #     The content that will be split into words and returned on the stream.
          #   @param error [Google::Rpc::Status | Hash]
          #     The error that is thrown after all words are sent on the stream.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response] Called on each streaming responses, when provided.
          # @yieldparam response [Google::Showcase::V1alpha3::EchoResponse]
          #
          # @return [Enumerable<Google::Showcase::V1alpha3::EchoResponse, Thread>]
          #   An enumerable of {Google::Showcase::V1alpha3::EchoResponse} instances when a block is not provided.
          #   When a block is provided a thread running the block for every streamed response is returned.
          #
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          #
          # @example
          #   TODO
          #
          def expand request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::ExpandRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @metadata.dup
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.apply_defaults timeout: @timeout, metadata: metadata, retry_policy: retry_policy

            @expand ||= Google::Gax::ApiCall.new @echo_stub.method :expand
            @expand.call request, options: options, stream_callback: block
          end

          ##
          # This method will collect the words given to it. When the stream is closed
          # by the client, this method will return the a concatenation of the strings
          # passed to it. This method showcases client-side streaming rpcs.
          #
          # @param requests [Google::Gax::StreamInput, Enumerable<Google::Showcase::V1alpha3::EchoRequest | Hash>]
          #   An enumerable of {Google::Showcase::V1alpha3::EchoRequest} instances.
          # @param options [Google::Gax::ApiCall::Options, Hash]
          #   Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::EchoResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::EchoResponse]
          #
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          #
          # @example
          #   TODO
          #
          def collect requests, options: nil, &block
            unless requests.is_a? Enumerable
              if requests.respond_to? :to_enum
                requests = requests.to_enum
              else
                raise ArgumentError, "requests must be an Enumerable"
              end
            end

            requests = requests.lazy.map do |request|
              Google::Gax.to_proto request, Google::Showcase::V1alpha3::EchoRequest
            end

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @metadata.dup
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.apply_defaults timeout: @timeout, metadata: metadata, retry_policy: retry_policy

            @collect ||= Google::Gax::ApiCall.new @echo_stub.method :collect
            @collect.call requests, options: options, operation_callback: block
          end

          ##
          # This method, upon receiving a request on the stream, the same content will
          # be passed  back on the stream. This method showcases bidirectional
          # streaming rpcs.
          #
          # @param requests [Google::Gax::StreamInput, Enumerable<Google::Showcase::V1alpha3::EchoRequest | Hash>]
          #   An enumerable of {Google::Showcase::V1alpha3::EchoRequest} instances.
          # @param options [Google::Gax::ApiCall::Options, Hash]
          #   Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response] Called on each streaming responses, when provided.
          # @yieldparam response [Google::Showcase::V1alpha3::EchoResponse]
          #
          # @return [Enumerable<Google::Showcase::V1alpha3::EchoResponse, Thread>]
          #   An enumerable of {Google::Showcase::V1alpha3::EchoResponse} instances when a block is not provided.
          #   When a block is provided a thread running the block for every streamed response is returned.
          #
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          #
          # @example
          #   TODO
          #
          def chat requests, options: nil, &block
            unless requests.is_a? Enumerable
              if requests.respond_to? :to_enum
                requests = requests.to_enum
              else
                raise ArgumentError, "requests must be an Enumerable"
              end
            end

            requests = requests.lazy.map do |request|
              Google::Gax.to_proto request, Google::Showcase::V1alpha3::EchoRequest
            end

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @metadata.dup
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.apply_defaults timeout: @timeout, metadata: metadata, retry_policy: retry_policy

            @chat ||= Google::Gax::ApiCall.new @echo_stub.method :chat
            @chat.call requests, options: options, stream_callback: block
          end

          ##
          # This is similar to the Expand method but instead of returning a stream of
          # expanded words, this method returns a paged list of expanded words.
          #
          # @overload paged_expand(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::PagedExpandRequest | Hash]
          #     This is similar to the Expand method but instead of returning a stream of
          #     expanded words, this method returns a paged list of expanded words.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload paged_expand(content: nil, page_size: nil, page_token: nil, options: nil)
          #   @param content [String]
          #     The string to expand.
          #   @param page_size [Integer]
          #     The amount of words to returned in each page.
          #   @param page_token [String]
          #     The position of the page to be returned.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::PagedExpandResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::PagedExpandResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def paged_expand request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::PagedExpandRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @metadata.dup
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.apply_defaults timeout: @timeout, metadata: metadata, retry_policy: retry_policy

            @paged_expand ||= Google::Gax::ApiCall.new @echo_stub.method :paged_expand
            @paged_expand.call request, options: options, operation_callback: block
          end

          ##
          # This method will wait the requested amount of and then return.
          # This method showcases how a client handles a request timing out.
          #
          # @overload wait(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::WaitRequest | Hash]
          #     This method will wait the requested amount of and then return.
          #     This method showcases how a client handles a request timing out.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload wait(end_time: nil, ttl: nil, error: nil, success: nil, options: nil)
          #   @param end_time [Google::Protobuf::Timestamp | Hash]
          #     The time that this operation will complete.
          #   @param ttl [Google::Protobuf::Duration | Hash]
          #     The duration of this operation.
          #   @param error [Google::Rpc::Status | Hash]
          #     The error that will be returned by the server. If this code is specified
          #     to be the OK rpc code, an empty response will be returned.
          #   @param success [Google::Showcase::V1alpha3::WaitResponse | Hash]
          #     The response to be returned on operation completion.
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
          def wait request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::WaitRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @metadata.dup
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.apply_defaults timeout: @timeout, metadata: metadata, retry_policy: retry_policy

            format_response = ->(response) { Google::Gax::Operation.new response, @operations_client, options }

            @wait ||= Google::Gax::ApiCall.new @echo_stub.method :wait
            @wait.call request, options: options, operation_callback: block, format_response: format_response
          end

          protected

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
  require "google/showcase/v1alpha3/echo/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
