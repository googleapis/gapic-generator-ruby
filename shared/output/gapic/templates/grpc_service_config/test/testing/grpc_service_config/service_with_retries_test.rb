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

require "helper"

require "gapic/grpc/service_stub"

require "testing/grpc_service_config/grpc_service_config_pb"
require "testing/grpc_service_config/grpc_service_config_services_pb"
require "testing/grpc_service_config/service_with_retries"

class ::Testing::GrpcServiceConfig::ServiceWithRetries::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_rpc_count, :requests

    def initialize response, operation, &block
      @response = response
      @operation = operation
      @block = block
      @call_rpc_count = 0
      @requests = []
    end

    def call_rpc *args
      @call_rpc_count += 1

      @requests << @block&.call(*args)

      yield @response, @operation if block_given?

      @response
    end
  end

  def test_service_level_retry_method
    # Create GRPC objects.
    grpc_response = ::Testing::GrpcServiceConfig::Response.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.

    service_level_retry_method_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :service_level_retry_method, name
      assert_kind_of ::Testing::GrpcServiceConfig::Request, request
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, service_level_retry_method_client_stub do
      # Create client
      client = ::Testing::GrpcServiceConfig::ServiceWithRetries::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.service_level_retry_method({}) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.service_level_retry_method ::Testing::GrpcServiceConfig::Request.new() do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.service_level_retry_method({}, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.service_level_retry_method ::Testing::GrpcServiceConfig::Request.new(), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 4, service_level_retry_method_client_stub.call_rpc_count
    end
  end

  def test_method_level_retry_method
    # Create GRPC objects.
    grpc_response = ::Testing::GrpcServiceConfig::Response.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.

    method_level_retry_method_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :method_level_retry_method, name
      assert_kind_of ::Testing::GrpcServiceConfig::Request, request
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, method_level_retry_method_client_stub do
      # Create client
      client = ::Testing::GrpcServiceConfig::ServiceWithRetries::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.method_level_retry_method({}) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.method_level_retry_method ::Testing::GrpcServiceConfig::Request.new() do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.method_level_retry_method({}, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.method_level_retry_method ::Testing::GrpcServiceConfig::Request.new(), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 4, method_level_retry_method_client_stub.call_rpc_count
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Testing::GrpcServiceConfig::ServiceWithRetries::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Testing::GrpcServiceConfig::ServiceWithRetries::Client::Configuration, config
  end
end
