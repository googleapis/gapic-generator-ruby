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

module Gapic
  module PathPattern
    # A URI path template parser.
    #
    # @see https://tools.ietf.org/html/rfc6570 URI Template
    #
    # @!attribute [r] path_pattern
    #   @return [String] The URI path template to be parsed.
    # @!attribute [r] segments
    #   @return [Array<Segment|String>] The segments of the parsed URI path
    #     template.
    class Parser
      # @private
      # /((?<positional>\*\*?)|{(?<name>[^\/]+?)(?:=(?<template>.+?))?})/
      PATH_PATTERN = %r{
        (
          (?<positional>\*\*?)
          |
          {(?<name>[^\/]+?)(?:=(?<template>.+?))?}
        )
      }x.freeze

      attr_reader :path_pattern, :segments

      # Create a new URI path template parser.
      #
      # @param path_pattern [String] The URI path template to be parsed.
      def initialize path_pattern
        @path_pattern = path_pattern
        @segments = parse! path_pattern
      end

      protected

      def parse! path_pattern
        # segments contain either Strings or segment objects
        segments = []
        segment_pos = 0

        while (match = PATH_PATTERN.match path_pattern)
          # The String before the match needs to be added to the segments
          segments << match.pre_match unless match.pre_match.empty?

          segment, segment_pos = segment_and_pos_from_match match, segment_pos
          segments << segment

          path_pattern = match.post_match
        end

        # Whatever String is unmatched needs to be added to the segments
        segments << path_pattern unless path_pattern.empty?

        segments
      end

      def segment_and_pos_from_match match, pos
        if match[:positional]
          [Segment.new(pos, match[:positional]), pos + 1]
        else
          [Segment.new(match[:name], match[:template]), pos]
        end
      end
    end
  end
end
