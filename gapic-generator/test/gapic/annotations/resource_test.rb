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
  def test_garbage_Common
    garbage = api :garbage
    file = garbage.files.find { |f| f.address == ["google", "cloud"] }
    assert_equal 5, file.resources.size

    resource = garbage.lookup_resource_type "cloudresourcemanager.googleapis.com/Project"
    assert_equal 0, resource.parent_resources.size
  end

  def test_garbage_Garbage
    garbage = api :garbage
    file = garbage.file_for "endless.trash.forever.GarbageService"

    resources = file.resources
    assert_equal 1, resources.size

    resource = resources.first
    assert_equal 6, resource.pattern.size
    assert_equal "endlesstrash.example.net/Garbage", resource.type
    assert_equal resource, garbage.lookup_resource_type("endlesstrash.example.net/Garbage")

    parents = resource.parent_resources
    assert_equal 1, parents.size
    assert_equal ["projects/{project}"], parents.first.pattern
    assert_equal parents.first, garbage.lookup_resource_type("cloudresourcemanager.googleapis.com/Project")
  end

  ##
  # Make sure that the resources with complex patterns (multi-variate resource IDs) construct resource chains correctly
  # Resources with simple patterns are as controls here
  #
  def test_garbage_ResourceNames
    garbage = api :garbage
    file = garbage.file_for "endless.trash.forever.ResourceNames"

    simple_req_message = file.messages.find { |s| s.name == "SimplePatternRequest" }
    refute_nil simple_req_message

    resource = simple_req_message.resource
    refute_nil resource

    resource_type_chain = construct_resource_type_chain resource
    expected_type_chain = [
      "resourcenames.example.com/SimplePatternRequest",
      "resourcenames.example.com/SimplePatternResource"
    ]
    assert_equal expected_type_chain, resource_type_chain

    complex_req_message = file.messages.find { |s| s.name == "ComplexPatternRequest" }
    refute_nil complex_req_message

    resource = complex_req_message.resource
    refute_nil resource

    resource_type_chain = construct_resource_type_chain resource
    expected_type_chain = [
      "resourcenames.example.com/ComplexPatternRequest", 
      "resourcenames.example.com/ComplexPatternIntermediateResource", 
      "resourcenames.example.com/ComplexPatternResource", 
      "resourcenames.example.com/SimplePatternResource"
    ]
    assert_equal expected_type_chain, resource_type_chain
  end

  def test_garbage_SimpleGarbage
    garbage = api :garbage
    message = garbage.messages.find { |s| s.name == "SimpleGarbage" }
    refute_nil message
    refute_nil message.options
    assert_kind_of Google::Protobuf::MessageOptions, message.options

    resource = message.options[:resource]
    assert_kind_of Google::Api::ResourceDescriptor, resource
    assert_equal ["projects/{project}/simple_garbage/{simple_garbage}"], resource.pattern

    assert_kind_of Gapic::Schema::Resource, message.resource
    assert_equal ["projects/{project}/simple_garbage/{simple_garbage}"], message.resource.pattern
    assert_equal ["projects/*/simple_garbage/*"], message.resource.parsed_patterns
    assert_equal ["projects/*"], message.resource.parsed_parent_patterns
    assert_equal message.resource, garbage.lookup_resource_type("endlesstrash.example.net/SimpleGarbage")

    parents = message.resource.parent_resources
    assert_equal 1, parents.size
    assert_equal ["projects/{project}"], parents.first.pattern
    assert_equal parents.first, garbage.lookup_resource_type("cloudresourcemanager.googleapis.com/Project")

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
    assert_equal "endlesstrash.example.net/Garbage", field.options[:resource_reference].child_type

    assert_equal 1, message.fields.count
    assert_equal "endlesstrash.example.net/Garbage", message.fields[0].resource_reference.child_type
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

  private

  def construct_resource_type_chain resource
    resource_type_chain = [resource.type]

    while resource.parent_resources.count > 0
      assert_equal resource.parent_resources.count, 1
      resource = resource.parent_resources[0]
      resource_type_chain.append resource.type
    end

    return resource_type_chain
  end
end
