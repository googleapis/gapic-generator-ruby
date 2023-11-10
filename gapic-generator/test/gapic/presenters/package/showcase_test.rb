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

class ShowcasePackagePresenterTest < PresenterTest
  def test_google_showcase_v1beta1
    api_schema = api :showcase
    gem_presenter = Gapic::Presenters::GemPresenter.new api_schema
    presenter = Gapic::Presenters::PackagePresenter.new gem_presenter, api_schema, "google.showcase.v1beta1"

    assert_equal ["google", "showcase", "v1beta1"], presenter.address
    assert_equal "google.showcase.v1beta1", presenter.name
    assert_equal "::Google::Showcase::V1beta1", presenter.namespace
    assert_equal "google/showcase/v1beta1", presenter.package_require
    assert_equal "google/showcase/v1beta1.rb", presenter.package_file_path

    assert_kind_of Gapic::Presenters::GemPresenter, presenter.gem

    assert_equal ["Compliance", "Echo", "Identity", "Messaging", "Testing"], presenter.services.map(&:name)
    presenter.services.each { |sp| assert_kind_of Gapic::Presenters::ServicePresenter, sp }
  end

  ##
  # Testing the drift manifest for the showcase
  #
  def test_drift_showcase_v1beta1
    api_schema = api :showcase
    gem_presenter = Gapic::Presenters::GemPresenter.new api_schema
    presenter = Gapic::Presenters::PackagePresenter.new gem_presenter, api_schema, "google.showcase.v1beta1"

    refute_nil presenter.drift_manifest
    assert_equal "1.0", presenter.drift_manifest[:schema]
    assert_equal "google.showcase.v1beta1", presenter.drift_manifest[:protoPackage]
    assert_equal "::Google::Showcase::V1beta1", presenter.drift_manifest[:libraryPackage]
    assert_equal 5, presenter.drift_manifest[:services].length

    echo_service_manifest = presenter.drift_manifest[:services]["Echo"]
    echo_gprc = echo_service_manifest[:clients][:grpc]

    refute_nil echo_gprc

    assert_equal "::Google::Showcase::V1beta1::Echo::Client", echo_gprc[:libraryClient]
    assert_equal 9, echo_gprc[:rpcs].length

    echo_grpc_chat = echo_gprc[:rpcs]["Chat"][:methods]
    refute_nil echo_grpc_chat

    assert_kind_of Array, echo_grpc_chat
    assert 1, echo_grpc_chat.length
    assert_equal "chat", echo_grpc_chat[0]
  end
end
