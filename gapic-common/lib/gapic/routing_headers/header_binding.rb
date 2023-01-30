# Copyright 2023 Google LLC
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
  module RoutingHeaders
    class HeadersExtractor
      ##
      # @private
      class HeaderBinding
        attr_reader :field
        attr_reader :header_name
        attr_reader :regex

        def initialize field, header_name=nil, regex=nil
          @field = field
          @header_name = header_name
          @regex = regex
        end

        ##
        # @private
        # Creates a new HeaderBinding.
        #
        def self.create field:, header_name: nil, regex: nil
          HeaderBinding.new field, header_name, regex
        end
      end
    end
  end
end
