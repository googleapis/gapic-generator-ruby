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

require "google/showcase/v1beta1/compliance_pb"
require "google/showcase/v1beta1/compliance_services_pb"
require "google/showcase/v1beta1/compliance"

class ::Google::Showcase::V1beta1::Compliance::ClientTest < Minitest::Test
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

  def test_repeat_data_body
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::RepeatResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    info = {}
    server_verify = true
    intended_binding_uri = "hello world"
    f_int32 = 42
    f_int64 = 42
    f_double = 3.5
    p_int32 = 42
    p_int64 = 42
    p_double = 3.5

    repeat_data_body_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :repeat_data_body, name
      assert_kind_of ::Google::Showcase::V1beta1::RepeatRequest, request
      assert_equal "hello world", request["name"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Showcase::V1beta1::ComplianceData), request["info"]
      assert_equal true, request["server_verify"]
      assert_equal "hello world", request["intended_binding_uri"]
      assert request.has_intended_binding_uri?
      assert_equal 42, request["f_int32"]
      assert_equal 42, request["f_int64"]
      assert_equal 3.5, request["f_double"]
      assert_equal 42, request["p_int32"]
      assert request.has_p_int32?
      assert_equal 42, request["p_int64"]
      assert request.has_p_int64?
      assert_equal 3.5, request["p_double"]
      assert request.has_p_double?
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, repeat_data_body_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Compliance::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.repeat_data_body({ name: name, info: info, server_verify: server_verify,
intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.repeat_data_body name: name, info: info, server_verify: server_verify,
                              intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.repeat_data_body ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info,
                                                                             server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.repeat_data_body(
        { name: name, info: info, server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32,
f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }, grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.repeat_data_body(
        ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info, server_verify: server_verify,
                                                       intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double), grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, repeat_data_body_client_stub.call_rpc_count
    end
  end

  def test_repeat_data_body_info
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::RepeatResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    info = {}
    server_verify = true
    intended_binding_uri = "hello world"
    f_int32 = 42
    f_int64 = 42
    f_double = 3.5
    p_int32 = 42
    p_int64 = 42
    p_double = 3.5

    repeat_data_body_info_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :repeat_data_body_info, name
      assert_kind_of ::Google::Showcase::V1beta1::RepeatRequest, request
      assert_equal "hello world", request["name"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Showcase::V1beta1::ComplianceData), request["info"]
      assert_equal true, request["server_verify"]
      assert_equal "hello world", request["intended_binding_uri"]
      assert request.has_intended_binding_uri?
      assert_equal 42, request["f_int32"]
      assert_equal 42, request["f_int64"]
      assert_equal 3.5, request["f_double"]
      assert_equal 42, request["p_int32"]
      assert request.has_p_int32?
      assert_equal 42, request["p_int64"]
      assert request.has_p_int64?
      assert_equal 3.5, request["p_double"]
      assert request.has_p_double?
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, repeat_data_body_info_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Compliance::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.repeat_data_body_info({ name: name, info: info, server_verify: server_verify,
intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.repeat_data_body_info name: name, info: info, server_verify: server_verify,
                                   intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.repeat_data_body_info ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info,
                                                                                  server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.repeat_data_body_info(
        { name: name, info: info, server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32,
f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }, grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.repeat_data_body_info(
        ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info, server_verify: server_verify,
                                                       intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double), grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, repeat_data_body_info_client_stub.call_rpc_count
    end
  end

  def test_repeat_data_query
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::RepeatResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    info = {}
    server_verify = true
    intended_binding_uri = "hello world"
    f_int32 = 42
    f_int64 = 42
    f_double = 3.5
    p_int32 = 42
    p_int64 = 42
    p_double = 3.5

    repeat_data_query_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :repeat_data_query, name
      assert_kind_of ::Google::Showcase::V1beta1::RepeatRequest, request
      assert_equal "hello world", request["name"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Showcase::V1beta1::ComplianceData), request["info"]
      assert_equal true, request["server_verify"]
      assert_equal "hello world", request["intended_binding_uri"]
      assert request.has_intended_binding_uri?
      assert_equal 42, request["f_int32"]
      assert_equal 42, request["f_int64"]
      assert_equal 3.5, request["f_double"]
      assert_equal 42, request["p_int32"]
      assert request.has_p_int32?
      assert_equal 42, request["p_int64"]
      assert request.has_p_int64?
      assert_equal 3.5, request["p_double"]
      assert request.has_p_double?
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, repeat_data_query_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Compliance::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.repeat_data_query({ name: name, info: info, server_verify: server_verify,
intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.repeat_data_query name: name, info: info, server_verify: server_verify,
                               intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.repeat_data_query ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info,
                                                                              server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.repeat_data_query(
        { name: name, info: info, server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32,
f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }, grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.repeat_data_query(
        ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info, server_verify: server_verify,
                                                       intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double), grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, repeat_data_query_client_stub.call_rpc_count
    end
  end

  def test_repeat_data_simple_path
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::RepeatResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    info = {}
    server_verify = true
    intended_binding_uri = "hello world"
    f_int32 = 42
    f_int64 = 42
    f_double = 3.5
    p_int32 = 42
    p_int64 = 42
    p_double = 3.5

    repeat_data_simple_path_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :repeat_data_simple_path, name
      assert_kind_of ::Google::Showcase::V1beta1::RepeatRequest, request
      assert_equal "hello world", request["name"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Showcase::V1beta1::ComplianceData), request["info"]
      assert_equal true, request["server_verify"]
      assert_equal "hello world", request["intended_binding_uri"]
      assert request.has_intended_binding_uri?
      assert_equal 42, request["f_int32"]
      assert_equal 42, request["f_int64"]
      assert_equal 3.5, request["f_double"]
      assert_equal 42, request["p_int32"]
      assert request.has_p_int32?
      assert_equal 42, request["p_int64"]
      assert request.has_p_int64?
      assert_equal 3.5, request["p_double"]
      assert request.has_p_double?
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, repeat_data_simple_path_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Compliance::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.repeat_data_simple_path({ name: name, info: info, server_verify: server_verify,
intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.repeat_data_simple_path name: name, info: info, server_verify: server_verify,
                                     intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.repeat_data_simple_path ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info,
                                                                                    server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.repeat_data_simple_path(
        { name: name, info: info, server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32,
f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }, grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.repeat_data_simple_path(
        ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info, server_verify: server_verify,
                                                       intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double), grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, repeat_data_simple_path_client_stub.call_rpc_count
    end
  end

  def test_repeat_data_path_resource
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::RepeatResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    info = {}
    server_verify = true
    intended_binding_uri = "hello world"
    f_int32 = 42
    f_int64 = 42
    f_double = 3.5
    p_int32 = 42
    p_int64 = 42
    p_double = 3.5

    repeat_data_path_resource_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :repeat_data_path_resource, name
      assert_kind_of ::Google::Showcase::V1beta1::RepeatRequest, request
      assert_equal "hello world", request["name"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Showcase::V1beta1::ComplianceData), request["info"]
      assert_equal true, request["server_verify"]
      assert_equal "hello world", request["intended_binding_uri"]
      assert request.has_intended_binding_uri?
      assert_equal 42, request["f_int32"]
      assert_equal 42, request["f_int64"]
      assert_equal 3.5, request["f_double"]
      assert_equal 42, request["p_int32"]
      assert request.has_p_int32?
      assert_equal 42, request["p_int64"]
      assert request.has_p_int64?
      assert_equal 3.5, request["p_double"]
      assert request.has_p_double?
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, repeat_data_path_resource_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Compliance::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.repeat_data_path_resource({ name: name, info: info, server_verify: server_verify,
intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.repeat_data_path_resource name: name, info: info, server_verify: server_verify,
                                       intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.repeat_data_path_resource ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info,
                                                                                      server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.repeat_data_path_resource(
        { name: name, info: info, server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32,
f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }, grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.repeat_data_path_resource(
        ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info, server_verify: server_verify,
                                                       intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double), grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, repeat_data_path_resource_client_stub.call_rpc_count
    end
  end

  def test_repeat_data_path_trailing_resource
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::RepeatResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    info = {}
    server_verify = true
    intended_binding_uri = "hello world"
    f_int32 = 42
    f_int64 = 42
    f_double = 3.5
    p_int32 = 42
    p_int64 = 42
    p_double = 3.5

    repeat_data_path_trailing_resource_client_stub = ClientStub.new grpc_response,
                                                                    grpc_operation do |name, request, options:|
      assert_equal :repeat_data_path_trailing_resource, name
      assert_kind_of ::Google::Showcase::V1beta1::RepeatRequest, request
      assert_equal "hello world", request["name"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Showcase::V1beta1::ComplianceData), request["info"]
      assert_equal true, request["server_verify"]
      assert_equal "hello world", request["intended_binding_uri"]
      assert request.has_intended_binding_uri?
      assert_equal 42, request["f_int32"]
      assert_equal 42, request["f_int64"]
      assert_equal 3.5, request["f_double"]
      assert_equal 42, request["p_int32"]
      assert request.has_p_int32?
      assert_equal 42, request["p_int64"]
      assert request.has_p_int64?
      assert_equal 3.5, request["p_double"]
      assert request.has_p_double?
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, repeat_data_path_trailing_resource_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Compliance::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.repeat_data_path_trailing_resource({ name: name, info: info, server_verify: server_verify,
intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.repeat_data_path_trailing_resource name: name, info: info, server_verify: server_verify,
                                                intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.repeat_data_path_trailing_resource ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info,
                                                                                               server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.repeat_data_path_trailing_resource(
        { name: name, info: info, server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32,
f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }, grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.repeat_data_path_trailing_resource(
        ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info, server_verify: server_verify,
                                                       intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double), grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, repeat_data_path_trailing_resource_client_stub.call_rpc_count
    end
  end

  def test_repeat_data_body_put
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::RepeatResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    info = {}
    server_verify = true
    intended_binding_uri = "hello world"
    f_int32 = 42
    f_int64 = 42
    f_double = 3.5
    p_int32 = 42
    p_int64 = 42
    p_double = 3.5

    repeat_data_body_put_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :repeat_data_body_put, name
      assert_kind_of ::Google::Showcase::V1beta1::RepeatRequest, request
      assert_equal "hello world", request["name"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Showcase::V1beta1::ComplianceData), request["info"]
      assert_equal true, request["server_verify"]
      assert_equal "hello world", request["intended_binding_uri"]
      assert request.has_intended_binding_uri?
      assert_equal 42, request["f_int32"]
      assert_equal 42, request["f_int64"]
      assert_equal 3.5, request["f_double"]
      assert_equal 42, request["p_int32"]
      assert request.has_p_int32?
      assert_equal 42, request["p_int64"]
      assert request.has_p_int64?
      assert_equal 3.5, request["p_double"]
      assert request.has_p_double?
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, repeat_data_body_put_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Compliance::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.repeat_data_body_put({ name: name, info: info, server_verify: server_verify,
intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.repeat_data_body_put name: name, info: info, server_verify: server_verify,
                                  intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.repeat_data_body_put ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info,
                                                                                 server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.repeat_data_body_put(
        { name: name, info: info, server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32,
f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }, grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.repeat_data_body_put(
        ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info, server_verify: server_verify,
                                                       intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double), grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, repeat_data_body_put_client_stub.call_rpc_count
    end
  end

  def test_repeat_data_body_patch
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::RepeatResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    info = {}
    server_verify = true
    intended_binding_uri = "hello world"
    f_int32 = 42
    f_int64 = 42
    f_double = 3.5
    p_int32 = 42
    p_int64 = 42
    p_double = 3.5

    repeat_data_body_patch_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :repeat_data_body_patch, name
      assert_kind_of ::Google::Showcase::V1beta1::RepeatRequest, request
      assert_equal "hello world", request["name"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Showcase::V1beta1::ComplianceData), request["info"]
      assert_equal true, request["server_verify"]
      assert_equal "hello world", request["intended_binding_uri"]
      assert request.has_intended_binding_uri?
      assert_equal 42, request["f_int32"]
      assert_equal 42, request["f_int64"]
      assert_equal 3.5, request["f_double"]
      assert_equal 42, request["p_int32"]
      assert request.has_p_int32?
      assert_equal 42, request["p_int64"]
      assert request.has_p_int64?
      assert_equal 3.5, request["p_double"]
      assert request.has_p_double?
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, repeat_data_body_patch_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Compliance::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.repeat_data_body_patch({ name: name, info: info, server_verify: server_verify,
intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.repeat_data_body_patch name: name, info: info, server_verify: server_verify,
                                    intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.repeat_data_body_patch ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info,
                                                                                   server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.repeat_data_body_patch(
        { name: name, info: info, server_verify: server_verify, intended_binding_uri: intended_binding_uri, f_int32: f_int32,
f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double }, grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.repeat_data_body_patch(
        ::Google::Showcase::V1beta1::RepeatRequest.new(name: name, info: info, server_verify: server_verify,
                                                       intended_binding_uri: intended_binding_uri, f_int32: f_int32, f_int64: f_int64, f_double: f_double, p_int32: p_int32, p_int64: p_int64, p_double: p_double), grpc_options
      ) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, repeat_data_body_patch_client_stub.call_rpc_count
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Showcase::V1beta1::Compliance::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Showcase::V1beta1::Compliance::Client::Configuration, config
  end
end
