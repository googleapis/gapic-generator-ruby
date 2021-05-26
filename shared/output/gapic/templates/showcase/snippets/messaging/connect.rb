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

# [START showcase_v0_generated_Messaging_Connect_sync]
require "google/showcase/v1beta1/messaging"

# Create a client object. The client can be reused for multiple calls.
client = Google::Showcase::V1beta1::Messaging::Client.new

# Create an input stream
input = Gapic::StreamInput.new

# Call the connect method to start streaming.
output = client.connect input

# Send requests on the stream. For each request, pass in keyword
# arguments to set fields. Be sure to close the stream when done.
input << Google::Showcase::V1beta1::ConnectRequest.new
input << Google::Showcase::V1beta1::ConnectRequest.new
input.close

# Handle streamed responses. These may be interleaved with inputs.
# Each response is of type ::Google::Showcase::V1beta1::StreamBlurbsResponse.
output.each do |response|
  p response
end
# [END showcase_v0_generated_Messaging_Connect_sync]
