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

class RetryPolicySettingsTest < Minitest::Test
  def test_defaults
    retry_policy = Gapic::ApiCall::RetryPolicy.new

    assert_equal [], retry_policy.retry_codes
    assert_equal 1, retry_policy.initial_delay
    assert_equal 1.3, retry_policy.multiplier
    assert_equal 15, retry_policy.max_delay
  end

  def test_apply_defaults_overrides_default_values
    retry_policy = Gapic::ApiCall::RetryPolicy.new
    retry_policy.apply_defaults(
      retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE],
      initial_delay: 4, multiplier: 5, max_delay: 6
    )

    assert_equal(
      [GRPC::Core::StatusCodes::UNAVAILABLE],
      retry_policy.retry_codes
    )
    assert_equal 4, retry_policy.initial_delay
    assert_equal 5, retry_policy.multiplier
    assert_equal 6, retry_policy.max_delay
  end

  def test_overrides_default_values
    retry_policy = Gapic::ApiCall::RetryPolicy.new(
      retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE],
      initial_delay: 4, multiplier: 5, max_delay: 6
    )

    assert_equal(
      [GRPC::Core::StatusCodes::UNAVAILABLE],
      retry_policy.retry_codes
    )
    assert_equal 4, retry_policy.initial_delay
    assert_equal 5, retry_policy.multiplier
    assert_equal 6, retry_policy.max_delay
  end

  def test_apply_defaults_wont_override_custom_values
    retry_policy = Gapic::ApiCall::RetryPolicy.new(
      retry_codes: [GRPC::Core::StatusCodes::UNIMPLEMENTED],
      initial_delay: 7, multiplier: 6, max_delay: 5
    )
    retry_policy.apply_defaults(
      retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE],
      initial_delay: 4, multiplier: 5, max_delay: 6
    )

    assert_equal(
      [GRPC::Core::StatusCodes::UNIMPLEMENTED],
      retry_policy.retry_codes
    )
    assert_equal 7, retry_policy.initial_delay
    assert_equal 6, retry_policy.multiplier
    assert_equal 5, retry_policy.max_delay
  end
end
