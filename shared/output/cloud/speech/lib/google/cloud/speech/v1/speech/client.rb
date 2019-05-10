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

require "google/cloud/speech/version"
require "google/cloud/speech/v1/cloud_speech_pb"
require "google/cloud/speech/v1/speech/configure"
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
            # @yield [config] Configure the Client client.
            # @yieldparam config [Google::Gax::Configuration]
            #
            def initialize credentials: nil, config: nil
              # These require statements are intentionally placed here to initialize
              # the gRPC module only when it's required.
              # See https://github.com/googleapis/toolkit/issues/446
              require "google/gax/grpc"
              require "google/cloud/speech/v1/cloud_speech_services_pb"

              # Create the configuration object
              config ||= Configure.wrap Google::Cloud::Speech::V1::Speech.configure

              # Yield the configuration if needed
              yield config if block_given?

              @config = config

              # Update the configuration with x-goog-api-client header
              # Paradox: do we generate the header before yielding without the lib_name?
              # Or, do we generate it after yielding, when the lib_name is most likely to be set?
              x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
              x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
              x_goog_api_client_header << "gapic/#{Google::Cloud::Speech::VERSION}"
              x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
              x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
              @config.metadata ||= {}
              @config.metadata["x-goog-api-client"] ||= x_goog_api_client_header.join " "

              # Create credentials
              credentials ||= Credentials.default scope: @config.scope
              if credentials.is_a?(String) || credentials.is_a?(Hash)
                credentials = Credentials.new credentials, scope: @config.scope
              end

              @operations_client = Operations.new(
                credentials: credentials,
                config:      @config
              )

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
              metadata = @config.metadata.dup
              # TODO: Grab retry_policy from @config
              # TODO: Allow for Proc in @config's retry_policy
              options.apply_defaults timeout: @config.timeout, metadata: metadata

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
              metadata = @config.metadata.dup
              # TODO: Grab retry_policy from @config
              # TODO: Allow for Proc in @config's retry_policy
              options.apply_defaults timeout: @config.timeout, metadata: metadata

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
              metadata = @config.metadata.dup
              # TODO: Grab retry_policy from @config
              # TODO: Allow for Proc in @config's retry_policy
              options.apply_defaults timeout: @config.timeout, metadata: metadata

              @streaming_recognize ||= Google::Gax::ApiCall.new @speech_stub.method :streaming_recognize
              @streaming_recognize.call requests, options: options, stream_callback: block
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
