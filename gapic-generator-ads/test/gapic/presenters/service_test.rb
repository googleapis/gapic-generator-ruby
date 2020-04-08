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

class GoogleAdsServiceTest < PresenterTest
  def presenter
    service_presenter :googleads, "CampaignService"
  end

  def test_name
    assert_equal "CampaignService", presenter.name
  end

  def test_methods
    refute_empty presenter.methods
    presenter.methods.each { |ref| assert_kind_of Gapic::Presenters::MethodPresenter, ref }
    exp_method_names = ["get_campaign", "mutate_campaigns"]
    assert_equal exp_method_names, presenter.methods.map(&:name)
  end

  def test_references
    refute_empty presenter.references
  end

  def test_proto_methods
    assert_equal "Google::Ads::GoogleAds::V1::Services::CampaignService", presenter.proto_service_name_full
    assert_equal "google/ads/googleads/v1/services/campaign_service_pb.rb", presenter.proto_service_file_path
    assert_equal "campaign_service_pb.rb", presenter.proto_service_file_name
    assert_equal "google/ads/googleads/v1/services/campaign_service_pb", presenter.proto_service_require
    assert_equal "google/ads/googleads/v1/services/campaign_service_services_pb.rb", presenter.proto_services_file_path
    assert_equal "campaign_service_services_pb.rb", presenter.proto_services_file_name
    assert_equal "google/ads/googleads/v1/services/campaign_service_services_pb", presenter.proto_services_require
    assert_equal "Google::Ads::GoogleAds::V1::Services::CampaignService::Stub", presenter.proto_service_stub_name_full
  end

  def test_credentials_methods
    assert_equal "Credentials", presenter.credentials_name
    assert_equal "Google::Ads::GoogleAds::V1::Services::CampaignService::Credentials", presenter.credentials_name_full
    assert_equal "google/ads/google_ads/v1/services/campaign_service/credentials.rb", presenter.credentials_file_path
    assert_equal "credentials.rb", presenter.credentials_file_name
    assert_equal "google/ads/google_ads/v1/services/campaign_service/credentials", presenter.credentials_require
  end

  def test_operations_methods
    assert_equal "Operations", presenter.operations_name
    assert_equal "Google::Ads::GoogleAds::V1::Services::CampaignService::Operations", presenter.operations_name_full
    assert_equal "google/ads/google_ads/v1/services/campaign_service/operations.rb", presenter.operations_file_path
    assert_equal "operations.rb", presenter.operations_file_name
    assert_equal "google/ads/google_ads/v1/services/campaign_service/operations", presenter.operations_require
  end

  def test_helpers_methods
    assert_equal "google/ads/google_ads/v1/services/campaign_service/helpers.rb", presenter.helpers_file_path
    assert_equal "helpers.rb", presenter.helpers_file_name
    assert_equal "google/ads/google_ads/v1/services/campaign_service/helpers", presenter.helpers_require
  end

  def test_test_client_file_path
    assert_equal "google/ads/google_ads/v1/services/campaign_service_test.rb", presenter.test_client_file_path
  end

  def test_test_client_operations_file_path
    assert_equal "google/ads/google_ads/v1/services/campaign_service_operations_test.rb",
                 presenter.test_client_operations_file_path
  end

  def test_stub_name
    assert_equal "campaign_service_stub", presenter.stub_name
  end

  def test_lro?
    refute presenter.lro?
  end

  def test_lro_client_var
    assert_equal "operations_client", presenter.lro_client_var
  end

  def test_lro_client_ivar
    assert_equal "@operations_client", presenter.lro_client_ivar
  end

  def test_paths?
    assert presenter.paths?
  end

  def test_paths_name
    assert_equal "Paths", presenter.paths_name
  end

  def test_paths_name_full
    assert_equal "Google::Ads::GoogleAds::V1::Services::CampaignService::Paths", presenter.paths_name_full
  end

  def test_paths_file_path
    assert_equal "google/ads/google_ads/v1/services/campaign_service/paths.rb", presenter.paths_file_path
  end

  def test_paths_file_name
    assert_equal "paths.rb", presenter.paths_file_name
  end

  def test_paths_require
    assert_equal "google/ads/google_ads/v1/services/campaign_service/paths", presenter.paths_require
  end
end
