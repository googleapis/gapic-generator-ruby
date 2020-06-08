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
        starts_with_slash = path_pattern.start_with? "/"
        ends_with_slash = path_pattern.end_with? "/"

        remainder = path_pattern
        remainder[0] = "" if starts_with_slash
        remainder[remainder.length - 1] = "" if ends_with_slash

        segments = []
        position = 0
        until remainder.empty?
          segment, position, remainder = parse_first_segment_with_position remainder, position
          segments << segment
        end

        Pattern.new path_pattern, segments
      end

      # @private
      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/MethodLength
      # rubocop:disable Style/RegexpLiteral
      def self.parse_first_segment_with_position url_pattern, position
        # check for the w ildcard capture -- either * or **
        wildcard_capture_regex = /^(?<pattern>\*\*|\*)(?:\/|$)/
        if wildcard_capture_regex.match? url_pattern
          match = wildcard_capture_regex.match url_pattern

          wildcard_pattern = match[:pattern]

          segment = PositionalSegment.new position, wildcard_pattern
          remainder = match.post_match
          return segment, position + 1, remainder
        end

        # check for the complex resource id segment --
        # {<name_first>}<separator>{<name_second>} etc, e.g. {foo}-{bar}_{baz}
        # see AIP-4231 Parsing resource names, Complex resource ID path segments
        complex_resource_id_regex =
          /^(?<segment_pattern>{(?<name_first>[^\/}]+?)}(?:(?<separator>[_-~\.]){(?<name_seq>[^\/}]+?)})+)(?:\/|$)/
        if complex_resource_id_regex.match? url_pattern
          match = complex_resource_id_regex.match url_pattern
          segment_pattern = match[:segment_pattern]

          resource_name_regex = /{(?<name>[^\/}]+?)}/
          resource_names = segment_pattern.scan(resource_name_regex).flatten

          segment = ResourceIdSegment.new :complex_resource_id, segment_pattern, resource_names
          remainder = match.post_match
          return segment, position, remainder
        end

        # check for the simple resource id segment -- {<name>},
        # e.g. {foo} with an optional pattern, e.g. {foo=**} or {foo=bar}
        simple_resource_id_regex =
          /^(?<segment_pattern>{(?<resource_name>[^\/}]+?)(?:=(?<resource_pattern>.+?))?})(?:\/|$)/
        if simple_resource_id_regex.match? url_pattern
          match = simple_resource_id_regex.match url_pattern
          segment_pattern = match[:segment_pattern]

          resource_name = match[:resource_name]
          resource_pattern = match[:resource_pattern] if match.names.include? "resource_pattern"
          resource_patterns = [resource_pattern] unless resource_pattern.nil?

          segment = ResourceIdSegment.new :simple_resource_id, segment_pattern, [resource_name], resource_patterns
          remainder = match.post_match
          return segment, position, remainder
        end

        # if nothing else fits, it's the collection id
        collection_id_regex = /^(?<collection_name>[^\/]+?)(?:\/|$)/
        match = collection_id_regex.match url_pattern

        collection_name = match[:collection_name]

        segment = CollectionIdSegment.new collection_name
        remainder = match.post_match
        [segment, position, remainder]
      end
      # rubocop:enable Metrics/AbcSize
      # rubocop:enable Metrics/MethodLength
      # rubocop:enable Style/RegexpLiteral
    end
  end
end
