# Copyright 2022 Google LLC
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
require "gapic/rest"

class ClientStubRetryRaiseTest < ClientStubTestBase
  ##
  # Tests that no retrying happens then the call simply completes with no response
  #
  def test_no_retry_when_no_response
    call_count = 0
    client_stub = make_client_stub

    make_request_proc = lambda do |args|
      call_count += 1
      nil
    end

    options = Gapic::CallOptions.new(
      retry_policy: { retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
    )

    client_stub.stub :base_make_http_request, make_request_proc do
      client_stub.make_get_request uri: "/foo", options: options
    end

    assert_equal 1, call_count
  end

  ##
  # Tests that if options don't have retry code, retrying does not happen
  #
  def test_no_retry_without_codes
    call_count = 0
    client_stub = make_client_stub

    make_request_proc = lambda do |args|
      call_count += 1
      raise FakeFaradayError.new(GRPC::Core::StatusCodes::INTERNAL)
    end

    options = Gapic::CallOptions.new # no codes
    client_stub.stub :base_make_http_request, make_request_proc do
      ex = assert_raises Gapic::Rest::Error do
        client_stub.make_get_request uri: "/foo", options: options
      end

      refute_nil ex.cause
      assert_kind_of FakeFaradayError, ex.cause
      assert_equal GRPC::Core::StatusCodes::INTERNAL, ex.cause.grpc_code
    end

    assert_equal 1, call_count
  end

  ##
  # Tests that if error has a code different from one in options, retrying does not happen
  #
  def test_no_retry_with_mismatched_error
    call_count = 0
    client_stub = make_client_stub

    make_request_proc = lambda do |args|
      call_count += 1
      raise FakeFaradayError.new(GRPC::Core::StatusCodes::INTERNAL)
    end
    
    options = Gapic::CallOptions.new(
      retry_policy: { retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
    )

    client_stub.stub :base_make_http_request, make_request_proc do
      ex = assert_raises Gapic::Rest::Error do
        client_stub.make_get_request uri: "/foo", options: options
      end

      refute_nil ex.cause
      assert_kind_of FakeFaradayError, ex.cause
      assert_equal GRPC::Core::StatusCodes::INTERNAL, ex.cause.grpc_code
    end
    assert_equal 1, call_count
  end

  ##
  # Test that if it retries specified exceptions until it runs out of time,
  # without Faraday layer throwing a ::Faraday::Timeout, the last exception gets surfaced.
  #
  def test_times_outs
    client_stub = make_client_stub
    to_attempt = 5
    time_delay = 60

    call_count = 0
    make_request_proc = lambda do |args|
      call_count += 1
      raise FakeFaradayError.new(GRPC::Core::StatusCodes::UNAVAILABLE)
    end

    time_now = 1
    time_proc = ->(_) do
      time_now += time_delay
    end

    # Default delay and multiplier are 1 and 1.3
    # The number of expects here is `to_attempt-1`, spelt out for visibility
    sleep_mock = Minitest::Mock.new
    sleep_mock.expect :sleep, nil, [1]
    sleep_mock.expect :sleep, nil, [1 * 1.3]
    sleep_mock.expect :sleep, nil, [1 * 1.3 * 1.3]
    sleep_mock.expect :sleep, nil, [1 * 1.3 * 1.3 * 1.3]
    sleep_proc = ->(count) { sleep_mock.sleep count }

    options = Gapic::CallOptions.new(
      timeout: time_delay * to_attempt + 0.1, # `+0.1` means that timeout stays positive on last cycle  
      retry_policy: {
        retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE], 
      }
    )

    Kernel.stub :sleep, sleep_proc do
      ::Process.stub :clock_gettime, time_proc do
        client_stub.stub :base_make_http_request, make_request_proc do
          ex = assert_raises ::Gapic::Rest::Error do
            client_stub.make_get_request uri: "/foo", options: options
          end

          refute_nil ex.cause
          assert_kind_of FakeFaradayError, ex.cause

          # Note that this is not a DEADLINE_EXCEEDED
          # Our fake never throws ::Faraday::TimeoutError so the error gets wrapped as is.
          # This mirrors the gRPC test
          assert_equal GRPC::Core::StatusCodes::UNAVAILABLE, ex.cause.grpc_code
        end
      end
    end

    assert_equal to_attempt, call_count
    sleep_mock.verify
  end

  ##
  # Test that if it retries specified exceptions and then raises
  # a ::Faraday::Timeout, the two exceptions get wrapped in a Gapic::Rest::DeadlineExceededError
  #
  def test_deadline_exceeded
    client_stub = make_client_stub

    call_count = 0
    make_request_proc = lambda do |args|
      call_count += 1
      raise Faraday::TimeoutError.new(nil, {status: 504}) if call_count == 3
      raise FakeFaradayError.new(GRPC::Core::StatusCodes::UNAVAILABLE)
    end

    # Default delay and multiplier are 1 and 1.3
    sleep_mock = Minitest::Mock.new
    sleep_mock.expect :sleep, nil, [1]
    sleep_mock.expect :sleep, nil, [1 * 1.3]
    sleep_proc = ->(count) { sleep_mock.sleep count }

    options = Gapic::CallOptions.new(
      retry_policy: {
        retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE], 
      }
    )

    Kernel.stub :sleep, sleep_proc do
      client_stub.stub :base_make_http_request, make_request_proc do
        ex = assert_raises ::Gapic::Rest::DeadlineExceededError do
          client_stub.make_get_request uri: "/foo", options: options
        end

        refute_nil ex.cause
        assert_kind_of Faraday::TimeoutError, ex.cause

        refute_nil ex.root_cause
        assert_equal GRPC::Core::StatusCodes::UNAVAILABLE, ex.root_cause.grpc_code
      end
    end

    assert_equal 3, call_count
    sleep_mock.verify
  end

  ##
  # Test that it retries specified exceptions and then raises
  # an unspecified exception, when unspecified one is NOT a Faraday exception
  #
  def test_retries_then_raises_unexpected_exception
    client_stub = make_client_stub

    call_count = 0
    make_request_proc = lambda do |args|
      call_count += 1
      raise RuntimeError if call_count == 3
      raise FakeFaradayError.new(GRPC::Core::StatusCodes::UNAVAILABLE)
    end

    sleep_proc = ->(count) { }

    options = Gapic::CallOptions.new(
      timeout: 1,
      retry_policy: {
        retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE], 
      }
    )

    Kernel.stub :sleep, sleep_proc do
      client_stub.stub :base_make_http_request, make_request_proc do
        assert_raises RuntimeError do
          client_stub.make_get_request uri: "/foo", options: options
        end
      end
    end

    assert_equal 3, call_count
  end
end
