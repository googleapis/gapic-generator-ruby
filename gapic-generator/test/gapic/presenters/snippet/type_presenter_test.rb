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
require "gapic/presenters/snippet/type_presenter"

class TypePresenterTest < PresenterTest
  include SnippetTestHelper

  def build_type_presenter json
    proto = build_proto_fragment Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type, json
    Gapic::Presenters::SnippetPresenter::TypePresenter.new proto, json
  end

  def test_no_json
    presenter = build_type_presenter nil
    assert_equal "Object", presenter.render
  end

  def test_scalar_float
    json = {"scalarType" => "TYPE_FLOAT"}
    presenter = build_type_presenter json
    assert_equal "Float", presenter.render
  end

  def test_scalar_integer
    json = {"scalarType" => "TYPE_UINT64"}
    presenter = build_type_presenter json
    assert_equal "Integer", presenter.render
  end

  def test_scalar_string
    json = {"scalarType" => "TYPE_STRING"}
    presenter = build_type_presenter json
    assert_equal "String", presenter.render
  end

  def test_bytes
    json = {"bytesType" => {"languageEquivalent" => "BASE64"}}
    presenter = build_type_presenter json
    assert_equal "String", presenter.render
  end

  def test_message_string
    json = {"messageType" => {"messageFullName" => "google.cloud.snippetgen.data.RubyCode"}}
    presenter = build_type_presenter json
    assert_equal "Google::Cloud::Snippetgen::Data::RubyCode", presenter.render
  end

  def test_enum_string
    json = {"enumType" => {"enumFullName" => "google.cloud.snippetgen.data.LanguageName"}}
    presenter = build_type_presenter json
    assert_equal "Google::Cloud::Snippetgen::Data::LanguageName", presenter.render
  end

  def test_repeated_scalar
    json = {
      "repeatedType" => {
        "elementType" => {
          "scalarType" => "TYPE_STRING"
        },
        "languageEquivalent" => "ARRAY"
      }
    }
    presenter = build_type_presenter json
    assert_equal "Array<String>", presenter.render
  end

  def test_repeated_message
    json = {
      "repeatedType" => {
        "elementType" => {
          "messageType" => {
            "messageFullName" => "google.cloud.snippetgen.data.RubyCode"
          }
        },
        "languageEquivalent" => "LIST"
      }
    }
    presenter = build_type_presenter json
    assert_equal "Array<Google::Cloud::Snippetgen::Data::RubyCode>", presenter.render
  end

  def test_map
    json = {
      "mapType" => {
        "keyType" => {
          "scalarType" => "TYPE_STRING"
        },
        "valueType" => {
          "messageType" => {
            "messageFullName" => "google.cloud.snippetgen.data.RubyCode"
          }
        },
        "languageEquivalent" => "DICTIONARY"
      }
    }
    presenter = build_type_presenter json
    assert_equal "Hash{String=>Google::Cloud::Snippetgen::Data::RubyCode}", presenter.render
  end
end
