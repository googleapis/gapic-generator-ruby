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

##
# The parameters for creatig a policy for retrying operation as parsed from the grpc service config json
#
module Grpc
  module ServiceConfigParsing
    class ParsedMethodConfig
      attr_reader :timeout_seconds, :retry_policy

      ##
      # Create new ParsedMethodConfig.
      #
      def initialize timeout_seconds, retry_policy
        @timeout_seconds = timeout_seconds
        @retry_policy    = retry_policy
      end
    end
  end
end