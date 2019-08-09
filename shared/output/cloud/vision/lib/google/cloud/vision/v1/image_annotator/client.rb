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

require "gapic/common"
require "gapic/config"
require "gapic/config/method"

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
            # Configuration for the ImageAnnotator Client API.
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
            # Configure the ImageAnnotator Client instance.
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
              require "google/cloud/vision/v1/image_annotator_services_pb"

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

              @image_annotator_stub = Gapic::Grpc::Stub.new(
                Google::Cloud::Vision::V1::ImageAnnotator::Stub,
                credentials:  credentials,
                endpoint:     @config.endpoint,
                channel_args: @config.channel_args,
                interceptors: @config.interceptors
              )
            end

            # Service calls

            ##
            # Run image detection and annotation for a batch of images.
            #
            # @overload batch_annotate_images(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::BatchAnnotateImagesRequest | Hash]
            #     Run image detection and annotation for a batch of images.
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload batch_annotate_images(requests: nil)
            #   @param requests [Google::Cloud::Vision::V1::AnnotateImageRequest | Hash]
            #     Individual image annotation requests for this batch.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::BatchAnnotateImagesResponse]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::BatchAnnotateImagesResponse]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def batch_annotate_images request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::BatchAnnotateImagesRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.batch_annotate_images.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              options.apply_defaults timeout:      @config.rpcs.batch_annotate_images.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.batch_annotate_images.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @image_annotator_stub.call_rpc :batch_annotate_images, request, options: options, operation_callback: block
            end

            ##
            # Run asynchronous image detection and annotation for a list of generic
            # files, such as PDF files, which may contain multiple pages and multiple
            # images per page. Progress and results can be retrieved through the
            # `google.longrunning.Operations` interface.
            # `Operation.metadata` contains `OperationMetadata` (metadata).
            # `Operation.response` contains `AsyncBatchAnnotateFilesResponse` (results).
            #
            # @overload async_batch_annotate_files(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest | Hash]
            #     Run asynchronous image detection and annotation for a list of generic
            #     files, such as PDF files, which may contain multiple pages and multiple
            #     images per page. Progress and results can be retrieved through the
            #     `google.longrunning.Operations` interface.
            #     `Operation.metadata` contains `OperationMetadata` (metadata).
            #     `Operation.response` contains `AsyncBatchAnnotateFilesResponse` (results).
            #   @param options [Gapic::CallOptions, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload async_batch_annotate_files(requests: nil)
            #   @param requests [Google::Cloud::Vision::V1::AsyncAnnotateFileRequest | Hash]
            #     Individual async file annotation requests for this batch.
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
            # @example
            #   TODO
            #
            def async_batch_annotate_files request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest

              # Converts hash and nil to an options object
              options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.async_batch_annotate_files.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              options.apply_defaults timeout:      @config.rpcs.async_batch_annotate_files.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.async_batch_annotate_files.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              wrap_gax_operation = ->(response) { Gapic::Operation.new response, @operations_client }

              @image_annotator_stub.call_rpc :async_batch_annotate_files, request, options: options, operation_callback: block, format_response: wrap_gax_operation
            end

            class Configuration
              extend Gapic::Config

              config_attr :endpoint,     "vision.googleapis.com", String
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
                attr_reader :batch_annotate_images
                attr_reader :async_batch_annotate_files

                def initialize parent_rpcs = nil
                  batch_annotate_images_config = nil
                  batch_annotate_images_config = parent_rpcs&.batch_annotate_images if parent_rpcs&.respond_to? :batch_annotate_images
                  @batch_annotate_images = Gapic::Config::Method.new batch_annotate_images_config
                  async_batch_annotate_files_config = nil
                  async_batch_annotate_files_config = parent_rpcs&.async_batch_annotate_files if parent_rpcs&.respond_to? :async_batch_annotate_files
                  @async_batch_annotate_files = Gapic::Config::Method.new async_batch_annotate_files_config

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
  require "google/cloud/vision/v1/image_annotator/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
