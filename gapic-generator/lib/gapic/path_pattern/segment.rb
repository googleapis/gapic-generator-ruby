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
    ##
    # A positional segment in a path pattern.
    #  positional segments have a pattern of wildcards and do not carry a name
    #
    # @!attribure [r] type
    #   @return [String] The type of this segment
    # @!attribute [r] position
    #   @return [Integer] The argument position of this segment i.e.
    #     it's position if we remove all non-positional segments from the pattern
    # @!attribute [r] pattern
    #   @return [String] The pattern of the segment, for the positional segment it is also
    #     a pattern of its resource
    class PositionalSegment
      attr_reader :type
      attr_reader :position
      attr_reader :pattern

      def initialize position, pattern
        @type       = :positional
        @position   = position
        @pattern    = pattern
      end

      ##
      # Whether the segment is positional
      # @return [Boolean]
      def positional?
        true
      end

      ##
      # Whether the segment provides a resource pattern
      # @return [Boolean]
      def resource_pattern?
        true
      end

      ##
      # Whether the segment provides a nontrivial resource pattern
      # @return [Boolean]
      def nontrivial_resource_pattern?
        false
      end

      ##
      # Whether the segment provides arguments
      # @return [Boolean]
      def provides_arguments?
        true
      end

      ##
      # Names of the segment's arguments
      # @return [Array<String>]
      def arguments
        [position.to_s]
      end

      ##
      # Returns a segment's pattern filled with dummy values
      #   names of the values are generated starting from the index provided
      # @param start_index [Integer] a starting index for dummy value generation
      # @return [String] a pattern filled with dummy values
      def expected_path_for_dummy_values start_index
        "value#{start_index}"
      end

      ##
      # Path string for this segment
      # @return [String]
      def path_string
        "\#{#{position}}"
      end

      ##
      # A pattern template for this segment
      # @return [String]
      def pattern_template
        pattern
      end

      ##
      # Whether the segment is a resource id segment
      # @return [Boolean]
      def resource_id_segment?
        false
      end

      ##
      # The difference between `simplified_pattern` and `pattern`
      # does not exist for the Positional segments
      # @return [String]
      def simplified_pattern
        pattern
      end

      ##
      # Creates a string with a regex representation of this segment's pattern
      # @return [String]
      def to_regex_str
        if pattern == "**"
          ".*"
        else
          "[^/]+"
        end
      end

      # @private
      def == other
        return false unless other.is_a? self.class

        (pattern == other.pattern && position == other.position)
      end
    end

    # A ResourceId segment in a path pattern.
    #  ResourceId segments can be simple, with one resource name
    #  or complex, with multiple resource names divided by separators
    #
    # @!attribure [r] type
    #   @return [String] The type of this segment
    # @!attribute [r] pattern
    #   @return [String] The pattern of the segment, for the positional segment it is also
    #     a pattern of its resource
    # @!attribute [r] resource_names
    #   @return [Array<String>] The resource names in this segment
    # @!attribute [r] resource_patterns
    #   @return [Array<String>] The resource patterns associated with
    #     the resource_names of this segment
    class ResourceIdSegment
      attr_reader :type
      attr_reader :pattern
      attr_reader :resource_names
      attr_reader :resource_patterns

      def initialize type, pattern, resource_names, resource_patterns = []
        @type              = type
        @pattern           = pattern
        @resource_names    = resource_names

        # For the segments specified like `{foo}`, the implied resource pattern is `*`
        # `{foo}` === `{foo=*}`
        if resource_patterns.empty?
          resource_patterns = ["*"]
        end
        @resource_patterns = resource_patterns
      end

      ##
      # Whether the segment is positional
      # @return [Boolean]
      def positional?
        false
      end

      ##
      # Whether the segment provides a nontrivial resource pattern
      # (not `*` or `**`)
      # @return [Boolean]
      def nontrivial_resource_pattern?
        resource_patterns.any? { |res_pattern| !res_pattern.match?(/^\*+$/) }
      end

      ##
      # Whether the segment provides arguments
      # @return [Boolean]
      def provides_arguments?
        true
      end

      ##
      # Names of the segment's arguments
      # @return [Array<String>]
      def arguments
        resource_names
      end

      ##
      # Returns a segment's pattern filled with dummy values.
      # Names of the values are generated starting from the index provided.
      # @param start_index [Integer] a starting index for dummy value generation
      # @return [String] a pattern filled with dummy values
      def expected_path_for_dummy_values start_index
        return "value#{start_index}" if type == :simple_resource_id

        resource_names.each_with_index.reduce pattern do |exp_path, (res_name, index)|
          exp_path.sub "{#{res_name}}", "value#{start_index + index}"
        end
      end

      ##
      # Path string for this segment
      # @return [String]
      def path_string
        type == :simple_resource_id ? "\#{#{resource_names[0]}}" : pattern.gsub("{", "\#{")
      end

      ##
      # A pattern template for this segment
      # @return [String]
      def pattern_template
        "*"
      end

      ##
      # Whether the segment is a resource id segment
      # @return [Boolean]
      def resource_id_segment?
        true
      end

      ##
      # The pattern with the resource name
      # (e.g. `foo` in `{foo=bar/*}`) stripped.
      # So `{foo=bar/*}` -> `bar/*`.
      #
      # Not implemented for multivariate segments
      # (e.g `{foo}~{bar}`).
      #
      # @return [String]
      def simplified_pattern
        if resource_patterns.count > 1
          raise "Not implemented for multivariate ResourceId segments"
        end
        resource_patterns[0]
      end

      ##
      # Creates a string with a regex representation of this segment's pattern
      # @return [String]
      def to_regex_str
        raise "Not implemented for multivariate ResourceId segments" if resource_patterns.count > 1

        resource_pattern = if resource_patterns[0].nil?
                             "*"
                           else
                             resource_patterns[0]
                           end

        resource_pattern_regex = Gapic::PathPattern::Parser.parse(resource_pattern).to_regex_str

        "(?<#{resource_names[0]}>#{resource_pattern_regex})"
      end

      ##
      # Initialization helper to create a simple resource without a pattern
      # @param name [String] resource name
      # @return [ResourceIdSegment]
      def self.create_simple name
        ResourceIdSegment.new :simple_resource_id, "{#{name}}", [name]
      end

      # @private
      def == other
        return false unless other.is_a? self.class

        (type == other.type && pattern == other.pattern &&
          resource_names == other.resource_names &&
          resource_patterns == other.resource_patterns)
      end
    end

    ##
    # A CollectionId segment in a path template.
    #  CollectionId segments are basically string literals
    #
    # @!attribure [r] type
    #   @return [String] The type of this segment
    # @!attribute [r] pattern
    #   @return [String] The pattern of the segment, for the positional segment it is also
    #     a pattern of its resource
    class CollectionIdSegment
      attr_reader :type
      attr_reader :pattern

      def initialize pattern
        @type     = :collection_id
        @pattern  = pattern
      end

      ##
      # Whether the segment is positional
      # @return [Boolean]
      def positional?
        false
      end

      ##
      # Whether the segment provides a resource pattern
      # @return [Boolean]
      def resource_pattern?
        false
      end

      ##
      # Whether the segment provides a nontrivial resource pattern
      # @return [Boolean]
      def nontrivial_resource_pattern?
        false
      end

      ##
      # Whether the segment provides arguments
      # @return [Boolean]
      def provides_arguments?
        false
      end

      ##
      # Path string for this segment
      # @return [String]
      def path_string
        pattern
      end

      ##
      # A pattern template for this segment
      # @return [String]
      def pattern_template
        pattern
      end

      ##
      # Whether the segment is a resource id segment
      # @return [Boolean]
      def resource_id_segment?
        false
      end

      ##
      # The difference between `simplified_pattern` and `pattern`
      # does not exist for the CollectionId segments
      # @return [String]
      def simplified_pattern
        pattern
      end

      ##
      # Creates a string with a regex representation of this segment's pattern
      # @return [String]
      def to_regex_str
        pattern
      end

      # @private
      def == other
        return false unless other.is_a? self.class

        (pattern == other.pattern)
      end
    end
  end
end
