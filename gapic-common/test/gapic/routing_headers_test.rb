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
require "gapic/routing_headers"

class RoutingHeaderTest < Minitest::Test
  # Extracting a field from the request to put into the routing header
  # unchanged, with the key equal to the field name.
  def test_simple_extraction
    extractor = Gapic::RoutingHeaders::HeadersExtractor.new
                  .with_bindings(field: "app_profile_id")

    test_cases = [
      {
        request: OpenStruct.new(app_profile_id: "foo.123"),
        expected: "app_profile_id=foo.123"
      },
      {
        request: OpenStruct.new(app_profile_id: "projects/100"),
        expected: "app_profile_id=projects/100"
      },
      {
        request: OpenStruct.new(app_profile_id: ""),
        expected: ""
      }
    ]

    assert_regex_matches extractor, test_cases
  end

  # Extracting a field from the request to put into the routing header
  # unchanged, with the key different from the field name.
  def test_rename_extraction
    extractor = Gapic::RoutingHeaders::HeadersExtractor.new
      .with_bindings(field: "app_profile_id", header_name: "routing_id")

    test_cases = [
      {
        request: OpenStruct.new(app_profile_id: "foo123"),
        expected: "routing_id=foo123"
      },
      {
        request: OpenStruct.new(app_profile_id: "projects/100"),
        expected: "routing_id=projects/100"
      },
      {
        request: OpenStruct.new(app_profile_id: ""),
        expected: ""
      }
    ]

    assert_regex_matches extractor, test_cases
  end

  def test_nested_field
    extractor = Gapic::RoutingHeaders::HeadersExtractor.new
      .with_bindings(field: "sub.name", header_name: "sub_name", regex: %r{^subs/([^/]+)/?$})
      .with_bindings(field: "app_profile_id", header_name: "legacy.routing_id", regex: %r{^(.+)$})

    sub_message = OpenStruct.new name: "subs/100"
    test_cases = [
      {
        request: OpenStruct.new(app_profile_id: "routes/200"),
        expected: "legacy.routing_id=routes/200"
      },
      {
        request: OpenStruct.new(sub: sub_message, app_profile_id: "routes/200"),
        expected: "sub_name=100&legacy.routing_id=routes/200"
      }
    ]

    assert_regex_matches extractor, test_cases
  end

  # Extracting a field from the request to put into the routing
  # header, while matching a path template syntax on the field's value.
  def test_field_match
    extractor = Gapic::RoutingHeaders::HeadersExtractor.new
    .with_bindings(field: "table_name", regex: %r{^(projects/[^/]+/instances/[^/]+(?:/.*)?)$})
    .with_bindings(field: "table_name", regex: %r{^(regions/[^/]+/zones/[^/]+(?:/.*)?)$})

    test_cases = [
      {
        request: OpenStruct.new(table_name: "projects/100/instances/200"),
        expected: "table_name=projects/100/instances/200"
      },
      {
        request: OpenStruct.new(table_name: "projects/100/instances/200/whatever"),
        expected: "table_name=projects/100/instances/200/whatever"
      },
      {
        request: OpenStruct.new(table_name: "foo"),
        expected: ""
      }
    ]

    assert_regex_matches extractor, test_cases
  end

  # Extracting a single routing header key-value pair by matching a
  # template syntax on (a part of) a single request field.
  def test_simple_extract
    extractor = Gapic::RoutingHeaders::HeadersExtractor.new
    .with_bindings(field: "table_name", header_name: "routing_id", regex: %r{^(projects/[^/]+)(?:/.*)?$})

    test_cases = [
      {
        request: OpenStruct.new(table_name: "projects/100"),
        expected: "routing_id=projects/100"
      },
      {
        request: OpenStruct.new(table_name: "projects/100/instances/200"),
        expected: "routing_id=projects/100"
      },
      {
        request: OpenStruct.new(table_name: "regions/10/projects/100"),
        expected: ""
      },
      {
        request: OpenStruct.new(table_name: "foo"),
        expected: ""
      }
    ]

    assert_regex_matches extractor, test_cases
  end

  # Extracting a single routing header key-value pair by matching
  # several conflictingly named path templates on (parts of) a single request
  # field. The last template to match "wins" the conflict.
  def test_overlapping_patterns
    extractor = Gapic::RoutingHeaders::HeadersExtractor.new
    .with_bindings(field: "table_name", header_name: "routing_id", regex: %r{^(projects/[^/]+)(?:/.*)?$})
    .with_bindings(field: "table_name", header_name: "routing_id", regex: %r{^(projects/[^/]+/instances/[^/]+)(?:/.*)?$})

    test_cases = [
      {
        request: OpenStruct.new(table_name: "projects/100"),
        expected: "routing_id=projects/100"
      },
      {
        request: OpenStruct.new(table_name: "projects/100/shards/300"),
        expected: "routing_id=projects/100"
      },
      {
        request: OpenStruct.new(table_name: "projects/100/instances/200"),
        expected: "routing_id=projects/100/instances/200"
      },
      {
        request: OpenStruct.new(table_name: "projects/100/instances/200/shards/300"),
        expected: "routing_id=projects/100/instances/200"
      },
      {
        request: OpenStruct.new(table_name: "foo"),
        expected: ""
      },
      {
        request: OpenStruct.new(table_name: "orgs/1/projects/100/instances/200"),
        expected: ""
      }
    ]

    assert_regex_matches extractor, test_cases
  end

  # Extracting multiple routing header key-value pairs by matching
  # several non-conflicting path templates on (parts of) a single request field.
  # Make the templates strict, so that if the `table_name` does not
  # have an instance information, nothing is sent.
  def test_multiple_keyvaluepairs_strict
    extractor = Gapic::RoutingHeaders::HeadersExtractor.new
    .with_bindings(field: "table_name", header_name: "project_id", regex: %r{^(projects/[^/]+)/instances/[^/]+(?:/.*)?$})
    .with_bindings(field: "table_name", header_name: "instance_id", regex: %r{^projects/[^/]+/(instances/[^/]+)(?:/.*)?$})

    test_cases = [
      {
        request: OpenStruct.new(table_name: "projects/100/instances/200/tables/300"),
        expected: "project_id=projects/100&instance_id=instances/200"
      },
      {
        request: OpenStruct.new(table_name: "projects/100"),
        expected: ""
      }
    ]

    assert_regex_matches extractor, test_cases
  end

  # Extracting multiple routing header key-value pairs by matching
  # several non-conflicting path templates on (parts of) a single request field.
  # Make the templates loose, so that if the `table_name` does not
  # have an instance information, just the project id part is sent.
  def test_multiple_keyvaluepairs_loose
    extractor = Gapic::RoutingHeaders::HeadersExtractor.new
    .with_bindings(field: "table_name", header_name: "project_id", regex: %r{^(projects/[^/]+)(?:/.*)?$})
    .with_bindings(field: "table_name", header_name: "instance_id", regex: %r{^projects/[^/]+/(instances/[^/]+)(?:/.*)?$})

    test_cases = [
      {
        request: OpenStruct.new(table_name: "projects/100/instances/200/tables/300"),
        expected: "project_id=projects/100&instance_id=instances/200"
      },
      {
        request: OpenStruct.new(table_name: "projects/100"),
        expected: "project_id=projects/100"
      }
    ]

    assert_regex_matches extractor, test_cases
  end

  # Extracting multiple routing header key-value pairs by matching
  # several path templates on multiple request fields.
  def test_multple_request_fields
    extractor = Gapic::RoutingHeaders::HeadersExtractor.new
    .with_bindings(field: "table_name", header_name: "project_id", regex: %r{^(projects/[^/]+)(?:/.*)?$})
    .with_bindings(field: "app_profile_id", header_name: "routing_id", regex: %r{^(.+)$})

    test_cases = [
      {
        request: OpenStruct.new(table_name: "projects/100/instances/200/tables/300",
                                app_profile_id: "profiles/profile_17"),
        expected: "project_id=projects/100&routing_id=profiles/profile_17"
      },
      {
        request: OpenStruct.new(table_name: "projects/100"),
        expected: "project_id=projects/100"
      }
    ]

    assert_regex_matches extractor, test_cases
  end

  # Extracting a single routing header key-value pair by matching
  # several conflictingly named path templates on several request fields. The
  # last template to match "wins" the conflict.
  def test_multple_conflicts_and_request_fields
    extractor = Gapic::RoutingHeaders::HeadersExtractor.new
    .with_bindings(field: "table_name", header_name: "routing_id", regex: %r{^(projects/[^/]+)(?:/.*)?$})
    .with_bindings(field: "table_name", header_name: "routing_id", regex: %r{^(regions/[^/]+)(?:/.*)?$})
    .with_bindings(field: "app_profile_id", header_name: "routing_id", regex: %r{^(.+)$})

    test_cases = [
      {
        request: OpenStruct.new(table_name: "projects/100/instances/200/tables/300",
                                app_profile_id: "profiles/profile_17"),
        expected: "routing_id=profiles/profile_17"
      },
      {
        request: OpenStruct.new(table_name: "regions/100", app_profile_id: ""),
        expected: "routing_id=regions/100"
      }
    ]

    assert_regex_matches extractor, test_cases
  end

  # Test a complex scenario with a kitchen sink of concerns
  def test_complex_scenario
    extractor = Gapic::RoutingHeaders::HeadersExtractor.new
    .with_bindings(field: "table_name", header_name: "table_location", regex: %r{^projects/[^/]+/(instances/[^/]+)/tables/[^/]+/?$})
    .with_bindings(field: "table_name", header_name: "table_location", regex: %r{^(regions/[^/]+/zones/[^/]+)/tables/[^/]+/?$})
    .with_bindings(field: "table_name", header_name: "routing_id", regex: %r{^(projects/[^/]+)(?:/.*)?$})
    .with_bindings(field: "app_profile_id", header_name: "routing_id", regex: %r{^(.+)$})
    .with_bindings(field: "app_profile_id", header_name: "routing_id", regex: %r{^profiles/([^/]+)/?$})

    test_cases = [
      {
        request: OpenStruct.new(table_name: "projects/100/instances/200/tables/300",
                                app_profile_id: "profiles/profile_17"),
        expected: "table_location=instances/200&routing_id=profile_17"
      },
      {
        request: OpenStruct.new(table_name: "projects/100/instances/200/tables/300",
                                app_profile_id: "profile_17"),
        expected: "table_location=instances/200&routing_id=profile_17"
      },
      {
        request: OpenStruct.new(table_name: "projects/100/instances/200/tables/300",
                                app_profile_id: ""),
        expected: "table_location=instances/200&routing_id=projects/100"
      }
    ]

    assert_regex_matches extractor, test_cases
  end

  def assert_regex_matches extractor, test_cases
    test_cases.each do |test_case|
      request = test_case[:request]
      expected = test_case[:expected]
      err_str = "Test case:\nRequest: \n#{request.pretty_inspect}\nExpected: \n#{expected.pretty_inspect}"
      
      headers = extractor.extract_headers request
      err_str = "#{err_str}\nHeaders formed: \n #{headers.pretty_inspect}"

      assert_equal expected, headers.map { |key, value| "#{key}=#{value}" }.join("&"), err_str
    end
  end
end
