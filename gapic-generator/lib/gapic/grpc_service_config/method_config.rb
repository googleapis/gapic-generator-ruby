# frozen_string_literal: true

# Copyright 2020 Google LLC
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
  module GrpcServiceConfig
    ##
    # Method config represents a combination of a timeout and
    # a retry policy, both of which can be optional
    # It is applied during a GRPC method call and governs the
    # client-side timeout/retry policy
    #
    class MethodConfig
      attr_reader :timeout_seconds, :retry_policy

      ##
      # Create new MethodConfig
      #
      # @param timeout_seconds [Float, nil] the value of timeout in seconds if provided
      # @param retry_policy [Gapic::GrpcServiceConfig::RetryPolicy] the retry policy
      #
      def initialize timeout_seconds, retry_policy
        @timeout_seconds = timeout_seconds
        @retry_policy    = retry_policy
      end
      
      ##
      # Returns whether MethodConfig is empty (does not contain any values)
      #
      # @return [Boolean] whether MethodConfig is empty
      #
      def empty?
        @timeout_seconds.nil? && @retry_policy.empty?
      end
    end
  end
end
