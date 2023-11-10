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

class ClientStubRetryRaiseLegacyTest < ClientStubTestBase
  ##
  # Tests that if options don't have retry code, retrying does not happen
  # in legacy `raise_faraday_errors` mode.
  #
  def test_no_retry_without_codes_legacy
    call_count = 0
    client_stub = make_client_stub raise_faraday_errors: true

    make_request_proc = lambda do |args|
      call_count += 1
      raise FakeFaradayError.new(GRPC::Core::StatusCodes::INTERNAL)
    end

    options = Gapic::CallOptions.new # no codes
    client_stub.stub :base_make_http_request, make_request_proc do
      ex = assert_raises FakeFaradayError do
        client_stub.make_get_request uri: "/foo", options: options
      end

      assert_equal GRPC::Core::StatusCodes::INTERNAL, ex.grpc_code
    end

    assert_equal 1, call_count
  end

  ##
  # Tests that if error has a code different from one in options, retrying does not happen
  # in legacy `raise_faraday_errors` mode.
  #
  def test_no_retry_with_mismatched_error_legacy
    call_count = 0
    client_stub = make_client_stub raise_faraday_errors: true

    make_request_proc = lambda do |args|
      call_count += 1
      raise FakeFaradayError.new(GRPC::Core::StatusCodes::INTERNAL)
    end
    
    options = Gapic::CallOptions.new(
      retry_policy: { retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
    )

    client_stub.stub :base_make_http_request, make_request_proc do
      ex = assert_raises FakeFaradayError do
        client_stub.make_get_request uri: "/foo", options: options
      end

      assert_equal GRPC::Core::StatusCodes::INTERNAL, ex.grpc_code
    end
    assert_equal 1, call_count
  end

  ##
  # Test that if it retries specified exceptions and then raises
  # a ::Faraday::TimeoutError, ::Faraday::TimeoutError gets raised as is
  # in legacy `raise_faraday_errors` mode.
  #
  def test_deadline_exceeded_legacy
    client_stub = make_client_stub raise_faraday_errors: true

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
        ex = assert_raises Faraday::TimeoutError do
          client_stub.make_get_request uri: "/foo", options: options
        end
      end
    end

    assert_equal 3, call_count
    sleep_mock.verify
  end

  ##
  # Test that it retries specified exceptions and then raises
  # an unspecified exception, when unspecified one is NOT a Faraday exception
  # in legacy `raise_faraday_errors` mode.
  #
  def test_retries_then_raises_unexpected_exception_legacy
    client_stub = make_client_stub raise_faraday_errors: true

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
        ex = assert_raises RuntimeError do
          client_stub.make_get_request uri: "/foo", options: options
        end
      end
    end

    assert_equal 3, call_count
  end
end
