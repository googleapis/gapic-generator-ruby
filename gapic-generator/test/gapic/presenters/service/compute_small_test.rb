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

class ComputeSmallTest < PresenterTest
  def test_compute_addresses
    main_service = service_presenter(:compute_small, "Addresses")
    presenter = main_service.rest

    refute main_service.nonstandard_lro_provider?
    assert main_service.nonstandard_lro_consumer?

    refute presenter.is_hosted_mixin?
    refute presenter.is_main_mixin_service?
    refute presenter.mixins?
    refute presenter.mixin_binding_overrides?
  end

  def test_compute_region_operations
    main_service = service_presenter(:compute_small, "RegionOperations")
    presenter = main_service.rest

    assert main_service.nonstandard_lro_provider?
    refute main_service.nonstandard_lro_consumer?

    refute presenter.is_hosted_mixin?
    refute presenter.is_main_mixin_service?
    refute presenter.mixins?
    refute presenter.mixin_binding_overrides?
  end
end
