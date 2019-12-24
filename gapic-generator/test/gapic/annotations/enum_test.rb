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

class EnumTest < AnnotationTest
  def test_enum
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "TypicalGarbage" }
    refute_nil message

    assert_equal 13, message.fields.count

    assert_equal "enum", message.fields[12].name
    assert_equal Google::Protobuf::FieldDescriptorProto::Type::TYPE_ENUM, message.fields[12].type
    assert message.fields[12].enum?
  end
end
