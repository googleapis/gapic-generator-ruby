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

class OptionsSettingsTest < Minitest::Test
  def test_defaults
    options = Gapic::CallOptions.new

    assert_nil options.timeout
    assert_equal({}, options.metadata)
    assert_equal [], options.retry_policy.retry_codes
    assert_equal 1, options.retry_policy.initial_delay
    assert_equal 1.3, options.retry_policy.multiplier
    assert_equal 15, options.retry_policy.max_delay
  end

  def test_apply_defaults_overrides_default_values
    options = Gapic::CallOptions.new
    options.apply_defaults(
      timeout: 60, metadata: { foo: :bar },
      retry_policy: {
        retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE],
        initial_delay: 4, multiplier: 5, max_delay: 6
      }
    )

    assert_equal 60, options.timeout
    assert_equal({ foo: :bar }, options.metadata)
    assert_equal(
      [GRPC::Core::StatusCodes::UNAVAILABLE],
      options.retry_policy.retry_codes
    )
    assert_equal 4, options.retry_policy.initial_delay
    assert_equal 5, options.retry_policy.multiplier
    assert_equal 6, options.retry_policy.max_delay
  end

  def test_overrides_default_values
    options = Gapic::CallOptions.new(
      timeout: 60, metadata: { foo: :bar },
      retry_policy: {
        retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE],
        initial_delay: 4, multiplier: 5, max_delay: 6
      }
    )

    assert_equal 60, options.timeout
    assert_equal({ foo: :bar }, options.metadata)
    assert_equal(
      [GRPC::Core::StatusCodes::UNAVAILABLE],
      options.retry_policy.retry_codes
    )
    assert_equal 4, options.retry_policy.initial_delay
    assert_equal 5, options.retry_policy.multiplier
    assert_equal 6, options.retry_policy.max_delay
  end

  def test_apply_defaults_wont_override_custom_values
    options = Gapic::CallOptions.new(
      timeout: 30, metadata: { baz: :bif },
      retry_policy: {
        retry_codes: [GRPC::Core::StatusCodes::UNIMPLEMENTED],
        initial_delay: 7, multiplier: 6, max_delay: 5
      }
    )
    options.apply_defaults(
      timeout: 60, metadata: { foo: :bar },
      retry_policy: {
        retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE],
        initial_delay: 4, multiplier: 5, max_delay: 6
      }
    )

    assert_equal 30, options.timeout
    # metadata is merged, but not overridden
    assert_equal({ foo: :bar, baz: :bif }, options.metadata)
    assert_equal(
      [GRPC::Core::StatusCodes::UNIMPLEMENTED],
      options.retry_policy.retry_codes
    )
    assert_equal 7, options.retry_policy.initial_delay
    assert_equal 6, options.retry_policy.multiplier
    assert_equal 5, options.retry_policy.max_delay
  end

  def test_to_h_empty
    options = Gapic::CallOptions.new
    expected = {
      timeout: nil,
      metadata: {},
      retry_policy: Gapic::CallOptions::RetryPolicy.new
    }
    assert_equal expected, options.to_h
  end

  def test_to_h_with_values
    options = Gapic::CallOptions.new(
      timeout: 60,
      metadata: { foo: :bar },
      retry_policy: {
        retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE],
        initial_delay: 4, multiplier: 5, max_delay: 6
      }
    )
    expected_retry_policy = Gapic::CallOptions::RetryPolicy.new(
      retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE],
      initial_delay: 4, multiplier: 5, max_delay: 6
    )
    expected = {
      timeout: 60,
      metadata: { foo: :bar },
      retry_policy: expected_retry_policy
    }
    assert_equal expected, options.to_h
  end

  def test_merge_no_changes
    options = Gapic::CallOptions.new(
      timeout: 60,
      metadata: { foo: :bar },
      retry_policy: {
        retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE],
        initial_delay: 4, multiplier: 5, max_delay: 6
      }
    )
    merged = options.merge
    assert_equal 60, merged.timeout
    expected_retry_policy = Gapic::CallOptions::RetryPolicy.new(
      retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE],
      initial_delay: 4, multiplier: 5, max_delay: 6
    )
    assert_equal expected_retry_policy, merged.retry_policy
    assert_equal({ foo: :bar }, merged.metadata)
  end

  def test_merge_with_changes
    options = Gapic::CallOptions.new(
      timeout: 60,
      metadata: { foo: :bar },
      retry_policy: {
        retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE],
        initial_delay: 4, multiplier: 5, max_delay: 6
      }
    )
    merged = options.merge(
      timeout: 30,
      retry_policy: nil,
      metadata: { bar: :foo }
    )
    assert_equal 30, merged.timeout
    assert_equal Gapic::CallOptions::RetryPolicy.new, merged.retry_policy
    assert_equal({ bar: :foo }, merged.metadata)
  end

  def test_equality
    options = Gapic::CallOptions.new(
      timeout: 60,
      metadata: { foo: :bar },
      retry_policy: {
        retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE],
        initial_delay: 4, multiplier: 5, max_delay: 6
      }
    )
    other = Gapic::CallOptions.new(
      timeout: 60,
      metadata: { foo: :bar },
      retry_policy: {
        retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE],
        initial_delay: 4, multiplier: 5, max_delay: 6
      }
    )
    assert_equal other, options
    assert_equal other.hash, options.hash
  end

  def test_inequality
    options = Gapic::CallOptions.new(
      timeout: 60,
      metadata: { foo: :bar },
      retry_policy: {
        retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE],
        initial_delay: 4, multiplier: 5, max_delay: 6
      }
    )
    other = Gapic::CallOptions.new
    refute_equal other, options
    refute_equal other.hash, options.hash
  end
end
