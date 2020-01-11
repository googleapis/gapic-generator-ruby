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

class GoogleAdsPackageTest < PresenterTest
  def presenter
    @presenter ||= PackagePresenter.new api(:googleads), "google.ads.googleads.v1.services"
  end

  def test_google_showcase_v1beta1
    assert_equal ["google", "ads", "googleads", "v1", "services"], presenter.address
    assert_equal "google.ads.googleads.v1.services", presenter.name
    assert_equal "Google::Ads::GoogleAds::V1::Services", presenter.namespace
    assert_equal "google/ads/google_ads/v1/services", presenter.package_require
    assert_equal "google/ads/google_ads/v1/services.rb", presenter.package_file_path

    assert_kind_of GemPresenter, presenter.gem

    assert_equal ["CampaignService"], presenter.services.map(&:name)
    presenter.services.each { |sp| assert_kind_of ServicePresenter, sp }
  end

  def test_references
    assert_empty presenter.references
  end

  def test_paths?
    refute presenter.paths?
  end

  def test_paths_name
    assert_equal "Paths", presenter.paths_name
  end

  def test_paths_name_full
    assert_equal "Google::Ads::GoogleAds::V1::Services::Paths", presenter.paths_name_full
  end

  def test_paths_file_path
    assert_equal "google/ads/google_ads/v1/services/paths.rb", presenter.paths_file_path
  end

  def test_paths_file_name
    assert_equal "paths.rb", presenter.paths_file_name
  end

  def test_paths_require
    assert_equal "google/ads/google_ads/v1/services/paths", presenter.paths_require
  end
end
