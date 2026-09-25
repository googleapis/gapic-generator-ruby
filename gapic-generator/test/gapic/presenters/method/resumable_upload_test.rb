# frozen_string_literal: true

# Copyright 2026 Google LLC
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

class MethodPresenterResumableUploadTest < PresenterTest
  def test_showcase_UploadMedia
    presenter = method_presenter :showcase, "ResumableUploadService", "UploadMedia"

    assert presenter.resumable_upload?
    assert_equal "resumable/upload", presenter.upload_url_prefix
  end

  def test_showcase_Echo_is_not_an_upload
    presenter = method_presenter :showcase, "Echo", "Echo"

    refute presenter.resumable_upload?
    assert_nil presenter.upload_url_prefix
  end

  def test_googleads_CreateYouTubeVideoUpload
    presenter = method_presenter :googleads, "YouTubeVideoUploadService", "CreateYouTubeVideoUpload"

    assert presenter.resumable_upload?
    assert_equal "resumable/upload", presenter.upload_url_prefix
  end

  def test_googleads_siblings_are_not_uploads
    %w[UpdateYouTubeVideoUpload RemoveYouTubeVideoUpload].each do |method_name|
      presenter = method_presenter :googleads, "YouTubeVideoUploadService", method_name

      refute presenter.resumable_upload?, "#{method_name} must not be detected as an upload"
      assert_nil presenter.upload_url_prefix
    end
  end
end

class ResumableUploadModelPrefixTest < Minitest::Test
  Model = Gapic::Model::Method::ResumableUpload

  def test_exact_match
    assert_equal "resumable/upload",
                 Model.url_prefix_for("google.showcase.v1beta1.ResumableUploadService.UploadMedia")
  end

  def test_versioned_match_covers_every_ads_version
    %w[v23 v24 v25 v23_1 v101].each do |version|
      full_name = "google.ads.googleads.#{version}.services.YouTubeVideoUploadService.CreateYouTubeVideoUpload"

      assert_equal "resumable/upload", Model.url_prefix_for(full_name), "#{version} must match"
    end
  end

  def test_versioned_match_does_not_constrain_the_middle_segments
    assert_equal "resumable/upload",
                 Model.url_prefix_for("google.ads.googleads.v25.YouTubeVideoUploadService.CreateYouTubeVideoUpload")
  end

  def test_near_misses_do_not_match
    [
      # Wrong package.
      "google.ads.googleadsx.v25.services.YouTubeVideoUploadService.CreateYouTubeVideoUpload",
      # Unversioned package.
      "google.ads.googleads.services.YouTubeVideoUploadService.CreateYouTubeVideoUpload",
      # Right service, wrong method.
      "google.ads.googleads.v25.services.YouTubeVideoUploadService.UpdateYouTubeVideoUpload",
      # Right method, wrong service.
      "google.ads.googleads.v25.services.CampaignService.CreateYouTubeVideoUpload",
      # Right suffix, but not left-anchored at the ads package.
      "example.google.ads.googleads.v25.services.YouTubeVideoUploadService.CreateYouTubeVideoUpload",
      # Right showcase service, wrong method.
      "google.showcase.v1beta1.ResumableUploadService.UploadMediaAgain"
    ].each do |full_name|
      assert_nil Model.url_prefix_for(full_name), "#{full_name} must not match"
    end
  end
end

class ResumableUploadModelValidationTest < Minitest::Test
  Model = Gapic::Model::Method::ResumableUpload

  # A stand-in for a MethodPresenter, carrying only what validation reads.
  class FakeMethod
    def initialize **overrides
      @attrs = {
        grpc_full_name:   "google.showcase.v1beta1.ResumableUploadService.UploadMedia",
        client_streaming: false,
        server_streaming: false,
        paged:            false,
        lro:              false,
        nonstandard_lro:  false,
        http_bindings:    [FakeBinding.new(verb: :post, body: "*")]
      }.merge overrides
    end

    def grpc_full_name
      @attrs[:grpc_full_name]
    end

    def client_streaming?
      @attrs[:client_streaming]
    end

    def server_streaming?
      @attrs[:server_streaming]
    end

    def paged?
      @attrs[:paged]
    end

    def lro?
      @attrs[:lro]
    end

    def nonstandard_lro?
      @attrs[:nonstandard_lro]
    end

    def http_bindings
      @attrs[:http_bindings]
    end
  end

  FakeBinding = Struct.new :verb, :body, keyword_init: true do
    def body?
      !body.nil? && !body.empty?
    end
  end

  def test_a_matched_unary_post_with_a_body_is_accepted
    model = Model.create FakeMethod.new

    assert_equal "resumable/upload", model.url_prefix
  end

  def test_an_unmatched_method_is_not_validated_at_all
    assert_nil Model.create(FakeMethod.new(grpc_full_name: "google.showcase.v1beta1.Echo.Echo",
                                           server_streaming: true))
  end

  def test_streaming_is_rejected
    assert_rejected FakeMethod.new(client_streaming: true), "non-streaming"
    assert_rejected FakeMethod.new(server_streaming: true), "non-streaming"
  end

  def test_pagination_is_rejected
    assert_rejected FakeMethod.new(paged: true), "non-paginated"
  end

  def test_long_running_is_rejected
    assert_rejected FakeMethod.new(lro: true), "long-running"
    assert_rejected FakeMethod.new(nonstandard_lro: true), "long-running"
  end

  def test_a_missing_binding_is_rejected
    assert_rejected FakeMethod.new(http_bindings: []), "an HTTP binding"
  end

  def test_a_non_post_binding_is_rejected
    assert_rejected FakeMethod.new(http_bindings: [FakeBinding.new(verb: :get, body: "*")]), "POST"
  end

  def test_a_bodiless_binding_is_rejected
    assert_rejected FakeMethod.new(http_bindings: [FakeBinding.new(verb: :post, body: nil)]), "a body"
  end

  private

  def assert_rejected method, expected_reason
    error = assert_raises Gapic::Model::ModelError do
      Model.create method
    end

    assert_includes error.message, method.grpc_full_name
    assert_includes error.message, expected_reason
  end
end
