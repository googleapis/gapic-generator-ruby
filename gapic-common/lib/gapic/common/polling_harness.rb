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

module Gapic
  module Common
    # Add docs
    class PollingHarness
      def initialize retry_policy:
        @retry_policy = retry_policy
      end

      ##
      # Perform polling with delay. The provided block MUST yield `nil` in cases where the operation should
      # continue. Otherwise, the yielded value will be returned.
      #
      # @param [Block] Custom logic to be retriable.
      def wait
        unless block_given?
          raise ArgumentError, "No callback provided to wait method."
        end
        loop do
          begin
            response = yield
            return response unless response.nil?
          rescue ::GRPC::BadStatus => e
            return e unless retry_policy.retry_error? e
          end
          retry_policy.perform_delay!
        end
      end

      def retry_policy
        @retry_policy
      end
    end
  end
end
