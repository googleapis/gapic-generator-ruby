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

# [START showcase_v0_generated_Messaging_SendBlurbs_sync]
require "google/showcase/v1beta1"

##
# Snippet for the send_blurbs call in the Messaging service
#
# This is an auto-generated example demonstrating basic usage of
# Google::Showcase::V1beta1::Messaging::Client#send_blurbs. It may require
# modification in order to execute successfully.
#
def send_blurbs
  # Create a client object. The client can be reused for multiple calls.
  client = Google::Showcase::V1beta1::Messaging::Client.new

  # Create an input stream.
  input = Gapic::StreamInput.new

  # Call the send_blurbs method to start streaming.
  result = client.send_blurbs input

  # Send requests on the stream. For each request object, set fields by
  # passing keyword arguments. Be sure to close the stream when done.
  input << Google::Showcase::V1beta1::CreateBlurbRequest.new
  input << Google::Showcase::V1beta1::CreateBlurbRequest.new
  input.close

  # The returned object is of type Google::Showcase::V1beta1::SendBlurbsResponse.
  p result
end
# [END showcase_v0_generated_Messaging_SendBlurbs_sync]
