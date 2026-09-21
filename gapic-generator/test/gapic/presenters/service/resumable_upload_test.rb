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

class ServicePresenterResumableUploadTest < PresenterTest
  def test_showcase_ResumableUploadService
    presenter = service_presenter :showcase, "ResumableUploadService"

    assert presenter.resumable_upload?
    assert_equal ["upload_media"], presenter.resumable_upload_methods.map(&:name)

    assert_equal "ResumableUploadStub", presenter.resumable_upload_stub_name
    assert_equal "::Google::Showcase::V1beta1::ResumableUploadService::ResumableUploadStub",
                 presenter.resumable_upload_stub_name_full
    assert_equal "google/showcase/v1beta1/resumable_upload_service/resumable_upload_stub",
                 presenter.resumable_upload_stub_require
    assert_equal "google/showcase/v1beta1/resumable_upload_service/resumable_upload_stub.rb",
                 presenter.resumable_upload_stub_file_path
    assert_equal "resumable_upload_stub.rb", presenter.resumable_upload_stub_file_name
    assert_equal "@resumable_upload_stub", presenter.resumable_upload_stub_ivar
  end

  def test_showcase_Echo_has_no_uploads
    presenter = service_presenter :showcase, "Echo"

    refute presenter.resumable_upload?
    assert_empty presenter.resumable_upload_methods
  end

  def test_upload_rpcs_are_kept_out_of_the_rest_service_stub
    presenter = service_presenter :showcase, "ResumableUploadService"

    # The REST client still generates a method for the RPC; only the stub skips it.
    assert_includes presenter.rest.methods.map(&:name), "upload_media"
    refute_includes presenter.rest.service_stub_methods.map(&:name), "upload_media"
  end

  def test_non_upload_rpcs_stay_in_both_lists
    presenter = service_presenter :showcase, "Echo"

    assert_equal presenter.rest.methods.map(&:name), presenter.rest.service_stub_methods.map(&:name)
  end

  def test_googleads_YouTubeVideoUploadService
    presenter = service_presenter :googleads, "YouTubeVideoUploadService"

    assert presenter.resumable_upload?
    assert_equal ["create_you_tube_video_upload"], presenter.resumable_upload_methods.map(&:name)
  end
end
