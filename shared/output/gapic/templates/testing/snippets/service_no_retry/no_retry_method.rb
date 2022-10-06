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

# [START testing_v0_generated_ServiceNoRetry_NoRetryMethod_sync]
require "testing/grpc_service_config"

##
# Example demonstrating basic usage of
# Testing::GrpcServiceConfig::ServiceNoRetry::Client#no_retry_method
#
def no_retry_method
  # Create a client object. The client can be reused for multiple calls.
  client = Testing::GrpcServiceConfig::ServiceNoRetry::Client.new

  # Create a request. To set request fields, pass in keyword arguments.
  request = Testing::GrpcServiceConfig::Request.new

  # Call the no_retry_method method.
  result = client.no_retry_method request

  # The returned object is of type Testing::GrpcServiceConfig::Response.
  p result
end
# [END testing_v0_generated_ServiceNoRetry_NoRetryMethod_sync]
