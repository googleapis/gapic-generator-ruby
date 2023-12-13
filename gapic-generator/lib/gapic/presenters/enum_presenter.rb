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

module Gapic
  module Presenters
    ##
    # A presenter for proto enums.
    #
    class EnumPresenter
      # @return [String] String representation of this presenter type.
      attr_reader :type

      ##
      # @param enum [Gapic::Schema::Enum]
      def initialize enum
        @enum = enum
        @type = "enum"
      end

      def name
        @enum.name
      end

      def doc_description
        @enum.docs_leading_comments
      end

      def values
        @values ||= @enum.values.map { |v| EnumValuePresenter.new v }
      end

      ##
      # @return [Boolean] Whether the enum is marked as deprecated.
      def is_deprecated?
        @enum.is_deprecated?
      end
    end
  end
end
