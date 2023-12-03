# frozen_string_literal: true

# Copyright 2022 Google LLC
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
require_relative "snippet_test_helper"
require "gapic/presenters/snippet/request_initialization_presenters"

class RequestInitializationPresenterTest < PresenterTest
  include SnippetTestHelper

  REQUEST_TYPE = "Google::Cloud::MyAPI::V1::MyRequest"
  STANDARD_REQUEST_NAME = "request"

  def build_simple_presenter json, phase1: false
    klass = Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::SimpleRequestInitialization
    proto = build_proto_fragment klass, json if json
    Gapic::Presenters::SnippetPresenter::SimpleRequestInitializationPresenter.new \
      proto, json, request_type: REQUEST_TYPE, phase1: phase1
  end

  def build_streaming_presenter json, phase1: false
    klass = Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::StreamingRequestInitialization
    proto = build_proto_fragment klass, json if json
    Gapic::Presenters::SnippetPresenter::StreamingRequestInitializationPresenter.new \
      proto, json, request_name: STANDARD_REQUEST_NAME, request_type: REQUEST_TYPE, phase1: phase1
  end

  def test_simple_phase1
    presenter = build_simple_presenter nil, phase1: true
    expected = [
      "# Create a request. To set request fields, pass in keyword arguments.",
      "request = #{REQUEST_TYPE}.new"
    ]
    assert_equal expected, presenter.render_precall_lines
    assert_empty presenter.render_postcall_lines
    assert_equal "request", presenter.request_name
  end

  def test_simple_value
    json = {
      "requestValue" => {
        "complexValue" => {
          "properties" => {
            "name" => {
              "stringValue" => "Jane Doe"
            },
            "age" => {
              "numberValue" => 21
            }
          }
        }
      },
      "requestName" => "the_request"
    }
    presenter = build_simple_presenter json
    expected = [
      "the_request = {",
      "  age: 21,",
      '  name: "Jane Doe"',
      "}"
    ]
    assert_equal expected, presenter.render_precall_lines
    assert_empty presenter.render_postcall_lines
    assert_equal "the_request", presenter.request_name
  end

  def test_simple_value_with_pre_lines
    json = {
      "preRequestInitialization" => [
        {
          "declaration" => {
            "name" => "age",
            "value" => {
              "numberValue" => 21
            }
          }
        }
      ],
      "requestValue" => {
        "complexValue" => {
          "properties" => {
            "name" => {
              "stringValue" => "Jane Doe"
            },
            "age" => {
              "nameValue" => {
                "name" => "age"
              }
            }
          }
        }
      },
      "requestName" => "the_request"
    }
    presenter = build_simple_presenter json
    expected = [
      "age = 21",
      "the_request = {",
      "  age: age,",
      '  name: "Jane Doe"',
      "}"
    ]
    assert_equal expected, presenter.render_precall_lines
    assert_empty presenter.render_postcall_lines
    assert_equal "the_request", presenter.request_name
  end

  def test_streaming_phase1
    presenter = build_streaming_presenter nil, phase1: true
    expected_precall = [
      "# Create an input stream.",
      "request = Gapic::StreamInput.new"
    ]
    expected_postcall = [
      "# Send requests on the stream. For each request object, set fields by",
      "# passing keyword arguments. Be sure to close the stream when done.",
      "request << #{REQUEST_TYPE}.new",
      "request << #{REQUEST_TYPE}.new",
      "request.close"
    ]
    assert_equal expected_precall, presenter.render_precall_lines
    assert_equal expected_postcall, presenter.render_postcall_lines
    assert_equal "request", presenter.request_name
  end

  def test_streaming_full
    json = {
      "firstStreamingRequest" => {
        "preRequestInitialization" => [
          {
            "declaration" => {
              "name" => "field1",
              "value" => {
                "stringValue" => "NAME"
              }
            }
          },
          {
            "declaration" => {
              "name" => "field2",
              "value" => {
                "stringValue" => "AGE"
              }
            }
          }
        ],
        "requestValue" => {
          "listValue" => {
            "values" => [
              {
                "nameValue" => {
                  "name" => "field1"
                }
              },
              {
                "nameValue" => {
                  "name" => "field2"
                }
              }
            ]
          }
        },
        "requestName" => "first_request"
      },
      "iteration" => {
        "mapIteration" => {
          "map" => {
            "type" => {
              "mapType" => {
                "keyType" => {
                  "scalarType" => "TYPE_STRING"
                },
                "valueType" => {
                  "scalarType" => "TYPE_DOUBLE"
                }
              }
            },
            "name" => "people",
            "value" => {
              "mapValue" => {
                "keys" => [
                  {
                    "stringValue" => "Jane Doe"
                  },
                  {
                    "stringValue" => "John Doe"
                  }
                ],
                "values" => [
                  {
                    "numberValue" => 21
                  },
                  {
                    "numberValue" => 20
                  }
                ]
              }
            }
          },
          "currentKeyName" => "name",
          "currentValueName" => "age"
        }
      },
      "streamingRequest" => {
        "requestValue" => {
          "complexValue" => {
            "properties" => {
              "name" => {
                "nameValue" => {
                  "name" => "name"
                }
              },
              "age" => {
                "nameValue" => {
                  "name" => "age"
                }
              }
            }
          }
        },
        "requestName" => "next_request"
      }
    }
    presenter = build_streaming_presenter json
    expected_precall = [
      "request = Gapic::StreamInput.new"
    ]
    expected_postcall = [
      'field1 = "NAME"',
      'field2 = "AGE"',
      "first_request = [",
      "  field1,",
      "  field2",
      "]",
      "request << first_request",
      "people = {",
      '  "Jane Doe" => 21,',
      '  "John Doe" => 20',
      "}",
      "people.each do |name, age|",
      "  next_request = {",
      "    age: age,",
      "    name: name",
      "  }",
      "  request << next_request",
      "end",
      "request.close"
    ]
    assert_equal expected_precall, presenter.render_precall_lines
    assert_equal expected_postcall, presenter.render_postcall_lines
    assert_equal "request", presenter.request_name
  end
end
