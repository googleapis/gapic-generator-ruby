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

##
# Annotation parsing ('given annotation X, this is the result of its analysis')
# tests for the Explicit Routing Headers.
#
class ExplictRoutingHeadersModelTest < Minitest::Test
  ##
  # Test simple header patterns
  #
  def test_simple_patterns
    routing_mock = OpenStruct.new(
      routing_parameters: [
        OpenStruct.new(field: "take_field", path_template: ""),
        OpenStruct.new(field: "rename_field_1", path_template: "{new_name_1}"),
        OpenStruct.new(field: "rename_field_2", path_template: "{new_name_2=*}"),
        OpenStruct.new(field: "rename_field_3", path_template: "{new_name_3=**}"),
        OpenStruct.new(field: "match_full_field", path_template: "{match_full_field=projects/*/instances/*/tables/*}"),
        OpenStruct.new(field: "match_and_rename", path_template: "{new_name_match=projects/*/instances/*/tables/*}")
      ]
    )
    routing = Gapic::Model::Method::Routing.new routing_mock, nil

    assert routing.explicit_annotation?
    expected = {
      "take_field" => [{
        field: "take_field",
        field_pattern: "**",
        value_pattern: "**",
        pattern_matching_not_needed?: true,
        value_is_full_field?: true
      }],
      "new_name_1" => [{
        field: "rename_field_1",
        field_pattern: "*",
        value_pattern: "*",
        pattern_matching_not_needed?: false,
        value_is_full_field?: true
      }],
      "new_name_2" => [{
        field: "rename_field_2",
        field_pattern: "*",
        value_pattern: "*",
        pattern_matching_not_needed?: false,
        value_is_full_field?: true
      }],
      "new_name_3" => [{
        field: "rename_field_3",
        field_pattern: "**",
        value_pattern: "**",
        pattern_matching_not_needed?: true,
        value_is_full_field?: true
      }],
      "match_full_field" => [{
        field: "match_full_field",
        field_pattern: "projects/*/instances/*/tables/*",
        value_pattern: "projects/*/instances/*/tables/*",
        pattern_matching_not_needed?: false,
        value_is_full_field?: true
      }],
      "new_name_match" => [{
        field: "match_and_rename",
        field_pattern: "projects/*/instances/*/tables/*",
        value_pattern: "projects/*/instances/*/tables/*",
        pattern_matching_not_needed?: false,
        value_is_full_field?: true
      }]
    }

    assert_routing_matches expected, routing.explicit_params
  end

  ##
  # Test multiple patterns that might conflict
  #
  def test_overlapping_patterns
    routing_mock = OpenStruct.new(
      routing_parameters: [
        OpenStruct.new(field: "table_name", path_template: "{routing_id=projects/*}/**"),
        OpenStruct.new(field: "table_name", path_template: "{routing_id=projects/*/instances/*}/**")
      ]
    )

    routing = Gapic::Model::Method::Routing.new routing_mock, nil
    assert routing.explicit_annotation?
    expected = {
      "routing_id" => [
        {
          field: "table_name",
          value_pattern: "projects/*",
          field_pattern: "projects/*/**",
          pattern_matching_not_needed?: false,
          value_is_full_field?: false
        },
        {
          field: "table_name",
          value_pattern: "projects/*/instances/*",
          field_pattern: "projects/*/instances/*/**",
          pattern_matching_not_needed?: false,
          value_is_full_field?: false
        }
      ]
    }

    assert_routing_matches expected, routing.explicit_params
  end

  ##
  # Test complex pattern that conflict and overlap
  #
  def test_complex_patterns
    routing_mock = OpenStruct.new(
      routing_parameters: [
        OpenStruct.new(field: "table_name", path_template: "projects/*/{table_location=instances/*}/tables/*"),
        OpenStruct.new(field: "table_name", path_template: "{table_location=regions/*/zones/*}/tables/*"),
        OpenStruct.new(field: "table_name", path_template: "{routing_id=projects/*}/**"),
        OpenStruct.new(field: "app_profile_id", path_template: "{routing_id=**}"),
        OpenStruct.new(field: "app_profile_id", path_template: "profiles/{routing_id=*}")
      ]
    )
    routing = Gapic::Model::Method::Routing.new routing_mock, nil
    assert routing.explicit_annotation?
    expected = {
      "table_location" => [
        {
          field: "table_name",
          field_pattern: "projects/*/instances/*/tables/*",
          value_pattern: "instances/*",
          pattern_matching_not_needed?: false
        },
        {
          field: "table_name",
          field_pattern: "regions/*/zones/*/tables/*",
          value_pattern: "regions/*/zones/*",
          pattern_matching_not_needed?: false
        }
      ],
      "routing_id" => [
        {
          field: "table_name",
          field_pattern: "projects/*/**",
          value_pattern: "projects/*",
          pattern_matching_not_needed?: false
        },
        {
          field: "app_profile_id",
          field_pattern: "**",
          value_pattern: "**",
          pattern_matching_not_needed?: true
        },
        {
          field: "app_profile_id",
          field_pattern: "profiles/*",
          value_pattern: "*",
          pattern_matching_not_needed?: false
        }
      ]
    }

    assert_routing_matches expected, routing.explicit_params
  end

  ##
  # A helper to compare parsed routing header annotation to the expected.
  # In the `expected`, the parameters are grouped by the name of the routing header.
  def assert_routing_matches expected, actual
    error_msg_end = "\nExpected: \n#{expected}\nActual: \n#{actual}"

    # Base asserts
    refute actual.nil?, "Actual should not be nil!#{error_msg_end}"
    assert_equal expected.count, actual.count,
                 "Expected and Actual should have same amount of header keys#{error_msg_end}"

    # Per-header analysis
    # The parameters are grouped by the headers, so first we loop through the header groups
    expected.each do |header_key, exp_val_arr|
      assert actual.key?(header_key), "Actual should has a header key `#{header_key}`!" + error_msg_end
      act_val_arr = actual[header_key]

      assert_equal(exp_val_arr.count, act_val_arr.count,
                   "Expected['#{header_key}'] and Actual['#{header_key}'] " \
                   "should have same amount of parameters" + error_msg_end)

      # Within the header group, the per-parameter comparison.
      # The order should match, so the parameter at position `i` in expected
      # should match the parameter in the position `i` in actual
      exp_val_arr.each_with_index do |exp_val, index|
        act_val = act_val_arr[index]
        all_subfields_match = true

        # Compare the keys specified in expected to the fields in actual
        exp_val.each do |exp_subkey, exp_subval|
          subfield_match = act_val.respond_to?(exp_subkey) && exp_subval == act_val.send(exp_subkey)
          all_subfields_match &&= subfield_match
        end

        next if all_subfields_match
        expected_err = "Value from Expected['#{header_key}'] at index #{index}: \n#{exp_val}"
        act_err = "Value from Actual['#{header_key}'] at index #{index}: \n#{act_val}"
        assert all_subfields_match,
               "Cannot find a match for a value in Expected['#{header_key}'] at index #{index}:\n" \
               "#{expected_err}\n#{act_err}\n" + error_msg_end
      end
    end
  end
end
