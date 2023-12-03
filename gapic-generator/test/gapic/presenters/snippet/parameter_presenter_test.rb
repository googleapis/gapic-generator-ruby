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
require "gapic/presenters/snippet/parameter_presenter"

class ParameterPresenterTest < PresenterTest
  include SnippetTestHelper

  def build_parameter_presenter json
    proto = build_proto_fragment Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Statement::Declaration, json
    Gapic::Presenters::SnippetPresenter::ParameterPresenter.new proto, json
  end

  def test_trivial
    json = {"name" => "parent"}
    presenter = build_parameter_presenter json
    assert_equal "parent", presenter.name
    assert_nil presenter.description
    assert_equal "Object", presenter.type.render
    refute presenter.example.exist?
  end

  def test_full
    json = {
      "name" => "parent",
      "type" => {
        "scalarType" => "TYPE_STRING"
      },
      "description" => "Name of the parent resource",
      "value" => {
        "stringValue" => "/projects/hello"
      }
    }
    presenter = build_parameter_presenter json
    assert_equal "parent", presenter.name
    assert_equal "Name of the parent resource", presenter.description
    assert_equal "String", presenter.type.render
    assert_equal '"/projects/hello"', presenter.example.render
  end
end
