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

require "gapic/common/retry_policy"

module Gapic
  class Operation
    ##
    # The policy for retrying operation reloads using an incremental backoff.
    #
    # A new object instance should be used for every Operation invocation.
    #
    class RetryPolicy < Gapic::Common::RetryPolicy
      # @return [Numeric] Default initial delay in seconds.
      DEFAULT_INITIAL_DELAY = 10
      # @return [Numeric] Default maximum delay in seconds.
      DEFAULT_MAX_DELAY = 300 # Five minutes
      # @return [Numeric] Default delay scaling factor for subsequent retry attempts.
      DEFAULT_MULTIPLIER = 1.3
      # @return [Numeric] Default timeout threshold value in seconds.
      DEFAULT_TIMEOUT = 3600 # One hour

      ##
      # Create new Operation RetryPolicy.
      #
      # @param initial_delay [Numeric] Initial delay in seconds.
      # @param multiplier [Numeric] The delay scaling factor for each subsequent retry attempt.
      # @param max_delay [Numeric] Maximum delay in seconds.
      # @param timeout [Numeric] Timeout threshold value in seconds.
      #
      def initialize initial_delay: nil, multiplier: nil, max_delay: nil, timeout: nil
        super(
          initial_delay: initial_delay || DEFAULT_INITIAL_DELAY,
          max_delay: max_delay || DEFAULT_MAX_DELAY,
          multiplier: multiplier || DEFAULT_MULTIPLIER,
          timeout: timeout || DEFAULT_TIMEOUT
        )
      end
    end
  end
end
