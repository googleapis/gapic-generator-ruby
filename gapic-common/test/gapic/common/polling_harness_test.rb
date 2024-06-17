# Copyright 2024 Google LLC
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

require "gapic/common/polling_harness"
require "gapic/common/retry_policy"

# Test class for Gapic::Common::PollingHarness
class PollingHarnessTest < Minitest::Test
  def test_init
    retry_policy = Gapic::Common::RetryPolicy.new initial_delay: 20
    polling_harness = Gapic::Common::PollingHarness.new retry_policy: retry_policy
    assert_equal retry_policy, polling_harness.retry_policy
  end

  def test_wait_perform_delay_once
    should_wait = true
    retry_policy_mock = Minitest::Mock.new
    retry_policy_mock.expect :update_deadline!, nil, []
    retry_policy_mock.expect :perform_delay!, nil, []
    retry_policy_mock.expect :retry_with_deadline?, true, []
    polling_harness = Gapic::Common::PollingHarness.new retry_policy: retry_policy_mock

    polling_harness.wait do
      if should_wait
        should_wait = false
        nil
      else
        should_wait
      end
    end
    retry_policy_mock.verify
    assert_equal false, should_wait
  end

  def test_wait_perform_delay_many
    perform_delay_total = 5
    retry_policy_mock = Minitest::Mock.new
    retry_policy_mock.expect :update_deadline!, nil, []
    polling_harness = Gapic::Common::PollingHarness.new retry_policy: retry_policy_mock

    polling_harness.wait do
      if perform_delay_total.positive?
        retry_policy_mock.expect :perform_delay!, nil, []
        retry_policy_mock.expect :retry_with_deadline?, true, []
        perform_delay_total -= 1
        nil
      else
        perform_delay_total
      end
    end
    retry_policy_mock.verify
    assert_equal 0, perform_delay_total
  end

  def test_wait_with_retriable_code
    perform_delay_count = 0
    retry_policy = Gapic::Common::RetryPolicy.new retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE]
    retry_policy.define_singleton_method :perform_delay! do
      perform_delay_count += 1
    end
    polling_harness = Gapic::Common::PollingHarness.new retry_policy: retry_policy

    should_raise_error = true
    polling_harness.wait do
      if should_raise_error
        should_raise_error = false
        raise ::GRPC::Unavailable
      else
        should_raise_error
      end
    end
    assert_equal 1, perform_delay_count
  end

  def test_wait_non_retriable_code
    perform_delay_count = 0
    retry_policy = Gapic::Common::RetryPolicy.new retry_codes: [GRPC::Core::StatusCodes::RESOURCE_EXHAUSTED]
    retry_policy.define_singleton_method :perform_delay! do
      perform_delay_count += 1
    end
    polling_harness = Gapic::Common::PollingHarness.new retry_policy: retry_policy
    assert_raises ::GRPC::Aborted do
      polling_harness.wait do
        raise ::GRPC::Aborted
      end
    end
    assert_equal 0, perform_delay_count
  end

  def test_wait_argument_error
    retry_policy = Gapic::Common::RetryPolicy.new
    polling_harness = Gapic::Common::PollingHarness.new retry_policy: retry_policy
    assert_raises ArgumentError do
      polling_harness.wait
    end
  end

  def test_wait_with_timeout
    retry_policy = Gapic::Common::RetryPolicy.new initial_delay: 2, multiplier: 1, timeout: 3
    polling_harness = Gapic::Common::PollingHarness.new retry_policy: retry_policy
    wait_count = 0
    polling_harness.wait do
      wait_count += 1
      nil
    end
    assert_equal 2, wait_count
  end
end
