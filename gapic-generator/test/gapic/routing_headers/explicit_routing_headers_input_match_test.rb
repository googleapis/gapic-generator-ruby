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
# Input matching ('given annotation X and input message Y, header should be Z')
# tests for the Explicit Routing Headers.
# The structure of these tests is lifted from the `routing.proto`.
#
class ExplictRoutingHeadersInputMatchTest < Minitest::Test
  # Extracting a field from the request to put into the routing header
  # unchanged, with the key equal to the field name.
  def test_simple_extraction
    routing_mock = OpenStruct.new(
      routing_parameters: [
        OpenStruct.new(field: "app_profile_id", path_template: "")
      ]
    )

    routing = Gapic::Model::Method::Routing.new routing_mock, nil

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

    assert_regex_matches routing, test_cases
  end

  # Extracting a field from the request to put into the routing header
  # unchanged, with the key different from the field name.
  def test_rename_extraction
    routing_mock = OpenStruct.new(
      routing_parameters: [
        OpenStruct.new(field: "app_profile_id", path_template: "{routing_id=**}")
      ]
    )

    routing = Gapic::Model::Method::Routing.new routing_mock, nil

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

    assert_regex_matches routing, test_cases
  end

  def test_nested_field
    routing_mock = OpenStruct.new(
      routing_parameters: [
        OpenStruct.new(field: "sub.name", path_template: "subs/{sub_name}"),
        OpenStruct.new(field: "app_profile_id", path_template: "{legacy.routing_id=**}")
      ]
    )

    routing = Gapic::Model::Method::Routing.new routing_mock, nil

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

    assert_regex_matches routing, test_cases
  end

  # Extracting a field from the request to put into the routing
  # header, while matching a path template syntax on the field's value.
  def test_field_match
    routing_mock = OpenStruct.new(
      routing_parameters: [
        OpenStruct.new(field: "table_name", path_template: "{table_name=projects/*/instances/*/**}"),
        OpenStruct.new(field: "table_name", path_template: "{table_name=regions/*/zones/*/**}")
      ]
    )

    routing = Gapic::Model::Method::Routing.new routing_mock, nil

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

    assert_regex_matches routing, test_cases
  end

  # Extracting a single routing header key-value pair by matching a
  # template syntax on (a part of) a single request field.
  def test_simple_extract
    routing_mock = OpenStruct.new(
      routing_parameters: [
        OpenStruct.new(field: "table_name", path_template: "{routing_id=projects/*}/**")
      ]
    )

    routing = Gapic::Model::Method::Routing.new routing_mock, nil

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

    assert_regex_matches routing, test_cases
  end

  # Extracting a single routing header key-value pair by matching
  # several conflictingly named path templates on (parts of) a single request
  # field. The last template to match "wins" the conflict.
  def test_overlapping_patterns
    routing_mock = OpenStruct.new(
      routing_parameters: [
        OpenStruct.new(field: "table_name", path_template: "{routing_id=projects/*}/**"),
        OpenStruct.new(field: "table_name", path_template: "{routing_id=projects/*/instances/*}/**")
      ]
    )
    routing = Gapic::Model::Method::Routing.new routing_mock, nil

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

    assert_regex_matches routing, test_cases
  end

  # Extracting multiple routing header key-value pairs by matching
  # several non-conflicting path templates on (parts of) a single request field.
  # Make the templates strict, so that if the `table_name` does not
  # have an instance information, nothing is sent.
  def test_multiple_keyvaluepairs_strict
    routing_mock = OpenStruct.new(
      routing_parameters: [
        OpenStruct.new(field: "table_name", path_template: "{project_id=projects/*}/instances/*/**"),
        OpenStruct.new(field: "table_name", path_template: "projects/*/{instance_id=instances/*}/**")
      ]
    )

    routing = Gapic::Model::Method::Routing.new routing_mock, nil

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

    assert_regex_matches routing, test_cases
  end

  # Extracting multiple routing header key-value pairs by matching
  # several non-conflicting path templates on (parts of) a single request field.
  # Make the templates loose, so that if the `table_name` does not
  # have an instance information, just the project id part is sent.
  def test_multiple_keyvaluepairs_loose
    routing_mock = OpenStruct.new(
      routing_parameters: [
        OpenStruct.new(field: "table_name", path_template: "{project_id=projects/*}/**"),
        OpenStruct.new(field: "table_name", path_template: "projects/*/{instance_id=instances/*}/**")
      ]
    )

    routing = Gapic::Model::Method::Routing.new routing_mock, nil

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

    assert_regex_matches routing, test_cases
  end

  # Extracting multiple routing header key-value pairs by matching
  # several path templates on multiple request fields.
  def test_multple_request_fields
    routing_mock = OpenStruct.new(
      routing_parameters: [
        OpenStruct.new(field: "table_name", path_template: "{project_id=projects/*}/**"),
        OpenStruct.new(field: "app_profile_id", path_template: "{routing_id=**}")
      ]
    )

    routing = Gapic::Model::Method::Routing.new routing_mock, nil

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

    assert_regex_matches routing, test_cases
  end

  # Extracting a single routing header key-value pair by matching
  # several conflictingly named path templates on several request fields. The
  # last template to match "wins" the conflict.
  def test_multple_conflicts_and_request_fields
    routing_mock = OpenStruct.new(
      routing_parameters: [
        OpenStruct.new(field: "table_name", path_template: "{routing_id=projects/*}/**"),
        OpenStruct.new(field: "table_name", path_template: "{routing_id=regions/*}/**"),
        OpenStruct.new(field: "app_profile_id", path_template: "{routing_id=**}")
      ]
    )

    routing = Gapic::Model::Method::Routing.new routing_mock, nil

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

    assert_regex_matches routing, test_cases
  end

  # Test a complex scenario with a kitchen sink of concerns
  def test_complex_scenario
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

    assert_regex_matches routing, test_cases
  end

  # Test percent-encoding
  def test_encoding
    routing_mock = OpenStruct.new(
      routing_parameters: [
        OpenStruct.new(field: "table_name", path_template: "{project=projects/*}/**"),
        OpenStruct.new(field: "table_name", path_template: "projects/*/{instance=instances/*}/**")
      ]
    )

    routing = Gapic::Model::Method::Routing.new routing_mock, nil

    test_cases = [
      {
        request: OpenStruct.new(table_name: "projects/100/instances/200"),
        expected: "project=projects%2F100&instance=instances%2F200"
      },
      {
        request: OpenStruct.new(table_name: "projects/_-_._/instances/_=_#_"),
        expected: "project=projects%2F_-_._&instance=instances%2F_%3D_%23_"
      }
    ]

    assert_regex_matches routing, test_cases, percent_encode: true
  end

  private

  ##
  # A helper to run multiple test cases for the input match
  # and report which of them fail
  # Does not encode the result by default to make expected cases more legible
  def assert_regex_matches routing, test_cases, percent_encode: false
    test_cases.each do |test_case|
      request = test_case[:request]
      expected = test_case[:expected]

      err_str = "Test case:\nRequest: \n#{request.pretty_inspect}\nExpected: \n#{expected.pretty_inspect}"

      headers = {}
      routing.explicit_params.each do |key, param_arr|
        param_arr.each do |param|
          field_val = get_field_val param.field.to_s, request
          if field_val && !field_val.empty? && Regexp.new(param.field_regex_str).match?(field_val)
            headers[key] = Regexp.new(param.field_full_regex_str).match(field_val)[key.to_s]
          end
        end
      end

      err_str = "#{err_str}\nHeaders formed: \n #{headers.pretty_inspect}"
      err_str = "#{err_str}\nRouting: #{routing.explicit_params.pretty_inspect}"

      if percent_encode
        assert_equal expected, URI.encode_www_form(headers), err_str
      else
        assert_equal expected, headers.map { |key, value| "#{key}=#{value}" }.join("&"), err_str
      end
    end
  end

  ##
  # A helper to get to the value of a sub-field of the request by the field path.
  # E.g. given "foo.bar.baz" returns the converted to string value of the "request.foo.bar.baz".
  #
  # @param field [String] full name of the (sub-) field, e.g. "foo" or "foo.bar.baz"
  # @param request [Object] a request object
  #
  # @return [String, nil] either a value of the sub-field converted to string
  #    or nil if a sub-field does not exit or is itself nil
  def get_field_val field, request
    field_path = field.split "."

    curr_submessage = request
    field_path.each do |curr_field|
      return nil unless curr_submessage.respond_to? curr_field
      curr_submessage = curr_submessage.send curr_field
    end

    curr_submessage&.to_s
  end
end
