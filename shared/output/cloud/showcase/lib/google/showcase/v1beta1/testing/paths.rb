# frozen_string_literal: true

# Copyright 2018 Google LLC
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

module Google
  module Showcase
    module V1beta1
      module Testing
        module Paths
          ##
          # Create a fully-qualified Session resource string.
          #
          # The resource will be in the following format:
          #
          # `sessions/{session}`
          #
          # @param session [String]
          #
          # @return [String]
          def session_path session:
            raise ArgumentError, "session is required" if session.nil?

            "sessions/#{session}"
          end

          ##
          # Create a fully-qualified Test resource string.
          #
          # The resource will be in the following format:
          #
          # `sessions/{session}/tests/{test}`
          #
          # @param session [String]
          # @param test [String]
          #
          # @return [String]
          def test_path session:, test:
            raise ArgumentError, "session is required" if session.nil?
            raise ArgumentError, "session cannot contain /" if %r{/}.match? session
            raise ArgumentError, "test is required" if test.nil?

            "sessions/#{session}/tests/#{test}"
          end
        end
      end
    end
  end
end
