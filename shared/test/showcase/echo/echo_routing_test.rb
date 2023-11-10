# frozen_string_literal: true

# Copyright 2023 Google LLC
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
require "google/showcase/v1beta1/echo"
require "grpc"

class EchoRoutingTest < ShowcaseTest
  def setup client=nil
    @client = client
  end

  # Currently cannot be done from the standard test battery in routing.proto:
  # - test_nested_field (no nested field in EchoRequest)
  # - test_overlapping_patterns -- no conflicting overlapping patterns
  # - test_multiple_keyvaluepairs_strict -- requires a very specific pattern setup
  # - test_multiple_conflicts_and_request_fields -- no conflicts
  # - test_complex_scenario -- no conflicts

  # Extracting a field from the request to put into the routing header
  # unchanged, with the key equal to the field name.
  # Extracting a field from the request to put into the routing header
  # unchanged, with the key different from the field name.
  #
  # This tests:
  # - test_simple_extraction
  # - test_rename_extraction
  def test_simple_and_rename_extraction
    test_cases = [
      {
        header_field: "foo.123",
        expected: ["header=foo.123", "routing_id=foo.123"]
      },
      {
        header_field: "projects/100",
        expected: "super_id=projects/100"
      },
    ]

    assert_matches @client, test_cases
  end

  # Extracting a field from the request to put into the routing
  # header, while matching a path template syntax on the field's value.
  # Extracting a single routing header key-value pair by matching a
  # template syntax on (a part of) a single request field.
  #
  # This tests: 
  # - test_field_match
  # - test_simple_extract
  # - test_multiple_keyvaluepairs_loose
  def test_field_match_simple_extract_multiple_kvp
    test_cases = [
      {
        header_field: "projects/100/instances/200",
        expected: ["super_id=projects/100", "table_name=projects/100/instances/200", "instance_id=instances/200"]
      },
      {
        header_field: "regions/100/zones/200",
        expected: ["table_name=regions/100/zones/200",]
      },
      {
        header_field: "projects/100/instances/200/whatever",
        expected: ["super_id=projects/100", "table_name=projects/100/instances/200/whatever", "instance_id=instances/200"]
      },
    ]

    assert_matches @client, test_cases
  end

  # Extracting multiple routing header key-value pairs by matching
  # several path templates on multiple request fields.
  #
  # This tests: 
  # - test_multiple_request_fields
  # - test_complex_scenario (only partially since no conflicts)
  def test_multiple_request_fields_conflicts
    test_cases = [
      {
        header_field: "projects/100",
        other_header_field: "projects/100/misc",
        expected: ["super_id=projects/100", "qux=projects/100", "baz=projects/100/misc"]
      },
      {
        header_field: "projects/100",
        other_header_field: "foo.123",
        expected: ["super_id=projects/100", "baz=foo.123"]
      },
    ]

    assert_matches @client, test_cases
  end

  def assert_matches client, test_cases
    return unless client
    test_cases.each do |test_case|
      request = { content: "foo", header: test_case[:header_field] }
      request[:other_header] = test_case[:other_header_field] if test_case.key? :other_header_field
      @client.echo request do |response, operation|
        assert_kind_of ::Hash, operation.metadata
        assert operation.metadata.key? "x-goog-request-params"

        expected = test_case[:expected]
        expected = [expected] unless expected.is_a? ::Array

        routing_keyvals = operation.metadata["x-goog-request-params"]

        routing_keys = routing_keyvals.split("&").map { |kvp| kvp.split("=")[0]}
        expected_keys = expected.map {|kvp| kvp.split("=")[0]}

        expected_keys.append("header") unless expected_keys.include? "header"
        expected_keys.append("routing_id") unless expected_keys.include? "routing_id"

        err_str = "Test case keys mismatch:\nRequest: \n#{request.pretty_inspect}\nExpected: \n#{expected.pretty_inspect}" \
        "\nHeaders formed: \n #{routing_keys}"

        assert_equal expected_keys.sort, routing_keys.sort, err_str

        expected.each do |expected_elem|
          expected_elem_encoded = URI.encode_www_form([expected_elem.split("=")])

          err_str = "Test case:\nRequest: \n#{request.pretty_inspect}\nExpected: \n#{expected_elem.pretty_inspect}" \
          "\nEncoded: #{expected_elem_encoded}"
          
          err_str = "#{err_str}\nRouting header formed: \n #{routing_keys}"

          assert_match expected_elem_encoded, routing_keyvals, err_str
        end
      end
    end
  end
end

class EchoRoutingGRPCTest < EchoRoutingTest
  def setup
    super new_echo_client
  end
end
