# frozen_string_literal: true

# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "minitest/autorun"

require "gapic/grpc/service_stub"

require "google/showcase/v1beta1/echo_pb"
require "google/showcase/v1beta1/echo_services_pb"
require "google/showcase/v1beta1/echo"

class Google::Showcase::V1beta1::Echo::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_rpc_count

    def initialize response, operation, &block
      @response = response
      @operation = operation
      @block = block
      @call_rpc_count = 0
    end

    def call_rpc *args
      @call_rpc_count += 1

      @block&.call *args

      yield @response, @operation if block_given?

      @response
    end
  end

  def test_echo
    # Create GRPC objects
    grpc_response = Google::Showcase::V1beta1::EchoResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    content = "hello world"

    echo_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :echo, name
      assert_equal "hello world", request.content
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, echo_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.echo content: content do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.echo content: content do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.echo Google::Showcase::V1beta1::EchoRequest.new(content: content) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.echo({ content: content }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.echo Google::Showcase::V1beta1::EchoRequest.new(content: content), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, echo_client_stub.call_rpc_count
    end
  end

  # TODO

  # TODO

  # TODO

  def test_paged_expand
    # Create GRPC objects
    grpc_response = Google::Showcase::V1beta1::PagedExpandResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    content = "hello world"
    page_size = 42
    page_token = "hello world"

    paged_expand_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :paged_expand, name
      assert_equal "hello world", request.content
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, paged_expand_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.paged_expand content: content, page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.paged_expand content: content, page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.paged_expand Google::Showcase::V1beta1::PagedExpandRequest.new(content: content, page_size: page_size, page_token: page_token) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.paged_expand({ content: content, page_size: page_size, page_token: page_token }, grpc_options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.paged_expand Google::Showcase::V1beta1::PagedExpandRequest.new(content: content, page_size: page_size, page_token: page_token), grpc_options do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, paged_expand_client_stub.call_rpc_count
    end
  end

  def test_wait
    # Create GRPC objects
    grpc_response = Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    end_time = {}
    error = {}

    wait_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :wait, name
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::Timestamp), request.end_time
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Rpc::Status), request.error
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, wait_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.wait end_time: end_time, error: error do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.wait end_time: end_time, error: error do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.wait Google::Showcase::V1beta1::WaitRequest.new(end_time: end_time, error: error) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.wait({ end_time: end_time, error: error }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.wait Google::Showcase::V1beta1::WaitRequest.new(end_time: end_time, error: error), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, wait_client_stub.call_rpc_count
    end
  end

  def test_block
    # Create GRPC objects
    grpc_response = Google::Showcase::V1beta1::BlockResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    response_delay = {}

    block_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :block, name
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::Duration), request.response_delay
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, block_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.block response_delay: response_delay do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.block response_delay: response_delay do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.block Google::Showcase::V1beta1::BlockRequest.new(response_delay: response_delay) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.block({ response_delay: response_delay }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.block Google::Showcase::V1beta1::BlockRequest.new(response_delay: response_delay), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, block_client_stub.call_rpc_count
    end
  end
end
