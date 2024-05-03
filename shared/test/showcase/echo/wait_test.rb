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
require "google/showcase/v1beta1/echo"
require "grpc"

class WaitTest < ShowcaseTest
  attr_reader :retry_policy

  def setup client = nil
    @client = client
    @retry_policy = ::Gapic::Operation::RetryPolicy.new initial_delay: 0.2, multiplier: 2, max_delay: 1, timeout: 2
  end

  def test_wait
    return unless @client
    operation = @client.wait ttl: { seconds: 2 }, success: { content: "hi there!" }
    refute operation.done?
  
    # exercise the operations_client
    ops_name = operation.name.split("/", 4).slice(0, 3).join("/")
    ops = @client.operations_client.list_operations(::Google::Longrunning::ListOperationsRequest.new(name: ops_name))
    assert ops.count > 0
    
    operation = @client.operations_client.get_operation name: operation.name
    operation.wait_until_done! retry_policy: retry_policy

    assert operation.done?
    assert operation.response?
    assert operation.response.is_a? Google::Showcase::V1beta1::WaitResponse
    assert_equal "hi there!", operation.response.content
  end

  def test_wait_error
    return unless @client
    operation = @client.wait ttl: { nanos: 500000 }, error: Google::Rpc::Status.new(message: "nope")

    refute operation.done?
    operation.wait_until_done! retry_policy: @retry_policy

    assert operation.done?
    assert operation.error?
    assert_equal "nope", operation.error.message
  end
end

class WaitGRPCTest < WaitTest
  def setup
    super new_echo_client
  end

  def test_wait_with_metadata
    options = Gapic::CallOptions.new metadata: {
      'showcase-trailer': ["q", "wer", "ty", "!"],
      junk:               ["zab", "show"]
    }
    @client.wait({ ttl: { nanos: 500000 }, success: { content: "hi again!" } }, options) do |operation, grpc_operation|
      refute operation.done?
      operation.wait_until_done! retry_policy: @retry_policy

      assert operation.done?
      assert operation.response?
      assert_equal "hi again!", operation.response.content
      assert_instance_of GRPC::ActiveCall::Operation, grpc_operation
      assert_equal ["q", "wer", "ty", "!"], grpc_operation.trailing_metadata["showcase-trailer"]
    end
  end
end

class WaitRestTest < WaitTest
  def setup
    super new_echo_rest_client
  end
end
