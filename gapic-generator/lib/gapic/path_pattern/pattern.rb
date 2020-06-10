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

require "gapic/path_pattern/segment"

module Gapic
  module PathPattern
    ##
    # A parsed pattern.
    # @see https://google.aip.dev/122 AIP-122 Resource names
    # @see https://google.aip.dev/123 AIP-123 Resource types
    #
    # @!attribute [r] path_pattern
    #   @return [String] The path pattern
    # @!attribute [r] segments
    #   @return [Array<PositionalSegment|ResourceIdSegment|CollectionIdSegment>]
    #     The parsed segments of the path pattern
    class Pattern
      attr_reader :path_pattern, :segments

      def initialize path_pattern, segments
        @path_pattern = path_pattern
        @segments = segments
      end

      ##
      # All argument names from this pattern
      # @return [Array<String>]
      def arguments
        @segments.select(&:provides_arguments?).map(&:arguments).flatten
      end

      ##
      # Whether pattern contains a positional segment
      # @return [Boolean]
      def positional_segments?
        @segments.any?(&:positional?)
      end

      ##
      # Whether pattern contains a segment with a nontrivial resource pattern
      # @return [Boolean]
      def nontrivial_pattern_segments?
        @segments.any?(&:nontrivial_resource_pattern?)
      end

      ##
      # A template of this pattern - all resource id segments are
      # stripped and replaced by '*'
      # @return [String]
      def template
        @segments.map(&:pattern_template).join("/")
      end

      ##
      # A parent template to this pattern or an empty string if a pattern
      # can not have a parent (too short)
      # @return [String]
      def parent_template
        return nil if segments.length <= 2
        last_segment = segments.last
        parent_pattern_segments = last_segment.provides_arguments? ? segments[0...-2] : segments[0...-1]
        parent_pattern_segments.map(&:pattern_template).join("/")
      end
    end
  end
end
