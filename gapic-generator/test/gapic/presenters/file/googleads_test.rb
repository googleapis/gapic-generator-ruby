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

class GoogleAdsFilePresenterTest < PresenterTest
  def schema
    api :googleads
  end

  def test_campaign_service
    file = schema.files.find { |f| f.name == "google/ads/googleads/v1/services/campaign_service.proto" }
    fp = FilePresenter.new schema, file

    assert_equal ["google", "ads", "googleads", "v1", "services"], fp.address
    assert_equal "Google::Ads::GoogleAds::V1::Services", fp.namespace
    assert_equal "google/ads/googleads/v1/services/campaign_service.rb", fp.docs_file_path

    assert_equal ["GetCampaignRequest", "MutateCampaignsRequest", "CampaignOperation", "MutateCampaignsResponse", "MutateCampaignResult"], fp.messages.map(&:name)
    fp.messages.each { |mp| assert_kind_of MessagePresenter, mp }

    assert_equal [], fp.enums.map(&:name)
    fp.enums.each { |ep| assert_kind_of EnumPresenter, ep }
  end
end
