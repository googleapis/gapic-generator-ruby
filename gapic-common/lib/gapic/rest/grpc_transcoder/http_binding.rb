# Copyright 2022 Google LLC
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
    class GrpcTranscoder
      # @private
      # A single binding for GRPC-REST transcoding of a request
      # It includes a uri template with bound field parameters, a HTTP method type,
      # and a body template
      #
      # @attribute [r] method
      #   @return [Symbol] The REST verb for the request.
      # @attribute [r] template
      #   @return [String] The URI template for the request.
      # @attribute [r] field_bindings
      #   @return [Array<FieldBinding>] The field bindings for the URI template variables.
      # @attribute [r] body
      #   @return [String] The body template for the request.
      class HttpBinding
        attr_reader :method
        attr_reader :template
        attr_reader :field_bindings
        attr_reader :body

        def initialize method, template, field_bindings, body
          @method = method
          @template = template
          @field_bindings = field_bindings
          @body = body
        end

        # A single binding for a field of a request message.
        # @attribute [r] field_path
        #   @return [String] The path of the bound field, e.g. `foo.bar`.
        # @attribute [r] regex
        #   @return [Regexp] The regex to match on the bound field's string representation.
        # @attribute [r] preserve_slashes
        #   @return [Boolean] Whether the slashes in the field value should be preserved
        #     (as opposed to percent-escaped)
        class FieldBinding
          attr_reader :field_path
          attr_reader :regex
          attr_reader :preserve_slashes

          def initialize field_path, regex, preserve_slashes
            @field_path = field_path
            @regex = regex
            @preserve_slashes = preserve_slashes
          end
        end
      end
    end
  end
end
