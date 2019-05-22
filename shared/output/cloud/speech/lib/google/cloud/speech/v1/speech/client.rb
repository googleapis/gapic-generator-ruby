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
require "google/gax/config"
require "google/gax/config/method"

require "google/cloud/speech/version"
require "google/cloud/speech/v1/cloud_speech_pb"
require "google/cloud/speech/v1/speech/credentials"
require "google/cloud/speech/v1/speech/operations"

module Google
  module Cloud
    module Speech
      module V1
        module Speech
          # Service that implements Speech API.
          class Client
            # @private
            attr_reader :speech_stub

            ##
            # Configuration for the Speech Client API.
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
            # Configure the Speech Client instance.
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
              require "google/cloud/speech/v1/cloud_speech_services_pb"

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

              @speech_stub = Google::Gax::Grpc::Stub.new(
                Google::Cloud::Speech::V1::Speech::Stub,
                credentials:  credentials,
                host:         @config.host,
                port:         @config.port,
                interceptors: @config.interceptors
              )
            end

            # Service calls

            ##
            # Performs synchronous speech recognition: receive results after all audio
            # has been sent and processed.
            #
            # @overload recognize(request, options: nil)
            #   @param request [Google::Cloud::Speech::V1::RecognizeRequest | Hash]
            #     Performs synchronous speech recognition: receive results after all audio
            #     has been sent and processed.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload recognize(config: nil, audio: nil, options: nil)
            #   @param config [Google::Cloud::Speech::V1::RecognitionConfig | Hash]
            #     *Required* Provides information to the recognizer that specifies how to
            #     process the request.
            #   @param audio [Google::Cloud::Speech::V1::RecognitionAudio | Hash]
            #     *Required* The audio data to be recognized.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Speech::V1::RecognizeResponse]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Speech::V1::RecognizeResponse]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def recognize request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Speech::V1::RecognizeRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.recognize.metadata.to_h

              x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
              x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
              x_goog_api_client_header << "gapic/#{Google::Cloud::Speech::VERSION}"
              x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
              x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
              metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

              options.apply_defaults timeout:      @config.rpcs.recognize.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.recognize.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @recognize ||= Google::Gax::ApiCall.new @speech_stub.method :recognize

              @recognize.call request, options: options, operation_callback: block
            end

            ##
            # Performs asynchronous speech recognition: receive results via the
            # google.longrunning.Operations interface. Returns either an
            # `Operation.error` or an `Operation.response` which contains
            # a `LongRunningRecognizeResponse` message.
            #
            # @overload long_running_recognize(request, options: nil)
            #   @param request [Google::Cloud::Speech::V1::LongRunningRecognizeRequest | Hash]
            #     Performs asynchronous speech recognition: receive results via the
            #     google.longrunning.Operations interface. Returns either an
            #     `Operation.error` or an `Operation.response` which contains
            #     a `LongRunningRecognizeResponse` message.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload long_running_recognize(config: nil, audio: nil, options: nil)
            #   @param config [Google::Cloud::Speech::V1::RecognitionConfig | Hash]
            #     *Required* Provides information to the recognizer that specifies how to
            #     process the request.
            #   @param audio [Google::Cloud::Speech::V1::RecognitionAudio | Hash]
            #     *Required* The audio data to be recognized.
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
            def long_running_recognize request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Speech::V1::LongRunningRecognizeRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.long_running_recognize.metadata.to_h

              x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
              x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
              x_goog_api_client_header << "gapic/#{Google::Cloud::Speech::VERSION}"
              x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
              x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
              metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

              options.apply_defaults timeout:      @config.rpcs.long_running_recognize.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.long_running_recognize.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @long_running_recognize ||= Google::Gax::ApiCall.new @speech_stub.method :long_running_recognize

              wrap_gax_operation = ->(response) { Google::Gax::Operation.new response, @operations_client }

              @long_running_recognize.call request, options: options, operation_callback: block, format_response: wrap_gax_operation
            end

            ##
            # Performs bidirectional streaming speech recognition: receive results while
            # sending audio. This method is only available via the gRPC API (not REST).
            #
            # @param requests [Google::Gax::StreamInput, Enumerable<Google::Cloud::Speech::V1::StreamingRecognizeRequest | Hash>]
            #   An enumerable of {Google::Cloud::Speech::V1::StreamingRecognizeRequest} instances.
            # @param options [Google::Gax::ApiCall::Options, Hash]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response] Called on each streaming responses, when provided.
            # @yieldparam response [Google::Cloud::Speech::V1::StreamingRecognizeResponse]
            #
            # @return [Enumerable<Google::Cloud::Speech::V1::StreamingRecognizeResponse, Thread>]
            #   An enumerable of {Google::Cloud::Speech::V1::StreamingRecognizeResponse} instances when a block is not provided.
            #   When a block is provided a thread running the block for every streamed response is returned.
            #
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def streaming_recognize requests, options: nil, &block
              unless requests.is_a? Enumerable
                if requests.respond_to? :to_enum
                  requests = requests.to_enum
                else
                  raise ArgumentError, "requests must be an Enumerable"
                end
              end

              requests = requests.lazy.map do |request|
                Google::Gax::Protobuf.coerce request, to: Google::Cloud::Speech::V1::StreamingRecognizeRequest
              end

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.streaming_recognize.metadata.to_h

              x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
              x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
              x_goog_api_client_header << "gapic/#{Google::Cloud::Speech::VERSION}"
              x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
              x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
              metadata[:"x-goog-api-client"] ||= x_goog_api_client_header.join " "

              options.apply_defaults timeout:      @config.rpcs.streaming_recognize.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.streaming_recognize.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @streaming_recognize ||= Google::Gax::ApiCall.new @speech_stub.method :streaming_recognize
              @streaming_recognize.call requests, options: options, stream_callback: block
            end

            class Configuration
              extend Google::Gax::Config

              config_attr :host,         "speech.googleapis.com", String
              config_attr :port,         443, Integer
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
                attr_reader :recognize
                attr_reader :long_running_recognize
                attr_reader :streaming_recognize

                def initialize parent_rpcs = nil
                  recognize_config = nil
                  recognize_config = parent_rpcs&.recognize if parent_rpcs&.respond_to? :recognize
                  @recognize = Google::Gax::Config::Method.new recognize_config
                  long_running_recognize_config = nil
                  long_running_recognize_config = parent_rpcs&.long_running_recognize if parent_rpcs&.respond_to? :long_running_recognize
                  @long_running_recognize = Google::Gax::Config::Method.new long_running_recognize_config
                  streaming_recognize_config = nil
                  streaming_recognize_config = parent_rpcs&.streaming_recognize if parent_rpcs&.respond_to? :streaming_recognize
                  @streaming_recognize = Google::Gax::Config::Method.new streaming_recognize_config

                  yield self if block_given?
                end
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
  require "google/cloud/speech/v1/speech/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
