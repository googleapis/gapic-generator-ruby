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

require "gapic/common"
require "gapic/config"
require "gapic/config/method"

require "google/cloud/vision/version"
require "google/cloud/vision/v1/product_search_service_pb"
require "google/cloud/vision/v1/product_search/credentials"
require "google/cloud/vision/v1/product_search/operations"

module Google
  module Cloud
    module Vision
      module V1
        module ProductSearch
          # Service that implements ProductSearch API.
          class Client
            # @private
            attr_reader :product_search_stub

            ##
            # Configuration for the ProductSearch Client API.
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
            # Configure the ProductSearch Client instance.
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
              require "google/cloud/vision/v1/product_search_service_services_pb"

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

              @product_search_stub = Gapic::Grpc::Stub.new(
                Google::Cloud::Vision::V1::ProductSearch::Stub,
                credentials:  credentials,
                endpoint:     @config.endpoint,
                channel_args: @config.channel_args,
                interceptors: @config.interceptors
              )
            end

            # Service calls

            ##
            # Creates and returns a new ProductSet resource.
            #
            # Possible errors:
            #
            # * Returns INVALID_ARGUMENT if display_name is missing, or is longer than
            #   4096 characters.
            #
            # @overload create_product_set(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::CreateProductSetRequest | Hash]
            #     Creates and returns a new ProductSet resource.
            #
            #     Possible errors:
            #
            #     * Returns INVALID_ARGUMENT if display_name is missing, or is longer than
            #       4096 characters.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload create_product_set(parent: nil, product_set: nil, product_set_id: nil)
            #   @param parent [String]
            #     The project in which the ProductSet should be created.
            #
            #     Format is `projects/PROJECT_ID/locations/LOC_ID`.
            #   @param product_set [Google::Cloud::Vision::V1::ProductSet | Hash]
            #     The ProductSet to create.
            #   @param product_set_id [String]
            #     A user-supplied resource id for this ProductSet. If set, the server will
            #     attempt to use this value as the resource id. If it is already in use, an
            #     error is returned with code ALREADY_EXISTS. Must be at most 128 characters
            #     long. It cannot contain the character `/`.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::ProductSet]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ProductSet]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def create_product_set request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::CreateProductSetRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.create_product_set.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.create_product_set.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.create_product_set.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_search_stub.call_rpc :create_product_set, request, options: options, operation_callback: block
            end

            ##
            # Lists ProductSets in an unspecified order.
            #
            # Possible errors:
            #
            # * Returns INVALID_ARGUMENT if page_size is greater than 100, or less
            #   than 1.
            #
            # @overload list_product_sets(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::ListProductSetsRequest | Hash]
            #     Lists ProductSets in an unspecified order.
            #
            #     Possible errors:
            #
            #     * Returns INVALID_ARGUMENT if page_size is greater than 100, or less
            #       than 1.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload list_product_sets(parent: nil, page_size: nil, page_token: nil)
            #   @param parent [String]
            #     The project from which ProductSets should be listed.
            #
            #     Format is `projects/PROJECT_ID/locations/LOC_ID`.
            #   @param page_size [Integer]
            #     The maximum number of items to return. Default 10, maximum 100.
            #   @param page_token [String]
            #     The next_page_token returned from a previous List request, if any.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Gapic::PagedEnumerable<Google::Cloud::Vision::V1::ProductSet>]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Gapic::PagedEnumerable<Google::Cloud::Vision::V1::ProductSet>]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def list_product_sets request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::ListProductSetsRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.list_product_sets.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.list_product_sets.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.list_product_sets.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              wrap_paged_enum = ->(response) { Gapic::PagedEnumerable.new @product_search_stub, :list_product_sets, request, response, options }

              @product_search_stub.call_rpc :list_product_sets, request, options: options, operation_callback: block, format_response: wrap_paged_enum
            end

            ##
            # Gets information associated with a ProductSet.
            #
            # Possible errors:
            #
            # * Returns NOT_FOUND if the ProductSet does not exist.
            #
            # @overload get_product_set(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::GetProductSetRequest | Hash]
            #     Gets information associated with a ProductSet.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the ProductSet does not exist.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload get_product_set(name: nil)
            #   @param name [String]
            #     Resource name of the ProductSet to get.
            #
            #     Format is:
            #     `projects/PROJECT_ID/locations/LOG_ID/productSets/PRODUCT_SET_ID`
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::ProductSet]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ProductSet]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def get_product_set request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::GetProductSetRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.get_product_set.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.get_product_set.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.get_product_set.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_search_stub.call_rpc :get_product_set, request, options: options, operation_callback: block
            end

            ##
            # Makes changes to a ProductSet resource.
            # Only display_name can be updated currently.
            #
            # Possible errors:
            #
            # * Returns NOT_FOUND if the ProductSet does not exist.
            # * Returns INVALID_ARGUMENT if display_name is present in update_mask but
            #   missing from the request or longer than 4096 characters.
            #
            # @overload update_product_set(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::UpdateProductSetRequest | Hash]
            #     Makes changes to a ProductSet resource.
            #     Only display_name can be updated currently.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the ProductSet does not exist.
            #     * Returns INVALID_ARGUMENT if display_name is present in update_mask but
            #       missing from the request or longer than 4096 characters.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload update_product_set(product_set: nil, update_mask: nil)
            #   @param product_set [Google::Cloud::Vision::V1::ProductSet | Hash]
            #     The ProductSet resource which replaces the one on the server.
            #   @param update_mask [Google::Protobuf::FieldMask | Hash]
            #     The [FieldMask][google.protobuf.FieldMask] that specifies which fields to
            #     update.
            #     If update_mask isn't specified, all mutable fields are to be updated.
            #     Valid mask path is `display_name`.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::ProductSet]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ProductSet]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def update_product_set request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::UpdateProductSetRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.update_product_set.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "product_set.name" => request.product_set.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.update_product_set.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.update_product_set.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_search_stub.call_rpc :update_product_set, request, options: options, operation_callback: block
            end

            ##
            # Permanently deletes a ProductSet. Products and ReferenceImages in the
            # ProductSet are not deleted.
            #
            # The actual image files are not deleted from Google Cloud Storage.
            #
            # Possible errors:
            #
            # * Returns NOT_FOUND if the ProductSet does not exist.
            #
            # @overload delete_product_set(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::DeleteProductSetRequest | Hash]
            #     Permanently deletes a ProductSet. Products and ReferenceImages in the
            #     ProductSet are not deleted.
            #
            #     The actual image files are not deleted from Google Cloud Storage.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the ProductSet does not exist.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload delete_product_set(name: nil)
            #   @param name [String]
            #     Resource name of the ProductSet to delete.
            #
            #     Format is:
            #     `projects/PROJECT_ID/locations/LOC_ID/productSets/PRODUCT_SET_ID`
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def delete_product_set request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::DeleteProductSetRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.delete_product_set.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.delete_product_set.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.delete_product_set.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_search_stub.call_rpc :delete_product_set, request, options: options, operation_callback: block
            end

            ##
            # Creates and returns a new product resource.
            #
            # Possible errors:
            #
            # * Returns INVALID_ARGUMENT if display_name is missing or longer than 4096
            #   characters.
            # * Returns INVALID_ARGUMENT if description is longer than 4096 characters.
            # * Returns INVALID_ARGUMENT if product_category is missing or invalid.
            #
            # @overload create_product(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::CreateProductRequest | Hash]
            #     Creates and returns a new product resource.
            #
            #     Possible errors:
            #
            #     * Returns INVALID_ARGUMENT if display_name is missing or longer than 4096
            #       characters.
            #     * Returns INVALID_ARGUMENT if description is longer than 4096 characters.
            #     * Returns INVALID_ARGUMENT if product_category is missing or invalid.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload create_product(parent: nil, product: nil, product_id: nil)
            #   @param parent [String]
            #     The project in which the Product should be created.
            #
            #     Format is
            #     `projects/PROJECT_ID/locations/LOC_ID`.
            #   @param product [Google::Cloud::Vision::V1::Product | Hash]
            #     The product to create.
            #   @param product_id [String]
            #     A user-supplied resource id for this Product. If set, the server will
            #     attempt to use this value as the resource id. If it is already in use, an
            #     error is returned with code ALREADY_EXISTS. Must be at most 128 characters
            #     long. It cannot contain the character `/`.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::Product]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::Product]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def create_product request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::CreateProductRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.create_product.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.create_product.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.create_product.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_search_stub.call_rpc :create_product, request, options: options, operation_callback: block
            end

            ##
            # Lists products in an unspecified order.
            #
            # Possible errors:
            #
            # * Returns INVALID_ARGUMENT if page_size is greater than 100 or less than 1.
            #
            # @overload list_products(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::ListProductsRequest | Hash]
            #     Lists products in an unspecified order.
            #
            #     Possible errors:
            #
            #     * Returns INVALID_ARGUMENT if page_size is greater than 100 or less than 1.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload list_products(parent: nil, page_size: nil, page_token: nil)
            #   @param parent [String]
            #     The project OR ProductSet from which Products should be listed.
            #
            #     Format:
            #     `projects/PROJECT_ID/locations/LOC_ID`
            #   @param page_size [Integer]
            #     The maximum number of items to return. Default 10, maximum 100.
            #   @param page_token [String]
            #     The next_page_token returned from a previous List request, if any.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Gapic::PagedEnumerable<Google::Cloud::Vision::V1::Product>]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Gapic::PagedEnumerable<Google::Cloud::Vision::V1::Product>]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def list_products request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::ListProductsRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.list_products.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.list_products.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.list_products.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              wrap_paged_enum = ->(response) { Gapic::PagedEnumerable.new @product_search_stub, :list_products, request, response, options }

              @product_search_stub.call_rpc :list_products, request, options: options, operation_callback: block, format_response: wrap_paged_enum
            end

            ##
            # Gets information associated with a Product.
            #
            # Possible errors:
            #
            # * Returns NOT_FOUND if the Product does not exist.
            #
            # @overload get_product(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::GetProductRequest | Hash]
            #     Gets information associated with a Product.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the Product does not exist.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload get_product(name: nil)
            #   @param name [String]
            #     Resource name of the Product to get.
            #
            #     Format is:
            #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::Product]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::Product]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def get_product request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::GetProductRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.get_product.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.get_product.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.get_product.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_search_stub.call_rpc :get_product, request, options: options, operation_callback: block
            end

            ##
            # Makes changes to a Product resource.
            # Only the `display_name`, `description`, and `labels` fields can be updated
            # right now.
            #
            # If labels are updated, the change will not be reflected in queries until
            # the next index time.
            #
            # Possible errors:
            #
            # * Returns NOT_FOUND if the Product does not exist.
            # * Returns INVALID_ARGUMENT if display_name is present in update_mask but is
            #   missing from the request or longer than 4096 characters.
            # * Returns INVALID_ARGUMENT if description is present in update_mask but is
            #   longer than 4096 characters.
            # * Returns INVALID_ARGUMENT if product_category is present in update_mask.
            #
            # @overload update_product(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::UpdateProductRequest | Hash]
            #     Makes changes to a Product resource.
            #     Only the `display_name`, `description`, and `labels` fields can be updated
            #     right now.
            #
            #     If labels are updated, the change will not be reflected in queries until
            #     the next index time.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the Product does not exist.
            #     * Returns INVALID_ARGUMENT if display_name is present in update_mask but is
            #       missing from the request or longer than 4096 characters.
            #     * Returns INVALID_ARGUMENT if description is present in update_mask but is
            #       longer than 4096 characters.
            #     * Returns INVALID_ARGUMENT if product_category is present in update_mask.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload update_product(product: nil, update_mask: nil)
            #   @param product [Google::Cloud::Vision::V1::Product | Hash]
            #     The Product resource which replaces the one on the server.
            #     product.name is immutable.
            #   @param update_mask [Google::Protobuf::FieldMask | Hash]
            #     The [FieldMask][google.protobuf.FieldMask] that specifies which fields
            #     to update.
            #     If update_mask isn't specified, all mutable fields are to be updated.
            #     Valid mask paths include `product_labels`, `display_name`, and
            #     `description`.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::Product]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::Product]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def update_product request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::UpdateProductRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.update_product.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "product.name" => request.product.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.update_product.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.update_product.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_search_stub.call_rpc :update_product, request, options: options, operation_callback: block
            end

            ##
            # Permanently deletes a product and its reference images.
            #
            # Metadata of the product and all its images will be deleted right away, but
            # search queries against ProductSets containing the product may still work
            # until all related caches are refreshed.
            #
            # Possible errors:
            #
            # * Returns NOT_FOUND if the product does not exist.
            #
            # @overload delete_product(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::DeleteProductRequest | Hash]
            #     Permanently deletes a product and its reference images.
            #
            #     Metadata of the product and all its images will be deleted right away, but
            #     search queries against ProductSets containing the product may still work
            #     until all related caches are refreshed.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the product does not exist.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload delete_product(name: nil)
            #   @param name [String]
            #     Resource name of product to delete.
            #
            #     Format is:
            #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def delete_product request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::DeleteProductRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.delete_product.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.delete_product.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.delete_product.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_search_stub.call_rpc :delete_product, request, options: options, operation_callback: block
            end

            ##
            # Creates and returns a new ReferenceImage resource.
            #
            # The `bounding_poly` field is optional. If `bounding_poly` is not specified,
            # the system will try to detect regions of interest in the image that are
            # compatible with the product_category on the parent product. If it is
            # specified, detection is ALWAYS skipped. The system converts polygons into
            # non-rotated rectangles.
            #
            # Note that the pipeline will resize the image if the image resolution is too
            # large to process (above 50MP).
            #
            # Possible errors:
            #
            # * Returns INVALID_ARGUMENT if the image_uri is missing or longer than 4096
            #   characters.
            # * Returns INVALID_ARGUMENT if the product does not exist.
            # * Returns INVALID_ARGUMENT if bounding_poly is not provided, and nothing
            #   compatible with the parent product's product_category is detected.
            # * Returns INVALID_ARGUMENT if bounding_poly contains more than 10 polygons.
            #
            # @overload create_reference_image(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::CreateReferenceImageRequest | Hash]
            #     Creates and returns a new ReferenceImage resource.
            #
            #     The `bounding_poly` field is optional. If `bounding_poly` is not specified,
            #     the system will try to detect regions of interest in the image that are
            #     compatible with the product_category on the parent product. If it is
            #     specified, detection is ALWAYS skipped. The system converts polygons into
            #     non-rotated rectangles.
            #
            #     Note that the pipeline will resize the image if the image resolution is too
            #     large to process (above 50MP).
            #
            #     Possible errors:
            #
            #     * Returns INVALID_ARGUMENT if the image_uri is missing or longer than 4096
            #       characters.
            #     * Returns INVALID_ARGUMENT if the product does not exist.
            #     * Returns INVALID_ARGUMENT if bounding_poly is not provided, and nothing
            #       compatible with the parent product's product_category is detected.
            #     * Returns INVALID_ARGUMENT if bounding_poly contains more than 10 polygons.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload create_reference_image(parent: nil, reference_image: nil, reference_image_id: nil)
            #   @param parent [String]
            #     Resource name of the product in which to create the reference image.
            #
            #     Format is
            #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`.
            #   @param reference_image [Google::Cloud::Vision::V1::ReferenceImage | Hash]
            #     The reference image to create.
            #     If an image ID is specified, it is ignored.
            #   @param reference_image_id [String]
            #     A user-supplied resource id for the ReferenceImage to be added. If set,
            #     the server will attempt to use this value as the resource id. If it is
            #     already in use, an error is returned with code ALREADY_EXISTS. Must be at
            #     most 128 characters long. It cannot contain the character `/`.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::ReferenceImage]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ReferenceImage]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def create_reference_image request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::CreateReferenceImageRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.create_reference_image.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.create_reference_image.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.create_reference_image.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_search_stub.call_rpc :create_reference_image, request, options: options, operation_callback: block
            end

            ##
            # Permanently deletes a reference image.
            #
            # The image metadata will be deleted right away, but search queries
            # against ProductSets containing the image may still work until all related
            # caches are refreshed.
            #
            # The actual image files are not deleted from Google Cloud Storage.
            #
            # Possible errors:
            #
            # * Returns NOT_FOUND if the reference image does not exist.
            #
            # @overload delete_reference_image(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::DeleteReferenceImageRequest | Hash]
            #     Permanently deletes a reference image.
            #
            #     The image metadata will be deleted right away, but search queries
            #     against ProductSets containing the image may still work until all related
            #     caches are refreshed.
            #
            #     The actual image files are not deleted from Google Cloud Storage.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the reference image does not exist.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload delete_reference_image(name: nil)
            #   @param name [String]
            #     The resource name of the reference image to delete.
            #
            #     Format is:
            #
            #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID/referenceImages/IMAGE_ID`
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def delete_reference_image request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::DeleteReferenceImageRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.delete_reference_image.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.delete_reference_image.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.delete_reference_image.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_search_stub.call_rpc :delete_reference_image, request, options: options, operation_callback: block
            end

            ##
            # Lists reference images.
            #
            # Possible errors:
            #
            # * Returns NOT_FOUND if the parent product does not exist.
            # * Returns INVALID_ARGUMENT if the page_size is greater than 100, or less
            #   than 1.
            #
            # @overload list_reference_images(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::ListReferenceImagesRequest | Hash]
            #     Lists reference images.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the parent product does not exist.
            #     * Returns INVALID_ARGUMENT if the page_size is greater than 100, or less
            #       than 1.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload list_reference_images(parent: nil, page_size: nil, page_token: nil)
            #   @param parent [String]
            #     Resource name of the product containing the reference images.
            #
            #     Format is
            #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`.
            #   @param page_size [Integer]
            #     The maximum number of items to return. Default 10, maximum 100.
            #   @param page_token [String]
            #     A token identifying a page of results to be returned. This is the value
            #     of `nextPageToken` returned in a previous reference image list request.
            #
            #     Defaults to the first page if not specified.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Gapic::PagedEnumerable<Google::Cloud::Vision::V1::ReferenceImage>]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Gapic::PagedEnumerable<Google::Cloud::Vision::V1::ReferenceImage>]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def list_reference_images request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::ListReferenceImagesRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.list_reference_images.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.list_reference_images.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.list_reference_images.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              wrap_paged_enum = ->(response) { Gapic::PagedEnumerable.new @product_search_stub, :list_reference_images, request, response, options }

              @product_search_stub.call_rpc :list_reference_images, request, options: options, operation_callback: block, format_response: wrap_paged_enum
            end

            ##
            # Gets information associated with a ReferenceImage.
            #
            # Possible errors:
            #
            # * Returns NOT_FOUND if the specified image does not exist.
            #
            # @overload get_reference_image(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::GetReferenceImageRequest | Hash]
            #     Gets information associated with a ReferenceImage.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the specified image does not exist.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload get_reference_image(name: nil)
            #   @param name [String]
            #     The resource name of the ReferenceImage to get.
            #
            #     Format is:
            #
            #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID/referenceImages/IMAGE_ID`.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::ReferenceImage]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ReferenceImage]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def get_reference_image request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::GetReferenceImageRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.get_reference_image.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.get_reference_image.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.get_reference_image.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_search_stub.call_rpc :get_reference_image, request, options: options, operation_callback: block
            end

            ##
            # Adds a Product to the specified ProductSet. If the Product is already
            # present, no change is made.
            #
            # One Product can be added to at most 100 ProductSets.
            #
            # Possible errors:
            #
            # * Returns NOT_FOUND if the Product or the ProductSet doesn't exist.
            #
            # @overload add_product_to_product_set(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::AddProductToProductSetRequest | Hash]
            #     Adds a Product to the specified ProductSet. If the Product is already
            #     present, no change is made.
            #
            #     One Product can be added to at most 100 ProductSets.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the Product or the ProductSet doesn't exist.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload add_product_to_product_set(name: nil, product: nil)
            #   @param name [String]
            #     The resource name for the ProductSet to modify.
            #
            #     Format is:
            #     `projects/PROJECT_ID/locations/LOC_ID/productSets/PRODUCT_SET_ID`
            #   @param product [String]
            #     The resource name for the Product to be added to this ProductSet.
            #
            #     Format is:
            #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def add_product_to_product_set request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::AddProductToProductSetRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.add_product_to_product_set.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.add_product_to_product_set.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.add_product_to_product_set.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_search_stub.call_rpc :add_product_to_product_set, request, options: options, operation_callback: block
            end

            ##
            # Removes a Product from the specified ProductSet.
            #
            # Possible errors:
            #
            # * Returns NOT_FOUND If the Product is not found under the ProductSet.
            #
            # @overload remove_product_from_product_set(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest | Hash]
            #     Removes a Product from the specified ProductSet.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND If the Product is not found under the ProductSet.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload remove_product_from_product_set(name: nil, product: nil)
            #   @param name [String]
            #     The resource name for the ProductSet to modify.
            #
            #     Format is:
            #     `projects/PROJECT_ID/locations/LOC_ID/productSets/PRODUCT_SET_ID`
            #   @param product [String]
            #     The resource name for the Product to be removed from this ProductSet.
            #
            #     Format is:
            #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def remove_product_from_product_set request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.remove_product_from_product_set.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.remove_product_from_product_set.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.remove_product_from_product_set.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @product_search_stub.call_rpc :remove_product_from_product_set, request, options: options, operation_callback: block
            end

            ##
            # Lists the Products in a ProductSet, in an unspecified order. If the
            # ProductSet does not exist, the products field of the response will be
            # empty.
            #
            # Possible errors:
            #
            # * Returns INVALID_ARGUMENT if page_size is greater than 100 or less than 1.
            #
            # @overload list_products_in_product_set(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::ListProductsInProductSetRequest | Hash]
            #     Lists the Products in a ProductSet, in an unspecified order. If the
            #     ProductSet does not exist, the products field of the response will be
            #     empty.
            #
            #     Possible errors:
            #
            #     * Returns INVALID_ARGUMENT if page_size is greater than 100 or less than 1.
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload list_products_in_product_set(name: nil, page_size: nil, page_token: nil)
            #   @param name [String]
            #     The ProductSet resource for which to retrieve Products.
            #
            #     Format is:
            #     `projects/PROJECT_ID/locations/LOC_ID/productSets/PRODUCT_SET_ID`
            #   @param page_size [Integer]
            #     The maximum number of items to return. Default 10, maximum 100.
            #   @param page_token [String]
            #     The next_page_token returned from a previous List request, if any.
            #
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Gapic::PagedEnumerable<Google::Cloud::Vision::V1::Product>]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Gapic::PagedEnumerable<Google::Cloud::Vision::V1::Product>]
            #
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def list_products_in_product_set request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::ListProductsInProductSetRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.list_products_in_product_set.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.list_products_in_product_set.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.list_products_in_product_set.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              wrap_paged_enum = ->(response) { Gapic::PagedEnumerable.new @product_search_stub, :list_products_in_product_set, request, response, options }

              @product_search_stub.call_rpc :list_products_in_product_set, request, options: options, operation_callback: block, format_response: wrap_paged_enum
            end

            ##
            # Asynchronous API that imports a list of reference images to specified
            # product sets based on a list of image information.
            #
            # The [google.longrunning.Operation][google.longrunning.Operation] API can be
            # used to keep track of the progress and results of the request.
            # `Operation.metadata` contains `BatchOperationMetadata`. (progress)
            # `Operation.response` contains `ImportProductSetsResponse`. (results)
            #
            # The input source of this method is a csv file on Google Cloud Storage.
            # For the format of the csv file please see
            # [ImportProductSetsGcsSource.csv_file_uri][google.cloud.vision.v1.ImportProductSetsGcsSource.csv_file_uri].
            #
            # @overload import_product_sets(request, options = nil)
            #   @param request [Google::Cloud::Vision::V1::ImportProductSetsRequest | Hash]
            #     Asynchronous API that imports a list of reference images to specified
            #     product sets based on a list of image information.
            #
            #     The [google.longrunning.Operation][google.longrunning.Operation] API can be
            #     used to keep track of the progress and results of the request.
            #     `Operation.metadata` contains `BatchOperationMetadata`. (progress)
            #     `Operation.response` contains `ImportProductSetsResponse`. (results)
            #
            #     The input source of this method is a csv file on Google Cloud Storage.
            #     For the format of the csv file please see
            #     [ImportProductSetsGcsSource.csv_file_uri][google.cloud.vision.v1.ImportProductSetsGcsSource.csv_file_uri].
            #   @param options [Gapic::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload import_product_sets(parent: nil, input_config: nil)
            #   @param parent [String]
            #     The project in which the ProductSets should be imported.
            #
            #     Format is `projects/PROJECT_ID/locations/LOC_ID`.
            #   @param input_config [Google::Cloud::Vision::V1::ImportProductSetsInputConfig | Hash]
            #     The input content for the list of requests.
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
            def import_product_sets request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Cloud::Vision::V1::ImportProductSetsRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.import_product_sets.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Vision::VERSION

              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.import_product_sets.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.import_product_sets.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              wrap_gax_operation = ->(response) { Gapic::Operation.new response, @operations_client }

              @product_search_stub.call_rpc :import_product_sets, request, options: options, operation_callback: block, format_response: wrap_gax_operation
            end

            class Configuration
              extend Gapic::Config

              config_attr :endpoint,     "vision.googleapis.com", String
              config_attr :credentials,  nil do |value|
                allowed = [::String, ::Hash, ::Proc, ::Google::Auth::Credentials, ::Signet::OAuth2::Client, nil]
                allowed += [::GRPC::Core::Channel, ::GRPC::Core::ChannelCredentials] if defined? ::GRPC
                allowed.any? { |klass| klass === value }
              end
              config_attr :scope,        nil,                                   String, Array, nil
              config_attr :lib_name,     nil,                                   String, nil
              config_attr :lib_version,  nil,                                   String, nil
              config_attr :channel_args, nil,                                   Hash, nil
              config_attr :interceptors, nil,                                   Array, nil
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
                attr_reader :create_product_set
                attr_reader :list_product_sets
                attr_reader :get_product_set
                attr_reader :update_product_set
                attr_reader :delete_product_set
                attr_reader :create_product
                attr_reader :list_products
                attr_reader :get_product
                attr_reader :update_product
                attr_reader :delete_product
                attr_reader :create_reference_image
                attr_reader :delete_reference_image
                attr_reader :list_reference_images
                attr_reader :get_reference_image
                attr_reader :add_product_to_product_set
                attr_reader :remove_product_from_product_set
                attr_reader :list_products_in_product_set
                attr_reader :import_product_sets

                def initialize parent_rpcs = nil
                  create_product_set_config = nil
                  create_product_set_config = parent_rpcs&.create_product_set if parent_rpcs&.respond_to? :create_product_set
                  @create_product_set = Gapic::Config::Method.new create_product_set_config
                  list_product_sets_config = nil
                  list_product_sets_config = parent_rpcs&.list_product_sets if parent_rpcs&.respond_to? :list_product_sets
                  @list_product_sets = Gapic::Config::Method.new list_product_sets_config
                  get_product_set_config = nil
                  get_product_set_config = parent_rpcs&.get_product_set if parent_rpcs&.respond_to? :get_product_set
                  @get_product_set = Gapic::Config::Method.new get_product_set_config
                  update_product_set_config = nil
                  update_product_set_config = parent_rpcs&.update_product_set if parent_rpcs&.respond_to? :update_product_set
                  @update_product_set = Gapic::Config::Method.new update_product_set_config
                  delete_product_set_config = nil
                  delete_product_set_config = parent_rpcs&.delete_product_set if parent_rpcs&.respond_to? :delete_product_set
                  @delete_product_set = Gapic::Config::Method.new delete_product_set_config
                  create_product_config = nil
                  create_product_config = parent_rpcs&.create_product if parent_rpcs&.respond_to? :create_product
                  @create_product = Gapic::Config::Method.new create_product_config
                  list_products_config = nil
                  list_products_config = parent_rpcs&.list_products if parent_rpcs&.respond_to? :list_products
                  @list_products = Gapic::Config::Method.new list_products_config
                  get_product_config = nil
                  get_product_config = parent_rpcs&.get_product if parent_rpcs&.respond_to? :get_product
                  @get_product = Gapic::Config::Method.new get_product_config
                  update_product_config = nil
                  update_product_config = parent_rpcs&.update_product if parent_rpcs&.respond_to? :update_product
                  @update_product = Gapic::Config::Method.new update_product_config
                  delete_product_config = nil
                  delete_product_config = parent_rpcs&.delete_product if parent_rpcs&.respond_to? :delete_product
                  @delete_product = Gapic::Config::Method.new delete_product_config
                  create_reference_image_config = nil
                  create_reference_image_config = parent_rpcs&.create_reference_image if parent_rpcs&.respond_to? :create_reference_image
                  @create_reference_image = Gapic::Config::Method.new create_reference_image_config
                  delete_reference_image_config = nil
                  delete_reference_image_config = parent_rpcs&.delete_reference_image if parent_rpcs&.respond_to? :delete_reference_image
                  @delete_reference_image = Gapic::Config::Method.new delete_reference_image_config
                  list_reference_images_config = nil
                  list_reference_images_config = parent_rpcs&.list_reference_images if parent_rpcs&.respond_to? :list_reference_images
                  @list_reference_images = Gapic::Config::Method.new list_reference_images_config
                  get_reference_image_config = nil
                  get_reference_image_config = parent_rpcs&.get_reference_image if parent_rpcs&.respond_to? :get_reference_image
                  @get_reference_image = Gapic::Config::Method.new get_reference_image_config
                  add_product_to_product_set_config = nil
                  add_product_to_product_set_config = parent_rpcs&.add_product_to_product_set if parent_rpcs&.respond_to? :add_product_to_product_set
                  @add_product_to_product_set = Gapic::Config::Method.new add_product_to_product_set_config
                  remove_product_from_product_set_config = nil
                  remove_product_from_product_set_config = parent_rpcs&.remove_product_from_product_set if parent_rpcs&.respond_to? :remove_product_from_product_set
                  @remove_product_from_product_set = Gapic::Config::Method.new remove_product_from_product_set_config
                  list_products_in_product_set_config = nil
                  list_products_in_product_set_config = parent_rpcs&.list_products_in_product_set if parent_rpcs&.respond_to? :list_products_in_product_set
                  @list_products_in_product_set = Gapic::Config::Method.new list_products_in_product_set_config
                  import_product_sets_config = nil
                  import_product_sets_config = parent_rpcs&.import_product_sets if parent_rpcs&.respond_to? :import_product_sets
                  @import_product_sets = Gapic::Config::Method.new import_product_sets_config

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
  require "google/cloud/vision/v1/product_search/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
