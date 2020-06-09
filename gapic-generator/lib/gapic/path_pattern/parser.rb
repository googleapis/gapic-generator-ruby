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
    ##
    # A path pattern parser.
    # takes a pattern and transforms it into a collection of parsed segments
    # @see https://google.aip.dev/122
    # @see https://google.aip.dev/123
    #
    module Parser
      ##
      # @param path_pattern [String] The path pattern to be parsed
      # @return [Gapic::PathPattern::Pattern]
      def self.parse path_pattern
        remainder = path_pattern.sub(%r{^/}, "").sub(%r{/$}, "")

        segments = []
        position = 0
        until remainder.empty?
          segment, position, remainder = parse_first_segment_with_position remainder, position
          segments << segment
        end

        Pattern.new path_pattern, segments
      end

      # @private
      def self.parse_first_segment_with_position url_pattern, position
        # check for the wildcard segment -- either * or **
        # wildcard segments are positional, so the position counter is used and updated
        segment, remainder = try_capture_wildcard_segment url_pattern, position
        return [segment, position + 1, remainder] if segment

        # check for the complex resource id segment, e.g. {foo}-{bar}_{baz}
        segment, remainder = try_capture_complex_resource_id_segment url_pattern
        return [segment, position, remainder] if segment

        # check for the simple resource id segment, e.g. {foo} or {foo=some/pattern/*}
        segment, remainder = try_capture_simple_resource_id_segment url_pattern
        return [segment, position, remainder] if segment

        # if nothing else fits, it's the collection id segment
        segment, remainder = capture_collection_id_segment url_pattern
        [segment, position, remainder]
      end

      ##
      # Tries to capture the first segment of the pattern as a wildcard segment
      # The wildcard segment can be either * or **
      # @private
      def self.try_capture_wildcard_segment url_pattern, position
        wildcard_capture_regex = %r{^(?<pattern>\*\*|\*)(?:/|$)}
        return nil, url_pattern unless wildcard_capture_regex.match? url_pattern

        match = wildcard_capture_regex.match url_pattern

        wildcard_pattern = match[:pattern]

        segment = PositionalSegment.new position, wildcard_pattern
        remainder = match.post_match
        [segment, remainder]
      end

      ##
      # Tries to capture the first segment of the pattern as a complex resource id segment
      # The pattern for the complex resource id segments is:
      # {<name_first>}<separator>{<name_second>} etc, e.g. {foo}-{bar}_{baz}
      # see AIP-4231 Parsing resource names, Complex resource ID path segments
      # @private
      def self.try_capture_complex_resource_id_segment url_pattern
        complex_resource_id_regex =
          %r/^(?<segment_pattern>{(?<name_first>[^\/}]+?)}(?:(?<separator>[_\-~\.]){(?<name_seq>[^\/}]+?)})+)(?:\/|$)/

        return nil, url_pattern unless complex_resource_id_regex.match? url_pattern

        match = complex_resource_id_regex.match url_pattern
        segment_pattern = match[:segment_pattern]

        resource_name_regex = %r/{(?<name>[^\/}]+?)}/
        resource_names = segment_pattern.scan(resource_name_regex).flatten

        segment = ResourceIdSegment.new :complex_resource_id, segment_pattern, resource_names
        remainder = match.post_match
        [segment, remainder]
      end

      ##
      # Tries to capture the first segment of the pattern as a simple resource id segment
      # The pattern for the simple resource id segments is:
      # {<name>} or with an optional resource name pattern {<name>=<pattern>}
      # e.g. {foo} or with an optional pattern, e.g. {foo=**} or {foo=bar}
      # notably here the pattern between the = and } *can* contain the path separator /
      # @private
      def self.try_capture_simple_resource_id_segment url_pattern
        simple_resource_id_regex =
          %r/^(?<segment_pattern>{(?<resource_name>[^\/}]+?)(?:=(?<resource_pattern>.+?))?})(?:\/|$)/
        return nil, url_pattern unless simple_resource_id_regex.match? url_pattern

        match = simple_resource_id_regex.match url_pattern
        segment_pattern = match[:segment_pattern]

        resource_name = match[:resource_name]
        resource_pattern = match[:resource_pattern] if match.names.include? "resource_pattern"
        resource_patterns = resource_pattern.nil? ? [] : [resource_pattern]

        segment = ResourceIdSegment.new :simple_resource_id, segment_pattern, [resource_name], resource_patterns
        remainder = match.post_match
        [segment, remainder]
      end

      ##
      # Captures the first segment of the pattern as a collection id segment
      # This is used as a catch-all, so the collection id segment can contain anything
      # except the path separator /
      # @private
      def self.capture_collection_id_segment url_pattern
        collection_id_regex = %r{^(?<collection_name>[^/]+?)(?:/|$)}
        match = collection_id_regex.match url_pattern

        collection_name = match[:collection_name]

        segment = CollectionIdSegment.new collection_name
        remainder = match.post_match
        [segment, remainder]
      end
    end
  end
end
