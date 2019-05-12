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

            ##
            # Configuration for the ImageAnnotator API.
            #
            def self.configure
              @configure ||= Google::Gax::Configuration.new do |config|
                default_scope = Google::Gax::Configuration.deferred do
                  Credentials::SCOPE
                end
                config.add_field! :host,         "vision.googleapis.com", match: [String]
                config.add_field! :port,         443, match: [Integer]
                config.add_field! :scope,        default_scope,                         match: [String, Array], allow_nil: true
                config.add_field! :lib_name,     nil,                                   match: [String],        allow_nil: true
                config.add_field! :lib_version,  nil,                                   match: [String],        allow_nil: true
                config.add_field! :interceptors, [],                                    match: [Array]

                config.add_field! :timeout,     60,  match: [Numeric]
                config.add_field! :metadata,    nil, match: [Hash],       allow_nil: true
                config.add_field! :retry_codes, nil, match: [Hash, Proc], allow_nil: true

                config.add_config! :methods do |methods|
                  methods.add_config! :batch_annotate_images do |method|
                    method.add_field! :timeout,     nil, match: [Numeric],    allow_nil: true
                    method.add_field! :metadata,    nil, match: [Hash],       allow_nil: true
                    method.add_field! :retry_codes, nil, match: [Hash, Proc], allow_nil: true
                  end
                  methods.add_config! :async_batch_annotate_files do |method|
                    method.add_field! :timeout,     nil, match: [Numeric],    allow_nil: true
                    method.add_field! :metadata,    nil, match: [Hash],       allow_nil: true
                    method.add_field! :retry_codes, nil, match: [Hash, Proc], allow_nil: true
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
              require "google/cloud/vision/v1/image_annotator_services_pb"

              # Create the configuration object
              config ||= Client.configure
              config = config.derive! unless config.derived?

              # Yield the configuration if needed
              yield config if block_given?

              @config = config

              # Update the configuration with x-goog-api-client header
              # Paradox: do we generate the header before yielding without the lib_name?
              # Or, do we generate it after yielding, when the lib_name is most likely to be set?
              x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
              x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
              x_goog_api_client_header << "gapic/#{Google::Cloud::Vision::VERSION}"
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
                credentials: credentials
              )

              @image_annotator_stub = Google::Gax::Grpc::Stub.new(
                Google::Cloud::Vision::V1::ImageAnnotator::Stub,
                credentials:  credentials,
                host:         @config.host,
                port:         @config.port,
                interceptors: @config.interceptors
              )
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
              metadata = @config.metadata.dup
              # TODO: Grab retry_policy from @config
              # TODO: Allow for Proc in @config's retry_policy
              options.apply_defaults timeout: @config.timeout, metadata: metadata

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
              metadata = @config.metadata.dup
              # TODO: Grab retry_policy from @config
              # TODO: Allow for Proc in @config's retry_policy
              options.apply_defaults timeout: @config.timeout, metadata: metadata

              @async_batch_annotate_files ||= Google::Gax::ApiCall.new @image_annotator_stub.method :async_batch_annotate_files

              wrap_gax_operation = ->(response) { Google::Gax::Operation.new response, @operations_client }

              @async_batch_annotate_files.call request, options: options, operation_callback: block, format_response: wrap_gax_operation
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
