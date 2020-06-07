require "gapic/path_pattern/segment"

module Gapic
  module PathPattern
    class Pattern
      attr_reader :pattern, :segments

      def initialize pattern, segments
        @pattern = pattern
        @segments = segments
      end

      def arguments
        @segments.select(&:provides_arguments?).map(&:arguments).flatten
      end

      def has_positional_segments?
        @segments.any?(&:positional?)
      end

      def has_nontrivial_pattern_segments?
        @segments.any?(&:has_nontrivial_resource_pattern?)
      end
    end
  end
end
