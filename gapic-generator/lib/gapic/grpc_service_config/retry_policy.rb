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
    # RetryPolicy encapsulates the parameters governing the client-side retry
    # for the GRPC method invocation. It is embedded into the MethodConfig
    #
    class RetryPolicy
      attr_reader :initial_delay_seconds, :max_delay_seconds, :multiplier, :status_codes

      ##
      # Create new ParsedRetryPolicy.
      #
      # @param initial_delay_seconds [Float, nil] the value of initial retry delay in seconds if provided
      # @param max_delay_seconds [Float, nil] the value of max retry delay in seconds if provided
      # @param multiplier [Float, nil] the value of retry multiplier if provided
      # @param status_codes [Array<String>, nil] the retry status codes if provided
      #
      def initialize initial_delay_seconds, max_delay_seconds, multiplier, status_codes
        @initial_delay_seconds = initial_delay_seconds
        @max_delay_seconds     = max_delay_seconds
        @multiplier            = multiplier
        @status_codes          = status_codes
      end

      ##
      # Returns whether RetryPolicy is empty (does not contain any values)
      #
      # @return [Boolean] whether RetryPolicy is empty
      #
      def empty?
        @initial_delay_seconds.nil? && @max_delay_seconds.nil? && @multiplier.nil? && status_codes.to_a.empty?
      end
    end
  end
end
