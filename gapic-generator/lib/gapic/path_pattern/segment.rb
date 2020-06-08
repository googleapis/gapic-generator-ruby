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
    # A segment in a path template.
    #
    # @!attribute [r] name
    #   @return [String, Integer] The name of a named segment, or the position
    #     of a positional segment.
    # @!attribute [r] pattern
    #   @return [String, nil] The pattern of the segment, nil if not set.
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

      def resource_pattern?
        true
      end

      def nontrivial_resource_pattern?
        false
      end

      def provides_arguments?
        true
      end

      def arguments
        [position]
      end

      def expected_path_for_dummy_values start_index
        "value#{start_index}"
      end

      def provides_path_string?
        true
      end

      def path_string
        "\#{#{position}}"
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

      def expected_path_for_dummy_values start_index
        return "value#{start_index}" if type == :simple_resource_id

        resource_names.each_with_index.reduce pattern do |exp_path, (res_name, index)|
          exp_path.sub "{#{res_name}}", "value#{start_index + index}"
        end
      end

      def resource_pattern?
        resource_patterns.any?
      end

      def nontrivial_resource_pattern?
        resource_patterns.any? { |res_pattern| !res_pattern.match?(/^\*+$/) }
      end

      def provides_path_string?
        true
      end

      def path_string
        type == :simple_resource_id ? "\#{#{resource_names[0]}}" : pattern.gsub("{", "\#{")
      end

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

    # A segment in a path template.
    #
    # @!attribute [r] name
    #   @return [String, Integer] The name of a named segment, or the position
    #     of a positional segment.
    # @!attribute [r] pattern
    #   @return [String, nil] The pattern of the segment, nil if not set.
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

      def resource_pattern?
        false
      end

      def nontrivial_resource_pattern?
        false
      end

      def provides_path_string?
        true
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
  end
end
