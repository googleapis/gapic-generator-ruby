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
    assert_equal fp.doc_description, "The name of this garbage.\n"
    assert_equal "\"hello world\"", fp.default_value
    assert_equal "", fp.type_name
    assert_nil fp.type_name_full
  end

  def test_typical_garbage_int_fields
    ["int32", "int64", "uint32", "uint64"].each do |field_name|
      fp = typical_garbage field_name

      assert_equal field_name, fp.name
      assert_equal "@!attribute [rw] #{field_name}", fp.doc_attribute_type
      assert_equal "Integer", fp.output_doc_types
      assert_equal fp.doc_description, "The #{field_name} of this garbage.\n"
      assert_equal "42", fp.default_value
      assert_equal "", fp.type_name
      assert_nil fp.type_name_full
    end
  end

  def test_typical_garbage_bool_field
    fp = typical_garbage "bool"

    assert_equal "bool", fp.name
    assert_equal "@!attribute [rw] bool", fp.doc_attribute_type
    assert_equal "Boolean", fp.output_doc_types
    assert_equal fp.doc_description, "The bool of this garbage.\n"
    assert_equal "true", fp.default_value
    assert_equal "", fp.type_name
    assert_nil fp.type_name_full
  end

  def test_typical_garbage_numeric_fields
    ["float", "double"].each do |field_name|
      fp = typical_garbage field_name

      assert_equal field_name, fp.name
      assert_equal "@!attribute [rw] #{field_name}", fp.doc_attribute_type
      assert_equal "Float", fp.output_doc_types
      assert_equal fp.doc_description, "The #{field_name} of this garbage.\n"
      assert_equal "3.14", fp.default_value
      assert_equal "", fp.type_name
      assert_nil fp.type_name_full
    end
  end

  def test_typical_garbage_bytes_field
    fp = typical_garbage "bytes"

    assert_equal "bytes", fp.name
    assert_equal "@!attribute [rw] bytes", fp.doc_attribute_type
    assert_equal "String", fp.output_doc_types
    assert_equal fp.doc_description, "The bytes of this garbage.\n"
    assert_equal "\"hello world\"", fp.default_value
    assert_equal "", fp.type_name
    assert_nil fp.type_name_full
  end

  def test_typical_garbage_msg_field
    fp = typical_garbage "msg"

    assert_equal "msg", fp.name
    assert_equal "@!attribute [r] msg", fp.doc_attribute_type
    assert_equal "So::Much::Trash::GarbageMap", fp.output_doc_types
    assert_equal fp.doc_description, "The map of this garbage.\n"
    assert_equal "{}", fp.default_value
    assert_equal ".endless.trash.forever.GarbageMap", fp.type_name
    assert_equal "So::Much::Trash::GarbageMap", fp.type_name_full
  end

  def test_typical_garbage_enum_field
    fp = typical_garbage "enum"

    assert_equal "enum", fp.name
    assert_equal "@!attribute [rw] enum", fp.doc_attribute_type
    assert_equal "ENUM(GarbageEnum)", fp.output_doc_types
    assert_equal fp.doc_description, "The type of this garbage.\n"
    assert_equal ":Default", fp.default_value
    assert_equal ".endless.trash.forever.GarbageEnum", fp.type_name
    assert_equal "So::Much::Trash::GarbageEnum", fp.type_name_full
  end
end
