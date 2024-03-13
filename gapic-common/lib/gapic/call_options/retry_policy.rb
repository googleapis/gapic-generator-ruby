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
  class CallOptions
    ##
    # The policy for retrying failed RPC calls using an incremental backoff. A new object instance should be used for
    # every RpcCall invocation.
    #
    # Only errors orginating from GRPC will be retried.
    #
    class RetryPolicy < Gapic::Common::RetryPolicy
      ##
      # Create new API Call RetryPolicy.
      #
      # @param initial_delay [Numeric] client-side timeout
      # @param multiplier [Numeric] client-side timeout
      # @param max_delay [Numeric] client-side timeout
      #
      def initialize retry_codes: nil, initial_delay: nil, multiplier: nil, max_delay: nil
        super(
          initial_delay: initial_delay,
          max_delay: max_delay,
          multiplier: multiplier,
          retry_codes: (convert_codes retry_codes),
        )
      end
    end
  end
end
