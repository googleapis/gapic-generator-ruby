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

require "base64"
require "test_helper"
require "google/showcase/v1beta1/echo"
require "grpc"

class OperationsTest < ShowcaseTest
  def setup
    @client = new_echo_operations_client
  end

  def test_raise_invalid_get_operation
    assert_raises(GRPC::NotFound) { @client.get_operation name: "thing1" }
  end

  def test_get_operation
    prefix = "operations/google.showcase.v1beta1.Echo/Wait/"
    wait_type = Google::Showcase::V1beta1::WaitRequest
    wait_request = Base64.encode64(wait_type.encode(wait_type.new(ttl: 200))).chop
    op = @client.get_operation name: prefix + wait_request

    waited = wait_type.decode(Base64.decode64(op.name.delete_prefix(prefix)))
    assert_instance_of wait_type, waited
  end

  def test_list_operations
    enumerable = @client.list_operations name: "a/thing/to/remember"

    assert_equal 1, enumerable.response.operations.count
  end

  def test_delete_operation
    response = @client.delete_operation name: "foo"

    assert_instance_of Google::Protobuf::Empty, response
  end

  def test_cancel_operation
    response = @client.cancel_operation name: "bar"

    assert_instance_of Google::Protobuf::Empty, response
  end
end
