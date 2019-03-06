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

require "google/cloud/image_annotator/v1/cloud_image_annotator_pb"
require "google/cloud/image_annotator/v1/credentials"

module Google
  module Cloud
    module Vision
      module V1
        ##
        # Service that performs Google Cloud Vision API detection tasks over client
        # images, such as face, landmark, logo, label, and text detection. The
        # ImageAnnotator service returns detected entities from the images.
        class ImageAnnotatorClient
          # @private
          attr_reader :image_annotator_stub

          # The default address of the service.
          SERVICE_ADDRESS = "image_annotator.googleapis.com"

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
            SERVICE_ADDRESS = ImageAnnotatorClient::SERVICE_ADDRESS
            GRPC_INTERCEPTORS = ImageAnnotatorClient::GRPC_INTERCEPTORS.dup
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
            require "google/cloud/image_annotator/v1/cloud_image_annotator_services_pb"

            credentials ||= Google::Cloud::ImageAnnotator::V1::Credentials.default

            @operations_client = OperationsClient.new(
              credentials: credentials,
              scopes: scopes,
              client_config: client_config,
              timeout: timeout,
              lib_name: lib_name,
              lib_version: lib_version
            )
            @image_annotator_stub = create_stub credentials, scopes

            defaults = default_settings client_config, timeout, metadata, lib_name, lib_version

            @batch_annotate_images = Google::Gax.create_api_call(
              @image_annotator_stub.method(:batch_annotate_images),
              defaults["batch_annotate_images"],
              exception_transformer: exception_transformer
            )
            @async_batch_annotate_files = Google::Gax.create_api_call(
              @image_annotator_stub.method(:async_batch_annotate_files),
              defaults["async_batch_annotate_files"],
              exception_transformer: exception_transformer
            )
          end

          # Service calls

          ##
          #  Run image detection and annotation for a batch of images.
          def batch_annotate_images \
              requests,
              options: nil,
              &block
            request = {
              requests: requests
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::BatchAnnotateImagesRequest
            @batch_annotate_images.call(request, options, &block)
          end

          ##
          #  Run asynchronous image detection and annotation for a list of generic
          #  files, such as PDF files, which may contain multiple pages and multiple
          #  images per page. Progress and results can be retrieved through the
          #  `google.longrunning.Operations` interface.
          #  `Operation.metadata` contains `OperationMetadata` (metadata).
          #  `Operation.response` contains `AsyncBatchAnnotateFilesResponse` (results).
          def async_batch_annotate_files \
              requests,
              options: nil,
              &block
            request = {
              requests: requests
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest
            @async_batch_annotate_files.call(request, options, &block)
          end

          protected

          def create_stub credentials, scopes
            if credentials.is_a?(String) || credentials.is_a?(Hash)
              updater_proc = Google::Cloud::ImageAnnotator::V1::Credentials.new(credentials).updater_proc
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
            stub_new = Google::Cloud::ImageAnnotator::V1::ImageAnnotator::Stub.method :new
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
            package_version = Gem.loaded_specs["google-cloud-image_annotator"].version.version

            google_api_client = ["gl-ruby/#{RUBY_VERSION}"]
            google_api_client << " #{lib_name}/#{lib_version}" if lib_name
            google_api_client << " gapic/#{package_version} gax/#{Google::Gax::VERSION}"
            google_api_client << " grpc/#{GRPC::VERSION}"
            google_api_client.join

            headers = { "x-goog-api-client": google_api_client }
            headers.merge! metadata unless metadata.nil?
            client_config_file = Pathname.new(__dir__).join(
              "image_annotator_client_config.json"
            )
            client_config_file.open do |f|
              Google::Gax.construct_settings(
                "google.cloud.image_annotator.v1.ImageAnnotator",
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
end
