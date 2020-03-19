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

class GarbagePackagePresenterTest < PresenterTest
  def test_endless_trash_forever
    presenter = Gapic::Presenters::PackagePresenter.new api(:garbage), "endless.trash.forever"

    assert_equal ["endless", "trash", "forever"], presenter.address
    assert_equal "endless.trash.forever", presenter.name
    assert_equal "So::Much::Trash", presenter.namespace
    assert_equal "so/much/trash", presenter.package_require
    assert_equal "so/much/trash.rb", presenter.package_file_path

    assert_kind_of Gapic::Presenters::GemPresenter, presenter.gem

    assert_equal ["GarbageService"], presenter.services.map(&:name)
    presenter.services.each { |sp| assert_kind_of Gapic::Presenters::ServicePresenter, sp }
  end
end
