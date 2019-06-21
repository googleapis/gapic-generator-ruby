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

class GoogleAdsGemPresenterTest < PresenterTest
  def presenter
    GemPresenter.new api :googleads
  end

  def test_googleads
    assert_equal ["Google", "Ads", "Googleads"], presenter.address
    assert_equal "google-ads-googleads", presenter.name
    assert_equal "Google::Ads::GoogleAds", presenter.namespace
    assert_equal "Google Ads GoogleAds", presenter.title
    assert_equal "0.0.1", presenter.version
    assert_equal "google/ads/google_ads/version", presenter.version_require
    assert_equal "google/ads/google_ads/version.rb", presenter.version_file_path
    assert_equal "Google::Ads::GoogleAds::VERSION", presenter.version_name_full
    assert_equal ["Google LLC"], presenter.authors
    assert_equal "googleapis-packages@google.com", presenter.email
    assert_equal "google-ads-googleads is the official library for Google Ads GoogleAds API.", presenter.description
    assert_equal "API Client library for Google Ads GoogleAds API", presenter.summary
    assert_equal "https://github.com/googleapis/googleapis", presenter.homepage
    assert_equal "GOOGLEADS", presenter.env_prefix

    assert_equal ["google.ads.googleads.v1.services"], presenter.packages.map(&:name)
    presenter.packages.each { |pp| assert_kind_of PackagePresenter, pp }

    assert_equal ["CampaignService"], presenter.services.map(&:name)
    presenter.services.each { |sp| assert_kind_of ServicePresenter, sp }

    assert_equal ["google/api/http.proto", "google/protobuf/descriptor.proto", "google/ads/googleads/v1/enums/page_one_promoted_strategy_goal.proto", "google/ads/googleads/v1/enums/target_impression_share_location.proto", "google/protobuf/wrappers.proto", "google/ads/googleads/v1/common/bidding.proto", "google/ads/googleads/v1/common/custom_parameter.proto", "google/ads/googleads/v1/enums/frequency_cap_event_type.proto", "google/ads/googleads/v1/enums/frequency_cap_level.proto", "google/ads/googleads/v1/enums/frequency_cap_time_unit.proto", "google/ads/googleads/v1/common/frequency_cap.proto", "google/ads/googleads/v1/common/real_time_bidding_setting.proto", "google/ads/googleads/v1/enums/targeting_dimension.proto", "google/ads/googleads/v1/common/targeting_setting.proto", "google/ads/googleads/v1/enums/ad_serving_optimization_status.proto", "google/ads/googleads/v1/enums/advertising_channel_sub_type.proto", "google/ads/googleads/v1/enums/advertising_channel_type.proto", "google/ads/googleads/v1/enums/bidding_strategy_type.proto", "google/ads/googleads/v1/enums/brand_safety_suitability.proto", "google/ads/googleads/v1/enums/campaign_serving_status.proto", "google/ads/googleads/v1/enums/campaign_status.proto", "google/ads/googleads/v1/enums/negative_geo_target_type.proto", "google/ads/googleads/v1/enums/positive_geo_target_type.proto", "google/ads/googleads/v1/enums/vanity_pharma_display_url_mode.proto", "google/ads/googleads/v1/enums/vanity_pharma_text.proto", "google/ads/googleads/v1/resources/campaign.proto", "google/protobuf/field_mask.proto", "google/protobuf/any.proto", "google/rpc/status.proto", "google/ads/googleads/v1/services/campaign_service.proto"], presenter.proto_files.map(&:name)
    presenter.proto_files.each { |fp| assert_kind_of FilePresenter, fp }
  end
end
