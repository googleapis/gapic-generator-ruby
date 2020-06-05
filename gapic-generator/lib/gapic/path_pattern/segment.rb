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

module Gapic
  module PathPattern
    # A segment in a URI path template.
    #
    # @see https://tools.ietf.org/html/rfc6570 URI Template
    #
    # @!attribute [r] name
    #   @return [String, Integer] The name of a named segment, or the position
    #     of a positional segment.
    # @!attribute [r] pattern
    #   @return [String, nil] The pattern of the segment, nil if not set.
    class Segment
      attr_reader :name, :pattern

      def initialize name, pattern
        @name    = name
        @pattern = pattern
      end

      # Determines if the segment is positional (has a number for a name).
      #
      # @return [Boolean]
      def positional?
        name.is_a? Integer
      end

      # Determines if the segment is named (has a string for a name).
      #
      # @return [Boolean]
      def named?
        !positional?
      end

      # Determines if the segment has a pattern. Positional segments always
      # have a pattern. Named segments may have a pattern if provided in the
      # URI path template.
      #
      # @return [Boolean]
      def pattern?
        !@pattern.nil?
      end

      # Determines if the segment has a nontrivial pattern (i.e. not `*` or `**`).
      #
      # @return [Boolean]
      def nontrivial_pattern?
        @pattern && @pattern != "*" && @pattern != "**"
      end

      # @private
      def == other
        return false unless other.is_a? self.class

        (name == other.name) && (pattern == other.pattern)
      end
    end
  end
end
