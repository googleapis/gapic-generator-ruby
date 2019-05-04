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
              require "google/cloud/vision/v1/product_search_service_services_pb"

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

              @product_search_stub = Google::Gax::Grpc::Stub.new(
                Google::Cloud::Vision::V1::ProductSearch::Stub,
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
            # Creates and returns a new ProductSet resource.
            #
            # Possible errors:
            #
            # * Returns INVALID_ARGUMENT if display_name is missing, or is longer than
            #   4096 characters.
            #
            # @overload create_product_set(request, options: nil)
            #   @param request [Google::Cloud::Vision::V1::CreateProductSetRequest | Hash]
            #     Creates and returns a new ProductSet resource.
            #
            #     Possible errors:
            #
            #     * Returns INVALID_ARGUMENT if display_name is missing, or is longer than
            #       4096 characters.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload create_product_set(parent: nil, product_set: nil, product_set_id: nil, options: nil)
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
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::ProductSet]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ProductSet]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def create_product_set request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::CreateProductSetRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @create_product_set ||= Google::Gax::ApiCall.new @product_search_stub.method :create_product_set

              @create_product_set.call request, options: options, operation_callback: block
            end

            ##
            # Lists ProductSets in an unspecified order.
            #
            # Possible errors:
            #
            # * Returns INVALID_ARGUMENT if page_size is greater than 100, or less
            #   than 1.
            #
            # @overload list_product_sets(request, options: nil)
            #   @param request [Google::Cloud::Vision::V1::ListProductSetsRequest | Hash]
            #     Lists ProductSets in an unspecified order.
            #
            #     Possible errors:
            #
            #     * Returns INVALID_ARGUMENT if page_size is greater than 100, or less
            #       than 1.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload list_product_sets(parent: nil, page_size: nil, page_token: nil, options: nil)
            #   @param parent [String]
            #     The project from which ProductSets should be listed.
            #
            #     Format is `projects/PROJECT_ID/locations/LOC_ID`.
            #   @param page_size [Integer]
            #     The maximum number of items to return. Default 10, maximum 100.
            #   @param page_token [String]
            #     The next_page_token returned from a previous List request, if any.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Gax::PagedEnumerable<Google::Cloud::Vision::V1::ProductSet>]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Gax::PagedEnumerable<Google::Cloud::Vision::V1::ProductSet>]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def list_product_sets request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::ListProductSetsRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @list_product_sets ||= Google::Gax::ApiCall.new @product_search_stub.method :list_product_sets

              wrap_paged_enum = ->(response) { Google::Gax::PagedEnumerable.new @list_product_sets, request, response, options }

              @list_product_sets.call request, options: options, operation_callback: block, format_response: wrap_paged_enum
            end

            ##
            # Gets information associated with a ProductSet.
            #
            # Possible errors:
            #
            # * Returns NOT_FOUND if the ProductSet does not exist.
            #
            # @overload get_product_set(request, options: nil)
            #   @param request [Google::Cloud::Vision::V1::GetProductSetRequest | Hash]
            #     Gets information associated with a ProductSet.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the ProductSet does not exist.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload get_product_set(name: nil, options: nil)
            #   @param name [String]
            #     Resource name of the ProductSet to get.
            #
            #     Format is:
            #     `projects/PROJECT_ID/locations/LOG_ID/productSets/PRODUCT_SET_ID`
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::ProductSet]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ProductSet]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def get_product_set request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::GetProductSetRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @get_product_set ||= Google::Gax::ApiCall.new @product_search_stub.method :get_product_set

              @get_product_set.call request, options: options, operation_callback: block
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
            # @overload update_product_set(request, options: nil)
            #   @param request [Google::Cloud::Vision::V1::UpdateProductSetRequest | Hash]
            #     Makes changes to a ProductSet resource.
            #     Only display_name can be updated currently.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the ProductSet does not exist.
            #     * Returns INVALID_ARGUMENT if display_name is present in update_mask but
            #       missing from the request or longer than 4096 characters.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload update_product_set(product_set: nil, update_mask: nil, options: nil)
            #   @param product_set [Google::Cloud::Vision::V1::ProductSet | Hash]
            #     The ProductSet resource which replaces the one on the server.
            #   @param update_mask [Google::Protobuf::FieldMask | Hash]
            #     The [FieldMask][google.protobuf.FieldMask] that specifies which fields to
            #     update.
            #     If update_mask isn't specified, all mutable fields are to be updated.
            #     Valid mask path is `display_name`.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::ProductSet]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ProductSet]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def update_product_set request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::UpdateProductSetRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "product_set.name" => request.product_set.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @update_product_set ||= Google::Gax::ApiCall.new @product_search_stub.method :update_product_set

              @update_product_set.call request, options: options, operation_callback: block
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
            # @overload delete_product_set(request, options: nil)
            #   @param request [Google::Cloud::Vision::V1::DeleteProductSetRequest | Hash]
            #     Permanently deletes a ProductSet. Products and ReferenceImages in the
            #     ProductSet are not deleted.
            #
            #     The actual image files are not deleted from Google Cloud Storage.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the ProductSet does not exist.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload delete_product_set(name: nil, options: nil)
            #   @param name [String]
            #     Resource name of the ProductSet to delete.
            #
            #     Format is:
            #     `projects/PROJECT_ID/locations/LOC_ID/productSets/PRODUCT_SET_ID`
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def delete_product_set request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::DeleteProductSetRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @delete_product_set ||= Google::Gax::ApiCall.new @product_search_stub.method :delete_product_set

              @delete_product_set.call request, options: options, operation_callback: block
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
            # @overload create_product(request, options: nil)
            #   @param request [Google::Cloud::Vision::V1::CreateProductRequest | Hash]
            #     Creates and returns a new product resource.
            #
            #     Possible errors:
            #
            #     * Returns INVALID_ARGUMENT if display_name is missing or longer than 4096
            #       characters.
            #     * Returns INVALID_ARGUMENT if description is longer than 4096 characters.
            #     * Returns INVALID_ARGUMENT if product_category is missing or invalid.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload create_product(parent: nil, product: nil, product_id: nil, options: nil)
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
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::Product]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::Product]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def create_product request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::CreateProductRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @create_product ||= Google::Gax::ApiCall.new @product_search_stub.method :create_product

              @create_product.call request, options: options, operation_callback: block
            end

            ##
            # Lists products in an unspecified order.
            #
            # Possible errors:
            #
            # * Returns INVALID_ARGUMENT if page_size is greater than 100 or less than 1.
            #
            # @overload list_products(request, options: nil)
            #   @param request [Google::Cloud::Vision::V1::ListProductsRequest | Hash]
            #     Lists products in an unspecified order.
            #
            #     Possible errors:
            #
            #     * Returns INVALID_ARGUMENT if page_size is greater than 100 or less than 1.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload list_products(parent: nil, page_size: nil, page_token: nil, options: nil)
            #   @param parent [String]
            #     The project OR ProductSet from which Products should be listed.
            #
            #     Format:
            #     `projects/PROJECT_ID/locations/LOC_ID`
            #   @param page_size [Integer]
            #     The maximum number of items to return. Default 10, maximum 100.
            #   @param page_token [String]
            #     The next_page_token returned from a previous List request, if any.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Gax::PagedEnumerable<Google::Cloud::Vision::V1::Product>]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Gax::PagedEnumerable<Google::Cloud::Vision::V1::Product>]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def list_products request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::ListProductsRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @list_products ||= Google::Gax::ApiCall.new @product_search_stub.method :list_products

              wrap_paged_enum = ->(response) { Google::Gax::PagedEnumerable.new @list_products, request, response, options }

              @list_products.call request, options: options, operation_callback: block, format_response: wrap_paged_enum
            end

            ##
            # Gets information associated with a Product.
            #
            # Possible errors:
            #
            # * Returns NOT_FOUND if the Product does not exist.
            #
            # @overload get_product(request, options: nil)
            #   @param request [Google::Cloud::Vision::V1::GetProductRequest | Hash]
            #     Gets information associated with a Product.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the Product does not exist.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload get_product(name: nil, options: nil)
            #   @param name [String]
            #     Resource name of the Product to get.
            #
            #     Format is:
            #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::Product]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::Product]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def get_product request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::GetProductRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @get_product ||= Google::Gax::ApiCall.new @product_search_stub.method :get_product

              @get_product.call request, options: options, operation_callback: block
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
            # @overload update_product(request, options: nil)
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
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload update_product(product: nil, update_mask: nil, options: nil)
            #   @param product [Google::Cloud::Vision::V1::Product | Hash]
            #     The Product resource which replaces the one on the server.
            #     product.name is immutable.
            #   @param update_mask [Google::Protobuf::FieldMask | Hash]
            #     The [FieldMask][google.protobuf.FieldMask] that specifies which fields
            #     to update.
            #     If update_mask isn't specified, all mutable fields are to be updated.
            #     Valid mask paths include `product_labels`, `display_name`, and
            #     `description`.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::Product]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::Product]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def update_product request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::UpdateProductRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "product.name" => request.product.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @update_product ||= Google::Gax::ApiCall.new @product_search_stub.method :update_product

              @update_product.call request, options: options, operation_callback: block
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
            # @overload delete_product(request, options: nil)
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
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload delete_product(name: nil, options: nil)
            #   @param name [String]
            #     Resource name of product to delete.
            #
            #     Format is:
            #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def delete_product request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::DeleteProductRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @delete_product ||= Google::Gax::ApiCall.new @product_search_stub.method :delete_product

              @delete_product.call request, options: options, operation_callback: block
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
            # @overload create_reference_image(request, options: nil)
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
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload create_reference_image(parent: nil, reference_image: nil, reference_image_id: nil, options: nil)
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
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::ReferenceImage]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ReferenceImage]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def create_reference_image request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::CreateReferenceImageRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @create_reference_image ||= Google::Gax::ApiCall.new @product_search_stub.method :create_reference_image

              @create_reference_image.call request, options: options, operation_callback: block
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
            # @overload delete_reference_image(request, options: nil)
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
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload delete_reference_image(name: nil, options: nil)
            #   @param name [String]
            #     The resource name of the reference image to delete.
            #
            #     Format is:
            #
            #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID/referenceImages/IMAGE_ID`
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def delete_reference_image request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::DeleteReferenceImageRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @delete_reference_image ||= Google::Gax::ApiCall.new @product_search_stub.method :delete_reference_image

              @delete_reference_image.call request, options: options, operation_callback: block
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
            # @overload list_reference_images(request, options: nil)
            #   @param request [Google::Cloud::Vision::V1::ListReferenceImagesRequest | Hash]
            #     Lists reference images.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the parent product does not exist.
            #     * Returns INVALID_ARGUMENT if the page_size is greater than 100, or less
            #       than 1.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload list_reference_images(parent: nil, page_size: nil, page_token: nil, options: nil)
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
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Gax::PagedEnumerable<Google::Cloud::Vision::V1::ReferenceImage>]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Gax::PagedEnumerable<Google::Cloud::Vision::V1::ReferenceImage>]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def list_reference_images request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::ListReferenceImagesRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @list_reference_images ||= Google::Gax::ApiCall.new @product_search_stub.method :list_reference_images

              wrap_paged_enum = ->(response) { Google::Gax::PagedEnumerable.new @list_reference_images, request, response, options }

              @list_reference_images.call request, options: options, operation_callback: block, format_response: wrap_paged_enum
            end

            ##
            # Gets information associated with a ReferenceImage.
            #
            # Possible errors:
            #
            # * Returns NOT_FOUND if the specified image does not exist.
            #
            # @overload get_reference_image(request, options: nil)
            #   @param request [Google::Cloud::Vision::V1::GetReferenceImageRequest | Hash]
            #     Gets information associated with a ReferenceImage.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the specified image does not exist.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload get_reference_image(name: nil, options: nil)
            #   @param name [String]
            #     The resource name of the ReferenceImage to get.
            #
            #     Format is:
            #
            #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID/referenceImages/IMAGE_ID`.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Cloud::Vision::V1::ReferenceImage]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ReferenceImage]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def get_reference_image request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::GetReferenceImageRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @get_reference_image ||= Google::Gax::ApiCall.new @product_search_stub.method :get_reference_image

              @get_reference_image.call request, options: options, operation_callback: block
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
            # @overload add_product_to_product_set(request, options: nil)
            #   @param request [Google::Cloud::Vision::V1::AddProductToProductSetRequest | Hash]
            #     Adds a Product to the specified ProductSet. If the Product is already
            #     present, no change is made.
            #
            #     One Product can be added to at most 100 ProductSets.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND if the Product or the ProductSet doesn't exist.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload add_product_to_product_set(name: nil, product: nil, options: nil)
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
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def add_product_to_product_set request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::AddProductToProductSetRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @add_product_to_product_set ||= Google::Gax::ApiCall.new @product_search_stub.method :add_product_to_product_set

              @add_product_to_product_set.call request, options: options, operation_callback: block
            end

            ##
            # Removes a Product from the specified ProductSet.
            #
            # Possible errors:
            #
            # * Returns NOT_FOUND If the Product is not found under the ProductSet.
            #
            # @overload remove_product_from_product_set(request, options: nil)
            #   @param request [Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest | Hash]
            #     Removes a Product from the specified ProductSet.
            #
            #     Possible errors:
            #
            #     * Returns NOT_FOUND If the Product is not found under the ProductSet.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload remove_product_from_product_set(name: nil, product: nil, options: nil)
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
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def remove_product_from_product_set request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @remove_product_from_product_set ||= Google::Gax::ApiCall.new @product_search_stub.method :remove_product_from_product_set

              @remove_product_from_product_set.call request, options: options, operation_callback: block
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
            # @overload list_products_in_product_set(request, options: nil)
            #   @param request [Google::Cloud::Vision::V1::ListProductsInProductSetRequest | Hash]
            #     Lists the Products in a ProductSet, in an unspecified order. If the
            #     ProductSet does not exist, the products field of the response will be
            #     empty.
            #
            #     Possible errors:
            #
            #     * Returns INVALID_ARGUMENT if page_size is greater than 100 or less than 1.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload list_products_in_product_set(name: nil, page_size: nil, page_token: nil, options: nil)
            #   @param name [String]
            #     The ProductSet resource for which to retrieve Products.
            #
            #     Format is:
            #     `projects/PROJECT_ID/locations/LOC_ID/productSets/PRODUCT_SET_ID`
            #   @param page_size [Integer]
            #     The maximum number of items to return. Default 10, maximum 100.
            #   @param page_token [String]
            #     The next_page_token returned from a previous List request, if any.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Gax::PagedEnumerable<Google::Cloud::Vision::V1::Product>]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Gax::PagedEnumerable<Google::Cloud::Vision::V1::Product>]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def list_products_in_product_set request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::ListProductsInProductSetRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @list_products_in_product_set ||= Google::Gax::ApiCall.new @product_search_stub.method :list_products_in_product_set

              wrap_paged_enum = ->(response) { Google::Gax::PagedEnumerable.new @list_products_in_product_set, request, response, options }

              @list_products_in_product_set.call request, options: options, operation_callback: block, format_response: wrap_paged_enum
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
            # @overload import_product_sets(request, options: nil)
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
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload import_product_sets(parent: nil, input_config: nil, options: nil)
            #   @param parent [String]
            #     The project in which the ProductSets should be imported.
            #
            #     Format is `projects/PROJECT_ID/locations/LOC_ID`.
            #   @param input_config [Google::Cloud::Vision::V1::ImportProductSetsInputConfig | Hash]
            #     The input content for the list of requests.
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
            def import_product_sets request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Cloud::Vision::V1::ImportProductSetsRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              header_params = {
                "parent" => request.parent
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata = @metadata.merge "x-goog-request-params" => request_params_header
              options.apply_defaults timeout: @timeout, metadata: metadata

              @import_product_sets ||= Google::Gax::ApiCall.new @product_search_stub.method :import_product_sets

              wrap_gax_operation = ->(response) { Google::Gax::Operation.new response, @operations_client }

              @import_product_sets.call request, options: options, operation_callback: block, format_response: wrap_gax_operation
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
