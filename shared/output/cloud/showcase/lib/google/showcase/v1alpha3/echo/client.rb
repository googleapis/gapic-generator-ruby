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
            require "google/showcase/v1alpha3/echo_services_pb"

            credentials ||= Credentials.default

            @operations_client = OperationsClient.new(
              credentials:   credentials,
              scopes:        scopes,
              client_config: client_config,
              timeout:       timeout,
              lib_name:      lib_name,
              lib_version:   lib_version
            )
            @echo_stub = create_stub credentials, scopes

            defaults = default_settings client_config, timeout, metadata, lib_name, lib_version

            @echo = Google::Gax.create_api_call(
              @echo_stub.method(:echo),
              defaults,
              exception_transformer: exception_transformer
            )
            @expand = Google::Gax.create_api_call(
              @echo_stub.method(:expand),
              defaults,
              exception_transformer: exception_transformer
            )
            @collect = Google::Gax.create_api_call(
              @echo_stub.method(:collect),
              defaults,
              exception_transformer: exception_transformer
            )
            @chat = Google::Gax.create_api_call(
              @echo_stub.method(:chat),
              defaults,
              exception_transformer: exception_transformer
            )
            @paged_expand = Google::Gax.create_api_call(
              @echo_stub.method(:paged_expand),
              defaults,
              exception_transformer: exception_transformer
            )
            @wait = Google::Gax.create_api_call(
              @echo_stub.method(:wait),
              defaults,
              exception_transformer: exception_transformer
            )
          end

          # Service calls

          ##
          # This method simply echos the request. This method is showcases unary rpcs.
          #
          # @overload echo(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::EchoRequest | Hash]
          #     This method simply echos the request. This method is showcases unary rpcs.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload echo(content: nil, error: nil, options: nil)
          #   @param content [String]
          #     The content to be echoed by the server.
          #   @param error [Google::Rpc::Status | Hash]
          #     The error to be thrown by the server.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::EchoResponse]
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

            @echo.call(request, options, &block)
          end

          ##
          # This method split the given content into words and will pass each word back
          # through the stream. This method showcases server-side streaming rpcs.
          #
          # @overload expand(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::ExpandRequest | Hash]
          #     This method split the given content into words and will pass each word back
          #     through the stream. This method showcases server-side streaming rpcs.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload expand(content: nil, error: nil, options: nil)
          #   @param content [String]
          #     The content that will be split into words and returned on the stream.
          #   @param error [Google::Rpc::Status | Hash]
          #     The error that is thrown after all words are sent on the stream.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @return [Enumerable<Google::Showcase::V1alpha3::EchoResponse>]
          #   An enumerable of {Google::Showcase::V1alpha3::EchoResponse} instances.
          #
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          #
          # @example
          #   TODO
          #
          def expand request = nil, options: nil, **request_fields
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::ExpandRequest

            @expand.call request, options
          end

          ##
          # This method will collect the words given to it. When the stream is closed
          # by the client, this method will return the a concatenation of the strings
          # passed to it. This method showcases client-side streaming rpcs.
          #
          # @param requests [Enumerable<Google::Showcase::V1alpha3::EchoRequest | Hash>]
          #   An enumerable of {Google::Showcase::V1alpha3::EchoRequest} instances.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::EchoResponse]
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
            raise ArgumentError, "requests must be an Enumerable" unless requests.is_a? Enumerable

            requests = requests.lazy.map do |request|
              Google::Gax.to_proto request, Google::Showcase::V1alpha3::EchoRequest
            end

            @collect.call(requests, options, &block)
          end

          ##
          # This method, upon receiving a request on the stream, the same content will
          # be passed  back on the stream. This method showcases bidirectional
          # streaming rpcs.
          #
          # @param requests [Enumerable<Google::Showcase::V1alpha3::EchoRequest | Hash>]
          #   An enumerable of {Google::Showcase::V1alpha3::EchoRequest} instances.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @return [Enumerable<Google::Showcase::V1alpha3::EchoResponse>]
          #   An enumerable of {Google::Showcase::V1alpha3::EchoResponse} instances.
          #
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          #
          # @example
          #   TODO
          #
          def chat requests, options: nil
            raise ArgumentError, "requests must be an Enumerable" unless requests.is_a? Enumerable

            requests = requests.lazy.map do |request|
              Google::Gax.to_proto request, Google::Showcase::V1alpha3::EchoRequest
            end

            @chat.call requests, options
          end

          ##
          # This is similar to the Expand method but instead of returning a stream of
          # expanded words, this method returns a paged list of expanded words.
          #
          # @overload paged_expand(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::PagedExpandRequest | Hash]
          #     This is similar to the Expand method but instead of returning a stream of
          #     expanded words, this method returns a paged list of expanded words.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload paged_expand(content: nil, page_size: nil, page_token: nil, options: nil)
          #   @param content [String]
          #     The string to expand.
          #   @param page_size [Integer]
          #     The amount of words to returned in each page.
          #   @param page_token [String]
          #     The position of the page to be returned.
          #   @param options [Google::Gax::CallOptions]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Showcase::V1alpha3::PagedExpandResponse]
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

            @paged_expand.call(request, options, &block)
          end

          ##
          # This method will wait the requested amount of and then return.
          # This method showcases how a client handles a request timing out.
          #
          # @overload wait(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::WaitRequest | Hash]
          #     This method will wait the requested amount of and then return.
          #     This method showcases how a client handles a request timing out.
          #   @param options [Google::Gax::CallOptions]
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
          def wait request = nil, options: nil, **request_fields
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::WaitRequest

            operation = Google::Gax::Operation.new(
              @wait.call(request, options),
              @operations_client,
              call_options: options
            )
            operation.on_done { |operation| yield operation } if block_given?
            operation
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
            stub_new = Google::Showcase::V1alpha3::Echo::Stub.method :new
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
  require "google/showcase/v1alpha3/echo/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
