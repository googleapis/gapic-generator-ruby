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
  def presenter
    @presenter ||= PackagePresenter.new api(:showcase), "google.showcase.v1beta1"
  end

  def test_google_showcase_v1beta1
    assert_equal ["google", "showcase", "v1beta1"], presenter.address
    assert_equal "google.showcase.v1beta1", presenter.name
    assert_equal "Google::Showcase::V1beta1", presenter.namespace
    assert_equal "google/showcase/v1beta1", presenter.package_require
    assert_equal "google/showcase/v1beta1.rb", presenter.package_file_path

    assert_kind_of GemPresenter, presenter.gem

    assert_equal ["Echo", "Identity", "Messaging", "Testing"], presenter.services.map(&:name)
    presenter.services.each { |sp| assert_kind_of ServicePresenter, sp }
  end

  def test_references
    refute_empty presenter.references
    presenter.references.each { |ref| assert_kind_of ResourcePresenter, ref }
    assert_equal ["Blurb", "Room", "Session", "Test", "User"], presenter.references.map(&:name)
    assert_equal ["rooms/{room_id}/blurbs/{blurb_id}", "rooms/{room_id}", "sessions/{session}", "sessions/{session}/tests/{test}", "users/{user_id}"], presenter.references.map(&:path_template)
  end

  def test_paths?
    assert presenter.paths?
  end

  def test_paths_name
    assert_equal "Paths", presenter.paths_name
  end

  def test_paths_name_full
    assert_equal "Google::Showcase::V1beta1::Paths", presenter.paths_name_full
  end

  def test_paths_file_path
    assert_equal "google/showcase/v1beta1/paths.rb", presenter.paths_file_path
  end

  def test_paths_file_name
    assert_equal "paths.rb", presenter.paths_file_name
  end

  def test_paths_require
    assert_equal "google/showcase/v1beta1/paths", presenter.paths_require
  end
end
