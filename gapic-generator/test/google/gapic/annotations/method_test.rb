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

class AnnotationMethodTest < AnnotationTest
  def test_garbage_GetSimpleGarbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    method = service.methods.find { |s| s.name == "GetSimpleGarbage" }
    refute_nil method

    assert_kind_of Google::Protobuf::MethodOptions, method.options
    assert_equal "/v1/simple_garbage:get", method.options[:http][:post]
    assert_equal "*", method.options[:http][:body]

    assert_empty method.options[:method_signature]

    assert_nil method.options[:operation_info]
  end

  def test_garbage_GetSpecificGarbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    method = service.methods.find { |s| s.name == "GetSpecificGarbage" }
    refute_nil method

    assert_kind_of Google::Protobuf::MethodOptions, method.options
    assert_equal "/v1/specific_garbage:get", method.options[:http][:post]
    assert_equal "*", method.options[:http][:body]

    expected_signatures = [
      "name,int32,bool",
    ]
    assert_equal expected_signatures, method.options[:method_signature]

    assert_nil method.options[:operation_info]
  end

  def test_garbage_GetNestedGarbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    method = service.methods.find { |s| s.name == "GetNestedGarbage" }
    refute_nil method

    assert_kind_of Google::Protobuf::MethodOptions, method.options
    assert_equal "/v1/nested_garbage:get", method.options[:http][:post]
    assert_equal "*", method.options[:http][:body]

    expected_signatures = [
      "name,int32,int64",
      "name,float,double",
      "name,bool,enum"
    ]
    assert_equal expected_signatures, method.options[:method_signature]

    assert_nil method.options[:operation_info]
  end

  def test_garbage_GetRepeatedGarbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    method = service.methods.find { |s| s.name == "GetRepeatedGarbage" }
    refute_nil method

    assert_kind_of Google::Protobuf::MethodOptions, method.options
    assert_equal "/v1/repeated_garbage:get", method.options[:http][:post]
    assert_equal "*", method.options[:http][:body]

    expected_signatures = [
      "name,bool,enum",
      "name,float,double",
      "name,int32,int64,uint32,uint64"
    ]
    assert_equal expected_signatures, method.options[:method_signature]

    assert_nil method.options[:operation_info]
  end

  def test_garbage_LongRunningGarbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    method = service.methods.find { |s| s.name == "LongRunningGarbage" }
    refute_nil method

    assert_kind_of Google::Protobuf::MethodOptions, method.options
    assert_equal "/v1/garbage:lro", method.options[:http][:post]
    assert_equal "*", method.options[:http][:body]

    assert_empty method.options[:method_signature]

    refute_nil method.options[:operation_info]
    assert_kind_of Google::Longrunning::OperationInfo, method.options[:operation_info]
    assert_equal "google.garbage.v1.LongRunningGarbageResponse", method.options[:operation_info].response_type
    assert_equal "google.garbage.v1.LongRunningGarbageMetadata", method.options[:operation_info].metadata_type
  end

  def test_garbage_ClientGarbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    method = service.methods.find { |s| s.name == "ClientGarbage" }
    refute_nil method

    assert_kind_of Google::Protobuf::MethodOptions, method.options
    assert_equal "/v1/garbage:client", method.options[:http][:post]
    assert_equal "*", method.options[:http][:body]

    assert_empty method.options[:method_signature]

    assert_nil method.options[:operation_info]
  end

  def test_garbage_ServerGarbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    method = service.methods.find { |s| s.name == "ServerGarbage" }
    refute_nil method

    assert_kind_of Google::Protobuf::MethodOptions, method.options
    assert_equal "/v1/garbage:server", method.options[:http][:post]
    assert_equal "*", method.options[:http][:body]

    assert_empty method.options[:method_signature]

    assert_nil method.options[:operation_info]
  end

  def test_garbage_BidiGarbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    method = service.methods.find { |s| s.name == "BidiGarbage" }
    refute_nil method

    assert_nil method.options
  end
end
