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

class DeclarationPresenterTest < PresenterTest
  include SnippetTestHelper

  def build_declaration_presenter json
    proto = build_proto_fragment Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Statement::Declaration, json
    Gapic::Presenters::SnippetPresenter::DeclarationPresenter.new proto, json
  end

  def test_no_json
    presenter = build_declaration_presenter nil
    refute presenter.exist?
    refute presenter.value?
    assert_nil presenter.render_lines
    assert_nil presenter.render
    assert_nil presenter.name
    assert_nil presenter.description
  end

  def test_declaration_simple
    json = {
      "name" => "greeting",
      "value" => {
        "stringValue" => "Hello, world!"
      }
    }
    presenter = build_declaration_presenter json
    expected = [
      'greeting = "Hello, world!"'
    ]
    assert_equal expected, presenter.render_lines
    assert_equal "greeting", presenter.name
    assert_nil presenter.description
    assert presenter.value?
    assert presenter.exist?
  end

  def test_declaration_complex
    json = {
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
    presenter = build_declaration_presenter json
    expected = [
      "# Initialize the value",
      "message = {",
      "  age: 21,",
      '  name: "Jane Doe"',
      "}"
    ]
    assert_equal expected, presenter.render_lines
    assert_equal "message", presenter.name
    assert_equal "Initialize the value", presenter.description
    assert presenter.value?
    assert presenter.exist?
  end
end
