# frozen_string_literal: true

# Copyright 2021 Google LLC
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

class GemPresenterMixinsTest < PresenterTest
  def test_explicit_plain
    presenter = Gapic::Presenters::GemPresenter.new api :testing
    assert presenter.mixins?
  end

  def test_proto_files_exclude_mixins
    presenter = Gapic::Presenters::GemPresenter.new api :testing
    refute_includes presenter.proto_files.map(&:name), "google/cloud/location/locations.proto"
  end
end
