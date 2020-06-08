require "gapic/path_pattern/segment"

module Gapic
  module PathPattern
    ##
    # A parsed pattern.
    # see https://google.aip.dev/122, https://google.aip.dev/123
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
        return "" if segments.length <= 2
        last_segment = segments[-1]
        parent_pattern_segents = last_segment.provides_arguments? ? segments[0...-2] : segments[0...-1]
        parent_pattern_segents.map(&:pattern_template).join("/")
      end
    end
  end
end
