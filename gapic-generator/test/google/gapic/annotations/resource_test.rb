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
    assert_nil message.options

    field = message.fields.first
    assert_equal "name", field.name
    refute_nil field.options.to_hash
    assert_kind_of Google::Protobuf::FieldOptions, field.options
    resource = field.options[:resource]
    assert_kind_of Google::Api::Resource, resource
    assert_equal "projects/{project}/simple_garbage/{garbage}", resource.pattern

    assert_equal 1, message.fields.count
    assert_kind_of Google::Api::Resource, message.fields[0].resource
    assert_equal "projects/{project}/simple_garbage/{garbage}", message.fields[0].resource.pattern
    assert_equal "", message.fields[0].resource_reference
    assert_nil message.fields[0].resource_set
  end

  def test_garbage_SimpleGarbageItem
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "SimpleGarbageItem" }
    refute_nil message
    assert_nil message.options

    field = message.fields.first
    assert_equal "garbage", field.name
    refute_nil field.options.to_hash
    assert_kind_of Google::Protobuf::FieldOptions, field.options
    assert_equal "SimpleGarbage", field.options[:resource_reference]

    assert_equal 3, message.fields.count
    assert_nil message.fields[0].resource
    assert_equal "SimpleGarbage", message.fields[0].resource_reference
    assert_nil message.fields[0].resource_set
    assert_nil message.fields[1].resource
    assert_nil message.fields[1].resource_reference
    assert_nil message.fields[1].resource_set
    assert_nil message.fields[2].resource
    assert_nil message.fields[2].resource_reference
    assert_nil message.fields[2].resource_set
  end

  def test_garbage_LongRunningGarbageRequest
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "LongRunningGarbageRequest" }
    refute_nil message
    assert_nil message.options
    field = message.fields.first
    assert_equal "garbage", field.name
    refute_nil field.options.to_hash
    assert_kind_of Google::Protobuf::FieldOptions, field.options
    resource_set = field.options[:resource_set]
    assert_kind_of Google::Api::ResourceSet, resource_set
    assert_equal "Garbage", resource_set.symbol
    assert_equal 5, resource_set.resources.count
    resource_set.resources.each do |resource|
      assert_kind_of Google::Api::Resource, resource
    end
    expected_resources = [
      { pattern: "projects/{project_id}/simple_garbage/{garbage_id}",   symbol: "SimpleGarbage"},
      { pattern: "projects/{project_id}/typical_garbage/{garbage_id}",  symbol: "TypicalGarbage"},
      { pattern: "projects/{project_id}/specific_garbage/{garbage_id}", symbol: "SpecificGarbage"},
      { pattern: "projects/{project_id}/nested_garbage/{garbage_id}",   symbol: "NestedGarbage"},
      { pattern: "projects/{project_id}/repeated_garbage/{garbage_id}", symbol: "RepeatedGarbage"}
    ]
    assert_equal expected_resources, resource_set.resources.map(&:to_hash)

    assert_equal 1, message.fields.count
    assert_nil message.fields[0].resource
    assert_equal "", message.fields[0].resource_reference
    assert_kind_of Google::Api::ResourceSet, message.fields[0].resource_set
    assert_equal expected_resources, message.fields[0].resource_set.resources.map(&:to_hash)
  end

  def test_garbage_LongRunningGarbageResponse
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "LongRunningGarbageResponse" }
    refute_nil message
    assert_nil message.options
    field = message.fields.first
    assert_equal "garbage", field.name
    refute_nil field.options.to_hash
    assert_kind_of Google::Protobuf::FieldOptions, field.options
    resource_set = field.options[:resource_set]
    assert_kind_of Google::Api::ResourceSet, resource_set
    assert_equal "Garbage", resource_set.symbol
    assert_equal 5, resource_set.resources.count
    resource_set.resources.each do |resource|
      assert_kind_of Google::Api::Resource, resource
    end
    expected_resources = [
      { pattern: "projects/{project_id}/simple_garbage/{garbage_id}",   symbol: "SimpleGarbage"},
      { pattern: "projects/{project_id}/typical_garbage/{garbage_id}",  symbol: "TypicalGarbage"},
      { pattern: "projects/{project_id}/specific_garbage/{garbage_id}", symbol: "SpecificGarbage"},
      { pattern: "projects/{project_id}/nested_garbage/{garbage_id}",   symbol: "NestedGarbage"},
      { pattern: "projects/{project_id}/repeated_garbage/{garbage_id}", symbol: "RepeatedGarbage"}
    ]
    assert_equal expected_resources, resource_set.resources.map(&:to_hash)

    assert_equal 2, message.fields.count
    assert_nil message.fields[0].resource
    assert_equal "", message.fields[0].resource_reference
    assert_kind_of Google::Api::ResourceSet, message.fields[0].resource_set
    assert_equal expected_resources, message.fields[0].resource_set.resources.map(&:to_hash)
    assert_nil message.fields[1].resource
    assert_nil message.fields[1].resource_reference
    assert_nil message.fields[1].resource_set
  end

  def test_garbage_ListGarbageRequest
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "ListGarbageRequest" }
    refute_nil message
    assert_nil message.options
    field = message.fields.first
    assert_equal "garbage", field.name
    refute_nil field.options.to_hash
    assert_kind_of Google::Protobuf::FieldOptions, field.options
    resource_set = field.options[:resource_set]
    assert_kind_of Google::Api::ResourceSet, resource_set
    assert_equal "Garbage", resource_set.symbol
    assert_equal 5, resource_set.resources.count
    resource_set.resources.each do |resource|
      assert_kind_of Google::Api::Resource, resource
    end
    expected_resources = [
      { pattern: "projects/{project_id}/simple_garbage/{garbage_id}",   symbol: "SimpleGarbage"},
      { pattern: "projects/{project_id}/typical_garbage/{garbage_id}",  symbol: "TypicalGarbage"},
      { pattern: "projects/{project_id}/specific_garbage/{garbage_id}", symbol: "SpecificGarbage"},
      { pattern: "projects/{project_id}/nested_garbage/{garbage_id}",   symbol: "NestedGarbage"},
      { pattern: "projects/{project_id}/repeated_garbage/{garbage_id}", symbol: "RepeatedGarbage"}
    ]
    assert_equal expected_resources, resource_set.resources.map(&:to_hash)

    assert_equal 1, message.fields.count
    assert_nil message.fields[0].resource
    assert_equal "", message.fields[0].resource_reference
    assert_kind_of Google::Api::ResourceSet, message.fields[0].resource_set
    assert_equal expected_resources, message.fields[0].resource_set.resources.map(&:to_hash)
  end

  def test_garbage_ListGarbageResponse
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "ListGarbageResponse" }
    refute_nil message
    assert_nil message.options
    field = message.fields.first
    assert_equal "garbage", field.name
    refute_nil field.options.to_hash
    assert_kind_of Google::Protobuf::FieldOptions, field.options
    resource_set = field.options[:resource_set]
    assert_kind_of Google::Api::ResourceSet, resource_set
    assert_equal "Garbage", resource_set.symbol
    assert_equal 5, resource_set.resources.count
    resource_set.resources.each do |resource|
      assert_kind_of Google::Api::Resource, resource
    end
    expected_resources = [
      { pattern: "projects/{project_id}/simple_garbage/{garbage_id}",   symbol: "SimpleGarbage"},
      { pattern: "projects/{project_id}/typical_garbage/{garbage_id}",  symbol: "TypicalGarbage"},
      { pattern: "projects/{project_id}/specific_garbage/{garbage_id}", symbol: "SpecificGarbage"},
      { pattern: "projects/{project_id}/nested_garbage/{garbage_id}",   symbol: "NestedGarbage"},
      { pattern: "projects/{project_id}/repeated_garbage/{garbage_id}", symbol: "RepeatedGarbage"}
    ]
    assert_equal expected_resources, resource_set.resources.map(&:to_hash)

    assert_equal 2, message.fields.count
    assert_nil message.fields[0].resource
    assert_equal "", message.fields[0].resource_reference
    assert_kind_of Google::Api::ResourceSet, message.fields[0].resource_set
    assert_equal expected_resources, message.fields[0].resource_set.resources.map(&:to_hash)
    assert_nil message.fields[1].resource
    assert_nil message.fields[1].resource_reference
    assert_nil message.fields[1].resource_set
  end
end
