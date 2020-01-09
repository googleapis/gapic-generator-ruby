# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright <YEAR> <COPYRIGHT HOLDER>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!


module So
  module Much
    module Trash
      module GarbageService
        # Path helper methods for the GarbageService API.
        module Paths
          ##
          # Create a fully-qualified SimpleGarbage resource string.
          #
          # The resource will be in the following format:
          #
          # `projects/{project}/simple_garbage/{garbage}`
          #
          # @param project [String]
          # @param garbage [String]
          #
          # @return [String]
          def simple_garbage_path project:, garbage:
            raise ArgumentError, "project is required" if project.nil?
            raise ArgumentError, "project cannot contain /" if %r{/}.match? project
            raise ArgumentError, "garbage is required" if garbage.nil?

            "projects/#{project}/simple_garbage/#{garbage}"
          end
        end
      end
    end
  end
end
