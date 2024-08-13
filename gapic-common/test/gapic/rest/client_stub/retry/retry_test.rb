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

class ClientStubRetryRetryTest < ClientStubTestBase
  ##
  # Test that the default retry strategy works
  #
  def test_default_retry_strategy
    client_stub = make_client_stub
    to_attempt = 5
    time_delay = 60

    inner_responses = Array.new 4 do
      FakeFaradayError.new(GRPC::Core::StatusCodes::UNAVAILABLE)
    end
    final_response = Struct.new(:body).new
    inner_responses += [final_response]

    call_count = 0
    make_request_proc = lambda do |args|
      call_count += 1
      inner_response = inner_responses.shift

      raise inner_response if inner_response.is_a? Exception

      inner_response
    end

    time_now = 0
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
          assert_equal final_response, client_stub.make_get_request(uri: "/foo", options: options)
        end
      end
    end

    # The code checks time for to_attempt calls and once for initial delay calc, hence +1.
    assert_equal time_delay * (to_attempt + 1), time_now
    assert_equal to_attempt, call_count
    sleep_mock.verify
  end

  ##
  # Test that the a custom retry strategy works
  #
  def test_custom_retry_strategy
    client_stub = make_client_stub

    inner_responses = Array.new 4 do
      FakeFaradayError.new(GRPC::Core::StatusCodes::UNAVAILABLE)
    end
    final_response = Struct.new(:body).new
    inner_responses += [final_response]

    call_count = 0
    make_request_proc = lambda do |args|
      call_count += 1
      inner_response = inner_responses.shift

      raise inner_response if inner_response.is_a? Exception

      inner_response
    end

    custom_policy_count = 0
    custom_policy_sleep = [15, 12, 24, 21]
    custom_policy_length = custom_policy_sleep.count
    custom_policy = lambda do |_error|
      custom_policy_count += 1
      delay = custom_policy_sleep.shift
      if delay
        Kernel.sleep delay
        true
      else
        false
      end
    end
    options = Gapic::CallOptions.new retry_policy: custom_policy

    sleep_mock = Minitest::Mock.new
    custom_policy_sleep.each do |sleep_count|
      sleep_mock.expect :sleep, nil, [sleep_count]
    end
    sleep_proc = ->(count) { sleep_mock.sleep count }

    Kernel.stub :sleep, sleep_proc do
      client_stub.stub :base_make_http_request, make_request_proc do
        assert_equal final_response, client_stub.make_get_request(uri: "/foo", options: options)
      end
    end

    assert_equal custom_policy_length, custom_policy_count
    assert_equal custom_policy_length + 1, call_count
    sleep_mock.verify
  end
end
