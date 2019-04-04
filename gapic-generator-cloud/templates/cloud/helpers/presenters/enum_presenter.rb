# frozen_string_literal: true

# Copyright 2018 Google LLC
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

require_relative "enum_value_presenter"

class EnumPresenter
  def initialize enum
    @enum = enum
  end

  def name
    @enum.name
  end

  def doc_description
    return nil if @enum.docs.leading_comments.empty?

    @enum
      .docs
      .leading_comments
      .each_line
      .map { |line| (line.start_with? " ") ? line[1..-1] : line }
      .join
  end

  def values
    @values ||= @enum.values.map { |v| EnumValuePresenter.new v }
  end
end
