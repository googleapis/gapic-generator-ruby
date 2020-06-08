# frozen_string_literal: true

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

require "gapic/path_pattern/parser"

module Gapic
  # TODO: Enter docs
  # Dooooooooocs!!!
  module PathPattern
    # Parse a URI path pattern.
    #
    # @see https://google.aip.dev/122 AIP-122 Resource names
    # @see https://google.aip.dev/123 AIP-123 Resource types
    #
    # @param path_pattern [String] The URI path template to be parsed.
    #
    # @return [PathPattern::Pattern] The parsed pattern
    #   path template.
    def self.parse path_pattern
      Parser.parse path_pattern
    end
  end
end
