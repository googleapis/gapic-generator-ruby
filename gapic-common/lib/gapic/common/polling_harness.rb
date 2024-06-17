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
    ##
    # Provides a generic mechanism for periodic polling an operation.
    #
    # Polling intervals are calculated from the provided retry policy.
    #
    # Supports exponential backoff via `multiplier`, and automatically
    # retries gRPC errors listed in `retry_codes`.
    #
    class PollingHarness
      # @return [Gapic::Common::RetryPolicy] The retry policy associated with this instance.
      attr_reader :retry_policy

      ##
      # Create new Gapic::Common::PollingHarness instance.
      #
      # @param retry_policy [Gapic::Common::RetryPolicy]
      #
      def initialize retry_policy:
        @retry_policy = retry_policy
      end

      ##
      # Perform polling with exponential backoff.
      #
      # The provided block MUST evaluate to `nil` in cases where the operation
      # should continue. Otherwise, the evaluated result will be returned.
      #
      # Errors are raised if not listed in `retry_codes`, and re-attempted otherwise.
      #
      # The block will be re-attempted indefinitely as long as the retry condition
      # passes or while a timeout has not been reached.
      #
      # @yieldreturn [Object, nil] Custom logic to be retriable.
      def wait
        unless block_given?
          raise ArgumentError, "No callback provided to wait method."
        end
        retry_policy.update_deadline!
        loop do
          begin
            response = yield
            return response unless response.nil?
          rescue StandardError => e # Currently retry_error only accounts for ::GRPC::BadStatus.
            raise unless retry_policy.retry_error? e
          end
          retry_policy.perform_delay!
          return response unless retry_policy.retry_with_deadline?
        end
      end
    end
  end
end
