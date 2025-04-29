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

# Test mixins model construction
class MixinsTest < PresenterTest
  # Test the `Testing` library, which does have mixins specified
  # in its service.yaml
  def test_testing_mixins
    gem_presenter = Gapic::Presenters::GemPresenter.new api :testing
    mx_model = gem_presenter.mixins_model

    assert mx_model.mixins?
    assert_includes mx_model.api_services, "testing.mixins.ServiceWithLoc"
    assert_includes mx_model.mixin_services, "google.cloud.location.Locations"
    assert_equal ["google.cloud.location.Locations"], mx_model.mixin_services
    assert_equal 1, mx_model.mixins.length
    assert_equal 1, mx_model.dependencies.length
    refute_includes gem_presenter.services, "google.cloud.location.Locations"

    service_to_dependency_value = Gapic::Model::Mixins.const_get :SERVICE_TO_DEPENDENCY
    locations_gem_name = service_to_dependency_value[Gapic::Model::Mixins::LOCATIONS_SERVICE].keys[0]
    assert mx_model.dependencies.key? locations_gem_name
  end

  def test_mixin_service_address_checker
    assert Gapic::Model::Mixins.mixin_service_address? "google.cloud.location.Locations"
    refute Gapic::Model::Mixins.mixin_service_address? "google.cloud.location.Locations",
                                                       gem_name: "google-cloud-location"
    assert Gapic::Model::Mixins.mixin_service_address? ["google", "iam", "v1", "IAMPolicy"]
    refute Gapic::Model::Mixins.mixin_service_address? "testing.mixins.ServiceWithLoc"
  end

  # Test the `Garbage` library, which does NOT have mixins specified
  # in its service.yaml (or service.yaml at all)
  def test_garbage_mixins
    mx_model = Gapic::Presenters::GemPresenter.new(api(:garbage)).mixins_model

    refute mx_model.mixins?
    assert_includes mx_model.api_services, "endless.trash.forever.GarbageService"
    assert_empty mx_model.mixin_services
    assert_empty mx_model.mixins
    assert_empty mx_model.dependencies
  end
end
