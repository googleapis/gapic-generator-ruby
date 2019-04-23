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

require "google/cloud/speech/version"
require "google/cloud/speech/v1/cloud_speech_pb"
require "google/cloud/speech/v1/speech/credentials"

module Google
  module Cloud
    module Speech
      module V1
        module Speech
          # Service that implements Speech API.
          class Client
            # @private
            attr_reader :speech_stub

            # The default address of the service.
            SERVICE_ADDRESS = "speech.googleapis.com"

            # The default port of the service.
            DEFAULT_SERVICE_PORT = 443

            # rubocop:disable Style/MutableConstant

            # The default set of gRPC interceptors.
            GRPC_INTERCEPTORS = []

            # rubocop:enable Style/MutableConstant

            DEFAULT_TIMEOUT = 30

            # The scopes needed to make gRPC calls to all of the methods defined
            # in this service.
            ALL_SCOPES = ["https://www.googleapis.com/auth/cloud-platform"].freeze

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
              require "google/cloud/speech/v1/cloud_speech_services_pb"

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
              @speech_stub = Google::Gax::Grpc::Stub.new(
                Google::Cloud::Speech::V1::Speech::Stub,
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
              request = Google::Gax.to_proto request, Google::Cloud::Speech::V1::RecognizeRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @metadata.dup
              retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
              options.apply_defaults timeout: @timeout, metadata: metadata, retry_policy: retry_policy

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
              request = Google::Gax.to_proto request, Google::Cloud::Speech::V1::LongRunningRecognizeRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @metadata.dup
              retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
              options.apply_defaults timeout: @timeout, metadata: metadata, retry_policy: retry_policy

              format_response = ->(response) { Google::Gax::Operation.new response, @operations_client, options }

              @long_running_recognize ||= Google::Gax::ApiCall.new @speech_stub.method :long_running_recognize
              @long_running_recognize.call request, options: options, operation_callback: block, format_response: format_response
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
                Google::Gax.to_proto request, Google::Cloud::Speech::V1::StreamingRecognizeRequest
              end

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @metadata.dup
              retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
              options.apply_defaults timeout: @timeout, metadata: metadata, retry_policy: retry_policy

              @streaming_recognize ||= Google::Gax::ApiCall.new @speech_stub.method :streaming_recognize
              @streaming_recognize.call requests, options: options, stream_callback: block
            end

            protected

            def x_goog_api_client_header lib_name, lib_version
              x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
              x_goog_api_client_header << "#{lib_name}/#{lib_version}" if lib_name
              x_goog_api_client_header << "gapic/#{Google::Cloud::Speech::VERSION}"
              x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
              x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
              x_goog_api_client_header.join " "
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
