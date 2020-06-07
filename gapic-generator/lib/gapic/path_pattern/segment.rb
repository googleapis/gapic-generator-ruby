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
    class PositionalSegment
      attr_reader :type, :position, :pattern
      def initialize position, pattern
        @type       = :positional
        @position   = position
        @pattern    = pattern
      end

      def positional?
        true
      end

      def has_resource_pattern?
        true
      end

      def has_nontrivial_resource_pattern?
        false
      end

      def provides_arguments?
        true
      end

      def arguments
        [position]
      end

      # @private
      def == other
        return false unless other.is_a? self.class

        (pattern == other.pattern && position == other.position)
      end
    end

    # A segment in a path template.
    #
    # @!attribute [r] name
    #   @return [String, Integer] The name of a named segment, or the position
    #     of a positional segment.
    # @!attribute [r] pattern
    #   @return [String, nil] The pattern of the segment, nil if not set.
    class ResourceIdSegment
      attr_reader :type, :pattern, :resource_names, :resource_patterns

      def initialize type, pattern, resource_names, resource_patterns = []
        @type              = type
        @pattern           = pattern
        @resource_names    = resource_names
        @resource_patterns = resource_patterns || []
      end

      # Determines if the segment is positional (has a number for a name).
      #
      # @return [Boolean]
      def positional?
        false
      end

      def provides_arguments?
        true
      end

      def arguments
        resource_names
      end

      def has_resource_pattern?
        resource_patterns.any?
      end

      def has_nontrivial_resource_pattern?
        resource_patterns.any?{|res_pattern| !res_pattern.match?(/^\*+$/)}
      end

      def path_string
        type == :simple_resource_id ? "\#{#{resource_names[0]}}" : pattern.sub("{", "\#{")
      end

      def self.create_simple name
        ResourceIdSegment.new :simple_resource_id, "{#{name}}", [name]
      end

      # @private
      def == other
        return false unless other.is_a? self.class

        (type == other.type && pattern == other.pattern && resource_names == other.resource_names && resource_patterns == other.resource_patterns)
      end
    end
    
    class CollectionIdSegment
      attr_reader :type, :pattern

      def initialize pattern
        @type     = :collection_id
        @pattern  = pattern
      end

      def positional?
        false
      end

      def provides_arguments?
        false
      end

      def has_resource_pattern?
        false
      end

      def has_nontrivial_resource_pattern?
        false
      end

      def path_string
        pattern
      end

      # @private
      def == other
        return false unless other.is_a? self.class

        (pattern == other.pattern)
      end
    end

    module Segment
      def self.parse_first_segment url_pattern, position
        # require 'pry'
        # binding.pry

        # check for the wildcard capture -- either * or **
        wildcard_capture_regex = /^(?<pattern>\*\*|\*)(?:\/|$)/
        if wildcard_capture_regex.match? url_pattern
          match = wildcard_capture_regex.match url_pattern
          whole_match = match[0]

          wildcard_pattern = match[:pattern]

          segment = PositionalSegment.new position, wildcard_pattern
          remainder = url_pattern[whole_match.length..-1]
          return segment, remainder
        end

        # check for the complex resource id segment -- {<name_first>}<separator>{<name_second>} etc, e.g. {foo}-{bar}_{baz}
        # see AIP-4231 Parsing resource names, Complex resource ID path segments
        complex_resource_id_regex =  /^(?<segment_pattern>{(?<name_first>[^\/}]+?)}(?:(?<separator>[_-~\.]){(?<name_seq>[^\/}]+?)})+)(?:\/|$)/
        if complex_resource_id_regex.match? url_pattern
          match = complex_resource_id_regex.match url_pattern
          whole_match = match[0]
          segment_pattern = match[:segment_pattern]

          resource_name_regex = /{(?<name>[^\/}]+?)}/
          resource_names = segment_pattern.scan(resource_name_regex).flatten
          
          segment = ResourceIdSegment.new :complex_resource_id, segment_pattern, resource_names
          remainder = url_pattern[whole_match.length..-1]
          return segment, remainder
        end

        # check for the simple resource id segment -- {<name>}, e.g. {foo} with an optional pattern, e.g. {foo=**} or {foo=bar}
        simple_resource_id_regex = /^(?<segment_pattern>{(?<resource_name>[^\/}]+?)(?:=(?<resource_pattern>.+?))?})(?:\/|$)/
        if simple_resource_id_regex.match? url_pattern
          match = simple_resource_id_regex.match url_pattern
          whole_match = match[0]
          segment_pattern = match[:segment_pattern]

          resource_name = match[:resource_name]
          resource_pattern = match[:resource_pattern] if match.names.include? "resource_pattern"
          resource_patterns = [resource_pattern] unless resource_pattern.nil?

          segment = ResourceIdSegment.new :simple_resource_id, segment_pattern, [resource_name], resource_patterns
          remainder = url_pattern[whole_match.length..-1]
          return segment, remainder
        end

        # if nothing else fits, it's the collection id
        collection_id_regex = /^(?<collection_name>[^\/]+?)(?:\/|$)/

        match = collection_id_regex.match url_pattern

        if match == nil
          STDERR.puts "the url_pattern is #{url_pattern}"
          require 'pry'
          binding.pry
        end

        whole_match = match[0]

        collection_name = match[:collection_name]

        segment = CollectionIdSegment.new collection_name
        remainder = url_pattern[whole_match.length..-1]
        return segment, remainder
      end
    end
  end
end
