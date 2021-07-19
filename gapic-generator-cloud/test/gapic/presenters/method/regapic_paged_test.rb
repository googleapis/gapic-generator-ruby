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

class MethodPresenterRegapicPagedTest < PresenterTest
  ##
  # Tests that a non-paged method is correctly identified as a non-paged by REGAPIC generation
  #
  def test_compute_addresses_delete
    presenter = method_presenter :compute_small, "Addresses", "Get"

    assert_equal "::Google::Cloud::Compute::V1::GetAddressRequest", presenter.request_type
    assert_equal "::Google::Cloud::Compute::V1::Address", presenter.return_type

    refute presenter.rest.paged?
  end

  ##
  # Tests that a paged method which has a list-based response pagination
  # is correctly identified as a paged by REGAPIC generation
  #
  def test_compute_addresses_list
    presenter = method_presenter :compute_small, "Addresses", "List"

    assert_equal "::Google::Cloud::Compute::V1::ListAddressesRequest", presenter.request_type
    assert_equal "::Google::Cloud::Compute::V1::AddressList", presenter.return_type

    assert presenter.rest.paged?
  end

  ##
  # Tests that a paged method which has a map-based response pagination
  # is correctly identified as a paged by REGAPIC generation
  #
  def test_compute_addresses_aggregatedlist
    presenter = method_presenter :compute_small, "Addresses", "AggregatedList"

    assert_equal "::Google::Cloud::Compute::V1::AggregatedListAddressesRequest", presenter.request_type
    assert_equal "::Google::Cloud::Compute::V1::AddressAggregatedList", presenter.return_type

    assert presenter.rest.paged?
    assert presenter.rest.pagination.repeated_field_is_a_map?
  end
end
