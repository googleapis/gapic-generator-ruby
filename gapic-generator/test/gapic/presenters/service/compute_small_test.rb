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

class ServicePresenterRestTest < PresenterTest
  def test_compute_addresses
    presenter = service_presenter :compute_small, "Addresses"

    refute presenter.nonstandard_lro_provider?
    assert presenter.nonstandard_lro_consumer?
  end

  def test_compute_region_operations
    presenter = service_presenter :compute_small, "RegionOperations"

    assert presenter.nonstandard_lro_provider?
    refute presenter.nonstandard_lro_consumer?
  end
end
