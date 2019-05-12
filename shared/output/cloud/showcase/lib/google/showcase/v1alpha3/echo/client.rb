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
require "google/showcase/v1alpha3/echo_pb"
require "google/showcase/v1alpha3/echo/credentials"
require "google/showcase/v1alpha3/echo/operations"

module Google
  module Showcase
    module V1alpha3
      module Echo
        # Service that implements Echo API.
        class Client
          # @private
          attr_reader :echo_stub

          ##
          # Configuration for the Echo API.
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
                methods.add_config! :echo do |method|
                  method.add_field! :timeout,      nil, match: [Numeric],    allow_nil: true
                  method.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
                  method.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true
                end
                methods.add_config! :expand do |method|
                  method.add_field! :timeout,      nil, match: [Numeric],    allow_nil: true
                  method.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
                  method.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true
                end
                methods.add_config! :collect do |method|
                  method.add_field! :timeout,      nil, match: [Numeric],    allow_nil: true
                  method.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
                  method.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true
                end
                methods.add_config! :chat do |method|
                  method.add_field! :timeout,      nil, match: [Numeric],    allow_nil: true
                  method.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
                  method.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true
                end
                methods.add_config! :paged_expand do |method|
                  method.add_field! :timeout,      nil, match: [Numeric],    allow_nil: true
                  method.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
                  method.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true
                end
                methods.add_config! :wait do |method|
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
            require "google/showcase/v1alpha3/echo_services_pb"

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

            @operations_client = Operations.new(
              credentials: credentials
            )

            @echo_stub = Google::Gax::Grpc::Stub.new(
              Google::Showcase::V1alpha3::Echo::Stub,
              credentials:  credentials,
              host:         @config.host,
              port:         @config.port,
              interceptors: @config.interceptors
            )
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
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::EchoRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.methods.echo.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            options.apply_defaults timeout:      @config.methods.echo.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.methods.echo.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

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
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::ExpandRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.methods.expand.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            options.apply_defaults timeout:      @config.methods.expand.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.methods.expand.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

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
              Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::EchoRequest
            end

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.methods.collect.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            options.apply_defaults timeout:      @config.methods.collect.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.methods.collect.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

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
              Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::EchoRequest
            end

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.methods.chat.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            options.apply_defaults timeout:      @config.methods.chat.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.methods.chat.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

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
          # @yieldparam response [Google::Gax::PagedEnumerable<Google::Showcase::V1alpha3::EchoResponse>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Gax::PagedEnumerable<Google::Showcase::V1alpha3::EchoResponse>]
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
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::PagedExpandRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.methods.paged_expand.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            options.apply_defaults timeout:      @config.methods.paged_expand.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.methods.paged_expand.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @paged_expand ||= Google::Gax::ApiCall.new @echo_stub.method :paged_expand

            wrap_paged_enum = ->(response) { Google::Gax::PagedEnumerable.new @paged_expand, request, response, options }

            @paged_expand.call request, options: options, operation_callback: block, format_response: wrap_paged_enum
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
            request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::WaitRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.methods.wait.metadata.to_h

            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

            options.apply_defaults timeout:      @config.methods.wait.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.methods.wait.retry_policy
            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @wait ||= Google::Gax::ApiCall.new @echo_stub.method :wait

            wrap_gax_operation = ->(response) { Google::Gax::Operation.new response, @operations_client }

            @wait.call request, options: options, operation_callback: block, format_response: wrap_gax_operation
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
