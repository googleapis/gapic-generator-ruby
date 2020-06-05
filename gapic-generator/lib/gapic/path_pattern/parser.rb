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

require "gapic/path_pattern/segment"
require "gapic/path_pattern/pattern"

module Gapic
  module PathPattern
    # A path pattern parser.
    # see https://google.aip.dev/122, https://google.aip.dev/123
    #
    # @!attribute [r] path_pattern
    #   @return [String] The path pattern to be parsed.
    # @!attribute [r] segments
    #   @return [Array<Segment|String>] The segments of the parsed path pattern.
    module Parser
      def self.parse path_pattern
        segment_strings = path_pattern.split("/")
        segments = segment_strings.map.with_index {|segment_string, position| Segment.parse segment_string, position}

        Pattern.new path_pattern, segments
      end
    end
  end
end
