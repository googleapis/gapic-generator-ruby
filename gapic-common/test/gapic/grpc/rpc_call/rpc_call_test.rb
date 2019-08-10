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

class RpcCallTest < Minitest::Test
  def test_call
    deadline_arg = nil

    api_meth_stub = proc do |deadline: nil, **_kwargs|
      deadline_arg = deadline
      OperationStub.new { 42 }
    end

    rpc_call = Gapic::ServiceStub::RpcCall.new api_meth_stub

    assert_equal 42, rpc_call.call(Object.new)
    assert_kind_of Time, deadline_arg

    new_deadline = Time.now + 20
    options = Gapic::CallOptions.new timeout: 20

    assert_equal 42, rpc_call.call(Object.new, options: options)
    assert_in_delta new_deadline, deadline_arg, 0.9
  end

  def test_call_with_format_response
    api_meth_stub = proc do |request, **_kwargs|
      assert_equal 3, request
      OperationStub.new { 2 + request }
    end

    format_response = ->(response) { response.to_s }
    rpc_call = Gapic::ServiceStub::RpcCall.new api_meth_stub

    assert_equal 5, rpc_call.call(3)
    assert_equal "5", rpc_call.call(3, format_response: format_response)
    assert_equal 5, rpc_call.call(3)
  end

  def test_call_with_operation_callback
    adder = 0

    api_meth_stub = proc do |request, **_kwargs|
      assert_equal 3, request
      OperationStub.new { 2 + request + adder }
    end

    increment_addr = ->(*args) { adder = 5 }
    rpc_call = Gapic::ServiceStub::RpcCall.new api_meth_stub

    assert_equal 5, rpc_call.call(3)
    assert_equal 5, rpc_call.call(3, operation_callback: increment_addr)
    assert_equal 10, rpc_call.call(3)
  end

  def test_call_with_format_response_and_operation_callback
    adder = 0

    api_meth_stub = proc do |request, **_kwargs|
      assert_equal 3, request
      OperationStub.new { 2 + request + adder }
    end

    format_response = ->(response) { response.to_s }
    increment_addr = ->(*args) { adder = 5 }
    rpc_call = Gapic::ServiceStub::RpcCall.new api_meth_stub

    assert_equal 5, rpc_call.call(3)
    assert_equal "5", rpc_call.call(3, format_response: format_response, operation_callback: increment_addr)
    assert_equal 10, rpc_call.call(3)
    assert_equal "10", rpc_call.call(3, format_response: format_response, operation_callback: increment_addr)
    assert_equal 10, rpc_call.call(3)
  end

  def test_call_with_stream_callback
    all_responses = []

    api_meth_stub = proc do |requests, **_kwargs, &block|
      assert_kind_of Enumerable, requests
      OperationStub.new { requests.each(&block) }
    end

    collect_response = ->(response) { all_responses << response }
    rpc_call = Gapic::ServiceStub::RpcCall.new api_meth_stub

    rpc_call.call([:foo, :bar, :baz].to_enum, stream_callback: collect_response)
    wait_until { all_responses == [:foo, :bar, :baz] }
    assert_equal [:foo, :bar, :baz], all_responses
    rpc_call.call([:qux, :quux, :quuz].to_enum, stream_callback: collect_response)
    wait_until { all_responses == [:foo, :bar, :baz, :qux, :quux, :quuz] }
    assert_equal [:foo, :bar, :baz, :qux, :quux, :quuz], all_responses
  end

  def test_call_with_stream_callback_and_format_response
    all_responses = []

    api_meth_stub = proc do |requests, **_kwargs, &block|
      assert_kind_of Enumerable, requests
      OperationStub.new { requests.each(&block) }
    end

    collect_response = ->(response) { all_responses << response }
    format_response = ->(response) { response.to_s }
    rpc_call = Gapic::ServiceStub::RpcCall.new api_meth_stub

    rpc_call.call([:foo, :bar, :baz].to_enum, stream_callback: collect_response)
    wait_until { all_responses == [:foo, :bar, :baz] }
    assert_equal [:foo, :bar, :baz], all_responses
    rpc_call.call([:qux, :quux, :quuz].to_enum, stream_callback: collect_response, format_response: format_response)
    wait_until { all_responses == [:foo, :bar, :baz, "qux", "quux", "quuz"] }
    assert_equal [:foo, :bar, :baz, "qux", "quux", "quuz"], all_responses
  end

  def test_stream_without_stream_callback_and_format_response
    all_responses = []

    api_meth_stub = proc do |requests, **_kwargs, &block|
      assert_kind_of Enumerable, requests
      OperationStub.new { requests.each(&block) }
    end

    rpc_call = Gapic::ServiceStub::RpcCall.new api_meth_stub

    responses = rpc_call.call [:foo, :bar, :baz].to_enum
    assert_kind_of Enumerable, responses
    all_responses += responses.to_a
    assert_equal [:foo, :bar, :baz], all_responses

    responses = rpc_call.call [:qux, :quux, :quuz].to_enum
    assert_kind_of Enumerable, responses
    all_responses += responses.to_a
    assert_equal [:foo, :bar, :baz, :qux, :quux, :quuz], all_responses
  end

  def test_stream_without_stream_callback_but_format_response
    all_responses = []

    api_meth_stub = proc do |requests, **_kwargs, &block|
      assert_kind_of Enumerable, requests
      OperationStub.new { requests.each(&block) }
    end

    format_responses = ->(responses) { responses.lazy.map(&:to_s) }
    rpc_call = Gapic::ServiceStub::RpcCall.new api_meth_stub

    responses = rpc_call.call [:foo, :bar, :baz].to_enum
    assert_kind_of Enumerable, responses
    all_responses += responses.to_a
    assert_equal [:foo, :bar, :baz], all_responses

    responses = rpc_call.call [:qux, :quux, :quuz].to_enum, format_response: format_responses
    assert_kind_of Enumerable, responses
    all_responses += responses.to_a
    assert_equal [:foo, :bar, :baz, "qux", "quux", "quuz"], all_responses
  end

  ##
  # This is an ugly way to block on concurrent criteria, but it works...
  def wait_until iterations = 100
    count = 0
    loop do
      raise "criteria not met" if count >= iterations
      break if yield
      sleep 0.0001
      count += 1
    end
  end
end
