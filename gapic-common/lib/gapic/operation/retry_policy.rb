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
    # The policy for retrying operation reloads using an incremental backoff. A new object instance should be used for
    # every Operation invocation.
    #
    class RetryPolicy < Gapic::Common::RetryPolicy
      DEFAULT_INITIAL_DELAY = 10
      DEFAULT_MAX_DELAY = 300 # Five minutes
      DEFAULT_MULTIPLIER = 1.3
      DEFAULT_TIMEOUT = 3600 # One hour
      ##
      # Create new Operation RetryPolicy.
      #
      # @param initial_delay [Numeric] client-side timeout
      # @param multiplier [Numeric] client-side timeout
      # @param max_delay [Numeric] client-side timeout
      # @param timeout [Numeric] client-side timeout
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
