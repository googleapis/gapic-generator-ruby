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
require "gapic/grpc"

class RpcCallRetryRaiseTest < Minitest::Test
  def test_no_retry_without_codes
    call_count = 0
    api_meth_stub = proc do
      call_count += 1
      raise GRPC::Unavailable
    end

    rpc_call = Gapic::ServiceStub::RpcCall.new api_meth_stub

    options = Gapic::CallOptions.new # no codes
    assert_raises GRPC::BadStatus do
      rpc_call.call Object.new, options: options
    end
    assert_equal 1, call_count
  end

  def test_no_retry_with_mismatched_grpc_error
    api_meth_stub = proc do
      raise GRPC::Unimplemented
    end
    rpc_call = Gapic::ServiceStub::RpcCall.new api_meth_stub

    options = Gapic::CallOptions.new(
      retry_policy: { retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
    )
    assert_raises GRPC::BadStatus do
      rpc_call.call Object.new, options: options
    end
  end

  def test_no_retry_with_fake_grpc_error
    api_meth_stub = proc do
      raise FakeCodeError.new("Not a real GRPC error",
                              GRPC::Core::StatusCodes::UNAVAILABLE)
    end
    rpc_call = Gapic::ServiceStub::RpcCall.new api_meth_stub

    options = Gapic::CallOptions.new(
      retry_policy: { retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
    )
    assert_raises FakeCodeError do
      rpc_call.call Object.new, options: options
    end
  end

  def test_times_out
    to_attempt = 5
    call_count = 0
    deadline_arg = nil

    api_meth_stub = proc do |deadline: nil, **_kwargs|
      deadline_arg = deadline
      call_count += 1
      raise GRPC::Unavailable
    end

    rpc_call = Gapic::ServiceStub::RpcCall.new api_meth_stub

    nanos = Process.clock_gettime Process::CLOCK_REALTIME, :nanosecond
    time_proc = lambda do |*|
      nanos += 60_000_000_000
    end

    sleep_mock = Minitest::Mock.new
    sleep_mock.expect :sleep, nil, [1]
    sleep_mock.expect :sleep, nil, [1 * 1.3]
    sleep_mock.expect :sleep, nil, [1 * 1.3 * 1.3]
    sleep_mock.expect :sleep, nil, [1 * 1.3 * 1.3 * 1.3]
    sleep_proc = ->(count) { sleep_mock.sleep count }

    options = Gapic::CallOptions.new(
      timeout: 300,
      retry_policy: { retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
    )

    Kernel.stub :sleep, sleep_proc do
      Process.stub :clock_gettime, time_proc do
        assert_raises GRPC::BadStatus do
          rpc_call.call Object.new, options: options
        end

        expected_time = Time.at(nanos / 1_000_000_000, nanos % 1_000_000_000, :nanosecond)
        assert_equal expected_time, deadline_arg
        assert_equal to_attempt, call_count
      end
    end

    sleep_mock.verify
  end

  ##
  # Tests that if a layer underlying the RpcCall repeatedly throws a retriable exception
  # and then throws a DeadlineExceeded, the two exceptions get wrapped in a Gapic::GRPC::DeadlineExceededError
  #
  def test_deadline_exceeded
    call_count = 0
    err_message = "foo"
    unavailable_err_message = "#{GRPC::Core::StatusCodes::UNAVAILABLE}:#{err_message}"

    api_meth_stub = proc do |deadline: nil, **_kwargs|
      call_count += 1
      raise GRPC::DeadlineExceeded if call_count == 3
      raise GRPC::Unavailable.new(err_message)
    end

    rpc_call = Gapic::ServiceStub::RpcCall.new api_meth_stub

    sleep_mock = Minitest::Mock.new
    sleep_mock.expect :sleep, nil, [1]
    sleep_mock.expect :sleep, nil, [1 * 1.3]
    sleep_proc = ->(count) { sleep_mock.sleep count }

    options = Gapic::CallOptions.new(
      retry_policy: { retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
    )

    Kernel.stub :sleep, sleep_proc do
      ex = assert_raises Gapic::GRPC::DeadlineExceededError do
        rpc_call.call Object.new, options: options
      end

      assert_equal 3, call_count

      assert_equal ::GRPC::Core::StatusCodes::DEADLINE_EXCEEDED, ex.code

      refute_nil ex.cause
      assert_kind_of ::GRPC::DeadlineExceeded, ex.cause

      refute_nil ex.root_cause
      assert_kind_of ::GRPC::Unavailable, ex.root_cause
      assert_equal unavailable_err_message, ex.root_cause.message
    end

    sleep_mock.verify
  end

  def test_aborts_on_unexpected_exception
    call_count = 0

    api_meth_stub = proc do
      call_count += 1
      raise RuntimeError
    end

    rpc_call = Gapic::ServiceStub::RpcCall.new api_meth_stub

    assert_raises RuntimeError do
      rpc_call.call Object.new
    end
    assert_equal 1, call_count
  end

  def test_no_retry_when_no_responses
    inner_stub = proc { nil }

    api_meth_stub = proc do |request, **kwargs|
      OperationStub.new { inner_stub.call(request, **kwargs) }
    end

    rpc_call = Gapic::ServiceStub::RpcCall.new api_meth_stub

    assert_nil rpc_call.call(Object.new)
  end
end
