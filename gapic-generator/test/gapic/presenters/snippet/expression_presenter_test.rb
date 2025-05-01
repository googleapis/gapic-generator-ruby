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

class ExpressionPresenterTest < PresenterTest
  include SnippetTestHelper

  def build_expression_presenter json
    proto = build_proto_fragment Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Expression, json
    Gapic::Presenters::SnippetPresenter::ExpressionPresenter.new proto, json
  end

  def test_no_json
    presenter = build_expression_presenter nil
    refute presenter.exist?
  end

  def test_null
    json = {"nullValue" => "NULL_VALUE"}
    presenter = build_expression_presenter json
    assert_equal ["nil"], presenter.render_lines
  end

  def test_name
    json = {"nameValue" => {"name" => "foo"}}
    presenter = build_expression_presenter json
    assert_equal ["foo"], presenter.render_lines
  end

  def test_name_with_path
    json = {"nameValue" => {"name" => "foo", "path" => ["bar", "baz"]}}
    presenter = build_expression_presenter json
    assert_equal ["foo.bar.baz"], presenter.render_lines
  end

  def test_number
    json = {"numberValue" => 1.2}
    presenter = build_expression_presenter json
    assert_equal ["1.2"], presenter.render_lines
  end

  def test_number_integer
    json = {"numberValue" => 2}
    presenter = build_expression_presenter json
    assert_equal ["2"], presenter.render_lines
  end

  def test_string
    json = {"stringValue" => 'Hello, "Ruby"'}
    presenter = build_expression_presenter json
    assert_equal ['"Hello, \\"Ruby\\""'], presenter.render_lines
  end

  def test_boolean
    json = {"booleanValue" => true}
    presenter = build_expression_presenter json
    assert_equal ["true"], presenter.render_lines
  end

  def test_complex
    json = {
      "complexValue" => {
        "properties" => {
          "id" => {
            "nameValue" => {
              "name" => "my_id"
            }
          },
          "name" => {
            "stringValue" => "Jane Doe"
          },
          "age" => {
            "numberValue" => 21
          }
        }
      }
    }
    presenter = build_expression_presenter json
    expected = [
      "{",
      "  id: my_id,",
      "  age: 21,",
      '  name: "Jane Doe"',
      "}"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_complex_nested
    json = {
      "complexValue" => {
        "properties" => {
          "id" => {
            "nameValue" => {
              "name" => "my_id"
            }
          },
          "stats" => {
            "complexValue" => {
              "properties" => {
                "eyes" => {
                  "stringValue" => "brown",
                },
                "hair" => {
                  "stringValue" => "black",
                }
              }
            }
          },
          "name" => {
            "stringValue" => "Jane Doe"
          }
        }
      }
    }
    presenter = build_expression_presenter json
    expected = [
      "{",
      "  id: my_id,",
      "  stats: {",
      '    eyes: "brown",',
      '    hair: "black"',
      "  },",
      '  name: "Jane Doe"',
      "}"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_repeated_string
    json = {
      "listValue" => {
        "values" => [
          {
            "numberValue" => 1.2
          },
          {
            "numberValue" => 2
          }
        ]
      }
    }
    presenter = build_expression_presenter json
    expected = [
      "[",
      "  1.2,",
      "  2",
      "]"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_repeated_complex
    json = {
      "listValue" => {
        "values" => [
          {
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
          {
            "complexValue" => {
              "properties" => {
                "name" => {
                  "stringValue" => "John Doe"
                },
                "age" => {
                  "numberValue" => 20
                }
              }
            }
          }
        ]
      }
    }
    presenter = build_expression_presenter json
    expected = [
      "[",
      "  {",
      "    age: 21,",
      '    name: "Jane Doe"',
      "  },",
      "  {",
      "    age: 20,",
      '    name: "John Doe"',
      "  }",
      "]"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_map_simple
    json = {
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
    presenter = build_expression_presenter json
    expected = [
      "{",
      '  "Jane Doe" => 21,',
      '  "John Doe" => 20',
      "}"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_map_multiline
    json = {
      "mapValue" => {
        "keys" => [
          {
            "listValue" => {
              "values" => [
                {
                  "numberValue" => 1
                },
                {
                  "numberValue" => 2
                }
              ]
            }
          },
          {
            "listValue" => {
              "values" => [
                {
                  "numberValue" => 4
                },
                {
                  "numberValue" => 5
                }
              ]
            }
          }
        ],
        "values" => [
          {
            "listValue" => {
              "values" => [
                {
                  "stringValue" => "odd"
                },
                {
                  "stringValue" => "even"
                }
              ]
            }
          },
          {
            "listValue" => {
              "values" => [
                {
                  "stringValue" => "even"
                },
                {
                  "stringValue" => "odd"
                }
              ]
            }
          }
        ]
      }
    }
    presenter = build_expression_presenter json
    expected = [
      "{",
      "  [",
      "    1,",
      "    2",
      "  ] => [",
      '    "odd",',
      '    "even"',
      "  ],",
      "  [",
      "    4,",
      "    5",
      "  ] => [",
      '    "even",',
      '    "odd"',
      "  ]",
      "}"
    ]
    assert_equal expected, presenter.render_lines
  end
end
