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

class StatementPresenterTest < PresenterTest
  include SnippetTestHelper

  def build_statement_presenter json
    proto = build_proto_fragment Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Statement, json
    Gapic::Presenters::SnippetPresenter::StatementPresenter.new proto, json
  end

  def test_no_json
    presenter = build_statement_presenter nil
    expected = [
      "# Unknown statement omitted here."
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_declaration_simple
    json = {
      "declaration" => {
        "name" => "greeting",
        "value" => {
          "stringValue" => "Hello, world!"
        }
      }
    }
    presenter = build_statement_presenter json
    expected = [
      'greeting = "Hello, world!"'
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_declaration_complex
    json = {
      "declaration" => {
        "name" => "message",
        "value" => {
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
        "description" => "Initialize the value"
      }
    }
    presenter = build_statement_presenter json
    expected = [
      "# Initialize the value",
      "message = {",
      "  age: 21,",
      '  name: "Jane Doe"',
      "}"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_stdout_variable
    json = {
      "standardOutput" => {
        "value" => {
          "nameValue" => {
            "name" => "message",
            "path" => ["foo", "bar"]
          }
        }
      }
    }
    presenter = build_statement_presenter json
    expected = [
      "puts(message.foo.bar)"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_stdout_complex
    json = {
      "standardOutput" => {
        "value" => {
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
        }
      }
    }
    presenter = build_statement_presenter json
    expected = [
      "puts(",
      "  {",
      "    age: 21,",
      '    name: "Jane Doe"',
      "  }",
      ")"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_return_nil
    json = {
      "return" => {
        "result" => {
          "nullValue" => "NULL_VALUE"
        }
      }
    }
    presenter = build_statement_presenter json
    expected = [
      "return nil"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_return_complex
    json = {
      "return" => {
        "result" => {
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
        }
      }
    }
    presenter = build_statement_presenter json
    expected = [
      "return {",
      "  age: 21,",
      '  name: "Jane Doe"',
      "}"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_conditional_true_only
    json = {
      "conditional" => {
        "condition" => {
          "nameValue" => {
            "name" => "object",
            "path" => ["is_active"]
          }
        },
        "onTrue" => [
          {
            "standardOutput" => {
              "value" => {
                "stringValue" => "Active!"
              }
            }
          },
          {
            "return" => {
              "result" => {
                "booleanValue" => true
              }
            }
          }
        ]
      }
    }
    presenter = build_statement_presenter json
    expected = [
      "if object.is_active",
      '  puts("Active!")',
      "  return true",
      "end"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_conditional_false_only
    json = {
      "conditional" => {
        "condition" => {
          "nameValue" => {
            "name" => "object",
            "path" => ["is_active"]
          }
        },
        "onFalse" => [
          {
            "standardOutput" => {
              "value" => {
                "stringValue" => "Dormant!"
              }
            }
          },
          {
            "return" => {
              "result" => {
                "booleanValue" => false
              }
            }
          }
        ]
      }
    }
    presenter = build_statement_presenter json
    expected = [
      "unless object.is_active",
      '  puts("Dormant!")',
      "  return false",
      "end"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_conditional_both_branches
    json = {
      "conditional" => {
        "condition" => {
          "nameValue" => {
            "name" => "object",
            "path" => ["is_active"]
          }
        },
        "onTrue" => [
          {
            "standardOutput" => {
              "value" => {
                "stringValue" => "Active!"
              }
            }
          },
          {
            "return" => {
              "result" => {
                "booleanValue" => true
              }
            }
          }
        ],
        "onFalse" => [
          {
            "standardOutput" => {
              "value" => {
                "stringValue" => "Dormant!"
              }
            }
          },
          {
            "return" => {
              "result" => {
                "booleanValue" => false
              }
            }
          }
        ]
      }
    }
    presenter = build_statement_presenter json
    expected = [
      "if object.is_active",
      '  puts("Active!")',
      "  return true",
      "else",
      '  puts("Dormant!")',
      "  return false",
      "end"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_iteration
    json = {
      "iteration" => {
        "repeatedIteration" => {
          "repeatedElements" => {
            "type" => {
              "repeatedType" => {
                "elementType" => {
                  "scalarType" => "TYPE_STRING"
                }
              }
            },
            "name" => "collection",
            "value" => {
              "listValue" => {
                "values" => [
                  {
                    "stringValue" => "foo"
                  },
                  {
                    "stringValue" => "bar"
                  }
                ]
              }
            }
          },
          "currentName" => "item"
        },
        "statements" => [
          {
            "standardOutput" => {
              "value" => {
                "nameValue" => {
                  "name" => "item"
                }
              }
            }
          }
        ]
      }
    }
    presenter = build_statement_presenter json
    expected = [
      "collection = [",
      '  "bar",',
      '  "foo"',
      "]",
      "collection.each do |item|",
      "  puts(item)",
      "end"
    ]
    assert_equal expected, presenter.render_lines
  end
end
