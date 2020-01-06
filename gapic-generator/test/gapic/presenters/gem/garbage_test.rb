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

class GarbageGemPresenterTest < PresenterTest
  def presenter
    GemPresenter.new api :garbage
  end

  def test_garbage
    assert_equal ["Google", "Garbage"], presenter.address
    assert_equal "google-garbage", presenter.name
    assert_equal "Google::Garbage", presenter.namespace
    assert_equal "Google Garbage", presenter.title
    assert_equal "0.0.1", presenter.version
    assert_equal "google/garbage/version", presenter.version_require
    assert_equal "google/garbage/version.rb", presenter.version_file_path
    assert_equal "Google::Garbage::VERSION", presenter.version_name_full
    assert_equal ["Google LLC"], presenter.authors
    assert_equal "googleapis-packages@google.com", presenter.email
    assert_equal "google-garbage is the official library for Google Garbage API.", presenter.description
    assert_equal "API Client library for Google Garbage API", presenter.summary
    assert_equal "https://github.com/googleapis/googleapis", presenter.homepage
    assert_equal "GARBAGE", presenter.env_prefix

    assert_equal ["endless.trash.forever"], presenter.packages.map(&:name)
    presenter.packages.each { |pp| assert_kind_of PackagePresenter, pp }

    assert_equal ["GarbageService"], presenter.services.map(&:name)
    presenter.services.each { |sp| assert_kind_of ServicePresenter, sp }

    assert_equal ["google/api/field_behavior.proto", "google/api/resource.proto", "google/protobuf/any.proto", "google/protobuf/empty.proto", "google/rpc/status.proto", "google/longrunning/operations.proto", "google/protobuf/timestamp.proto", "google/protobuf/duration.proto", "google/iam/v1/policy.proto", "google/iam/v1/iam_policy.proto", "garbage/garbage.proto"], presenter.proto_files.map(&:name)
    presenter.proto_files.each { |fp| assert_kind_of FilePresenter, fp }

    assert presenter.iam_dependency?
  end
end
