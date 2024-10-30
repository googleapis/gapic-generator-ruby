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

require "helper"

require "gapic/grpc/service_stub"

require "testing/routing_headers/routing_headers_pb"
require "testing/routing_headers/routing_headers_services_pb"
require "testing/routing_headers/service_implicit_headers"

class ::Testing::RoutingHeaders::ServiceImplicitHeaders::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_rpc_count, :requests

    def initialize response, operation, &block
      @response = response
      @operation = operation
      @block = block
      @call_rpc_count = 0
      @requests = []
    end

    def call_rpc *args, **kwargs
      @call_rpc_count += 1

      @requests << @block&.call(*args, **kwargs)

      catch :response do
        yield @response, @operation if block_given?
        @response
      end
    end

    def endpoint
      "endpoint.example.com"
    end

    def universe_domain
      "example.com"
    end

    def stub_logger
      nil
    end
  end

  def test_plain
    # Create GRPC objects.
    grpc_response = ::Testing::RoutingHeaders::Response.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    table_name = "hello world"
    app_profile_id = "hello world"
    resource = {}

    plain_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :plain, name
      assert_kind_of ::Testing::RoutingHeaders::Request, request
      assert_equal "hello world", request["table_name"]
      assert_equal "hello world", request["app_profile_id"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Testing::RoutingHeaders::RequestResource), request["resource"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, plain_client_stub do
      # Create client
      client = ::Testing::RoutingHeaders::ServiceImplicitHeaders::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.plain({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.plain table_name: table_name, app_profile_id: app_profile_id, resource: resource do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.plain ::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.plain({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.plain(::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource), grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, plain_client_stub.call_rpc_count
    end
  end

  def test_with_sub_message
    # Create GRPC objects.
    grpc_response = ::Testing::RoutingHeaders::Response.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    table_name = "hello world"
    app_profile_id = "hello world"
    resource = {}

    with_sub_message_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :with_sub_message, name
      assert_kind_of ::Testing::RoutingHeaders::Request, request
      assert_equal "hello world", request["table_name"]
      assert_equal "hello world", request["app_profile_id"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Testing::RoutingHeaders::RequestResource), request["resource"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, with_sub_message_client_stub do
      # Create client
      client = ::Testing::RoutingHeaders::ServiceImplicitHeaders::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.with_sub_message({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.with_sub_message table_name: table_name, app_profile_id: app_profile_id, resource: resource do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.with_sub_message ::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.with_sub_message({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.with_sub_message(::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource), grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, with_sub_message_client_stub.call_rpc_count
    end
  end

  def test_with_multiple_levels
    # Create GRPC objects.
    grpc_response = ::Testing::RoutingHeaders::Response.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    table_name = "hello world"
    app_profile_id = "hello world"
    resource = {}

    with_multiple_levels_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :with_multiple_levels, name
      assert_kind_of ::Testing::RoutingHeaders::Request, request
      assert_equal "hello world", request["table_name"]
      assert_equal "hello world", request["app_profile_id"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Testing::RoutingHeaders::RequestResource), request["resource"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, with_multiple_levels_client_stub do
      # Create client
      client = ::Testing::RoutingHeaders::ServiceImplicitHeaders::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.with_multiple_levels({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.with_multiple_levels table_name: table_name, app_profile_id: app_profile_id, resource: resource do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.with_multiple_levels ::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.with_multiple_levels({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.with_multiple_levels(::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource), grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, with_multiple_levels_client_stub.call_rpc_count
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    dummy_stub = ClientStub.new nil, nil
    Gapic::ServiceStub.stub :new, dummy_stub do
      client = ::Testing::RoutingHeaders::ServiceImplicitHeaders::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Testing::RoutingHeaders::ServiceImplicitHeaders::Client::Configuration, config
  end
end
