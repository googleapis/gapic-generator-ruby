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

require "google/cloud/product_search/v1/cloud_product_search_pb"
require "google/cloud/product_search/v1/credentials"

module Google
  module Cloud
    module Vision
      module V1
        ##
        # Manages Products and ProductSets of reference images for use in product
        # search. It uses the following resource model:
        #
        # - The API has a collection of [ProductSet][google.cloud.vision.v1.ProductSet]
        # resources, named `projects/*/locations/*/productSets/*`, which acts as a way
        # to put different products into groups to limit identification.
        #
        # In parallel,
        #
        # - The API has a collection of [Product][google.cloud.vision.v1.Product]
        # resources, named
        #   `projects/*/locations/*/products/*`
        #
        # - Each [Product][google.cloud.vision.v1.Product] has a collection of
        # [ReferenceImage][google.cloud.vision.v1.ReferenceImage] resources, named
        #   `projects/*/locations/*/products/*/referenceImages/*`
        class ProductSearchClient
          # @private
          attr_reader :product_search_stub

          # The default address of the service.
          SERVICE_ADDRESS = "product_search.googleapis.com"

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
            SERVICE_ADDRESS = ProductSearchClient::SERVICE_ADDRESS
            GRPC_INTERCEPTORS = ProductSearchClient::GRPC_INTERCEPTORS.dup
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
            require "google/cloud/product_search/v1/cloud_product_search_services_pb"
            credentials ||= Google::Cloud::ProductSearch::V1::Credentials.default

            @operations_client = OperationsClient.new(
              credentials: credentials,
              scopes: scopes,
              client_config: client_config,
              timeout: timeout,
              lib_name: lib_name,
              lib_version: lib_version
            )
            @product_search_stub = create_stub credentials, scopes

            defaults = default_settings client_config, timeout, metadata, lib_name, lib_version

            @create_product_set = Google::Gax.create_api_call(
              @product_search_stub.method(:create_product_set),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @list_product_sets = Google::Gax.create_api_call(
              @product_search_stub.method(:list_product_sets),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @get_product_set = Google::Gax.create_api_call(
              @product_search_stub.method(:get_product_set),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @update_product_set = Google::Gax.create_api_call(
              @product_search_stub.method(:update_product_set),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @delete_product_set = Google::Gax.create_api_call(
              @product_search_stub.method(:delete_product_set),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @create_product = Google::Gax.create_api_call(
              @product_search_stub.method(:create_product),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @list_products = Google::Gax.create_api_call(
              @product_search_stub.method(:list_products),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @get_product = Google::Gax.create_api_call(
              @product_search_stub.method(:get_product),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @update_product = Google::Gax.create_api_call(
              @product_search_stub.method(:update_product),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @delete_product = Google::Gax.create_api_call(
              @product_search_stub.method(:delete_product),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @create_reference_image = Google::Gax.create_api_call(
              @product_search_stub.method(:create_reference_image),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @delete_reference_image = Google::Gax.create_api_call(
              @product_search_stub.method(:delete_reference_image),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @list_reference_images = Google::Gax.create_api_call(
              @product_search_stub.method(:list_reference_images),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @get_reference_image = Google::Gax.create_api_call(
              @product_search_stub.method(:get_reference_image),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @add_product_to_product_set = Google::Gax.create_api_call(
              @product_search_stub.method(:add_product_to_product_set),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @remove_product_from_product_set = Google::Gax.create_api_call(
              @product_search_stub.method(:remove_product_from_product_set),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @list_products_in_product_set = Google::Gax.create_api_call(
              @product_search_stub.method(:list_products_in_product_set),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
            @import_product_sets = Google::Gax.create_api_call(
              @product_search_stub.method(:import_product_sets),
              CallSettings.new,
              exception_transformer: exception_transformer
            )
          end

          # Service calls

          ##
          #  Creates and returns a new ProductSet resource.
          #
          #  Possible errors:
          #
          #  * Returns INVALID_ARGUMENT if display_name is missing, or is longer than
          #    4096 characters.
          def create_product_set \
              parent,
              product_set,
              product_set_id,
              options: nil,
              &block
            request = {
              parent: parent,
              product_set: product_set,
              product_set_id: product_set_id
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::CreateProductSetRequest
            @create_product_set.call(request, options, &block)
          end

          ##
          #  Lists ProductSets in an unspecified order.
          #
          #  Possible errors:
          #
          #  * Returns INVALID_ARGUMENT if page_size is greater than 100, or less
          #    than 1.
          def list_product_sets \
              parent,
              page_size,
              page_token,
              options: nil,
              &block
            request = {
              parent: parent,
              page_size: page_size,
              page_token: page_token
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::ListProductSetsRequest
            @list_product_sets.call(request, options, &block)
          end

          ##
          #  Gets information associated with a ProductSet.
          #
          #  Possible errors:
          #
          #  * Returns NOT_FOUND if the ProductSet does not exist.
          def get_product_set \
              name,
              options: nil,
              &block
            request = {
              name: name
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::GetProductSetRequest
            @get_product_set.call(request, options, &block)
          end

          ##
          #  Makes changes to a ProductSet resource.
          #  Only display_name can be updated currently.
          #
          #  Possible errors:
          #
          #  * Returns NOT_FOUND if the ProductSet does not exist.
          #  * Returns INVALID_ARGUMENT if display_name is present in update_mask but
          #    missing from the request or longer than 4096 characters.
          def update_product_set \
              product_set,
              update_mask,
              options: nil,
              &block
            request = {
              product_set: product_set,
              update_mask: update_mask
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::UpdateProductSetRequest
            @update_product_set.call(request, options, &block)
          end

          ##
          #  Permanently deletes a ProductSet. Products and ReferenceImages in the
          #  ProductSet are not deleted.
          #
          #  The actual image files are not deleted from Google Cloud Storage.
          #
          #  Possible errors:
          #
          #  * Returns NOT_FOUND if the ProductSet does not exist.
          def delete_product_set \
              name,
              options: nil,
              &block
            request = {
              name: name
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::DeleteProductSetRequest
            @delete_product_set.call(request, options, &block)
          end

          ##
          #  Creates and returns a new product resource.
          #
          #  Possible errors:
          #
          #  * Returns INVALID_ARGUMENT if display_name is missing or longer than 4096
          #    characters.
          #  * Returns INVALID_ARGUMENT if description is longer than 4096 characters.
          #  * Returns INVALID_ARGUMENT if product_category is missing or invalid.
          def create_product \
              parent,
              product,
              product_id,
              options: nil,
              &block
            request = {
              parent: parent,
              product: product,
              product_id: product_id
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::CreateProductRequest
            @create_product.call(request, options, &block)
          end

          ##
          #  Lists products in an unspecified order.
          #
          #  Possible errors:
          #
          #  * Returns INVALID_ARGUMENT if page_size is greater than 100 or less than 1.
          def list_products \
              parent,
              page_size,
              page_token,
              options: nil,
              &block
            request = {
              parent: parent,
              page_size: page_size,
              page_token: page_token
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::ListProductsRequest
            @list_products.call(request, options, &block)
          end

          ##
          #  Gets information associated with a Product.
          #
          #  Possible errors:
          #
          #  * Returns NOT_FOUND if the Product does not exist.
          def get_product \
              name,
              options: nil,
              &block
            request = {
              name: name
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::GetProductRequest
            @get_product.call(request, options, &block)
          end

          ##
          #  Makes changes to a Product resource.
          #  Only the `display_name`, `description`, and `labels` fields can be updated
          #  right now.
          #
          #  If labels are updated, the change will not be reflected in queries until
          #  the next index time.
          #
          #  Possible errors:
          #
          #  * Returns NOT_FOUND if the Product does not exist.
          #  * Returns INVALID_ARGUMENT if display_name is present in update_mask but is
          #    missing from the request or longer than 4096 characters.
          #  * Returns INVALID_ARGUMENT if description is present in update_mask but is
          #    longer than 4096 characters.
          #  * Returns INVALID_ARGUMENT if product_category is present in update_mask.
          def update_product \
              product,
              update_mask,
              options: nil,
              &block
            request = {
              product: product,
              update_mask: update_mask
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::UpdateProductRequest
            @update_product.call(request, options, &block)
          end

          ##
          #  Permanently deletes a product and its reference images.
          #
          #  Metadata of the product and all its images will be deleted right away, but
          #  search queries against ProductSets containing the product may still work
          #  until all related caches are refreshed.
          #
          #  Possible errors:
          #
          #  * Returns NOT_FOUND if the product does not exist.
          def delete_product \
              name,
              options: nil,
              &block
            request = {
              name: name
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::DeleteProductRequest
            @delete_product.call(request, options, &block)
          end

          ##
          #  Creates and returns a new ReferenceImage resource.
          #
          #  The `bounding_poly` field is optional. If `bounding_poly` is not specified,
          #  the system will try to detect regions of interest in the image that are
          #  compatible with the product_category on the parent product. If it is
          #  specified, detection is ALWAYS skipped. The system converts polygons into
          #  non-rotated rectangles.
          #
          #  Note that the pipeline will resize the image if the image resolution is too
          #  large to process (above 50MP).
          #
          #  Possible errors:
          #
          #  * Returns INVALID_ARGUMENT if the image_uri is missing or longer than 4096
          #    characters.
          #  * Returns INVALID_ARGUMENT if the product does not exist.
          #  * Returns INVALID_ARGUMENT if bounding_poly is not provided, and nothing
          #    compatible with the parent product's product_category is detected.
          #  * Returns INVALID_ARGUMENT if bounding_poly contains more than 10 polygons.
          def create_reference_image \
              parent,
              reference_image,
              reference_image_id,
              options: nil,
              &block
            request = {
              parent: parent,
              reference_image: reference_image,
              reference_image_id: reference_image_id
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::CreateReferenceImageRequest
            @create_reference_image.call(request, options, &block)
          end

          ##
          #  Permanently deletes a reference image.
          #
          #  The image metadata will be deleted right away, but search queries
          #  against ProductSets containing the image may still work until all related
          #  caches are refreshed.
          #
          #  The actual image files are not deleted from Google Cloud Storage.
          #
          #  Possible errors:
          #
          #  * Returns NOT_FOUND if the reference image does not exist.
          def delete_reference_image \
              name,
              options: nil,
              &block
            request = {
              name: name
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::DeleteReferenceImageRequest
            @delete_reference_image.call(request, options, &block)
          end

          ##
          #  Lists reference images.
          #
          #  Possible errors:
          #
          #  * Returns NOT_FOUND if the parent product does not exist.
          #  * Returns INVALID_ARGUMENT if the page_size is greater than 100, or less
          #    than 1.
          def list_reference_images \
              parent,
              page_size,
              page_token,
              options: nil,
              &block
            request = {
              parent: parent,
              page_size: page_size,
              page_token: page_token
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::ListReferenceImagesRequest
            @list_reference_images.call(request, options, &block)
          end

          ##
          #  Gets information associated with a ReferenceImage.
          #
          #  Possible errors:
          #
          #  * Returns NOT_FOUND if the specified image does not exist.
          def get_reference_image \
              name,
              options: nil,
              &block
            request = {
              name: name
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::GetReferenceImageRequest
            @get_reference_image.call(request, options, &block)
          end

          ##
          #  Adds a Product to the specified ProductSet. If the Product is already
          #  present, no change is made.
          #
          #  One Product can be added to at most 100 ProductSets.
          #
          #  Possible errors:
          #
          #  * Returns NOT_FOUND if the Product or the ProductSet doesn't exist.
          def add_product_to_product_set \
              name,
              product,
              options: nil,
              &block
            request = {
              name: name,
              product: product
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::AddProductToProductSetRequest
            @add_product_to_product_set.call(request, options, &block)
          end

          ##
          #  Removes a Product from the specified ProductSet.
          #
          #  Possible errors:
          #
          #  * Returns NOT_FOUND If the Product is not found under the ProductSet.
          def remove_product_from_product_set \
              name,
              product,
              options: nil,
              &block
            request = {
              name: name,
              product: product
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest
            @remove_product_from_product_set.call(request, options, &block)
          end

          ##
          #  Lists the Products in a ProductSet, in an unspecified order. If the
          #  ProductSet does not exist, the products field of the response will be
          #  empty.
          #
          #  Possible errors:
          #
          #  * Returns INVALID_ARGUMENT if page_size is greater than 100 or less than 1.
          def list_products_in_product_set \
              name,
              page_size,
              page_token,
              options: nil,
              &block
            request = {
              name: name,
              page_size: page_size,
              page_token: page_token
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::ListProductsInProductSetRequest
            @list_products_in_product_set.call(request, options, &block)
          end

          ##
          #  Asynchronous API that imports a list of reference images to specified
          #  product sets based on a list of image information.
          #
          #  The [google.longrunning.Operation][google.longrunning.Operation] API can be
          #  used to keep track of the progress and results of the request.
          #  `Operation.metadata` contains `BatchOperationMetadata`. (progress)
          #  `Operation.response` contains `ImportProductSetsResponse`. (results)
          #
          #  The input source of this method is a csv file on Google Cloud Storage.
          #  For the format of the csv file please see
          #  [ImportProductSetsGcsSource.csv_file_uri][google.cloud.vision.v1.ImportProductSetsGcsSource.csv_file_uri].
          def import_product_sets \
              parent,
              input_config,
              options: nil,
              &block
            request = {
              parent: parent,
              input_config: input_config
            }.delete_if { |_, v| v.nil? }
            request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::ImportProductSetsRequest
            @import_product_sets.call(request, options, &block)
          end

          protected

          def create_stub credentials, scopes
            if credentials.is_a?(String) || credentials.is_a?(Hash)
              updater_proc = Google::Cloud::ProductSearch::V1::Credentials.new(credentials).updater_proc
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
            stub_new = Google::Cloud::Vision::V1::ProductSearch::Stub.method :new
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
            package_version = Gem.loaded_specs["google-cloud-product_search"].version.version

            google_api_client = ["gl-ruby/#{RUBY_VERSION}"]
            google_api_client << " #{lib_name}/#{lib_version}" if lib_name
            google_api_client << " gapic/#{package_version} gax/#{Google::Gax::VERSION}"
            google_api_client << " grpc/#{GRPC::VERSION}"
            google_api_client.join

            headers = { "x-goog-api-client": google_api_client }
            headers.merge! metadata unless metadata.nil?
            client_config_file = Pathname.new(__dir__).join(
              "product_search_client_config.json"
            )
            client_config_file.open do |f|
              Google::Gax.construct_settings(
                "google.cloud.product_search.v1.ProductSearch",
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
