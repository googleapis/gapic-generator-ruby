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

module Gapic
  module UriTemplate
    # A URI template parser.
    # see https://tools.ietf.org/html/rfc6570 URI Template
    #
    # @!attribute [r] path_pattern
    #   @return [String] The path pattern to be parsed.
    # @!attribute [r] segments
    #   @return [Array<Segment|String>] The segments of the parsed path pattern.
    module Parser
      # @private
      # `/(?<positional>\*\*?)|{(?<name>[^\/]+?)(?:=(?<template>.+?))?}/`
      URI_TEMPLATE = %r{
        (?<positional>\*\*?)
        |
        {(?<name>[^/]+?)(?:=(?<template>.+?))?}
      }x.freeze

      def self.parse_arguments uri_template
        arguments = []

        while (match = URI_TEMPLATE.match uri_template)
          # The String before the match needs to be added to the segments
          arguments << match[:name] if match[:name]
          uri_template = match.post_match
        end

        arguments
      end
    end
  end
end
