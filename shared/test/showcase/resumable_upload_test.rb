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
require "stringio"
require "google/showcase/v1beta1/resumable_upload_service"
require "google/showcase/v1beta1/resumable_upload_service/rest"

##
# End-to-end resumable upload through the generated `upload_media` method.
#
# Deliberately minimal: a completed upload and a completed resume, on each transport. Protocol
# behaviour (retries, recovery, error mapping) is covered by the gapic-common integration suite.
#
module ResumableUploadTests
  CHUNK_SIZE = 256 * 1024

  # Three full chunks and a partial one, so the upload spans several requests.
  PAYLOAD = ("0123456789" * ((CHUNK_SIZE * 3 / 10) + 100)).b.freeze

  class UserPauseError < StandardError
  end

  def test_upload_media
    progress = []
    upload = @client.upload_media
    response = upload.start stream:      StringIO.new(PAYLOAD),
                            upload_size: PAYLOAD.bytesize,
                            chunk_size:  CHUNK_SIZE,
                            on_progress: ->(p) { progress << p }

    assert_instance_of ::Google::Showcase::V1beta1::UploadMediaResponse, response
    assert_equal PAYLOAD.bytesize, response.size
    refute_empty response.name
    assert_operator progress.count { |p| p.phase == :uploading }, :>, 1
    assert_equal :completed, progress.last.phase
    refute upload.resumable?
  end

  def test_resume_upload_media
    pause = lambda do |p|
      raise UserPauseError if p.phase == :uploading && p.bytes_uploaded >= CHUNK_SIZE
    end
    paused = @client.upload_media
    assert_raises UserPauseError do
      paused.start stream:      StringIO.new(PAYLOAD),
                   upload_size: PAYLOAD.bytesize,
                   chunk_size:  CHUNK_SIZE,
                   on_progress: pause
    end
    assert paused.resumable?

    # A fresh handle with no request: resuming needs only the resume handle.
    progress = []
    resumed = @client.upload_media
    response = resumed.resume stream:        StringIO.new(PAYLOAD),
                              resume_handle: paused.resume_handle,
                              upload_size:   PAYLOAD.bytesize,
                              on_progress:   ->(p) { progress << p }

    assert_instance_of ::Google::Showcase::V1beta1::UploadMediaResponse, response
    assert_equal PAYLOAD.bytesize, response.size
    refute_empty response.name
    # The resumed run continues from the bytes the server already holds.
    assert_equal CHUNK_SIZE, progress.find { |p| p.phase == :uploading }.bytes_uploaded
    assert_equal :completed, progress.last.phase
    refute resumed.resumable?
  end
end

class ResumableUploadGRPCTest < ShowcaseTest
  include ResumableUploadTests

  def setup
    @client = new_resumable_upload_client
  end
end

class ResumableUploadRestTest < ShowcaseTest
  include ResumableUploadTests

  def setup
    @client = new_resumable_upload_rest_client
  end
end
