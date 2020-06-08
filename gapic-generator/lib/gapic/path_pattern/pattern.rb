require "gapic/path_pattern/segment"

module Gapic
  module PathPattern
    # A path pattern.
    # see https://google.aip.dev/122, https://google.aip.dev/123
    #
    # @!attribute [r] path_pattern
    #   @return [String] The path pattern.
    # @!attribute [r] segments
    #   @return [Array<Segment|String>] The parsed segments of the path pattern.
    class Pattern
      attr_reader :pattern, :segments

      def initialize pattern, segments
        @pattern = pattern
        @segments = segments
      end

      def arguments
        @segments.select(&:provides_arguments?).map(&:arguments).flatten
      end

      def positional_segments?
        @segments.any?(&:positional?)
      end

      def nontrivial_pattern_segments?
        @segments.any?(&:nontrivial_resource_pattern?)
      end
    end
  end
end
