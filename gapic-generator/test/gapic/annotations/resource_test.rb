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
require "awesome_print"

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

  def print_resource resource_name, resource
    STDERR.puts "-----------------------------------------------"
    STDERR.puts "#{resource_name}.type:"
    STDERR.puts resource.type
    STDERR.puts "#{resource_name}.pattern:"
    STDERR.puts resource.pattern
    STDERR.puts "#{resource_name}.parsed_patterns:"
    STDERR.puts resource.parsed_patterns.awesome_inspect
    STDERR.puts "#{resource_name}.parent_resources.length:"
    STDERR.puts resource.parent_resources.length 

    if resource.parent_resources.length 
      resource.parent_resources.each_with_index do |presource, index|
        STDERR.puts "#{resource_name}.parent_resources[#{index}].type:" 
        STDERR.puts presource.type
        STDERR.puts "#{resource_name}.parent_resources[#{index}].pattern:"
        STDERR.puts presource.pattern
      end
    end
    STDERR.puts "-----------------------------------------------"
  end

  def garbage_Resources

    garbage = api :garbage
    file = garbage.file_for "endless.trash.forever.ResourceNames"

    STDERR.puts "==============================================="
    STDERR.puts "debugging is supposed to start"
    STDERR.puts "==============================================="

    STDERR.puts "-----------------------------------------------"
    STDERR.puts "file.resources.size"
    STDERR.puts file.resources.size
    STDERR.puts "-----------------------------------------------"

    if file.resources.size
      file.resources.each_with_index do |resource, index|
        print_resource "file.resources[#{index}]", resource
      end
    end

    STDERR.puts "-----------------------------------------------"
    STDERR.puts "file.messages.size"
    STDERR.puts file.messages.size
    STDERR.puts "-----------------------------------------------"

    if file.messages.size 
      file.messages.each_with_index do |message, index|
        STDERR.puts "-----------------------------------------------"
        STDERR.puts "file.messages[#{index}].name:"
        STDERR.puts message.name

        if message.resource
          print_resource "file.messages[#{index}].resource", message.resource
        end
      end
    end

    require 'pry'
    binding.pry
    abort

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
    assert_equal [["projects", "*", "simple_garbage", "*"]], message.resource.parsed_patterns
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
end
