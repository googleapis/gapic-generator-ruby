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

# [START showcase_v0_generated_Testing_ListTests_sync]
require "google/showcase/v1beta1"

##
# Example demonstrating basic usage of
# Google::Showcase::V1beta1::Testing::Client#list_tests
#
def list_tests
  # Create a client object. The client can be reused for multiple calls.
  client = Google::Showcase::V1beta1::Testing::Client.new

  # Create a request. To set request fields, pass in keyword arguments.
  request = Google::Showcase::V1beta1::ListTestsRequest.new

  # Call the list_tests method.
  result = client.list_tests request

  # The returned object is of type Gapic::PagedEnumerable. You can iterate
  # overal elements, and API calls will be issued to fetch pages as needed.
  result.each do |item|
    # Each element is of type ::Google::Showcase::V1beta1::Test.
    p item
  end
end
# [END showcase_v0_generated_Testing_ListTests_sync]
