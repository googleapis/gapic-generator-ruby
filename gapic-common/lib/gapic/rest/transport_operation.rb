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
  module Rest
    ##
    # Surfaces information from the underlying transport library.
    #
    # @!attribute [r] underlying_op
    #   The underlying transport's library operation object.
    #   @return [::Object, nil, ::Faraday::Response]
    class TransportOperation
      attr_reader :underlying_op

      ##
      # @private
      # @param request [::Object, nil, ::Faraday::Response]
      #  The underlying transport's library operation object.
      #
      def initialize underlying_op
        @underlying_op = underlying_op
      end
    end
  end
end
