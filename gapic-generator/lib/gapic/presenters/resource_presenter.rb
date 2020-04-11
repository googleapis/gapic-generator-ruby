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

require "gapic/path_template"
require "ostruct"
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

        @patterns = resource.pattern.map do |template|
          segments = Gapic::PathTemplate.parse template
          OpenStruct.new(
            template:    template,
            segments:    segments,
            arguments:   arguments_for(segments),
            path_string: path_string_for(segments)
          )
        end

        # Keep only patterns that can be used to create path helpers
        @patterns.reject! do |pattern|
          named_arg_patterns?(pattern.segments) || positional_args?(pattern.segments)
        end
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

      private

      def arguments_for segments
        arg_segments(segments).map(&:name)
      end

      def arg_segments segments
        segments.select { |segment| segment.is_a? Gapic::PathTemplate::Segment }
      end

      def path_string_for segments
        segments.map do |segment|
          if segment.is_a? Gapic::PathTemplate::Segment
            "\#{#{segment.name}}"
          else
            # Should be a String
            segment
          end
        end.join
      end

      def positional_args? segments
        arg_segments(segments).any?(&:positional?)
      end

      def named_arg_patterns? segments
        arg_segments(segments).any?(&:pattern)
      end
    end
  end
end
