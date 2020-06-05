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

require "gapic/path_pattern"
require "active_support/inflector"

module Gapic
  module Presenters
    ##
    # A presenter for proto resources.
    #
    class ResourcePresenter
      # @param resource [Google::Api::ResourceDescriptor]
      def initialize resource
        @resource = resource

        @patterns = resource.pattern.map { |pattern| PatternPresenter.new pattern }

        # Keep only patterns that can be used to create path helpers
        @patterns.filter!(&:useful_for_helpers?)
      end

      def name
        @resource.type.split("/").delete_if(&:empty?).last
      end

      def type
        @resource.type
      end

      def patterns
        @patterns
      end

      def path_helper
        "#{ActiveSupport::Inflector.underscore name}_path"
      end

      ##
      # A presenter for a particular pattern
      #
      class PatternPresenter
        def initialize pattern
          @pattern = pattern
          @segments = Gapic::PathPattern.parse pattern
          @arguments = arg_segments.map(&:name)
          @path_string = build_path_string
        end

        attr_reader :pattern, :segments, :arguments, :path_string

        def useful_for_helpers?
          arg_segments.none?(&:nontrivial_pattern?) && arg_segments.none?(&:positional?)
        end

        def formal_arguments
          arguments.map { |arg| "#{arg}:" }.join ", "
        end

        def arguments_key
          arguments.sort.join ":"
        end

        def arguments_with_dummy_values
          arguments.each_with_index.map { |arg, index| "#{arg}: \"value#{index}\"" }.join ", "
        end

        def expected_path_for_dummy_values
          index = -1
          segments.map do |segment|
            if segment.is_a? Gapic::PathPattern::Segment
              index += 1
              "value#{index}"
            else
              # Should be a String
              segment
            end
          end.join
        end

        private

        def arg_segments
          segments.select { |segment| segment.is_a? Gapic::PathPattern::Segment }
        end

        def build_path_string
          segments.map do |segment|
            if segment.is_a? Gapic::PathPattern::Segment
              "\#{#{segment.name}}"
            else
              # Should be a String
              segment
            end
          end.join
        end
      end
    end
  end
end
