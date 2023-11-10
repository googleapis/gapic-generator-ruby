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

class ShowcaseGemPresenterTest < PresenterTest
  def presenter
    Gapic::Presenters::GemPresenter.new api :showcase
  end

  def test_showcase
    assert_equal "google-showcase", presenter.name
    assert_equal "Google::Showcase", presenter.namespace
    assert_equal "Client Libraries Showcase", presenter.title
    assert_equal "0.0.1", presenter.version
    assert_equal "google/showcase/version", presenter.version_require
    assert_equal "google/showcase/version.rb", presenter.version_file_path
    assert_equal "Google::Showcase::VERSION", presenter.version_name_full
    assert_equal ["Google LLC"], presenter.authors
    assert_equal "googleapis-packages@google.com", presenter.email
    assert_equal "Showcase represents both a model API and an integration testing surface for client library generator consumption.", presenter.description
    assert_equal "Showcase represents both a model API and an integration testing surface for client library generator consumption.", presenter.summary
    assert_equal "https://github.com/googleapis/googleapis", presenter.homepage
    assert_equal "SHOWCASE", presenter.env_prefix

    assert_equal ["google.showcase.v1beta1"], presenter.packages.map(&:name)
    presenter.packages.each { |pp| assert_kind_of Gapic::Presenters::PackagePresenter, pp }

    assert_equal ["Compliance", "Echo", "Identity", "Messaging", "SequenceService", "Testing"], presenter.services.map(&:name)
    presenter.services.each { |sp| assert_kind_of Gapic::Presenters::ServicePresenter, sp }

    expected_proto_files = [
      "google/api/field_behavior.proto",
      "google/api/resource.proto",
      "google/api/routing.proto",
      "google/longrunning/operations.proto",
      "google/protobuf/any.proto",
      "google/protobuf/duration.proto",
      "google/protobuf/empty.proto",
      "google/protobuf/field_mask.proto",
      "google/protobuf/timestamp.proto",
      "google/rpc/error_details.proto",
      "google/rpc/status.proto",
      "google/showcase/v1beta1/compliance.proto",
      "google/showcase/v1beta1/echo.proto",
      "google/showcase/v1beta1/identity.proto",
      "google/showcase/v1beta1/messaging.proto",
      "google/showcase/v1beta1/sequence.proto",
      "google/showcase/v1beta1/testing.proto"
    ]
    assert_equal expected_proto_files.sort, presenter.proto_files.map(&:name).sort
    presenter.proto_files.each { |fp| assert_kind_of Gapic::Presenters::FilePresenter, fp }

    refute presenter.iam_dependency?
  end
end
