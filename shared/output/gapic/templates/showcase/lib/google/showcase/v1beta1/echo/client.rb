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
require "google/showcase/v1beta1/echo_pb"
require "google/showcase/v1beta1/echo/credentials"
require "google/showcase/v1beta1/echo/operations"

module Google
  module Showcase
    module V1beta1
      module Echo
        # Service that implements Echo API.
        class Client
          # @private
          attr_reader :echo_stub

          ##
          # Configuration for the Echo Client API.
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
          # Configure the Echo Client instance.
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
            require "google/showcase/v1beta1/echo_services_pb"

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

            @echo_stub = Gapic::ServiceStub.new(
              Google::Showcase::V1beta1::Echo::Stub,
              credentials:  credentials,
              endpoint:     @config.endpoint,
              channel_args: @config.channel_args,
              interceptors: @config.interceptors
            )
          end

          # Service calls

          ##
          # This method simply echos the request. This method is showcases unary rpcs.
          #
          # @overload echo(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::EchoRequest | Hash]
          #     This method simply echos the request. This method is showcases unary rpcs.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload echo(content: nil, error: nil)
          #   @param content [String]
          #     The content to be echoed by the server.
          #   @param error [Google::Rpc::Status | Hash]
          #     The error to be thrown by the server.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::EchoResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::EchoResponse]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def echo request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::EchoRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.echo.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            options.apply_defaults timeout:      @config.rpcs.echo.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.echo.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @echo_stub.call_rpc :echo, request, options: options, operation_callback: block
          end

          ##
          # This method split the given content into words and will pass each word back
          # through the stream. This method showcases server-side streaming rpcs.
          #
          # @overload expand(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::ExpandRequest | Hash]
          #     This method split the given content into words and will pass each word back
          #     through the stream. This method showcases server-side streaming rpcs.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload expand(content: nil, error: nil)
          #   @param content [String]
          #     The content that will be split into words and returned on the stream.
          #   @param error [Google::Rpc::Status | Hash]
          #     The error that is thrown after all words are sent on the stream.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Enumerable<Google::Showcase::V1beta1::EchoResponse>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Enumerable<Google::Showcase::V1beta1::EchoResponse>]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def expand request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::ExpandRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.expand.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            options.apply_defaults timeout:      @config.rpcs.expand.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.expand.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @echo_stub.call_rpc :expand, request, options: options, operation_callback: block
          end

          ##
          # This method will collect the words given to it. When the stream is closed
          # by the client, this method will return the a concatenation of the strings
          # passed to it. This method showcases client-side streaming rpcs.
          #
          # @param request [Gapic::StreamInput, Enumerable<Google::Showcase::V1beta1::EchoRequest | Hash>]
          #   An enumerable of {Google::Showcase::V1beta1::EchoRequest} instances.
          # @param options [Gapic::CallOptions, Hash]
          #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::EchoResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::EchoResponse]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def collect request, options = nil, &block
            unless request.is_a? Enumerable
              if request.respond_to? :to_enum
                request = request.to_enum
              else
                raise ArgumentError, "request must be an Enumerable"
              end
            end

            request = request.lazy.map do |req|
              Gapic::Protobuf.coerce req, to: Google::Showcase::V1beta1::EchoRequest
            end

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.collect.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            options.apply_defaults timeout:      @config.rpcs.collect.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.collect.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @echo_stub.call_rpc :collect, request, options: options, operation_callback: block
          end

          ##
          # This method, upon receiving a request on the stream, the same content will
          # be passed  back on the stream. This method showcases bidirectional
          # streaming rpcs.
          #
          # @param request [Gapic::StreamInput, Enumerable<Google::Showcase::V1beta1::EchoRequest | Hash>]
          #   An enumerable of {Google::Showcase::V1beta1::EchoRequest} instances.
          # @param options [Gapic::CallOptions, Hash]
          #   Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Enumerable<Google::Showcase::V1beta1::EchoResponse>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Enumerable<Google::Showcase::V1beta1::EchoResponse>]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def chat request, options = nil, &block
            unless request.is_a? Enumerable
              if request.respond_to? :to_enum
                request = request.to_enum
              else
                raise ArgumentError, "request must be an Enumerable"
              end
            end

            request = request.lazy.map do |req|
              Gapic::Protobuf.coerce req, to: Google::Showcase::V1beta1::EchoRequest
            end

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.chat.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            options.apply_defaults timeout:      @config.rpcs.chat.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.chat.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @echo_stub.call_rpc :chat, request, options: options, operation_callback: block
          end

          ##
          # This is similar to the Expand method but instead of returning a stream of
          # expanded words, this method returns a paged list of expanded words.
          #
          # @overload paged_expand(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::PagedExpandRequest | Hash]
          #     This is similar to the Expand method but instead of returning a stream of
          #     expanded words, this method returns a paged list of expanded words.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload paged_expand(content: nil, page_size: nil, page_token: nil)
          #   @param content [String]
          #     The string to expand.
          #   @param page_size [Integer]
          #     The amount of words to returned in each page.
          #   @param page_token [String]
          #     The position of the page to be returned.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Gapic::PagedEnumerable<Google::Showcase::V1beta1::EchoResponse>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Gapic::PagedEnumerable<Google::Showcase::V1beta1::EchoResponse>]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def paged_expand request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::PagedExpandRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.paged_expand.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            options.apply_defaults timeout:      @config.rpcs.paged_expand.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.paged_expand.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            paged_response = nil
            paged_operation_callback = lambda do |response, operation|
              paged_response = Gapic::PagedEnumerable.new @echo_stub, :paged_expand, request, response, operation, options
              yield paged_response, operation if block
            end
            @echo_stub.call_rpc :paged_expand, request, options: options, operation_callback: paged_operation_callback
            paged_response
          end

          ##
          # This method will wait the requested amount of and then return.
          # This method showcases how a client handles a request timing out.
          #
          # @overload wait(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::WaitRequest | Hash]
          #     This method will wait the requested amount of and then return.
          #     This method showcases how a client handles a request timing out.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload wait(end_time: nil, ttl: nil, error: nil, success: nil)
          #   @param end_time [Google::Protobuf::Timestamp | Hash]
          #     The time that this operation will complete.
          #   @param ttl [Google::Protobuf::Duration | Hash]
          #     The duration of this operation.
          #   @param error [Google::Rpc::Status | Hash]
          #     The error that will be returned by the server. If this code is specified
          #     to be the OK rpc code, an empty response will be returned.
          #   @param success [Google::Showcase::V1beta1::WaitResponse | Hash]
          #     The response to be returned on operation completion.
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
          def wait request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::WaitRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.wait.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            options.apply_defaults timeout:      @config.rpcs.wait.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.wait.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            wrap_gax_operation = ->(response) { Gapic::Operation.new response, @operations_client }
            @echo_stub.call_rpc :wait, request, options: options, operation_callback: block, format_response: wrap_gax_operation
          end

          ##
          # This method will block (wait) for the requested amount of time
          # and then return the response or error.
          # This method showcases how a client handles delays or retries.
          #
          # @overload block(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::BlockRequest | Hash]
          #     This method will block (wait) for the requested amount of time
          #     and then return the response or error.
          #     This method showcases how a client handles delays or retries.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload block(response_delay: nil, error: nil, success: nil)
          #   @param response_delay [Google::Protobuf::Duration | Hash]
          #     The amount of time to block before returning a response.
          #   @param error [Google::Rpc::Status | Hash]
          #     The error that will be returned by the server. If this code is specified
          #     to be the OK rpc code, an empty response will be returned.
          #   @param success [Google::Showcase::V1beta1::BlockResponse | Hash]
          #     The response to be returned that will signify successful method call.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::BlockResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::BlockResponse]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def block request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::BlockRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.block.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            options.apply_defaults timeout:      @config.rpcs.block.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.block.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @echo_stub.call_rpc :block, request, options: options, operation_callback: block
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
              attr_reader :echo
              attr_reader :expand
              attr_reader :collect
              attr_reader :chat
              attr_reader :paged_expand
              attr_reader :wait
              attr_reader :block

              def initialize parent_rpcs = nil
                echo_config = nil
                echo_config = parent_rpcs&.echo if parent_rpcs&.respond_to? :echo
                @echo = Gapic::Config::Method.new echo_config
                expand_config = nil
                expand_config = parent_rpcs&.expand if parent_rpcs&.respond_to? :expand
                @expand = Gapic::Config::Method.new expand_config
                collect_config = nil
                collect_config = parent_rpcs&.collect if parent_rpcs&.respond_to? :collect
                @collect = Gapic::Config::Method.new collect_config
                chat_config = nil
                chat_config = parent_rpcs&.chat if parent_rpcs&.respond_to? :chat
                @chat = Gapic::Config::Method.new chat_config
                paged_expand_config = nil
                paged_expand_config = parent_rpcs&.paged_expand if parent_rpcs&.respond_to? :paged_expand
                @paged_expand = Gapic::Config::Method.new paged_expand_config
                wait_config = nil
                wait_config = parent_rpcs&.wait if parent_rpcs&.respond_to? :wait
                @wait = Gapic::Config::Method.new wait_config
                block_config = nil
                block_config = parent_rpcs&.block if parent_rpcs&.respond_to? :block
                @block = Gapic::Config::Method.new block_config

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
  require "google/showcase/v1beta1/echo/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
