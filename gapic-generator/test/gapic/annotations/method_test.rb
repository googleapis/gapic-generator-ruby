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
    assert_equal "/v1/simple_garbage:get", method.option_named("http")["post"]
    assert_equal "*", method.option_named("http")["body"]

    assert_empty method.option_named "method_signature"

    assert_nil method.option_named "operation_info"

    refute_nil method.http
    assert_kind_of Google::Api::HttpRule, method.http
    assert_equal "/v1/simple_garbage:get", method.http.post
    assert_equal "*", method.http.body

    assert_empty method.signatures

    assert_nil method.operation_info
  end

  def test_garbage_GetSpecificGarbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    method = service.methods.find { |s| s.name == "GetSpecificGarbage" }
    refute_nil method

    assert_kind_of Google::Protobuf::MethodOptions, method.options
    assert_kind_of Google::Api::HttpRule, method.option_named("http")
    assert_equal "/v1/specific_garbage:get", method.option_named("http")["post"]
    assert_equal "*", method.option_named("http")["body"]

    assert_empty method.option_named "method_signature"

    assert_nil method.option_named "operation_info"

    assert_nil method.operation_info

    refute_nil method.http
    assert_kind_of Google::Api::HttpRule, method.http
    assert_equal "/v1/specific_garbage:get", method.http.post
    assert_equal "*", method.http.body

    assert_empty method.signatures

    assert_nil method.operation_info
  end

  def test_garbage_GetNestedGarbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    method = service.methods.find { |s| s.name == "GetNestedGarbage" }
    refute_nil method

    assert_kind_of Google::Protobuf::MethodOptions, method.options
    assert_kind_of Google::Api::HttpRule, method.option_named("http")
    assert_equal "/v1/nested_garbage:get", method.option_named("http")["post"]
    assert_equal "*", method.option_named("http")["body"]

    assert_empty method.option_named "method_signature"

    assert_nil method.option_named "operation_info"

    assert_nil method.operation_info

    refute_nil method.http
    assert_kind_of Google::Api::HttpRule, method.http
    assert_equal "/v1/nested_garbage:get", method.http.post
    assert_equal "*", method.http.body

    assert_empty method.signatures

    assert_nil method.operation_info
  end

  def test_garbage_GetRepeatedGarbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    method = service.methods.find { |s| s.name == "GetRepeatedGarbage" }
    refute_nil method

    assert_kind_of Google::Protobuf::MethodOptions, method.options
    assert_kind_of Google::Api::HttpRule, method.option_named("http")
    assert_equal "/v1/repeated_garbage:get", method.option_named("http")["post"]
    assert_equal "*", method.option_named("http")["body"]

    assert_empty method.option_named("method_signature")

    assert_nil method.option_named("operation_info")

    assert_nil method.operation_info

    refute_nil method.http
    assert_kind_of Google::Api::HttpRule, method.http
    assert_equal "/v1/repeated_garbage:get", method.http.post
    assert_equal "*", method.http.body

    assert_empty method.signatures

    assert_nil method.operation_info
  end

  def test_garbage_LongRunningGarbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    method = service.methods.find { |s| s.name == "LongRunningGarbage" }
    refute_nil method

    assert_kind_of Google::Protobuf::MethodOptions, method.options
    assert_kind_of Google::Api::HttpRule, method.option_named("http")
    assert_equal "/v1/garbage:lro", method.option_named("http")["post"]
    assert_equal "*", method.option_named("http")["body"]

    assert_empty method.option_named "method_signature"

    refute_nil method.option_named "operation_info"
    assert_kind_of Google::Longrunning::OperationInfo, method.option_named("operation_info")
    assert_equal "google.garbage.v1.LongRunningGarbageResponse", method.option_named("operation_info")["response_type"]
    assert_equal "google.garbage.v1.LongRunningGarbageMetadata", method.option_named("operation_info")["metadata_type"]

    refute_nil method.http
    assert_kind_of Google::Api::HttpRule, method.http
    assert_equal "/v1/garbage:lro", method.http.post
    assert_equal "*", method.http.body

    assert_empty method.signatures

    assert_kind_of Google::Longrunning::OperationInfo, method.operation_info
    assert_equal "google.garbage.v1.LongRunningGarbageResponse", method.operation_info.response_type
    assert_equal "google.garbage.v1.LongRunningGarbageMetadata", method.operation_info.metadata_type
  end

  def test_garbage_ClientGarbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    method = service.methods.find { |s| s.name == "ClientGarbage" }
    refute_nil method

    assert_kind_of Google::Protobuf::MethodOptions, method.options
    assert_kind_of Google::Api::HttpRule, method.option_named("http")
    assert_equal "/v1/garbage:client", method.option_named("http")["post"]
    assert_equal "*", method.option_named("http")["body"]

    assert_empty method.option_named("method_signature")

    assert_nil method.option_named "operation_info"

    assert_nil method.operation_info

    refute_nil method.http
    assert_kind_of Google::Api::HttpRule, method.http
    assert_equal "/v1/garbage:client", method.http.post
    assert_equal "*", method.http.body

    assert_empty method.signatures

    assert_nil method.operation_info
  end

  def test_garbage_ServerGarbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    method = service.methods.find { |s| s.name == "ServerGarbage" }
    refute_nil method

    assert_kind_of Google::Protobuf::MethodOptions, method.options
    assert_kind_of Google::Api::HttpRule, method.option_named("http")
    assert_equal "/v1/garbage:server", method.option_named("http")["post"]
    assert_equal "*", method.option_named("http")["body"]

    assert_empty method.option_named "method_signature"

    assert_nil method.option_named "operation_info"

    assert_nil method.operation_info

    refute_nil method.http
    assert_kind_of Google::Api::HttpRule, method.http
    assert_equal "/v1/garbage:server", method.http.post
    assert_equal "*", method.http.body

    assert_empty method.signatures

    assert_nil method.operation_info
  end

  def test_garbage_BidiGarbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    method = service.methods.find { |s| s.name == "BidiGarbage" }
    refute_nil method

    assert_nil method.options

    assert_nil method.http
    assert_empty method.signatures
    assert_nil method.operation_info
  end
end
