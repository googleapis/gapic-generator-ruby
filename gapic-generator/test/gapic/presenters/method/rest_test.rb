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

class MethodPresenterRestTest < PresenterTest
  def test_compute_addresses_agglist
    presenter = method_presenter :compute_small, "Addresses", "AggregatedList"

    first_binding = presenter.http_bindings.first
    refute_nil first_binding

    assert presenter.routing_params?

    assert first_binding.verb?
    assert_equal first_binding.verb, :get

    refute presenter.nonstandard_lro?
  end

  def test_compute_addresses_delete
    presenter = method_presenter :compute_small, "Addresses", "Delete"
    assert presenter.nonstandard_lro?
    refute_nil presenter.lro
    assert presenter.lro.nonstandard_lro?
    assert_equal "google.cloud.compute.v1.RegionOperations", presenter.lro.service_full_name
    assert presenter.lro.operation_request_fields.key? "project"
    assert_equal "project", presenter.lro.operation_request_fields["project"]
    assert presenter.lro.operation_request_fields.key? "region"
    assert_equal "region", presenter.lro.operation_request_fields["region"]
  end

  def test_showcase_expand_server_streaming
    presenter = method_presenter :showcase, "Echo", "Expand"
    assert presenter.rest.server_streaming?
  end
end
