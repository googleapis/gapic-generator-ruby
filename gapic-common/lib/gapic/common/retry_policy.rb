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

require "gapic/common/error_codes"

module Gapic
  module Common
    # Gapic Common retry policy base class.
    class RetryPolicy
      # @return [Numeric] Default initial delay in seconds.
      DEFAULT_INITIAL_DELAY = 1
      # @return [Numeric] Default maximum delay in seconds.
      DEFAULT_MAX_DELAY = 15
      # @return [Numeric] Default delay scaling factor for subsequent retry attempts.
      DEFAULT_MULTIPLIER = 1.3
      # @return [Array<String|Numeric>] Default list of retry codes.
      DEFAULT_RETRY_CODES = [].freeze
      # @return [Numeric] Default timeout threshold value in seconds.
      DEFAULT_TIMEOUT = 3600 # One hour

      ##
      # Create new Gapic::Common:RetryPolicy instance.
      #
      # Instance values are set as `nil` to determine whether values are overriden from default.
      #
      # @param initial_delay [Numeric] Initial delay in seconds.
      # @param max_delay [Numeric] Maximum delay in seconds.
      # @param multiplier [Numeric] The delay scaling factor for each subsequent retry attempt.
      # @param retry_codes [Array<String|Numeric>] List of retry codes.
      # @param timeout [Numeric] Timeout threshold value in seconds.
      #
      def initialize initial_delay: nil, max_delay: nil, multiplier: nil, retry_codes: nil, timeout: nil
        @initial_delay = initial_delay
        @max_delay = max_delay
        @multiplier = multiplier
        @retry_codes = convert_codes retry_codes
        @timeout = timeout
        @delay = nil
      end

      # @return [Numeric] Initial delay in seconds.
      def initial_delay
        @initial_delay || DEFAULT_INITIAL_DELAY
      end

      # @return [Numeric] Maximum delay in seconds.
      def max_delay
        @max_delay || DEFAULT_MAX_DELAY
      end

      # @return [Numeric] The delay scaling factor for each subsequent retry attempt.
      def multiplier
        @multiplier || DEFAULT_MULTIPLIER
      end

      # @return [Array<Numeric>] List of retry codes.
      def retry_codes
        @retry_codes || DEFAULT_RETRY_CODES
      end

      # @return [Numeric] Timeout threshold value in seconds.
      def timeout
        @timeout || DEFAULT_TIMEOUT
      end

      ##
      # Perform delay if and only if retriable.
      #
      # If positional argument `error` is provided, the retriable logic uses
      # `retry_codes`. Otherwise, `timeout` is used.
      #
      # @return [Boolean] Whether the delay was executed.
      #
      def call error = nil
        should_retry = error.nil? ? retry_with_deadline? : retry_error?(error)
        return false unless should_retry
        perform_delay!
      end
      alias perform_delay call

      ##
      # Perform delay.
      #
      # @return [Boolean] Whether the delay was executed.
      #
      def perform_delay!
        delay!
        increment_delay!
        true
      end

      ##
      # Current delay value in seconds.
      #
      # @return [Numeric] Time delay in seconds.
      #
      def delay
        @delay || initial_delay
      end

      ##
      # Sets a deadline based on the current time.
      #
      # @return [Numeric] The deadline for timeout-based retry policies.
      def update_deadline!
        @deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + timeout
      end

      ##
      # @private
      # @return [Boolean] Whether this error should be retried.
      #
      def retry_error? error
        (defined?(::GRPC) && error.is_a?(::GRPC::BadStatus) && retry_codes.include?(error.code)) ||
          (error.respond_to?(:response_status) &&
            retry_codes.include?(ErrorCodes.grpc_error_for(error.response_status)))
      end

      # @private
      # @return [Boolean] Whether this policy should be retried based on the deadline.
      def retry_with_deadline?
        deadline > Process.clock_gettime(Process::CLOCK_MONOTONIC)
      end

      ##
      # @private
      # Apply default values to the policy object. This does not replace user-provided values,
      # it only overrides empty values.
      #
      # @param retry_policy [Hash] The policy for error retry. Keys must match the arguments for
      #   {Gapic::Common::RetryPolicy.new}.
      #
      def apply_defaults retry_policy
        return unless retry_policy.is_a? Hash
        @retry_codes   ||= convert_codes retry_policy[:retry_codes]
        @initial_delay ||= retry_policy[:initial_delay]
        @multiplier    ||= retry_policy[:multiplier]
        @max_delay     ||= retry_policy[:max_delay]

        self
      end

      # @private Equality test
      def eql? other
        other.is_a?(RetryPolicy) &&
          other.initial_delay == initial_delay &&
          other.max_delay == max_delay &&
          other.multiplier == multiplier &&
          other.retry_codes == retry_codes &&
          other.timeout == timeout
      end
      alias == eql?

      # @private Hash code
      def hash
        [initial_delay, max_delay, multiplier, retry_codes, timeout].hash
      end

      private

      # @private
      # @return [Numeric] The performed delay.
      def delay!
        Kernel.sleep delay
      end

      # @private
      # @return [Numeric] The new delay in seconds.
      def increment_delay!
        @delay = [delay * multiplier, max_delay].min
      end

      # @private
      # @return [Numeric] The deadline for timeout-based policies.
      def deadline
        @deadline ||= update_deadline!
      end

      # @private
      # @return [Array<Numeric> Error codes converted to their respective integer values.
      def convert_codes input_codes
        return nil if input_codes.nil?
        Array(input_codes).map do |obj|
          case obj
          when String
            ErrorCodes::ERROR_STRING_MAPPING[obj]
          when Integer
            obj
          end
        end.compact
      end
    end
  end
end
