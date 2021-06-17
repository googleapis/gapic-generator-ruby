# frozen_string_literal: true

# Copyright 2021 Google LLC
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
  module Presenters
    ##
    # A presenter for grpc service config.
    #
    class ServiceConfigPresenter
      def initialize grpc_service_config
        @grpc_service_config = grpc_service_config
      end

      attr_reader :grpc_service_config

      def retry_policy_fields
        elems = []
        retry_policy = grpc_service_config&.retry_policy
        if retry_policy&.initial_delay_seconds
          elems << "initial_delay: #{Gapic::FormattingUtils.format_number retry_policy.initial_delay_seconds}"
        end
        if retry_policy&.max_delay_seconds
          elems << "max_delay: #{Gapic::FormattingUtils.format_number retry_policy.max_delay_seconds}"
        end
        if retry_policy&.multiplier
          elems << "multiplier: #{Gapic::FormattingUtils.format_number retry_policy.multiplier}"
        end
        if retry_policy&.status_codes
          elems << "retry_codes: #{retry_policy.status_codes}"
        end
        elems.empty? ? "{}" : "{\n  #{elems.join ', '}\n}"
      end
    end
  end
end
