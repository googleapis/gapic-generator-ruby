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

class AnnotationFieldTest < AnnotationTest
  def test_garbage_TypicalGarbage
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "TypicalGarbage" }
    refute_nil message

    assert_equal 11, message.fields.count

    assert_equal "name", message.fields[0].name
    refute_nil message.fields[0].options
    assert_equal [Google::Api::FieldBehavior::REQUIRED], message.fields[0].options[:field_behavior]

    assert_equal "int32", message.fields[1].name
    refute_nil message.fields[1].options
    assert_equal [Google::Api::FieldBehavior::REQUIRED], message.fields[1].options[:field_behavior]

    assert_equal "int64", message.fields[2].name
    assert_nil message.fields[2].options

    assert_equal "uint32", message.fields[3].name
    assert_nil message.fields[3].options

    assert_equal "uint64", message.fields[4].name
    assert_nil message.fields[4].options

    assert_equal "bool", message.fields[5].name
    refute_nil message.fields[5].options
    assert_equal [Google::Api::FieldBehavior::REQUIRED], message.fields[5].options[:field_behavior]

    assert_equal "float", message.fields[6].name
    assert_nil message.fields[6].options

    assert_equal "double", message.fields[7].name
    assert_nil message.fields[7].options

    assert_equal "bytes", message.fields[8].name
    assert_nil message.fields[8].options

    assert_equal "msg", message.fields[9].name
    refute_nil message.fields[9].options
    assert_equal [Google::Api::FieldBehavior::OUTPUT_ONLY], message.fields[9].options[:field_behavior]

    assert_equal "enum", message.fields[10].name
    assert_nil message.fields[10].options
  end

  def test_garbage_SpecificGarbage
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "SpecificGarbage" }
    refute_nil message

    assert_equal 11, message.fields.count

    assert_equal "name", message.fields[0].name
    refute_nil message.fields[0].options
    assert_equal [Google::Api::FieldBehavior::REQUIRED], message.fields[0].options[:field_behavior]

    assert_equal "int32", message.fields[1].name
    assert_nil message.fields[1].options

    assert_equal "int64", message.fields[2].name
    assert_nil message.fields[2].options

    assert_equal "uint32", message.fields[3].name
    assert_nil message.fields[3].options

    assert_equal "uint64", message.fields[4].name
    assert_nil message.fields[4].options

    assert_equal "bool", message.fields[5].name
    assert_nil message.fields[5].options

    assert_equal "float", message.fields[6].name
    assert_nil message.fields[6].options

    assert_equal "double", message.fields[7].name
    assert_nil message.fields[7].options

    assert_equal "bytes", message.fields[8].name
    assert_nil message.fields[8].options

    assert_equal "msg", message.fields[9].name
    refute_nil message.fields[9].options
    assert_equal [Google::Api::FieldBehavior::OUTPUT_ONLY], message.fields[9].options[:field_behavior]

    assert_equal "enum", message.fields[10].name
    assert_nil message.fields[10].options
  end

  def test_garbage_RepeatedGarbage
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "RepeatedGarbage" }
    refute_nil message

    assert_equal 12, message.fields.count

    assert_equal "name", message.fields[0].name
    refute_nil message.fields[0].options
    assert_equal [Google::Api::FieldBehavior::REQUIRED], message.fields[0].options[:field_behavior]

    assert_equal "repeated_int32", message.fields[1].name
    assert_nil message.fields[1].options

    assert_equal "repeated_int64", message.fields[2].name
    assert_nil message.fields[2].options

    assert_equal "repeated_uint32", message.fields[3].name
    assert_nil message.fields[3].options

    assert_equal "repeated_uint64", message.fields[4].name
    assert_nil message.fields[4].options

    assert_equal "repeated_bool", message.fields[5].name
    assert_nil message.fields[5].options

    assert_equal "repeated_float", message.fields[6].name
    assert_nil message.fields[6].options

    assert_equal "repeated_double", message.fields[7].name
    assert_nil message.fields[7].options

    assert_equal "repeated_string", message.fields[8].name
    assert_nil message.fields[8].options

    assert_equal "repeated_bytes", message.fields[9].name
    assert_nil message.fields[9].options

    assert_equal "repeated_msg", message.fields[10].name
    refute_nil message.fields[10].options
    assert_equal [Google::Api::FieldBehavior::OUTPUT_ONLY], message.fields[10].options[:field_behavior]

    assert_equal "repeated_enum", message.fields[11].name
    assert_nil message.fields[11].options
  end
end
