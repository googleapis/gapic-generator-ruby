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

class VisionGemPresenterTest < PresenterTest
  def presenter
    GemPresenter.new api :vision
  end

  def test_vision
    assert_equal ["Google", "Cloud", "Vision"], presenter.address
    assert_equal "google-cloud-vision", presenter.name
    assert_equal "Google::Cloud::Vision", presenter.namespace
    assert_equal "Google Cloud Vision", presenter.title
    assert_equal "0.0.1", presenter.version
    assert_equal "google/cloud/vision/version", presenter.version_require
    assert_equal "google/cloud/vision/version.rb", presenter.version_file_path
    assert_equal "Google::Cloud::Vision::VERSION", presenter.version_name_full
    assert_equal ["Google LLC"], presenter.authors
    assert_equal "googleapis-packages@google.com", presenter.email
    assert_equal "google-cloud-vision is the official library for Google Cloud Vision API.", presenter.description
    assert_equal "API Client library for Google Cloud Vision API", presenter.summary
    assert_equal "https://github.com/googleapis/googleapis", presenter.homepage
    assert_equal "VISION", presenter.env_prefix

    assert_equal ["google.cloud.vision.v1"], presenter.packages.map(&:name)
    presenter.packages.each { |pp| assert_kind_of PackagePresenter, pp }

    assert_equal ["ProductSearch", "ImageAnnotator"], presenter.services.map(&:name)
    presenter.services.each { |sp| assert_kind_of ServicePresenter, sp }

    assert_equal ["google/api/http.proto", "google/protobuf/descriptor.proto", "google/cloud/vision/v1/geometry.proto", "google/protobuf/any.proto", "google/protobuf/empty.proto", "google/rpc/status.proto", "google/longrunning/operations.proto", "google/protobuf/field_mask.proto", "google/protobuf/timestamp.proto", "google/cloud/vision/v1/product_search_service.proto", "google/cloud/vision/v1/product_search.proto", "google/cloud/vision/v1/text_annotation.proto", "google/cloud/vision/v1/web_detection.proto", "google/protobuf/wrappers.proto", "google/type/color.proto", "google/type/latlng.proto", "google/cloud/vision/v1/image_annotator.proto"], presenter.proto_files.map(&:name)
    presenter.proto_files.each { |fp| assert_kind_of FilePresenter, fp }
  end
end
