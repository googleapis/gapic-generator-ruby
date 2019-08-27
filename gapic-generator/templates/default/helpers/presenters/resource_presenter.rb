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

class ResourcePresenter
  def initialize name, path_template
    @name = name
    @path_template = path_template
    @segments = Gapic::PathTemplate.parse path_template

    # URI path template verification for expected proto resource usage
    if named_arg_patterns? @segments
      raise ArgumentError, "only resources without named patterns are supported, " \
                           " not #{path_template}"
    elsif positional_args? @segments
      raise ArgumentError, "only resources with named segments are supported, " \
                           " not #{path_template}"
    end
  end

  def name
    @name
  end

  def path_template
    @path_template
  end

  def path_helper
    "#{ActiveSupport::Inflector.underscore @name}_path"
  end

  def arguments
    # We only expect that named args are present
    arg_structs = arg_segments(@segments).map do |arg|
      OpenStruct.new(
        name:   arg.name,
        msg:    "#{arg.name} cannot contain /",
        regexp: '/\//'
      )
    end
    arg_structs.last.regexp = nil
    arg_structs
  end

  def path_string
    @segments.map do |segment|
      if segment.is_a? Gapic::PathTemplate::Segment
        "\#{#{segment.name}}"
      else
        # Should be a String
        segment
      end
    end.join
  end

  private

  def arg_segments segments
    segments.select { |segment| segment.is_a? Gapic::PathTemplate::Segment }
  end

  def positional_args? segments
    arg_segments(segments).any?(&:positional?)
  end

  def named_arg_patterns? segments
    arg_segments(segments).any?(&:pattern)
  end
end
