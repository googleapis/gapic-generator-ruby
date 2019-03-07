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

require "google/cloud/garbage_service/v1/cloud_garbage_service_pb"
require "google/cloud/garbage_service/v1/credentials"

module Google
  module Garbage
    module V1
      ##
      # Endless trash
      class GarbageServiceClient
        # @private
        attr_reader :garbage_service_stub

        # The default address of the service.
        SERVICE_ADDRESS = "garbage_service.googleapis.com"

        # The default port of the service.
        DEFAULT_SERVICE_PORT = 443

        # The default set of gRPC interceptors.
        GRPC_INTERCEPTORS = [].freeze

        DEFAULT_TIMEOUT = 30

        # The scopes needed to make gRPC calls to all of the methods defined in
        # this service.
        ALL_SCOPES = [
          "https://www.googleapis.com/auth/cloud-platform"
        ].freeze

        # @private
        class OperationsClient < Google::Longrunning::OperationsClient
          SERVICE_ADDRESS = GarbageServiceClient::SERVICE_ADDRESS
          GRPC_INTERCEPTORS = GarbageServiceClient::GRPC_INTERCEPTORS.dup
        end

        ##
        # @param credentials [Google::Auth::Credentials, String, Hash,
        #   GRPC::Core::Channel, GRPC::Core::ChannelCredentials, Proc]
        #   Provides the means for authenticating requests made by the client. This parameter can
        #   be many types.
        #   A `Google::Auth::Credentials` uses a the properties of its represented keyfile for
        #   authenticating requests made by this client.
        #   A `String` will be treated as the path to the keyfile to be used for the construction of
        #   credentials for this client.
        #   A `Hash` will be treated as the contents of a keyfile to be used for the construction of
        #   credentials for this client.
        #   A `GRPC::Core::Channel` will be used to make calls through.
        #   A `GRPC::Core::ChannelCredentials` for the setting up the RPC client. The channel credentials
        #   should already be composed with a `GRPC::Core::CallCredentials` object.
        #   A `Proc` will be used as an updater_proc for the Grpc channel. The proc transforms the
        #   metadata for requests, generally, to give OAuth credentials.
        # @param scopes [Array<String>]
        #   The OAuth scopes for this service. This parameter is ignored if
        #   an updater_proc is supplied.
        # @param client_config [Hash]
        #   A Hash for call options for each method. See
        #   Google::Gax#construct_settings for the structure of
        #   this data. Falls back to the default config if not specified
        #   or the specified config is missing data points.
        # @param timeout [Numeric]
        #   The default timeout, in seconds, for calls made through this client.
        # @param metadata [Hash]
        #   Default metadata to be sent with each request. This can be overridden on a per call basis.
        # @param exception_transformer [Proc]
        #   An optional proc that intercepts any exceptions raised during an API call to inject
        #   custom error handling.
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
          require "google/cloud/garbage_service/v1/cloud_garbage_service_services_pb"

          credentials ||= Google::Cloud::GarbageService::V1::Credentials.default

          @operations_client = OperationsClient.new(
            credentials: credentials,
            scopes: scopes,
            client_config: client_config,
            timeout: timeout,
            lib_name: lib_name,
            lib_version: lib_version
          )
          @garbage_service_stub = create_stub credentials, scopes

          defaults = default_settings client_config, timeout, metadata, lib_name, lib_version

          @get_simple_garbage = Google::Gax.create_api_call(
            @garbage_service_stub.method(:get_simple_garbage),
            defaults["get_simple_garbage"],
            exception_transformer: exception_transformer
          )
          @get_specific_garbage = Google::Gax.create_api_call(
            @garbage_service_stub.method(:get_specific_garbage),
            defaults["get_specific_garbage"],
            exception_transformer: exception_transformer
          )
          @get_repeated_garbage = Google::Gax.create_api_call(
            @garbage_service_stub.method(:get_repeated_garbage),
            defaults["get_repeated_garbage"],
            exception_transformer: exception_transformer
          )
          @long_running_garbage = Google::Gax.create_api_call(
            @garbage_service_stub.method(:long_running_garbage),
            defaults["long_running_garbage"],
            exception_transformer: exception_transformer
          )
          @client_garbage = Google::Gax.create_api_call(
            @garbage_service_stub.method(:client_garbage),
            defaults["client_garbage"],
            exception_transformer: exception_transformer
          )
          @server_garbage = Google::Gax.create_api_call(
            @garbage_service_stub.method(:server_garbage),
            defaults["server_garbage"],
            exception_transformer: exception_transformer
          )
          @bidi_garbage = Google::Gax.create_api_call(
            @garbage_service_stub.method(:bidi_garbage),
            defaults["bidi_garbage"],
            exception_transformer: exception_transformer
          )
        end

        # Service calls

        ##
        def get_simple_garbage \
            name,
            options: nil,
            &block
          request = {
            name: name
          }.delete_if { |_, v| v.nil? }
          request = Google::Gax.to_proto request, Google::Garbage::V1::SimpleGarbage
          @get_simple_garbage.call(request, options, &block)
        end

        ##
        def get_specific_garbage \
            name,
            int32,
            int64,
            uint32,
            uint64,
            bool,
            float,
            double,
            bytes,
            msg,
            enum,
            options: nil,
            &block
          request = {
            name: name,
            int32: int32,
            int64: int64,
            uint32: uint32,
            uint64: uint64,
            bool: bool,
            float: float,
            double: double,
            bytes: bytes,
            msg: msg,
            enum: enum
          }.delete_if { |_, v| v.nil? }
          request = Google::Gax.to_proto request, Google::Garbage::V1::SpecificGarbage
          @get_specific_garbage.call(request, options, &block)
        end

        ##
        def get_repeated_garbage \
            repeated_int32,
            repeated_int64,
            repeated_uint32,
            repeated_uint64,
            repeated_bool,
            repeated_float,
            repeated_double,
            repeated_string,
            repeated_bytes,
            repeated_msg,
            repeated_enum,
            options: nil,
            &block
          request = {
            repeated_int32: repeated_int32,
            repeated_int64: repeated_int64,
            repeated_uint32: repeated_uint32,
            repeated_uint64: repeated_uint64,
            repeated_bool: repeated_bool,
            repeated_float: repeated_float,
            repeated_double: repeated_double,
            repeated_string: repeated_string,
            repeated_bytes: repeated_bytes,
            repeated_msg: repeated_msg,
            repeated_enum: repeated_enum
          }.delete_if { |_, v| v.nil? }
          request = Google::Gax.to_proto request, Google::Garbage::V1::RepeatedGarbage
          @get_repeated_garbage.call(request, options, &block)
        end

        ##
        def long_running_garbage \
            garbage,
            options: nil,
            &block
          request = {
            garbage: garbage
          }.delete_if { |_, v| v.nil? }
          request = Google::Gax.to_proto request, Google::Garbage::V1::LongRunningGarbageRequest
          @long_running_garbage.call(request, options, &block)
        end

        ##
        #  This method split the given content into words and will pass each word back
        #  through the stream. This method showcases server-side streaming rpcs.
        def client_garbage \
            garbage,
            options: nil,
            &block
          request = {
            garbage: garbage
          }.delete_if { |_, v| v.nil? }
          request = Google::Gax.to_proto request, Google::Garbage::V1::ListGarbageRequest
          @client_garbage.call(request, options, &block)
        end

        ##
        #  This method will collect the words given to it. When the stream is closed
        #  by the client, this method will return the a concatenation of the strings
        #  passed to it. This method showcases client-side streaming rpcs.
        def server_garbage \
            garbage,
            options: nil,
            &block
          request = {
            garbage: garbage
          }.delete_if { |_, v| v.nil? }
          request = Google::Gax.to_proto request, Google::Garbage::V1::ListGarbageRequest
          @server_garbage.call(request, options, &block)
        end

        ##
        #  This method, upon receiving a request on the stream, the same content will
        #  be passed  back on the stream. This method showcases bidirectional
        #  streaming rpcs.
        def bidi_garbage \
            garbage,
            options: nil,
            &block
          request = {
            garbage: garbage
          }.delete_if { |_, v| v.nil? }
          request = Google::Gax.to_proto request, Google::Garbage::V1::ListGarbageRequest
          @bidi_garbage.call(request, options, &block)
        end

        protected

        def create_stub credentials, scopes
          if credentials.is_a?(String) || credentials.is_a?(Hash)
            updater_proc = Google::Cloud::GarbageService::V1::Credentials.new(credentials).updater_proc
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
          stub_new = Google::Cloud::GarbageService::V1::GarbageService::Stub.method :new
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

        def default_settings client_config, timeout, metadata, lib_name, lib_version
          package_version = Gem.loaded_specs["google-cloud-garbage_service"].version.version

          google_api_client = ["gl-ruby/#{RUBY_VERSION}"]
          google_api_client << " #{lib_name}/#{lib_version}" if lib_name
          google_api_client << " gapic/#{package_version} gax/#{Google::Gax::VERSION}"
          google_api_client << " grpc/#{GRPC::VERSION}"
          google_api_client.join

          headers = { "x-goog-api-client": google_api_client }
          headers.merge! metadata unless metadata.nil?
          client_config_file = Pathname.new(__dir__).join(
            "garbage_service_client_config.json"
          )
          client_config_file.open do |f|
            Google::Gax.construct_settings(
              "google.cloud.garbage_service.v1.GarbageService",
              JSON.parse(f.read),
              client_config,
              Google::Gax::Grpc::STATUS_CODE_NAMES,
              timeout,
              errors: Google::Gax::Grpc::API_ERRORS,
              metadata: headers
            )
          end
        end
      end
    end
  end
end
