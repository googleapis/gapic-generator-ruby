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

require "garbage/resource_names_pb"
require "garbage/resource_names_services_pb"
require "so/much/trash/resource_names"

class ::So::Much::Trash::ResourceNames::ClientTest < Minitest::Test
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

      yield @response, @operation if block_given?

      @response
    end
  end

  def test_simple_pattern_method
    # Create GRPC objects.
    grpc_response = ::So::Much::Trash::Response.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    real_name = "hello world"
    ref = "hello world"
    repeated_ref = ["hello world"]

    simple_pattern_method_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :simple_pattern_method, name
      assert_kind_of ::So::Much::Trash::SimplePatternRequest, request
      assert_equal "hello world", request["real_name"]
      assert_equal "hello world", request["ref"]
      assert_equal ["hello world"], request["repeated_ref"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, simple_pattern_method_client_stub do
      # Create client
      client = ::So::Much::Trash::ResourceNames::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.simple_pattern_method({ real_name: real_name, ref: ref, repeated_ref: repeated_ref }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.simple_pattern_method real_name: real_name, ref: ref, repeated_ref: repeated_ref do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.simple_pattern_method ::So::Much::Trash::SimplePatternRequest.new(real_name: real_name, ref: ref, repeated_ref: repeated_ref) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.simple_pattern_method({ real_name: real_name, ref: ref, repeated_ref: repeated_ref }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.simple_pattern_method ::So::Much::Trash::SimplePatternRequest.new(real_name: real_name, ref: ref, repeated_ref: repeated_ref), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, simple_pattern_method_client_stub.call_rpc_count
    end
  end

  def test_complex_pattern_method
    # Create GRPC objects.
    grpc_response = ::So::Much::Trash::Response.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    real_name = "hello world"
    ref = "hello world"
    repeated_ref = ["hello world"]

    complex_pattern_method_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :complex_pattern_method, name
      assert_kind_of ::So::Much::Trash::ComplexPatternRequest, request
      assert_equal "hello world", request["real_name"]
      assert_equal "hello world", request["ref"]
      assert_equal ["hello world"], request["repeated_ref"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, complex_pattern_method_client_stub do
      # Create client
      client = ::So::Much::Trash::ResourceNames::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.complex_pattern_method({ real_name: real_name, ref: ref, repeated_ref: repeated_ref }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.complex_pattern_method real_name: real_name, ref: ref, repeated_ref: repeated_ref do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.complex_pattern_method ::So::Much::Trash::ComplexPatternRequest.new(real_name: real_name, ref: ref, repeated_ref: repeated_ref) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.complex_pattern_method({ real_name: real_name, ref: ref, repeated_ref: repeated_ref }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.complex_pattern_method ::So::Much::Trash::ComplexPatternRequest.new(real_name: real_name, ref: ref, repeated_ref: repeated_ref), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, complex_pattern_method_client_stub.call_rpc_count
    end
  end

  def test_resource_name_pattern_method
    # Create GRPC objects.
    grpc_response = ::So::Much::Trash::Response.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    resource_name_pattern_method_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :resource_name_pattern_method, name
      assert_kind_of ::So::Much::Trash::ResourceNamePatternRequest, request
      assert_equal "hello world", request["name"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, resource_name_pattern_method_client_stub do
      # Create client
      client = ::So::Much::Trash::ResourceNames::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.resource_name_pattern_method({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.resource_name_pattern_method name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.resource_name_pattern_method ::So::Much::Trash::ResourceNamePatternRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.resource_name_pattern_method({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.resource_name_pattern_method ::So::Much::Trash::ResourceNamePatternRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, resource_name_pattern_method_client_stub.call_rpc_count
    end
  end

  def test_multiparent_method
    # Create GRPC objects.
    grpc_response = ::So::Much::Trash::Response.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"

    multiparent_method_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :multiparent_method, name
      assert_kind_of ::So::Much::Trash::MultiparentRequest, request
      assert_equal "hello world", request["parent"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, multiparent_method_client_stub do
      # Create client
      client = ::So::Much::Trash::ResourceNames::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.multiparent_method({ parent: parent }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.multiparent_method parent: parent do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.multiparent_method ::So::Much::Trash::MultiparentRequest.new(parent: parent) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.multiparent_method({ parent: parent }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.multiparent_method ::So::Much::Trash::MultiparentRequest.new(parent: parent), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, multiparent_method_client_stub.call_rpc_count
    end
  end

  def test_no_arguments_multi_method
    # Create GRPC objects.
    grpc_response = ::So::Much::Trash::Response.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    no_arguments_multi_method_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :no_arguments_multi_method, name
      assert_kind_of ::So::Much::Trash::NoArgumentsMultiRequest, request
      assert_equal "hello world", request["name"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, no_arguments_multi_method_client_stub do
      # Create client
      client = ::So::Much::Trash::ResourceNames::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.no_arguments_multi_method({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.no_arguments_multi_method name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.no_arguments_multi_method ::So::Much::Trash::NoArgumentsMultiRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.no_arguments_multi_method({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.no_arguments_multi_method ::So::Much::Trash::NoArgumentsMultiRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, no_arguments_multi_method_client_stub.call_rpc_count
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::So::Much::Trash::ResourceNames::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::So::Much::Trash::ResourceNames::Client::Configuration, config
  end
end
