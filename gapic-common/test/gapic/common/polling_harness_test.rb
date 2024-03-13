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
  def test_init_with_policy
    retry_policy = Gapic::Common::RetryPolicy.new initial_delay: 20
    polling_harness = Gapic::Common::PollingHarness.new retry_policy: retry_policy
    assert_equal retry_policy, polling_harness.retry_policy
  end

  def test_wait_block_execution
    retry_policy = Gapic::Common::RetryPolicy.new initial_delay: 20
    wait_block_executed = false
    polling_harness = Gapic::Common::PollingHarness.new retry_policy: retry_policy
    polling_harness.wait do
      wait_block_executed = true
    end
    assert wait_block_executed
  end

  def test_wait_delay
    retry_policy = Gapic::Common::RetryPolicy.new initial_delay: 3, multiplier: 2
    polling_harness = Gapic::Common::PollingHarness.new retry_policy: retry_policy
    polling_harness.wait do
      return true
    end
    assert_equal 6, polling_harness.retry_policy.delay
  end

    #def test_wait_with_custom_error_logic
    #retry_policy = Gapic::Common::RetryPolicy.new retry_codes: [499]
    #metadata = {
    #  "grpc-status-details-bin" => encoded
    #}
    #error = GRPC::BadStatus.new 1, "", metadata
    #exception_trigger = -> { raise ::GRPC::BadStatus:.new 1, "", metadata }
    #polling_harness = Gapic::Common::PollingHarness.new retry_policy: retry_policy
    # polling_harness.wait do
    #   begin
    #     call_exception 
    #    return true
    # rescue => e
    #    error_triggered = true
    #  end
    # end
   # end
end
