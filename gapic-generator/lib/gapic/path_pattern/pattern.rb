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
      attr_reader :path_pattern
      attr_reader :segments

      def initialize path_pattern, segments
        @path_pattern = path_pattern
        @segments = segments
      end

      ##
      # All argument from this pattern, including ids for positional arguments
      # @return [Array<String>]
      def arguments
        @segments.select(&:provides_arguments?).map(&:arguments).flatten
      end

      ##
      # Whether this is a basic single-star ("*") pattern
      # @return [Boolean]
      def star_pattern?
        @segments.length == 1 && @segments[0].pattern == "*"
      end

      ##
      # Whether this is a basic double-star ("**") pattern
      # @return [Boolean]
      def double_star_pattern?
        @segments.length == 1 && @segments[0].pattern == "**"
      end

      ##
      # Converts the PathPattern into a regex string
      # @return [String]
      def to_regex_str
        regex_str = segments.first.to_regex_str

        # for double wildcards the leading `/`` is optional
        # e.g. `foo/**` should match `foo`
        # this is why segments 'bring' the leading separator
        # with them as they build the pattern
        segments.drop(1).each_with_index do |segment, _index|
          is_double_wildcard = segment.pattern == "**"

          regex_str = if is_double_wildcard
                        "#{regex_str}(?:/.*)?"
                      else
                        "#{regex_str}/#{segment.to_regex_str}"
                      end
        end

        regex_str
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

      ##
      # The pattern with the resource names stripped
      # from the ResourceId segments
      # (e.g. `collections/{resource_id=foo/*}` => `collections/foo/*`)
      #
      def simplified_pattern
        @segments.map(&:simplified_pattern).join("/")
      end
    end
  end
end
