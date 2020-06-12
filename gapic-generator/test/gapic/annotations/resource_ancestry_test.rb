# frozen_string_literal: true

# Copyright 2020 Google LLC
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

class AnnotationResourceAncestryTest < AnnotationTest
  ##
  # Make sure that the resources with complex resource IDs construct resource chains correctly
  # Resources with simple patterns are as controls here
  #
  def test_garbage_ResourceNames_complex_resource_ids
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

  ##
  # Make sure that the resource that has many patterns correctly determines its parents
  # if these patterns include complex and simple resource ids
  #
  def test_garbage_ResourceNames_multiancestry
    garbage = api :garbage
    file = garbage.file_for "endless.trash.forever.ResourceNames"

    log_resource = file.resources.find {|resource| resource.type == "resourcenames.example.com/LogEntry"}
    refute_nil log_resource

    refute_nil log_resource.parent_resources
    assert_equal 2, log_resource.parent_resources.length

    simplepattern_parent_resource = file.resources.find {|resource| resource.type == "resourcenames.example.com/SimplePatternLogParent"}
    refute_nil simplepattern_parent_resource

    complexpattern_parent_resource = file.resources.find {|resource| resource.type == "resourcenames.example.com/ComplexPatternLogParent"}
    refute_nil complexpattern_parent_resource

    assert_includes log_resource.parent_resources, simplepattern_parent_resource
    assert_includes log_resource.parent_resources, complexpattern_parent_resource
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
