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
require "gapic/presenters/method/compute_pagination_info"

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

  # No maps, no repeated -> Model error
  def test_compute_list_peering_routes_replacement_no_repeated
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes" do |api_obj, _, method|
      message = api_obj.messages.find { |m| m.address.join(".") == "google.cloud.compute.v1.TestResponseNoRepeated" }
      refute_nil message, "Replacement message should exist"
      method.instance_variable_set :@output, message
    end

    e = assert_raises StandardError do
      presenter.rest.paged?
    end
    assert_includes e.message, "0 (!= 1) map fields and no repeated fields"
  end

  # Multiple maps, no repeated -> Model error
  def test_compute_list_peering_routes_replacement_multimap_no_repeated
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes" do |api_obj, _, method|
      message = api_obj.messages.find { |m| m.address.join(".") == "google.cloud.compute.v1.TestResponseMultiMapNoRepeated" }
      refute_nil message, "Replacement message should exist"
      method.instance_variable_set :@output, message
    end

    e = assert_raises StandardError do
      presenter.rest.paged?
    end
    assert_includes e.message, "2 (!= 1) map fields"
  end

  # Two repeateds, one message-typed, one String -> paginating on message-typed repeated.
  def test_compute_list_peering_routes_replacement_two_repeated_correct_configuration
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes" do |api_obj, _, method|
      message = api_obj.messages.find { |m| m.address.join(".") == "google.cloud.compute.v1.TestResponseTwoRepeatedCorrectConfiguration" }
      refute_nil message, "Replacement message should exist"
      method.instance_variable_set :@output, message
    end

    assert presenter.rest.compute_pagination
    assert presenter.rest.paged?
    assert_equal "items", presenter.rest.paged_response_repeated_field_name
  end

  # Two repeateds, one message-typed, one String -> paginating on message-typed repeated.
  def test_compute_list_peering_routes_replacement_two_repeated_wrong_configuration
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes" do |api_obj, _, method|
      message = api_obj.messages.find { |m| m.address.join(".") == "google.cloud.compute.v1.TestResponseTwoRepeatedWrongConfiguration" }
      refute_nil message, "Replacement message should exist"
      method.instance_variable_set :@output, message
    end

    e = assert_raises StandardError do
      presenter.rest.paged?
    end
    assert_includes e.message, "a configuration of exactly 2 repeated fields"
  end

  # 3+ repeated -> Model error
  def test_compute_list_peering_routes_replacement_three_repeated
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes" do |api_obj, _, method|
      message = api_obj.messages.find { |m| m.address.join(".") == "google.cloud.compute.v1.TestResponseThreeRepeated" }
      refute_nil message, "Replacement message should exist"
      method.instance_variable_set :@output, message
    end

    e = assert_raises StandardError do
      presenter.rest.paged?
    end
    assert_includes e.message, "3 (>= 3) repeated fields"
  end

  # One map element -> paginated on map element.
  def test_compute_list_peering_routes_replacement_single_map
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes" do |api_obj, _, method|
      message = api_obj.messages.find { |m| m.address.join(".") == "google.cloud.compute.v1.TestResponseSingleMap" }
      refute_nil message, "Replacement message should exist"
      method.instance_variable_set :@output, message
    end

    assert presenter.rest.compute_pagination
    assert presenter.rest.paged?
    assert_equal "items", presenter.rest.paged_response_repeated_field_name
  end

  # Multiple maps, multiple repeated with correct configuration -> paginated on `items`.
  def test_compute_list_peering_routes_replacement_multi_map_correct_repeated
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes" do |api_obj, _, method|
      message = api_obj.messages.find { |m| m.address.join(".") == "google.cloud.compute.v1.TestResponseMultiMapCorrectRepeated" }
      refute_nil message, "Replacement message should exist"
      method.instance_variable_set :@output, message
    end

    assert presenter.rest.compute_pagination
    assert presenter.rest.paged?
    assert_equal "items", presenter.rest.paged_response_repeated_field_name
  end

  # Testing special dictionary. This method replaces the response message with one with three repeated fields.
  # This would normally result in model error. But additionally the test modifies the REPEATED_FIELD_SPECIAL_DICTIONARY
  # to include the full message name as the key and  the repeated field name as the value.
  # Therefore pagination heuristic succeeds.
  # This mimics the real world case of `google.cloud.compute.v1.UsableSubnetworksAggregatedList`
  def test_compute_list_peering_routes_replacement_three_repeated_special_dict_success
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes" do |api_obj, _, method|
      message = api_obj.messages.find { |m| m.address.join(".") == "google.cloud.compute.v1.TestResponseThreeRepeated" }
      refute_nil message, "Replacement message should exist"
      method.instance_variable_set :@output, message
    end

    special_dict = {
       "google.cloud.compute.v1.TestResponseThreeRepeated" => "items",
    }

    old_val = ::Gapic::Presenters::Method::ComputePaginationInfo.const_get(:REPEATED_FIELD_SPECIAL_DICTIONARY)
    ::Gapic::Presenters::Method::ComputePaginationInfo.const_set(:REPEATED_FIELD_SPECIAL_DICTIONARY, special_dict)
    assert presenter.rest.compute_pagination
    assert presenter.rest.paged?
    assert_equal "items", presenter.rest.paged_response_repeated_field_name
    ::Gapic::Presenters::Method::ComputePaginationInfo.const_set(:REPEATED_FIELD_SPECIAL_DICTIONARY, old_val)
  end

  # Testing special dictionary. This method replaces the response message with one with three repeated fields.
  # In addition the test modifies the REPEATED_FIELD_SPECIAL_DICTIONARY to include the full message name as the key
  # (just like the previous test). This should mean that the pagination heuristic succeeds. But the value
  # in the special dictionary now points at the non-repeated field, resulting in ModelError.
  def test_compute_list_peering_routes_replacement_three_repeated_special_dict_failure
    presenter = method_presenter :compute_small, "Networks", "ListPeeringRoutes" do |api_obj, _, method|
      message = api_obj.messages.find { |m| m.address.join(".") == "google.cloud.compute.v1.TestResponseThreeRepeated" }
      refute_nil message, "Replacement message should exist"
      method.instance_variable_set :@output, message
    end

    special_dict = {
       "google.cloud.compute.v1.TestResponseThreeRepeated" => "id",
    }

    old_val = ::Gapic::Presenters::Method::ComputePaginationInfo.const_get(:REPEATED_FIELD_SPECIAL_DICTIONARY)
    ::Gapic::Presenters::Method::ComputePaginationInfo.const_set(:REPEATED_FIELD_SPECIAL_DICTIONARY, special_dict)
    e = assert_raises StandardError do
      presenter.rest.paged?
    end
    assert_includes e.message, "field is not a map or repeated field"
    ::Gapic::Presenters::Method::ComputePaginationInfo.const_set(:REPEATED_FIELD_SPECIAL_DICTIONARY, old_val)
  end
end
