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

raise "This file is for documentation purposes only."

module Google
  module Cloud
    module Vision
      module V1
        # A Product contains ReferenceImages.
        # @!attribute [rw] name
        #   @return [String]
        #     The resource name of the product.
        #
        #     Format is:
        #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`.
        #
        #     This field is ignored when creating a product.
        # @!attribute [rw] display_name
        #   @return [String]
        #     The user-provided name for this Product. Must not be empty. Must be at most
        #     4096 characters long.
        # @!attribute [rw] description
        #   @return [String]
        #     User-provided metadata to be stored with this product. Must be at most 4096
        #     characters long.
        # @!attribute [rw] product_category
        #   @return [String]
        #     The category for the product identified by the reference image. This should
        #     be either "homegoods", "apparel", or "toys".
        #
        #     This field is immutable.
        # @!attribute [rw] product_labels
        #   @return [Google::Cloud::Vision::V1::Product::KeyValue]
        #     Key-value pairs that can be attached to a product. At query time,
        #     constraints can be specified based on the product_labels.
        #
        #     Note that integer values can be provided as strings, e.g. "1199". Only
        #     strings with integer values can match a range-based restriction which is
        #     to be supported soon.
        #
        #     Multiple values can be assigned to the same key. One product may have up to
        #     100 product_labels.
        class Product
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods

          # A product label represented as a key-value pair.
          # @!attribute [rw] key
          #   @return [String]
          #     The key of the label attached to the product. Cannot be empty and cannot
          #     exceed 128 bytes.
          # @!attribute [rw] value
          #   @return [String]
          #     The value of the label attached to the product. Cannot be empty and
          #     cannot exceed 128 bytes.
          class KeyValue
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end
        end

        # A ProductSet contains Products. A ProductSet can contain a maximum of 1
        # million reference images. If the limit is exceeded, periodic indexing will
        # fail.
        # @!attribute [rw] name
        #   @return [String]
        #     The resource name of the ProductSet.
        #
        #     Format is:
        #     `projects/PROJECT_ID/locations/LOC_ID/productSets/PRODUCT_SET_ID`.
        #
        #     This field is ignored when creating a ProductSet.
        # @!attribute [rw] display_name
        #   @return [String]
        #     The user-provided name for this ProductSet. Must not be empty. Must be at
        #     most 4096 characters long.
        # @!attribute [rw] index_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. The time at which this ProductSet was last indexed. Query
        #     results will reflect all updates before this time. If this ProductSet has
        #     never been indexed, this field is 0.
        #
        #     This field is ignored when creating a ProductSet.
        # @!attribute [rw] index_error
        #   @return [Google::Rpc::Status]
        #     Output only. If there was an error with indexing the product set, the field
        #     is populated.
        #
        #     This field is ignored when creating a ProductSet.
        class ProductSet
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # A `ReferenceImage` represents a product image and its associated metadata,
        # such as bounding boxes.
        # @!attribute [rw] name
        #   @return [String]
        #     The resource name of the reference image.
        #
        #     Format is:
        #
        #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID/referenceImages/IMAGE_ID`.
        #
        #     This field is ignored when creating a reference image.
        # @!attribute [rw] uri
        #   @return [String]
        #     The Google Cloud Storage URI of the reference image.
        #
        #     The URI must start with `gs://`.
        #
        #     Required.
        # @!attribute [rw] bounding_polys
        #   @return [Google::Cloud::Vision::V1::BoundingPoly]
        #     Bounding polygons around the areas of interest in the reference image.
        #     Optional. If this field is empty, the system will try to detect regions of
        #     interest. At most 10 bounding polygons will be used.
        #
        #     The provided shape is converted into a non-rotated rectangle. Once
        #     converted, the small edge of the rectangle must be greater than or equal
        #     to 300 pixels. The aspect ratio must be 1:4 or less (i.e. 1:3 is ok; 1:5
        #     is not).
        class ReferenceImage
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `CreateProduct` method.
        # @!attribute [rw] parent
        #   @return [String]
        #     The project in which the Product should be created.
        #
        #     Format is
        #     `projects/PROJECT_ID/locations/LOC_ID`.
        # @!attribute [rw] product
        #   @return [Google::Cloud::Vision::V1::Product]
        #     The product to create.
        # @!attribute [rw] product_id
        #   @return [String]
        #     A user-supplied resource id for this Product. If set, the server will
        #     attempt to use this value as the resource id. If it is already in use, an
        #     error is returned with code ALREADY_EXISTS. Must be at most 128 characters
        #     long. It cannot contain the character `/`.
        class CreateProductRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `ListProducts` method.
        # @!attribute [rw] parent
        #   @return [String]
        #     The project OR ProductSet from which Products should be listed.
        #
        #     Format:
        #     `projects/PROJECT_ID/locations/LOC_ID`
        # @!attribute [rw] page_size
        #   @return [Integer]
        #     The maximum number of items to return. Default 10, maximum 100.
        # @!attribute [rw] page_token
        #   @return [String]
        #     The next_page_token returned from a previous List request, if any.
        class ListProductsRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Response message for the `ListProducts` method.
        # @!attribute [rw] products
        #   @return [Google::Cloud::Vision::V1::Product]
        #     List of products.
        # @!attribute [rw] next_page_token
        #   @return [String]
        #     Token to retrieve the next page of results, or empty if there are no more
        #     results in the list.
        class ListProductsResponse
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `GetProduct` method.
        # @!attribute [rw] name
        #   @return [String]
        #     Resource name of the Product to get.
        #
        #     Format is:
        #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`
        class GetProductRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `UpdateProduct` method.
        # @!attribute [rw] product
        #   @return [Google::Cloud::Vision::V1::Product]
        #     The Product resource which replaces the one on the server.
        #     product.name is immutable.
        # @!attribute [rw] update_mask
        #   @return [Google::Protobuf::FieldMask]
        #     The [FieldMask][google.protobuf.FieldMask] that specifies which fields
        #     to update.
        #     If update_mask isn't specified, all mutable fields are to be updated.
        #     Valid mask paths include `product_labels`, `display_name`, and
        #     `description`.
        class UpdateProductRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `DeleteProduct` method.
        # @!attribute [rw] name
        #   @return [String]
        #     Resource name of product to delete.
        #
        #     Format is:
        #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`
        class DeleteProductRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `CreateProductSet` method.
        # @!attribute [rw] parent
        #   @return [String]
        #     The project in which the ProductSet should be created.
        #
        #     Format is `projects/PROJECT_ID/locations/LOC_ID`.
        # @!attribute [rw] product_set
        #   @return [Google::Cloud::Vision::V1::ProductSet]
        #     The ProductSet to create.
        # @!attribute [rw] product_set_id
        #   @return [String]
        #     A user-supplied resource id for this ProductSet. If set, the server will
        #     attempt to use this value as the resource id. If it is already in use, an
        #     error is returned with code ALREADY_EXISTS. Must be at most 128 characters
        #     long. It cannot contain the character `/`.
        class CreateProductSetRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `ListProductSets` method.
        # @!attribute [rw] parent
        #   @return [String]
        #     The project from which ProductSets should be listed.
        #
        #     Format is `projects/PROJECT_ID/locations/LOC_ID`.
        # @!attribute [rw] page_size
        #   @return [Integer]
        #     The maximum number of items to return. Default 10, maximum 100.
        # @!attribute [rw] page_token
        #   @return [String]
        #     The next_page_token returned from a previous List request, if any.
        class ListProductSetsRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Response message for the `ListProductSets` method.
        # @!attribute [rw] product_sets
        #   @return [Google::Cloud::Vision::V1::ProductSet]
        #     List of ProductSets.
        # @!attribute [rw] next_page_token
        #   @return [String]
        #     Token to retrieve the next page of results, or empty if there are no more
        #     results in the list.
        class ListProductSetsResponse
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `GetProductSet` method.
        # @!attribute [rw] name
        #   @return [String]
        #     Resource name of the ProductSet to get.
        #
        #     Format is:
        #     `projects/PROJECT_ID/locations/LOG_ID/productSets/PRODUCT_SET_ID`
        class GetProductSetRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `UpdateProductSet` method.
        # @!attribute [rw] product_set
        #   @return [Google::Cloud::Vision::V1::ProductSet]
        #     The ProductSet resource which replaces the one on the server.
        # @!attribute [rw] update_mask
        #   @return [Google::Protobuf::FieldMask]
        #     The [FieldMask][google.protobuf.FieldMask] that specifies which fields to
        #     update.
        #     If update_mask isn't specified, all mutable fields are to be updated.
        #     Valid mask path is `display_name`.
        class UpdateProductSetRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `DeleteProductSet` method.
        # @!attribute [rw] name
        #   @return [String]
        #     Resource name of the ProductSet to delete.
        #
        #     Format is:
        #     `projects/PROJECT_ID/locations/LOC_ID/productSets/PRODUCT_SET_ID`
        class DeleteProductSetRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `CreateReferenceImage` method.
        # @!attribute [rw] parent
        #   @return [String]
        #     Resource name of the product in which to create the reference image.
        #
        #     Format is
        #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`.
        # @!attribute [rw] reference_image
        #   @return [Google::Cloud::Vision::V1::ReferenceImage]
        #     The reference image to create.
        #     If an image ID is specified, it is ignored.
        # @!attribute [rw] reference_image_id
        #   @return [String]
        #     A user-supplied resource id for the ReferenceImage to be added. If set,
        #     the server will attempt to use this value as the resource id. If it is
        #     already in use, an error is returned with code ALREADY_EXISTS. Must be at
        #     most 128 characters long. It cannot contain the character `/`.
        class CreateReferenceImageRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `ListReferenceImages` method.
        # @!attribute [rw] parent
        #   @return [String]
        #     Resource name of the product containing the reference images.
        #
        #     Format is
        #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`.
        # @!attribute [rw] page_size
        #   @return [Integer]
        #     The maximum number of items to return. Default 10, maximum 100.
        # @!attribute [rw] page_token
        #   @return [String]
        #     A token identifying a page of results to be returned. This is the value
        #     of `nextPageToken` returned in a previous reference image list request.
        #
        #     Defaults to the first page if not specified.
        class ListReferenceImagesRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Response message for the `ListReferenceImages` method.
        # @!attribute [rw] reference_images
        #   @return [Google::Cloud::Vision::V1::ReferenceImage]
        #     The list of reference images.
        # @!attribute [rw] page_size
        #   @return [Integer]
        #     The maximum number of items to return. Default 10, maximum 100.
        # @!attribute [rw] next_page_token
        #   @return [String]
        #     The next_page_token returned from a previous List request, if any.
        class ListReferenceImagesResponse
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `GetReferenceImage` method.
        # @!attribute [rw] name
        #   @return [String]
        #     The resource name of the ReferenceImage to get.
        #
        #     Format is:
        #
        #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID/referenceImages/IMAGE_ID`.
        class GetReferenceImageRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `DeleteReferenceImage` method.
        # @!attribute [rw] name
        #   @return [String]
        #     The resource name of the reference image to delete.
        #
        #     Format is:
        #
        #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID/referenceImages/IMAGE_ID`
        class DeleteReferenceImageRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `AddProductToProductSet` method.
        # @!attribute [rw] name
        #   @return [String]
        #     The resource name for the ProductSet to modify.
        #
        #     Format is:
        #     `projects/PROJECT_ID/locations/LOC_ID/productSets/PRODUCT_SET_ID`
        # @!attribute [rw] product
        #   @return [String]
        #     The resource name for the Product to be added to this ProductSet.
        #
        #     Format is:
        #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`
        class AddProductToProductSetRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `RemoveProductFromProductSet` method.
        # @!attribute [rw] name
        #   @return [String]
        #     The resource name for the ProductSet to modify.
        #
        #     Format is:
        #     `projects/PROJECT_ID/locations/LOC_ID/productSets/PRODUCT_SET_ID`
        # @!attribute [rw] product
        #   @return [String]
        #     The resource name for the Product to be removed from this ProductSet.
        #
        #     Format is:
        #     `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`
        class RemoveProductFromProductSetRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `ListProductsInProductSet` method.
        # @!attribute [rw] name
        #   @return [String]
        #     The ProductSet resource for which to retrieve Products.
        #
        #     Format is:
        #     `projects/PROJECT_ID/locations/LOC_ID/productSets/PRODUCT_SET_ID`
        # @!attribute [rw] page_size
        #   @return [Integer]
        #     The maximum number of items to return. Default 10, maximum 100.
        # @!attribute [rw] page_token
        #   @return [String]
        #     The next_page_token returned from a previous List request, if any.
        class ListProductsInProductSetRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Response message for the `ListProductsInProductSet` method.
        # @!attribute [rw] products
        #   @return [Google::Cloud::Vision::V1::Product]
        #     The list of Products.
        # @!attribute [rw] next_page_token
        #   @return [String]
        #     Token to retrieve the next page of results, or empty if there are no more
        #     results in the list.
        class ListProductsInProductSetResponse
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # The Google Cloud Storage location for a csv file which preserves a list of
        # ImportProductSetRequests in each line.
        # @!attribute [rw] csv_file_uri
        #   @return [String]
        #     The Google Cloud Storage URI of the input csv file.
        #
        #     The URI must start with `gs://`.
        #
        #     The format of the input csv file should be one image per line.
        #     In each line, there are 8 columns.
        #
        #     1.  image-uri
        #     2.  image-id
        #     3.  product-set-id
        #     4.  product-id
        #     5.  product-category
        #     6.  product-display-name
        #     7.  labels
        #     8.  bounding-poly
        #
        #     The `image-uri`, `product-set-id`, `product-id`, and `product-category`
        #     columns are required. All other columns are optional.
        #
        #     If the `ProductSet` or `Product` specified by the `product-set-id` and
        #     `product-id` values does not exist, then the system will create a new
        #     `ProductSet` or `Product` for the image. In this case, the
        #     `product-display-name` column refers to
        #     [display_name][google.cloud.vision.v1.Product.display_name], the
        #     `product-category` column refers to
        #     [product_category][google.cloud.vision.v1.Product.product_category], and
        #     the `labels` column refers to
        #     [product_labels][google.cloud.vision.v1.Product.product_labels].
        #
        #     The `image-id` column is optional but must be unique if provided. If it is
        #     empty, the system will automatically assign a unique id to the image.
        #
        #     The `product-display-name` column is optional. If it is empty, the system
        #     sets the [display_name][google.cloud.vision.v1.Product.display_name] field
        #     for the product to a space (" "). You can update the `display_name` later
        #     by using the API.
        #
        #     If a `Product` with the specified `product-id` already exists, then the
        #     system ignores the `product-display-name`, `product-category`, and `labels`
        #     columns.
        #
        #     The `labels` column (optional) is a line containing a list of
        #     comma-separated key-value pairs, in the following format:
        #
        #         "key_1=value_1,key_2=value_2,...,key_n=value_n"
        #
        #     The `bounding-poly` column (optional) identifies one region of
        #     interest from the image in the same manner as `CreateReferenceImage`. If
        #     you do not specify the `bounding-poly` column, then the system will try to
        #     detect regions of interest automatically.
        #
        #     At most one `bounding-poly` column is allowed per line. If the image
        #     contains multiple regions of interest, add a line to the CSV file that
        #     includes the same product information, and the `bounding-poly` values for
        #     each region of interest.
        #
        #     The `bounding-poly` column must contain an even number of comma-separated
        #     numbers, in the format "p1_x,p1_y,p2_x,p2_y,...,pn_x,pn_y". Use
        #     non-negative integers for absolute bounding polygons, and float values
        #     in [0, 1] for normalized bounding polygons.
        #
        #     The system will resize the image if the image resolution is too
        #     large to process (larger than 20MP).
        class ImportProductSetsGcsSource
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # The input content for the `ImportProductSets` method.
        # @!attribute [rw] gcs_source
        #   @return [Google::Cloud::Vision::V1::ImportProductSetsGcsSource]
        #     The Google Cloud Storage location for a csv file which preserves a list
        #     of ImportProductSetRequests in each line.
        class ImportProductSetsInputConfig
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Request message for the `ImportProductSets` method.
        # @!attribute [rw] parent
        #   @return [String]
        #     The project in which the ProductSets should be imported.
        #
        #     Format is `projects/PROJECT_ID/locations/LOC_ID`.
        # @!attribute [rw] input_config
        #   @return [Google::Cloud::Vision::V1::ImportProductSetsInputConfig]
        #     The input content for the list of requests.
        class ImportProductSetsRequest
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Response message for the `ImportProductSets` method.
        #
        # This message is returned by the
        # [google.longrunning.Operations.GetOperation][google.longrunning.Operations.GetOperation]
        # method in the returned
        # [google.longrunning.Operation.response][google.longrunning.Operation.response]
        # field.
        # @!attribute [rw] reference_images
        #   @return [Google::Cloud::Vision::V1::ReferenceImage]
        #     The list of reference_images that are imported successfully.
        # @!attribute [rw] statuses
        #   @return [Google::Rpc::Status]
        #     The rpc status for each ImportProductSet request, including both successes
        #     and errors.
        #
        #     The number of statuses here matches the number of lines in the csv file,
        #     and statuses[i] stores the success or failure status of processing the i-th
        #     line of the csv, starting from line 0.
        class ImportProductSetsResponse
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end

        # Metadata for the batch operations such as the current state.
        #
        # This is included in the `metadata` field of the `Operation` returned by the
        # `GetOperation` call of the `google::longrunning::Operations` service.
        # @!attribute [rw] state
        #   @return [ENUM(State)]
        #     The current state of the batch operation.
        # @!attribute [rw] submit_time
        #   @return [Google::Protobuf::Timestamp]
        #     The time when the batch request was submitted to the server.
        # @!attribute [rw] end_time
        #   @return [Google::Protobuf::Timestamp]
        #     The time when the batch request is finished and
        #     [google.longrunning.Operation.done][google.longrunning.Operation.done] is
        #     set to true.
        class BatchOperationMetadata
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods

          # Enumerates the possible states that the batch request can be in.
          module State
            # Invalid.
            STATE_UNSPECIFIED = 0

            # Request is actively being processed.
            PROCESSING = 1

            # The request is done and at least one item has been successfully
            # processed.
            SUCCESSFUL = 2

            # The request is done and no item has been successfully processed.
            FAILED = 3

            # The request is done after the longrunning.Operations.CancelOperation has
            # been called by the user.  Any records that were processed before the
            # cancel command are output as specified in the request.
            CANCELLED = 4
          end
        end
      end
    end
  end
end
