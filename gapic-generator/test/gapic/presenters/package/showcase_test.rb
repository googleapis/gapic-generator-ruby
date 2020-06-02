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

    assert_equal ["Echo", "Identity", "Messaging", "Testing"], presenter.services.map(&:name)
    presenter.services.each { |sp| assert_kind_of Gapic::Presenters::ServicePresenter, sp }
  end
end
