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

  def test_compute_list_peering_routes
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes"
    assert presenter.rest.compute_pagination
    assert presenter.rest.paged?
    assert_equal "items", presenter.rest.paged_response_repeated_field_name
  end

  def test_compute_list_peering_routes_replacement_no_repeated
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes" do |api_obj, _, method|
      message = api_obj.messages.find { |m| m.address.join(".") == "google.cloud.compute.v1.TestResponseNoRepeated" }
      refute_nil message, "Replacement message should exist"
      method.instance_variable_set :@output, message
    end

    assert presenter.rest.compute_pagination
    refute presenter.rest.paged?
  end

  def test_compute_list_peering_routes_replacement_multi_repeated
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes" do |api_obj, _, method|
      message = api_obj.messages.find { |m| m.address.join(".") == "google.cloud.compute.v1.TestResponseMultiRepeated" }
      refute_nil message, "Replacement message should exist"
      method.instance_variable_set :@output, message
    end

    assert presenter.rest.compute_pagination
    assert presenter.rest.paged?
    assert_equal "first_repeated", presenter.rest.paged_response_repeated_field_name
  end

  def test_compute_list_peering_routes_replacement_single_map
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes" do |api_obj, _, method|
      message = api_obj.messages.find { |m| m.address.join(".") == "google.cloud.compute.v1.TestResponseSingleMap" }
      refute_nil message, "Replacement message should exist"
      method.instance_variable_set :@output, message
    end

    assert presenter.rest.compute_pagination
    assert presenter.rest.paged?
    assert_equal "first_map", presenter.rest.paged_response_repeated_field_name
  end

  def test_compute_list_peering_routes_replacement_multi_map_no_repeated
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes" do |api_obj, _, method|
      message = api_obj.messages.find { |m| m.address.join(".") == "google.cloud.compute.v1.TestResponseMultiMapNoRepeated" }
      refute_nil message, "Replacement message should exist"
      method.instance_variable_set :@output, message
    end

    assert presenter.rest.compute_pagination
    refute presenter.rest.paged?
  end

  def test_compute_list_peering_routes_replacement_multi_map_with_repeated
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes" do |api_obj, _, method|
      message = api_obj.messages.find { |m| m.address.join(".") == "google.cloud.compute.v1.TestResponseMultiMapWithRepeated" }
      refute_nil message, "Replacement message should exist"
      method.instance_variable_set :@output, message
    end

    assert presenter.rest.compute_pagination
    assert presenter.rest.paged?
    assert_equal "first_repeated", presenter.rest.paged_response_repeated_field_name
  end

  def test_compute_list_peering_routes_replacement_inverted_order
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes" do |api_obj, _, method|
      message = api_obj.messages.find { |m| m.address.join(".") == "google.cloud.compute.v1.TestResponseInvertedOrder" }
      refute_nil message, "Replacement message should exist"
      method.instance_variable_set :@output, message
    end
    
    assert_raises StandardError do |e|
      assert presenter.rest.compute_pagination
      assert presenter.rest.paged?
      assert_equal "first_repeated", presenter.rest.paged_response_repeated_field_name
      assert_contains e.message, "AIP-4233"
    end
  end
end
