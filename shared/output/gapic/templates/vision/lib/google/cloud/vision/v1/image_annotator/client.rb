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

require "google/gax"

require "google/cloud/vision/version"
require "google/cloud/vision/v1/image_annotator_pb"
require "google/cloud/vision/v1/image_annotator/credentials"
require "google/cloud/vision/v1/image_annotator/operations"

module Google
  module Cloud
    module Vision
      module V1
        module ImageAnnotator
          # Service that implements ImageAnnotator API.
          class Client
            # @private
            attr_reader :image_annotator_stub

            # The default address of the service.
            SERVICE_ADDRESS = "vision.googleapis.com"

            # The default port of the service.
            DEFAULT_SERVICE_PORT = 443

            # rubocop:disable Style/MutableConstant

            # The default set of gRPC interceptors.
            GRPC_INTERCEPTORS = []

            # rubocop:enable Style/MutableConstant

            DEFAULT_TIMEOUT = 30



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
                scope: nil,
                timeout: DEFAULT_TIMEOUT,
                metadata: nil,
                lib_name: nil,
                lib_version: nil
              # These require statements are intentionally placed here to initialize
              # the gRPC module only when it's required.
              # See https://github.com/googleapis/toolkit/issues/446
              require "google/gax/grpc"
              require "google/cloud/vision/v1/image_annotator_services_pb"

              credentials ||= Credentials.default scope: scope
              if credentials.is_a?(String) || credentials.is_a?(Hash)
                credentials = Credentials.new credentials, scope: scope
              end

              @operations_client = Operations.new(
                credentials: credentials,
                scope:       scope,
                timeout:     timeout,
                metadata:    metadata,
                lib_name:    lib_name,
                lib_version: lib_version
              )

              @image_annotator_stub = Google::Gax::Grpc::Stub.new(
                Google::Cloud::Vision::V1::ImageAnnotator::Stub,
                host:         self.class::SERVICE_ADDRESS,
                port:         self.class::DEFAULT_SERVICE_PORT,
                credentials:  credentials,
                interceptors: self.class::GRPC_INTERCEPTORS
              )

              @timeout = timeout
              x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
              x_goog_api_client_header << "#{lib_name}/#{lib_version}" if lib_name
              x_goog_api_client_header << "gapic/#{Google::Cloud::Vision::VERSION}"
              x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
              x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
              @metadata = metadata.to_h
              @metadata["x-goog-api-client"] ||= x_goog_api_client_header.join " "
            end

            # Service calls

            ##
            # Run image detection and annotation for a batch of images.
            #
            # @overload batch_annotate_images(request, options: nil)
            #   @param request [Google::Cloud::Vision::V1::BatchAnnotateImagesRequest | Hash]
            #     Run image detection and annotation for a batch of images.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload batch_annotate_images(requests: nil, options: nil)
            #   @param requests [Google::Cloud::Vision::V1::AnnotateImageRequest | Hash]
            #     Individual image annotation requests for this batch.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::BatchAnnotateImagesResponse]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::BatchAnnotateImagesResponse]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def batch_annotate_images request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::BatchAnnotateImagesRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @metadata.dup
              options.apply_defaults timeout: @timeout, metadata: metadata

              @batch_annotate_images ||= Google::Gax::ApiCall.new @image_annotator_stub.method :batch_annotate_images
              @batch_annotate_images.call request, options: options, operation_callback: block
            end

            ##
            # Run asynchronous image detection and annotation for a list of generic
            # files, such as PDF files, which may contain multiple pages and multiple
            # images per page. Progress and results can be retrieved through the
            # `google.longrunning.Operations` interface.
            # `Operation.metadata` contains `OperationMetadata` (metadata).
            # `Operation.response` contains `AsyncBatchAnnotateFilesResponse` (results).
            #
            # @overload async_batch_annotate_files(request, options: nil)
            #   @param request [Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest | Hash]
            #     Run asynchronous image detection and annotation for a list of generic
            #     files, such as PDF files, which may contain multiple pages and multiple
            #     images per page. Progress and results can be retrieved through the
            #     `google.longrunning.Operations` interface.
            #     `Operation.metadata` contains `OperationMetadata` (metadata).
            #     `Operation.response` contains `AsyncBatchAnnotateFilesResponse` (results).
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload async_batch_annotate_files(requests: nil, options: nil)
            #   @param requests [Google::Cloud::Vision::V1::AsyncAnnotateFileRequest | Hash]
            #     Individual async file annotation requests for this batch.
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
            def async_batch_annotate_files request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @metadata.dup
              options.apply_defaults timeout: @timeout, metadata: metadata

              format_response = ->(response) { Google::Gax::Operation.new response, @operations_client, options }

              @async_batch_annotate_files ||= Google::Gax::ApiCall.new @image_annotator_stub.method :async_batch_annotate_files
              @async_batch_annotate_files.call request, options: options, operation_callback: block, format_response: format_response
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
  require "google/cloud/vision/v1/image_annotator/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
