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

require "simplecov"
require "minitest/autorun"

require "gapic/grpc/service_stub"

require "garbage/resource_names_pb"
require "garbage/resource_names_services_pb"
require "so/much/trash/resource_names"

class So::Much::Trash::ResourceNames::ClientTest < Minitest::Test
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

  def test_single_pattern_method
    # Create GRPC objects.
    grpc_response = So::Much::Trash::Response.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    real_name = "hello world"
    ref = "hello world"
    repeated_ref = ["hello world"]
    value_ref = {}
    repeated_value_ref = [{}]

    single_pattern_method_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :single_pattern_method, name
      assert_kind_of So::Much::Trash::SinglePattern, request
      assert_equal "hello world", request.real_name
      assert_equal "hello world", request.ref
      assert_equal ["hello world"], request.repeated_ref
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::StringValue), request.value_ref
      assert_kind_of Google::Protobuf::StringValue, request.repeated_value_ref.first
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, single_pattern_method_client_stub do
      # Create client
      client = So::Much::Trash::ResourceNames::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.single_pattern_method({ real_name: real_name, ref: ref, repeated_ref: repeated_ref, value_ref: value_ref, repeated_value_ref: repeated_value_ref }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.single_pattern_method real_name: real_name, ref: ref, repeated_ref: repeated_ref, value_ref: value_ref, repeated_value_ref: repeated_value_ref do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.single_pattern_method So::Much::Trash::SinglePattern.new(real_name: real_name, ref: ref, repeated_ref: repeated_ref, value_ref: value_ref, repeated_value_ref: repeated_value_ref) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.single_pattern_method({ real_name: real_name, ref: ref, repeated_ref: repeated_ref, value_ref: value_ref, repeated_value_ref: repeated_value_ref }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.single_pattern_method So::Much::Trash::SinglePattern.new(real_name: real_name, ref: ref, repeated_ref: repeated_ref, value_ref: value_ref, repeated_value_ref: repeated_value_ref), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, single_pattern_method_client_stub.call_rpc_count
    end
  end

  def test_non_slash_pattern_method
    # Create GRPC objects.
    grpc_response = So::Much::Trash::Response.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    real_name = "hello world"
    ref = "hello world"
    repeated_ref = ["hello world"]
    value_ref = {}
    repeated_value_ref = [{}]

    non_slash_pattern_method_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :non_slash_pattern_method, name
      assert_kind_of So::Much::Trash::NonSlashMultiPattern, request
      assert_equal "hello world", request.real_name
      assert_equal "hello world", request.ref
      assert_equal ["hello world"], request.repeated_ref
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::StringValue), request.value_ref
      assert_kind_of Google::Protobuf::StringValue, request.repeated_value_ref.first
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, non_slash_pattern_method_client_stub do
      # Create client
      client = So::Much::Trash::ResourceNames::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.non_slash_pattern_method({ real_name: real_name, ref: ref, repeated_ref: repeated_ref, value_ref: value_ref, repeated_value_ref: repeated_value_ref }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.non_slash_pattern_method real_name: real_name, ref: ref, repeated_ref: repeated_ref, value_ref: value_ref, repeated_value_ref: repeated_value_ref do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.non_slash_pattern_method So::Much::Trash::NonSlashMultiPattern.new(real_name: real_name, ref: ref, repeated_ref: repeated_ref, value_ref: value_ref, repeated_value_ref: repeated_value_ref) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.non_slash_pattern_method({ real_name: real_name, ref: ref, repeated_ref: repeated_ref, value_ref: value_ref, repeated_value_ref: repeated_value_ref }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.non_slash_pattern_method So::Much::Trash::NonSlashMultiPattern.new(real_name: real_name, ref: ref, repeated_ref: repeated_ref, value_ref: value_ref, repeated_value_ref: repeated_value_ref), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, non_slash_pattern_method_client_stub.call_rpc_count
    end
  end
end
