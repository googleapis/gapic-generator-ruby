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

require "googleauth"
require "google/gax"
require "google/gax/operation"
require "google/longrunning/operations_client"

require "google/cloud/speech/v1/cloud_speech_pb"

module Google
  module Cloud
    module Speech
      module V1
        module Speech
          class Credentials < Google::Auth::Credentials
            SCOPE = [
              "https://www.googleapis.com/auth/cloud-platform"
            ].freeze
            PATH_ENV_VARS = %w[SPEECH_CREDENTIALS
                               SPEECH_KEYFILE
                               GOOGLE_CLOUD_CREDENTIALS
                               GOOGLE_CLOUD_KEYFILE
                               GCLOUD_KEYFILE].freeze
            JSON_ENV_VARS = %w[SPEECH_CREDENTIALS_JSON
                               SPEECH_KEYFILE_JSON
                               GOOGLE_CLOUD_CREDENTIALS_JSON
                               GOOGLE_CLOUD_KEYFILE_JSON
                               GCLOUD_KEYFILE_JSON].freeze
            DEFAULT_PATHS = ["~/.config/google_cloud/application_default_credentials.json"].freeze
          end

          # Service that implements Google Cloud Speech API.
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
              require "google/cloud/speech/v1/cloud_speech_services_pb"

              credentials ||= Credentials.default

              @operations_client = OperationsClient.new(
                credentials: credentials,
                scopes: scopes,
                client_config: client_config,
                timeout: timeout,
                lib_name: lib_name,
                lib_version: lib_version
              )
              @speech_stub = create_stub credentials, scopes

              defaults = default_settings client_config, timeout, metadata, lib_name, lib_version

              @recognize = Google::Gax.create_api_call(
                @speech_stub.method(:recognize),
                defaults,
                exception_transformer: exception_transformer
              )
              @long_running_recognize = Google::Gax.create_api_call(
                @speech_stub.method(:long_running_recognize),
                defaults,
                exception_transformer: exception_transformer
              )
              @streaming_recognize = Google::Gax.create_api_call(
                @speech_stub.method(:streaming_recognize),
                defaults,
                exception_transformer: exception_transformer
              )
            end

            # Service calls

            ##
            # Performs synchronous speech recognition: receive results after all audio
            #  has been sent and processed.
            #
            # @overload recognize(request, options: nil)
            #   @param request [Google::Cloud::Speech::V1::RecognizeRequest | Hash]
            #     Performs synchronous speech recognition: receive results after all audio
            #      has been sent and processed.
            #   @param options [Google::Gax::CallOptions]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload client_method(config: nil, audio: nil, options: nil)
            #   @param config [Google::Cloud::Speech::V1::RecognitionConfig | Hash]
            #     *Required* Provides information to the recognizer that specifies how to
            #      process the request.
            #   @param audio [Google::Cloud::Speech::V1::RecognitionAudio | Hash]
            #     *Required* The audio data to be recognized.
            #   @param options [Google::Gax::CallOptions]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Speech::V1::RecognizeResponse]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Speech::V1::RecognizeResponse]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def recognize request = nil, options: nil, **request_fields, &block
              if request.nil? && request_fields.empty?
                raise ArgumentError, "request must be provided"
              end
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax.to_proto request, Google::Cloud::Speech::V1::RecognizeRequest

              @recognize.call(request, options, &block)
            end

            ##
            # Performs asynchronous speech recognition: receive results via the
            #  google.longrunning.Operations interface. Returns either an
            #  `Operation.error` or an `Operation.response` which contains
            #  a `LongRunningRecognizeResponse` message.
            #
            # @overload long_running_recognize(request, options: nil)
            #   @param request [Google::Cloud::Speech::V1::LongRunningRecognizeRequest | Hash]
            #     Performs asynchronous speech recognition: receive results via the
            #      google.longrunning.Operations interface. Returns either an
            #      `Operation.error` or an `Operation.response` which contains
            #      a `LongRunningRecognizeResponse` message.
            #   @param options [Google::Gax::CallOptions]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload client_method(config: nil, audio: nil, options: nil)
            #   @param config [Google::Cloud::Speech::V1::RecognitionConfig | Hash]
            #     *Required* Provides information to the recognizer that specifies how to
            #      process the request.
            #   @param audio [Google::Cloud::Speech::V1::RecognitionAudio | Hash]
            #     *Required* The audio data to be recognized.
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
            def long_running_recognize request = nil, options: nil, **request_fields
              if request.nil? && request_fields.empty?
                raise ArgumentError, "request must be provided"
              end
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax.to_proto request, Google::Cloud::Speech::V1::LongRunningRecognizeRequest

              operation = Google::Gax::Operation.new(
                @long_running_recognize.call(request, options),
                @operations_client,
                call_options: options
              )
              operation.on_done { |operation| yield operation } if block_given?
              operation
            end

            ##
            # Performs bidirectional streaming speech recognition: receive results while
            #  sending audio. This method is only available via the gRPC API (not REST).
            #
            # @param requests [Enumerable<Google::Cloud::Speech::V1::StreamingRecognizeRequest | Hash>]
            #   An enumerable of {Google::Cloud::Speech::V1::StreamingRecognizeRequest} instances.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @return [Enumerable<Google::Cloud::Speech::V1::StreamingRecognizeResponse>]
            #   An enumerable of {Google::Cloud::Speech::V1::StreamingRecognizeResponse} instances.
            #
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def streaming_recognize requests, options: nil
              unless requests.is_a? Enumerable
                raise ArgumentError, "requests must be an Enumerable"
              end

              requests = requests.lazy.map do |request|
                Google::Gax.to_proto request, Google::Cloud::Speech::V1::StreamingRecognizeRequest
              end

              @streaming_recognize.call requests, options
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
              stub_new = Google::Cloud::Speech::V1::Speech::Stub.method :new
              Google::Gax::Grpc.create_stub(
                service_path,
                port,
                chan_creds: chan_creds,
                channel: channel,
                updater_proc: updater_proc,
                scopes: scopes,
                interceptors: interceptors,
                &stub_new
              )
            end

            def default_settings _client_config, _timeout, metadata, lib_name,
                                 lib_version
              package_gem = Gem.loaded_specs["google-cloud-speech"]
              package_version = package_gem ? package_gem.version.version : nil

              google_api_client = ["gl-ruby/#{RUBY_VERSION}"]
              google_api_client << "#{lib_name}/#{lib_version}" if lib_name
              google_api_client << "gapic/#{package_version}" if package_version
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
end

# rubocop:disable Lint/HandleExceptions

# Once client is loaded, load helpers.rb if it exists.
begin
  require "google/cloud/speech/v1/speech/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
