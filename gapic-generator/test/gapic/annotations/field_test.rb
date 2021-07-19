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

    assert_equal 22, message.fields.count

    assert_equal "name", message.fields[0].name
    refute_nil message.fields[0].options
    assert_equal [Google::Api::FieldBehavior::REQUIRED], message.fields[0].options[:field_behavior]

    assert_equal [Google::Api::FieldBehavior::REQUIRED], message.fields[0].field_behavior
    refute message.fields[0].optional?
    assert message.fields[0].required?
    refute message.fields[0].output_only?
    refute message.fields[0].input_only?
    refute message.fields[0].immutable?
    refute message.fields[0].repeated?

    assert_equal "int32", message.fields[1].name
    refute_nil message.fields[1].options
    assert_equal [Google::Api::FieldBehavior::REQUIRED], message.fields[1].options[:field_behavior]

    assert_equal [Google::Api::FieldBehavior::REQUIRED], message.fields[1].field_behavior
    refute message.fields[1].optional?
    assert message.fields[1].required?
    refute message.fields[1].output_only?
    refute message.fields[1].input_only?
    refute message.fields[1].immutable?
    refute message.fields[1].repeated?

    assert_equal "int64", message.fields[2].name
    assert_nil message.fields[2].options

    assert_empty message.fields[2].field_behavior
    refute message.fields[2].optional?
    refute message.fields[2].required?
    refute message.fields[2].output_only?
    refute message.fields[2].input_only?
    refute message.fields[2].immutable?
    refute message.fields[2].repeated?

    assert_equal "uint32", message.fields[3].name
    assert_nil message.fields[3].options

    assert_empty message.fields[3].field_behavior
    refute message.fields[3].optional?
    refute message.fields[3].required?
    refute message.fields[3].output_only?
    refute message.fields[3].input_only?
    refute message.fields[3].immutable?
    refute message.fields[3].repeated?

    assert_equal "uint64", message.fields[4].name
    assert_nil message.fields[4].options

    assert_empty message.fields[4].field_behavior
    refute message.fields[4].optional?
    refute message.fields[4].required?
    refute message.fields[4].output_only?
    refute message.fields[4].input_only?
    refute message.fields[4].immutable?
    refute message.fields[4].repeated?

    assert_equal "bool", message.fields[5].name
    refute_nil message.fields[5].options
    assert_equal [Google::Api::FieldBehavior::REQUIRED], message.fields[5].options[:field_behavior]

    assert_equal [Google::Api::FieldBehavior::REQUIRED], message.fields[5].field_behavior
    refute message.fields[5].optional?
    assert message.fields[5].required?
    refute message.fields[5].output_only?
    refute message.fields[5].input_only?
    refute message.fields[5].immutable?
    refute message.fields[5].repeated?

    assert_equal "float", message.fields[6].name
    assert_nil message.fields[6].options

    assert_empty message.fields[6].field_behavior
    refute message.fields[6].optional?
    refute message.fields[6].required?
    refute message.fields[6].output_only?
    refute message.fields[6].input_only?
    refute message.fields[6].immutable?
    refute message.fields[6].repeated?

    assert_equal "double", message.fields[7].name
    assert_nil message.fields[7].options

    assert_empty message.fields[7].field_behavior
    refute message.fields[7].optional?
    refute message.fields[7].required?
    refute message.fields[7].output_only?
    refute message.fields[7].input_only?
    refute message.fields[7].immutable?
    refute message.fields[7].repeated?

    assert_equal "bytes", message.fields[8].name
    assert_nil message.fields[8].options

    assert_empty message.fields[8].field_behavior
    refute message.fields[8].optional?
    refute message.fields[8].required?
    refute message.fields[8].output_only?
    refute message.fields[8].input_only?
    refute message.fields[8].immutable?
    refute message.fields[8].repeated?

    assert_equal "timeout", message.fields[9].name
    assert_nil message.fields[9].options

    assert_empty message.fields[9].field_behavior
    refute message.fields[9].optional?
    refute message.fields[9].required?
    refute message.fields[9].output_only?
    refute message.fields[9].input_only?
    refute message.fields[9].immutable?
    refute message.fields[9].repeated?

    assert_equal "duration", message.fields[10].name
    assert_nil message.fields[10].options

    assert_empty message.fields[10].field_behavior
    refute message.fields[10].optional?
    refute message.fields[10].required?
    refute message.fields[10].output_only?
    refute message.fields[10].input_only?
    refute message.fields[10].immutable?
    refute message.fields[10].repeated?

    assert_equal "msg", message.fields[11].name
    refute_nil message.fields[11].options
    assert_equal [Google::Api::FieldBehavior::OUTPUT_ONLY], message.fields[11].options[:field_behavior]

    assert_equal [Google::Api::FieldBehavior::OUTPUT_ONLY], message.fields[11].field_behavior
    refute message.fields[11].optional?
    refute message.fields[11].required?
    assert message.fields[11].output_only?
    refute message.fields[11].input_only?
    refute message.fields[11].immutable?
    refute message.fields[11].repeated?

    assert_equal "enum", message.fields[12].name
    assert_nil message.fields[12].options

    assert_empty message.fields[12].field_behavior
    refute message.fields[12].optional?
    refute message.fields[12].required?
    refute message.fields[12].output_only?
    refute message.fields[12].input_only?
    refute message.fields[12].immutable?
    refute message.fields[12].repeated?
  end

  def test_garbage_SpecificGarbage
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "SpecificGarbage" }
    refute_nil message

    assert_equal 12, message.fields.count

    assert_equal "name", message.fields[0].name
    refute_nil message.fields[0].options
    assert_equal [Google::Api::FieldBehavior::REQUIRED], message.fields[0].options[:field_behavior]

    assert_equal [Google::Api::FieldBehavior::REQUIRED], message.fields[0].field_behavior
    refute message.fields[0].optional?
    assert message.fields[0].required?
    refute message.fields[0].output_only?
    refute message.fields[0].input_only?
    refute message.fields[0].immutable?

    assert_equal "int32", message.fields[1].name
    assert_nil message.fields[1].options

    assert_empty message.fields[1].field_behavior
    refute message.fields[1].optional?
    refute message.fields[1].required?
    refute message.fields[1].output_only?
    refute message.fields[1].input_only?
    refute message.fields[1].immutable?

    assert_equal "int64", message.fields[2].name
    assert_nil message.fields[2].options

    assert_empty message.fields[2].field_behavior
    refute message.fields[2].optional?
    refute message.fields[2].required?
    refute message.fields[2].output_only?
    refute message.fields[2].input_only?
    refute message.fields[2].immutable?

    assert_equal "uint32", message.fields[3].name
    assert_nil message.fields[3].options

    assert_empty message.fields[3].field_behavior
    refute message.fields[3].optional?
    refute message.fields[3].required?
    refute message.fields[3].output_only?
    refute message.fields[3].input_only?
    refute message.fields[3].immutable?

    assert_equal "uint64", message.fields[4].name
    assert_nil message.fields[4].options

    assert_empty message.fields[4].field_behavior
    refute message.fields[4].optional?
    refute message.fields[4].required?
    refute message.fields[4].output_only?
    refute message.fields[4].input_only?
    refute message.fields[4].immutable?

    assert_equal "bool", message.fields[5].name
    assert_nil message.fields[5].options

    assert_empty message.fields[5].field_behavior
    refute message.fields[5].optional?
    refute message.fields[5].required?
    refute message.fields[5].output_only?
    refute message.fields[5].input_only?
    refute message.fields[5].immutable?

    assert_equal "float", message.fields[6].name
    assert_nil message.fields[6].options

    assert_empty message.fields[6].field_behavior
    refute message.fields[6].optional?
    refute message.fields[6].required?
    refute message.fields[6].output_only?
    refute message.fields[6].input_only?
    refute message.fields[6].immutable?

    assert_equal "double", message.fields[7].name
    assert_nil message.fields[7].options

    assert_empty message.fields[7].field_behavior
    refute message.fields[7].optional?
    refute message.fields[7].required?
    refute message.fields[7].output_only?
    refute message.fields[7].input_only?
    refute message.fields[7].immutable?

    assert_equal "bytes", message.fields[8].name
    assert_nil message.fields[8].options

    assert_empty message.fields[8].field_behavior
    refute message.fields[8].optional?
    refute message.fields[8].required?
    refute message.fields[8].output_only?
    refute message.fields[8].input_only?
    refute message.fields[8].immutable?

    assert_equal "msg", message.fields[9].name
    refute_nil message.fields[9].options
    assert_equal [Google::Api::FieldBehavior::OUTPUT_ONLY], message.fields[9].options[:field_behavior]

    assert_equal [Google::Api::FieldBehavior::OUTPUT_ONLY], message.fields[9].field_behavior
    refute message.fields[9].optional?
    refute message.fields[9].required?
    assert message.fields[9].output_only?
    refute message.fields[9].input_only?
    refute message.fields[9].immutable?

    assert_equal "enum", message.fields[10].name
    assert_nil message.fields[10].options

    assert_empty message.fields[10].field_behavior
    refute message.fields[10].optional?
    refute message.fields[10].required?
    refute message.fields[10].output_only?
    refute message.fields[10].input_only?
    refute message.fields[10].immutable?

    assert_equal "nested", message.fields[11].name
    assert_nil message.fields[11].options

    assert_empty message.fields[11].field_behavior
    refute message.fields[11].optional?
    refute message.fields[11].required?
    refute message.fields[11].output_only?
    refute message.fields[11].input_only?
    refute message.fields[11].immutable?
  end

  def test_garbage_RepeatedGarbage
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "RepeatedGarbage" }
    refute_nil message

    assert_equal 11, message.fields.count

    assert_equal "repeated_name", message.fields[0].name
    refute_nil message.fields[0].options
    assert_equal [Google::Api::FieldBehavior::REQUIRED], message.fields[0].options[:field_behavior]

    assert_equal [Google::Api::FieldBehavior::REQUIRED], message.fields[0].field_behavior
    refute message.fields[0].optional?
    assert message.fields[0].required?
    refute message.fields[0].output_only?
    refute message.fields[0].input_only?
    refute message.fields[0].immutable?
    assert message.fields[0].repeated?

    assert_equal "repeated_int32", message.fields[1].name
    assert_nil message.fields[1].options

    assert_empty message.fields[1].field_behavior
    refute message.fields[1].optional?
    refute message.fields[1].required?
    refute message.fields[1].output_only?
    refute message.fields[1].input_only?
    refute message.fields[1].immutable?
    assert message.fields[1].repeated?

    assert_equal "repeated_int64", message.fields[2].name
    assert_nil message.fields[2].options

    assert_empty message.fields[2].field_behavior
    refute message.fields[2].optional?
    refute message.fields[2].required?
    refute message.fields[2].output_only?
    refute message.fields[2].input_only?
    refute message.fields[2].immutable?
    assert message.fields[2].repeated?

    assert_equal "repeated_uint32", message.fields[3].name
    assert_nil message.fields[3].options

    assert_empty message.fields[3].field_behavior
    refute message.fields[3].optional?
    refute message.fields[3].required?
    refute message.fields[3].output_only?
    refute message.fields[3].input_only?
    refute message.fields[3].immutable?
    assert message.fields[3].repeated?

    assert_equal "repeated_uint64", message.fields[4].name
    assert_nil message.fields[4].options

    assert_empty message.fields[4].field_behavior
    refute message.fields[4].optional?
    refute message.fields[4].required?
    refute message.fields[4].output_only?
    refute message.fields[4].input_only?
    refute message.fields[4].immutable?
    assert message.fields[4].repeated?

    assert_equal "repeated_bool", message.fields[5].name
    assert_nil message.fields[5].options

    assert_empty message.fields[5].field_behavior
    refute message.fields[5].optional?
    refute message.fields[5].required?
    refute message.fields[5].output_only?
    refute message.fields[5].input_only?
    refute message.fields[5].immutable?
    assert message.fields[5].repeated?

    assert_equal "repeated_float", message.fields[6].name
    assert_nil message.fields[6].options

    assert_empty message.fields[6].field_behavior
    refute message.fields[6].optional?
    refute message.fields[6].required?
    refute message.fields[6].output_only?
    refute message.fields[6].input_only?
    refute message.fields[6].immutable?
    assert message.fields[6].repeated?

    assert_equal "repeated_double", message.fields[7].name
    assert_nil message.fields[7].options

    assert_empty message.fields[7].field_behavior
    refute message.fields[7].optional?
    refute message.fields[7].required?
    refute message.fields[7].output_only?
    refute message.fields[7].input_only?
    refute message.fields[7].immutable?
    assert message.fields[7].repeated?

    assert_equal "repeated_bytes", message.fields[8].name
    assert_nil message.fields[8].options

    assert_empty message.fields[8].field_behavior
    refute message.fields[8].optional?
    refute message.fields[8].required?
    refute message.fields[8].output_only?
    refute message.fields[8].input_only?
    refute message.fields[8].immutable?
    assert message.fields[8].repeated?

    assert_equal "repeated_msg", message.fields[9].name
    refute_nil message.fields[9].options
    assert_equal [Google::Api::FieldBehavior::OUTPUT_ONLY], message.fields[9].options[:field_behavior]

    assert_equal [Google::Api::FieldBehavior::OUTPUT_ONLY], message.fields[9].field_behavior
    refute message.fields[9].optional?
    refute message.fields[9].required?
    assert message.fields[9].output_only?
    refute message.fields[9].input_only?
    refute message.fields[9].immutable?
    assert message.fields[9].repeated?

    assert_equal "repeated_enum", message.fields[10].name
    assert_nil message.fields[10].options

    assert_empty message.fields[10].field_behavior
    refute message.fields[10].optional?
    refute message.fields[10].required?
    refute message.fields[10].output_only?
    refute message.fields[10].input_only?
    refute message.fields[10].immutable?
    assert message.fields[10].repeated?
  end
end
