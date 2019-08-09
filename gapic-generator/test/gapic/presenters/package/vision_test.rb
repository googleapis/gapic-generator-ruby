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

class VisionPackagePresenterTest < PresenterTest
  def test_google_cloud_vision_v1
    presenter = PackagePresenter.new api(:vision), "google.cloud.vision.v1"

    assert_equal ["google", "cloud", "vision", "v1"], presenter.address
    assert_equal "google.cloud.vision.v1", presenter.name
    assert_equal "Google::Cloud::Vision::V1", presenter.namespace
    assert_equal "google/cloud/vision/v1", presenter.version_require
    assert_equal "google/cloud/vision/v1.rb", presenter.version_file_path

    assert_kind_of GemPresenter, presenter.gem

    assert_equal ["ProductSearch", "ImageAnnotator"], presenter.services.map(&:name)
    presenter.services.each { |sp| assert_kind_of ServicePresenter, sp }
  end
end
