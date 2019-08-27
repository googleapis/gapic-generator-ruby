# frozen_string_literal: true

# Copyright 2019 Google LLC
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

class FieldPresenterTest < PresenterTest
  def typical_garbage field_name
    field_presenter :garbage, "endless.trash.forever.TypicalGarbage", field_name
  end

  def test_typical_garbage_name_field
    fp = typical_garbage "name"

    assert_equal "name", fp.name
    assert_equal "@!attribute [rw] name", fp.doc_attribute_type
    assert_equal "String", fp.output_doc_types
    assert_nil fp.doc_description
    assert_equal "\"hello world\"", fp.default_value
    assert_equal "", fp.type_name
    assert_nil fp.type_name_full
    assert_equal "name: name", fp.as_kwarg
    assert_equal "name: x", fp.as_kwarg(value: "x")
  end

  def test_typical_garbage_int_fields
    ["int32", "int64", "uint32", "uint64"].each do |field_name|
      fp = typical_garbage field_name

      assert_equal field_name, fp.name
      assert_equal "@!attribute [rw] #{field_name}", fp.doc_attribute_type
      assert_equal "Integer", fp.output_doc_types
      assert_nil fp.doc_description
      assert_equal "42", fp.default_value
      assert_equal "", fp.type_name
      assert_nil fp.type_name_full
      assert_equal "#{field_name}: #{field_name}", fp.as_kwarg
      assert_equal "#{field_name}: yx", fp.as_kwarg(value: "yx")
    end
  end

  def test_typical_garbage_bool_field
    fp = typical_garbage "bool"

    assert_equal "bool", fp.name
    assert_equal "@!attribute [rw] bool", fp.doc_attribute_type
    assert_equal "Boolean", fp.output_doc_types
    assert_nil fp.doc_description
    assert_equal "true", fp.default_value
    assert_equal "", fp.type_name
    assert_nil fp.type_name_full
    assert_equal "bool: bool", fp.as_kwarg
    assert_equal "bool: 1", fp.as_kwarg(value: 1)
  end

  def test_typical_garbage_numeric_fields
    ["float", "double"].each do |field_name|
      fp = typical_garbage field_name

      assert_equal field_name, fp.name
      assert_equal "@!attribute [rw] #{field_name}", fp.doc_attribute_type
      assert_equal "Float", fp.output_doc_types
      assert_nil fp.doc_description
      assert_equal "3.14", fp.default_value
      assert_equal "", fp.type_name
      assert_nil fp.type_name_full
      assert_equal "#{field_name}: #{field_name}", fp.as_kwarg
      assert_equal "#{field_name}: true", fp.as_kwarg(value: true)
    end
  end

  def test_typical_garbage_bytes_field
    fp = typical_garbage "bytes"

    assert_equal "bytes", fp.name
    assert_equal "@!attribute [rw] bytes", fp.doc_attribute_type
    assert_equal "String", fp.output_doc_types
    assert_nil fp.doc_description
    assert_equal "\"hello world\"", fp.default_value
    assert_equal "", fp.type_name
    assert_nil fp.type_name_full
    assert_equal "bytes: bytes", fp.as_kwarg
    assert_equal "bytes: ", fp.as_kwarg(value: "")
  end

  def test_typical_garbage_msg_field
    fp = typical_garbage "msg"

    assert_equal "msg", fp.name
    assert_equal "@!attribute [r] msg", fp.doc_attribute_type
    assert_equal "So::Much::Trash::GarbageMap", fp.output_doc_types
    assert_nil fp.doc_description
    assert_equal "{}", fp.default_value
    assert_equal ".endless.trash.forever.GarbageMap", fp.type_name
    assert_equal "So::Much::Trash::GarbageMap", fp.type_name_full
    assert_equal "msg: msg", fp.as_kwarg
    assert_equal "msg: 0", fp.as_kwarg(value: 0)
  end

  def test_typical_garbage_enum_field
    fp = typical_garbage "enum"

    assert_equal "enum", fp.name
    assert_equal "@!attribute [rw] enum", fp.doc_attribute_type
    assert_equal "ENUM(GarbageEnum)", fp.output_doc_types
    assert_nil fp.doc_description
    assert_equal "Default", fp.default_value
    assert_equal ".endless.trash.forever.GarbageEnum", fp.type_name
    assert_equal "So::Much::Trash::GarbageEnum", fp.type_name_full
    assert_equal "enum: enum", fp.as_kwarg
    assert_equal "enum: enum", fp.as_kwarg(value: "enum")
  end
end
