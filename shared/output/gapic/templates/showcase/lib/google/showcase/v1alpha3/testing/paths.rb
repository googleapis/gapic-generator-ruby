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

module Google
  module Showcase
    module V1alpha3
      module Testing
        module Paths
          ##
          # Create a fully-qualified Session resource string.
          #
          # The resource will be in the following format:
          #
          # `sessions/{session}`
          #
          # @param session [String]
          #
          # @return [String]
          def session_path session:
            raise ArgumentError, "session is required" if session.nil?

            "sessions/#{session}"
          end

          ##
          # Create a fully-qualified Test resource string.
          #
          # The resource will be in the following format:
          #
          # `sessions/{session}/tests/{test}`
          #
          # @param session [String]
          # @param test [String]
          #
          # @return [String]
          def test_path session:, test:
            raise ArgumentError, "session is required" if session.nil?
            raise ArgumentError, "session cannot contain /" unless /([^/]+)/.match session
            raise ArgumentError, "test is required" if test.nil?

            "sessions/#{session}/tests/#{test}"
          end

        end
      end
    end
  end
end

