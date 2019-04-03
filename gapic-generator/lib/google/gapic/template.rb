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

require "google/gapic/template/parser"

module Google
  module Gapic
    module Template
      # Parse a URI template.
      #
      # @param template [String] The template to be parsed.
      #
      # @return [Array<Template::Segment|String>] The segments of the template.
      def self.parse template
        Parser.new(template).segments
      end
    end
  end
end
