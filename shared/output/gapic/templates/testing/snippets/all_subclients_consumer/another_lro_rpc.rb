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

# [START testing_v0_generated_AllSubclientsConsumer_AnotherLroRpc_sync]
require "testing/nonstandard_lro_grpc"

##
# Example demonstrating basic usage of
# Testing::NonstandardLroGrpc::AllSubclientsConsumer::Client#another_lro_rpc
#
def another_lro_rpc
  # Create a client object. The client can be reused for multiple calls.
  client = Testing::NonstandardLroGrpc::AllSubclientsConsumer::Client.new

  # Create a request. To set request fields, pass in keyword arguments.
  request = Testing::NonstandardLroGrpc::AnotherRequest.new

  # Call the another_lro_rpc method.
  result = client.another_lro_rpc request

  # The returned object is of type Testing::NonstandardLroGrpc::NonstandardOperation.
  p result
end
# [END testing_v0_generated_AllSubclientsConsumer_AnotherLroRpc_sync]
