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

# [START garbage_v0_generated_GarbageService_BidiGarbage_sync]
require "so/much/trash"

##
# Snippet for the bidi_garbage call in the GarbageService service
#
# This snippet has been automatically generated and should be regarded as a code
# template only. It will require modifications to work:
# - It may require correct/in-range values for request initialization.
# - It may require specifying regional endpoints when creating the service
# client as shown in https://cloud.google.com/ruby/docs/reference.
#
# This is an auto-generated example demonstrating basic usage of
# So::Much::Trash::GarbageService::Client#bidi_garbage.
#
def bidi_garbage
  # Create a client object. The client can be reused for multiple calls.
  client = So::Much::Trash::GarbageService::Client.new

  # Create an input stream.
  input = Gapic::StreamInput.new

  # Call the bidi_garbage method to start streaming.
  output = client.bidi_garbage input

  # Send requests on the stream. For each request object, set fields by
  # passing keyword arguments. Be sure to close the stream when done.
  input << So::Much::Trash::ListGarbageRequest.new
  input << So::Much::Trash::ListGarbageRequest.new
  input.close

  # The returned object is a streamed enumerable yielding elements of type
  # ::So::Much::Trash::GarbageItem
  output.each do |current_response|
    p current_response
  end
end
# [END garbage_v0_generated_GarbageService_BidiGarbage_sync]
