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

# [START testing_v0_generated_ServiceWithRetries_MethodLevelRetryMethod_sync]
require "testing/grpc_service_config"

##
# Snippet for the method_level_retry_method call in the ServiceWithRetries service
#
# This snippet has been automatically generated and should be regarded as a code
# template only. It will require modifications to work:
# - It may require correct/in-range values for request initialization.
# - It may require specifying regional endpoints when creating the service
# client as shown in https://cloud.google.com/ruby/docs/reference.
#
# This is an auto-generated example demonstrating basic usage of
# Testing::GrpcServiceConfig::ServiceWithRetries::Client#method_level_retry_method.
#
def method_level_retry_method
  # Create a client object. The client can be reused for multiple calls.
  client = Testing::GrpcServiceConfig::ServiceWithRetries::Client.new

  # Create a request. To set request fields, pass in keyword arguments.
  request = Testing::GrpcServiceConfig::Request.new

  # Call the method_level_retry_method method.
  result = client.method_level_retry_method request

  # The returned object is of type Testing::GrpcServiceConfig::Response.
  p result
end
# [END testing_v0_generated_ServiceWithRetries_MethodLevelRetryMethod_sync]
