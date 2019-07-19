# frozen_string_literal: true

# Copyright 2019 Google LLC
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

require "test_helper"

class VisionFilePresenterTest < PresenterTest
  def schema
    api :vision
  end

  def test_geometry
    file = schema.files.find { |f| f.name == "google/cloud/vision/v1/geometry.proto" }
    fp = FilePresenter.new schema, file

    assert_equal ["google", "cloud", "vision", "v1"], fp.address
    assert_equal "Google::Cloud::Vision::V1", fp.namespace
    assert_equal "google/cloud/vision/v1/geometry.rb", fp.docs_file_path

    assert_equal ["Vertex", "NormalizedVertex", "BoundingPoly", "Position"], fp.messages.map(&:name)
    fp.messages.each { |mp| assert_kind_of MessagePresenter, mp }

    assert_equal [], fp.enums.map(&:name)
    fp.enums.each { |ep| assert_kind_of EnumPresenter, ep }
  end

  def test_product_search_service
    file = schema.files.find { |f| f.name == "google/cloud/vision/v1/product_search_service.proto" }
    fp = FilePresenter.new schema, file

    assert_equal ["google", "cloud", "vision", "v1"], fp.address
    assert_equal "Google::Cloud::Vision::V1", fp.namespace
    assert_equal "google/cloud/vision/v1/product_search_service.rb", fp.docs_file_path

    assert_equal ["Product", "ProductSet", "ReferenceImage", "CreateProductRequest", "ListProductsRequest", "ListProductsResponse", "GetProductRequest", "UpdateProductRequest", "DeleteProductRequest", "CreateProductSetRequest", "ListProductSetsRequest", "ListProductSetsResponse", "GetProductSetRequest", "UpdateProductSetRequest", "DeleteProductSetRequest", "CreateReferenceImageRequest", "ListReferenceImagesRequest", "ListReferenceImagesResponse", "GetReferenceImageRequest", "DeleteReferenceImageRequest", "AddProductToProductSetRequest", "RemoveProductFromProductSetRequest", "ListProductsInProductSetRequest", "ListProductsInProductSetResponse", "ImportProductSetsGcsSource", "ImportProductSetsInputConfig", "ImportProductSetsRequest", "ImportProductSetsResponse", "BatchOperationMetadata"], fp.messages.map(&:name)
    fp.messages.each { |mp| assert_kind_of MessagePresenter, mp }

    assert_equal [], fp.enums.map(&:name)
    fp.enums.each { |ep| assert_kind_of EnumPresenter, ep }
  end

  def test_product_search
    file = schema.files.find { |f| f.name == "google/cloud/vision/v1/product_search.proto" }
    fp = FilePresenter.new schema, file

    assert_equal ["google", "cloud", "vision", "v1"], fp.address
    assert_equal "Google::Cloud::Vision::V1", fp.namespace
    assert_equal "google/cloud/vision/v1/product_search.rb", fp.docs_file_path

    assert_equal ["ProductSearchParams", "ProductSearchResults"], fp.messages.map(&:name)
    fp.messages.each { |mp| assert_kind_of MessagePresenter, mp }

    assert_equal [], fp.enums.map(&:name)
    fp.enums.each { |ep| assert_kind_of EnumPresenter, ep }
  end

  def test_text_annotation
    file = schema.files.find { |f| f.name == "google/cloud/vision/v1/text_annotation.proto" }
    fp = FilePresenter.new schema, file

    assert_equal ["google", "cloud", "vision", "v1"], fp.address
    assert_equal "Google::Cloud::Vision::V1", fp.namespace
    assert_equal "google/cloud/vision/v1/text_annotation.rb", fp.docs_file_path

    assert_equal ["TextAnnotation", "Page", "Block", "Paragraph", "Word", "Symbol"], fp.messages.map(&:name)
    fp.messages.each { |mp| assert_kind_of MessagePresenter, mp }

    assert_equal [], fp.enums.map(&:name)
    fp.enums.each { |ep| assert_kind_of EnumPresenter, ep }
  end

  def test_web_detection
    file = schema.files.find { |f| f.name == "google/cloud/vision/v1/web_detection.proto" }
    fp = FilePresenter.new schema, file

    assert_equal ["google", "cloud", "vision", "v1"], fp.address
    assert_equal "Google::Cloud::Vision::V1", fp.namespace
    assert_equal "google/cloud/vision/v1/web_detection.rb", fp.docs_file_path

    assert_equal ["WebDetection"], fp.messages.map(&:name)
    fp.messages.each { |mp| assert_kind_of MessagePresenter, mp }

    assert_equal [], fp.enums.map(&:name)
    fp.enums.each { |ep| assert_kind_of EnumPresenter, ep }
  end

  def test_image_annotator
    file = schema.files.find { |f| f.name == "google/cloud/vision/v1/image_annotator.proto" }
    fp = FilePresenter.new schema, file

    assert_equal ["google", "cloud", "vision", "v1"], fp.address
    assert_equal "Google::Cloud::Vision::V1", fp.namespace
    assert_equal "google/cloud/vision/v1/image_annotator.rb", fp.docs_file_path

    assert_equal ["Feature", "ImageSource", "Image", "FaceAnnotation", "LocationInfo", "Property", "EntityAnnotation", "LocalizedObjectAnnotation", "SafeSearchAnnotation", "LatLongRect", "ColorInfo", "DominantColorsAnnotation", "ImageProperties", "CropHint", "CropHintsAnnotation", "CropHintsParams", "WebDetectionParams", "ImageContext", "AnnotateImageRequest", "ImageAnnotationContext", "AnnotateImageResponse", "AnnotateFileResponse", "BatchAnnotateImagesRequest", "BatchAnnotateImagesResponse", "AsyncAnnotateFileRequest", "AsyncAnnotateFileResponse", "AsyncBatchAnnotateFilesRequest", "AsyncBatchAnnotateFilesResponse", "InputConfig", "OutputConfig", "GcsSource", "GcsDestination", "OperationMetadata"], fp.messages.map(&:name)
    fp.messages.each { |mp| assert_kind_of MessagePresenter, mp }

    assert_equal ["Likelihood"], fp.enums.map(&:name)
    fp.enums.each { |ep| assert_kind_of EnumPresenter, ep }
  end
end
