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

class ServicePresenterMixinTest < PresenterTest
  ##
  # Tests that a mixin in it's own gem is not classified as a mixin
  #
  def test_location_locations
    presenter = service_presenter :location, "Locations"
    refute presenter.is_hosted_mixin?
    assert presenter.is_main_mixin_service?
  end

  def test_vision_mixins
    presenter = service_presenter :vision_v1, "ImageAnnotator"
    refute_empty presenter.rest.mixin_presenters
  end
end
