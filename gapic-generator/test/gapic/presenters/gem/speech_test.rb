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

class SpeechGemPresenterTest < PresenterTest
  def presenter
    GemPresenter.new api :speech
  end

  def test_speech
    assert_equal ["Google", "Cloud", "Speech"], presenter.address
    assert_equal "google-cloud-speech", presenter.name
    assert_equal "Google::Cloud::Speech", presenter.namespace
    assert_equal "Google Cloud Speech", presenter.title
    assert_equal "0.0.1", presenter.version
    assert_equal "google/cloud/speech/version", presenter.version_require
    assert_equal "google/cloud/speech/version.rb", presenter.version_file_path
    assert_equal "Google::Cloud::Speech::VERSION", presenter.version_name_full
    assert_equal ["Google LLC"], presenter.authors
    assert_equal "googleapis-packages@google.com", presenter.email
    assert_equal "google-cloud-speech is the official library for Google Cloud Speech API.", presenter.description
    assert_equal "API Client library for Google Cloud Speech API", presenter.summary
    assert_equal "https://github.com/googleapis/googleapis", presenter.homepage
    assert_equal "SPEECH", presenter.env_prefix

    assert_equal ["google.cloud.speech.v1"], presenter.packages.map(&:name)
    presenter.packages.each { |pp| assert_kind_of PackagePresenter, pp }

    assert_equal ["Speech"], presenter.services.map(&:name)
    presenter.services.each { |sp| assert_kind_of ServicePresenter, sp }

    assert_equal ["google/protobuf/any.proto", "google/protobuf/empty.proto", "google/rpc/status.proto", "google/longrunning/operations.proto", "google/protobuf/duration.proto", "google/protobuf/timestamp.proto", "google/cloud/speech/v1/cloud_speech.proto"], presenter.proto_files.map(&:name)
    presenter.proto_files.each { |fp| assert_kind_of FilePresenter, fp }
  end
end
