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

require "gapic/ruby_info"

module Gapic
  module Presenters
    ##
    # A presenter for proto enum values.
    #
    class EnumValuePresenter
      def initialize value
        @value = value
      end

      # @return [String] The enum value name without keyword collision.
      def name
        Gapic::RubyInfo.keywords.include?(@value.name) ? "#{@value.parent.name}::#{@value.name}" : @value.name
      end

      def doc_description
        @value.docs_leading_comments
      end

      def number
        @value.number
      end
    end
  end
end
