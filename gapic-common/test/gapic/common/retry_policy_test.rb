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

require "gapic/common/retry_policy"

# Test class for Gapic::Common::RetryPolicy
class RetryPolicyTest < Minitest::Test
  def test_init_with_values
    retry_policy = Gapic::Common::RetryPolicy.new initial_delay: 2, max_delay: 20, multiplier: 1.7
    assert_equal 2, retry_policy.initial_delay
    assert_equal 20, retry_policy.max_delay
    assert_equal 1.7, retry_policy.multiplier
  end

  def test_perform_delay_with_custom_retry
    retry_policy = Gapic::Common::RetryPolicy.new initial_delay: 1, max_delay: 3, multiplier: 1.5, timeout: 0
    retry_policy.customize_retry do |**kwargs|
      return kwargs[:retry_now]
    end
    assert retry_policy.perform_delay retry_node: true
  end

  def test_perform_delay_increment
    retry_policy = Gapic::Common::RetryPolicy.new initial_delay: 1, max_delay: 5, multiplier: 1.3
    retry_policy.perform_delay!
    refute_equal retry_policy.initial_delay, retry_policy.delay
    assert_equal 1.3, retry_policy.delay
  end

  def test_perform_delay_retry_logic
    retry_policy = Gapic::Common::RetryPolicy.new initial_delay: 3, max_delay: 10, multiplier: 2
    retry_policy.define_singleton_method :retry? do
      true
    end
    retry_policy.perform_delay
    assert_equal 6, retry_policy.delay
  end

  def test_max_delay
    retry_policy = Gapic::Common::RetryPolicy.new initial_delay: 10, max_delay: 12, multiplier: 1.5
    retry_policy.perform_delay!
    assert_equal 12, retry_policy.delay
  end
end
