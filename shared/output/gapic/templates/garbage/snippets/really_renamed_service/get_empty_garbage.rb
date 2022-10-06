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

# [START garbage_v0_generated_ReallyRenamedService_GetEmptyGarbage_sync]
require "so/much/trash"

##
# Example demonstrating basic usage of
# So::Much::Trash::ReallyRenamedService::Client#get_empty_garbage
#
def get_empty_garbage
  # Create a client object. The client can be reused for multiple calls.
  client = So::Much::Trash::ReallyRenamedService::Client.new

  # Create a request. To set request fields, pass in keyword arguments.
  request = So::Much::Trash::EmptyGarbage.new

  # Call the get_empty_garbage method.
  result = client.get_empty_garbage request

  # The returned object is of type So::Much::Trash::EmptyGarbage.
  p result
end
# [END garbage_v0_generated_ReallyRenamedService_GetEmptyGarbage_sync]
