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
require "gapic/presenters/snippet/iteration_presenter"
require "gapic/presenters/snippet/statement_presenter"

class IterationPresenterTest < PresenterTest
  include SnippetTestHelper

  def build_iteration_presenter json
    proto = build_proto_fragment Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Iteration, json
    Gapic::Presenters::SnippetPresenter::IterationPresenter.new proto, json
  end

  def test_no_json
    presenter = build_iteration_presenter nil
    refute presenter.exist?
    assert_nil presenter.render_lines
    assert_nil presenter.render
  end

  def test_repeated
    json = {
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
    presenter = build_iteration_presenter json
    expected_prelude = [
      "collection = [",
      '  "foo",',
      '  "bar"',
      "]",
      "collection.each do |item|"
    ]
    expected_postlude = ["end"]
    expected_inner = ["puts(item)"]
    expected_lines = [
      "collection = [",
      '  "foo",',
      '  "bar"',
      "]",
      "collection.each do |item|",
      "  puts(item)",
      "end"
    ]
    assert_equal expected_prelude, presenter.prelude_render_lines
    assert_equal expected_postlude, presenter.postlude_render_lines
    assert_equal expected_inner, presenter.inner_render_lines
    assert_equal expected_lines, presenter.render_lines
  end

  def test_map
    json = {
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
          "name" => "dict",
          "value" => {
            "mapValue" => {
              "keys" => [
                {
                  "stringValue" => "foo"
                },
                {
                  "stringValue" => "bar"
                }
              ],
              "values" => [
                {
                  "numberValue" => 1.2
                },
                {
                  "numberValue" => 2.0
                }
              ]
            }
          }
        },
        "currentKeyName" => "key",
        "currentValueName" => "val"
      },
      "statements" => [
        {
          "standardOutput" => {
            "value" => {
              "nameValue" => {
                "name" => "key"
              }
            }
          }
        },
        {
          "standardOutput" => {
            "value" => {
              "nameValue" => {
                "name" => "val"
              }
            }
          }
        }
      ]
    }
    presenter = build_iteration_presenter json
    expected_prelude = [
      "dict = {",
      '  "foo" => 1.2,',
      '  "bar" => 2',
      "}",
      "dict.each do |key, val|"
    ]
    expected_postlude = ["end"]
    expected_inner = [
      "puts(key)",
      "puts(val)"
    ]
    expected_lines = [
      "dict = {",
      '  "foo" => 1.2,',
      '  "bar" => 2',
      "}",
      "dict.each do |key, val|",
      "  puts(key)",
      "  puts(val)",
      "end"
    ]
    assert_equal expected_prelude, presenter.prelude_render_lines
    assert_equal expected_postlude, presenter.postlude_render_lines
    assert_equal expected_inner, presenter.inner_render_lines
    assert_equal expected_lines, presenter.render_lines
  end
end
