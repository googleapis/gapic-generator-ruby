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

class AnnotationResourceTest < AnnotationTest
  def test_garbage_SimpleGarbage
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "SimpleGarbage" }
    refute_nil message
    refute_nil message.options
    assert_kind_of Google::Protobuf::MessageOptions, message.options

    resource = message.options[:resource]
    assert_kind_of Google::Api::ResourceDescriptor, resource
    assert_equal ["projects/{project}/simple_garbage/{garbage}"], resource.pattern

    assert_kind_of Google::Api::ResourceDescriptor, message.resource
    assert_equal ["projects/{project}/simple_garbage/{garbage}"], message.resource.pattern

    assert_equal 1, message.fields.count
    field = message.fields.first
    assert_equal "name", field.name
    assert_nil field.options
    assert_nil field.resource_reference
  end

  def test_garbage_SimpleGarbageItem
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "SimpleGarbageItem" }
    refute_nil message
    assert_nil message.options

    field = message.fields.first
    assert_equal "garbage", field.name
    refute_nil field.options
    assert_kind_of Google::Protobuf::FieldOptions, field.options
    assert_kind_of Google::Api::ResourceReference, field.options[:resource_reference]
    assert_equal "endlesstrash.example.net/SimpleGarbage", field.options[:resource_reference].type

    assert_equal 3, message.fields.count
    assert_kind_of Google::Api::ResourceReference, message.fields[0].resource_reference
    assert_equal "endlesstrash.example.net/SimpleGarbage", message.fields[0].resource_reference.type
    assert_nil message.fields[1].resource_reference
    assert_nil message.fields[2].resource_reference
  end

  def test_garbage_LongRunningGarbageRequest
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "LongRunningGarbageRequest" }
    refute_nil message
    assert_nil message.options
    field = message.fields.first
    assert_equal "garbage", field.name
    assert_nil field.options

    assert_equal 1, message.fields.count
    assert_nil message.fields[0].resource_reference
  end

  def test_garbage_LongRunningGarbageResponse
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "LongRunningGarbageResponse" }
    refute_nil message
    assert_nil message.options
    field = message.fields.first
    assert_equal "garbage", field.name
    assert_nil field.options

    assert_equal 2, message.fields.count
    assert_nil message.fields[0].resource_reference
    assert_nil message.fields[1].resource_reference
  end

  def test_garbage_ListGarbageRequest
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "ListGarbageRequest" }
    refute_nil message
    assert_nil message.options
    field = message.fields.first
    assert_equal "garbage", field.name
    refute_nil field.options
    assert_kind_of Google::Protobuf::FieldOptions, field.options
    assert_kind_of Google::Api::ResourceReference, field.options[:resource_reference]
    assert_equal "endlesstrash.example.net/Garbage", field.options[:resource_reference].type

    assert_equal 1, message.fields.count
    assert_equal "endlesstrash.example.net/Garbage", message.fields[0].resource_reference.type
  end

  def test_garbage_ListGarbageResponse
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "ListGarbageResponse" }
    refute_nil message
    assert_nil message.options
    field = message.fields.first
    assert_equal "garbage", field.name
    assert_nil field.options

    assert_equal 2, message.fields.count
    assert_nil message.fields[0].resource_reference
    assert_nil message.fields[1].resource_reference
  end
end
