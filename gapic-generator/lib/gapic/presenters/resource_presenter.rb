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

      def dup
        ResourcePresenter.new @resource
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
        def initialize pattern_string
          @parsed_pattern = Gapic::PathPattern.parse pattern_string
          @path_string = build_path_string
        end

        attr_reader :path_string

        def pattern_template
          @parsed_pattern.template
        end

        def useful_for_helpers?
          !@parsed_pattern.positional_segments? && !@parsed_pattern.nontrivial_pattern_segments?
        end

        def arguments
          @parsed_pattern.arguments
        end

        def formal_arguments
          @parsed_pattern.arguments.map { |name| "#{name}:" }.join ", "
        end

        def arguments_key
          @parsed_pattern.arguments.sort.join ":"
        end

        def arguments_with_dummy_values
          @parsed_pattern.arguments.each_with_index.map { |name, index| "#{name}: \"value#{index}\"" }.join ", "
        end

        def expected_path_for_dummy_values
          index = 0
          @parsed_pattern.segments.map do |segment|
            if segment.provides_arguments?
              segment_dummy_path = segment.expected_path_for_dummy_values index
              index += segment.arguments.length
              segment_dummy_path
            else
              segment.pattern
            end
          end.join "/"
        end

        def pattern
          @parsed_pattern.path_pattern
        end

        private

        def build_path_string
          @parsed_pattern.segments.map(&:path_string).join "/"
        end
      end
    end
  end
end
