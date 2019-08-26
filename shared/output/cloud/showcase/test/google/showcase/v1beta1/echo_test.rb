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

require "google/showcase/v1beta1/echo_pb"
require "google/showcase/v1beta1/echo_services_pb"
require "google/showcase/v1beta1/echo"

class CustomTestErrorV1 < StandardError; end
# Mock for the GRPC::ClientStub class.
class MockGrpcClientStubV1
  # @param expected_symbol [Symbol] the symbol of the grpc method to be mocked.
  # @param mock_method [Proc] The method that is being mocked.
  def initialize expected_symbol, mock_method
    @expected_symbol = expected_symbol
    @mock_method = mock_method
  end

  # This overrides the Object#method method to return the mocked method when the mocked method
  # is being requested. For methods that aren"t being tested, this method returns a proc that
  # will raise an error when called. This is to assure that only the mocked grpc method is being
  # called.
  #
  # @param symbol [Symbol] The symbol of the method being requested.
  # @return [Proc] The proc of the requested method. If the requested method is not being mocked
  #   the proc returned will raise when called.
  def method symbol
    return @mock_method if symbol == @expected_symbol

    # The requested method is not being tested, raise if it called.
    proc do
      raise "The method #{symbol} was unexpectedly called during the " \
        "test for #{@expected_symbol}."
    end
  end
end

class MockEchoCredentialsV1beta1 < Google::Showcase::V1beta1::Echo::Credentials
  def initialize method_name
    @method_name = method_name
  end

  def updater_proc
    proc do
      raise "The method `#{@method_name}` was trying to make a grpc request. This should not " \
          "happen since the grpc layer is being mocked."
    end
  end
end

describe Google::Showcase::V1beta1::Echo::Client do
  describe "echo" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1beta1::Echo::Client#echo."
    end

    it "invokes echo without error" do
      # Create request parameters
      content = "hello world"
      error = {}

      # Create expected grpc response
      expected_response = Gapic::Protobuf.coerce {}, to: Google::Showcase::V1beta1::EchoResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::EchoRequest, request
      assert_equal content, request.content
      assert_equal Gapic::Protobuf.coerce(error, to: Google::Rpc::Status), request.error
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :echo, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "echo"

      Google::Showcase::V1beta1::Echo::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Echo::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Echo::Client.new

          # Call method
          response = client.echo content, error

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.echo content, error do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes echo with error" do
      # Create request parameters
      content = "hello world"
      error = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::EchoRequest, request
      assert_equal content, request.content
      assert_equal Gapic::Protobuf.coerce(error, to: Google::Rpc::Status), request.error
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :echo, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "echo"

      Google::Showcase::V1beta1::Echo::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Echo::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Echo::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.echo content, error
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "expand" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1beta1::Echo::Client#expand."
    end

    it "invokes expand without error" do
      # Create request parameters
      content = "hello world"
      error = {}

      # Create expected grpc response
      expected_response = Gapic::Protobuf.coerce {}, to: Google::Showcase::V1beta1::EchoResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::ExpandRequest, request
        assert_equal content, request.content
        assert_equal Gapic::Protobuf.coerce(error, to: Google::Rpc::Status), request.error
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :expand, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "expand"

      Google::Showcase::V1beta1::Echo::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Echo::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Echo::Client.new

          # Call method
          response = client.expand [request]

          # Verify the response
          assert_equal 1, response.count
          assert_equal expected_response, response.first
        end
      end
    end

    it "invokes expand with error" do
      # Create request parameters
      content = "hello world"
      error = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::ExpandRequest, request
        assert_equal content, request.content
        assert_equal Gapic::Protobuf.coerce(error, to: Google::Rpc::Status), request.error
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :expand, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "expand"

      Google::Showcase::V1beta1::Echo::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Echo::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Echo::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.expand content, error
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "collect" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1beta1::Echo::Client#collect."
    end

    it "invokes collect without error" do
      # Create request parameters
      request = {}

      # Create expected grpc response
      expected_response = Gapic::Protobuf.coerce {}, to: Google::Showcase::V1beta1::EchoResponse

      # Mock Grpc layer
      mock_method = proc do |requests|
        request = requests.first
        OpenStruct.new execute: [expected_response]
      end
      mock_stub = MockGrpcClientStubV1.new :collect, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "collect"

      Google::Showcase::V1beta1::Echo::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Echo::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Echo::Client.new

          # Call method
          response = client.collect [request]

          # Verify the response
          assert_equal expected_response, response
        end
      end
    end

    it "invokes collect with error" do
      # Create request parameters
      request = {}

      # Mock Grpc layer
      mock_method = proc { raise custom_error }
      mock_stub = MockGrpcClientStubV1.new :collect, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "collect"

      Google::Showcase::V1beta1::Echo::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Echo::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Echo::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.collect [request]
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "chat" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1beta1::Echo::Client#chat."
    end

    it "invokes chat without error" do
      # Create request parameters
      request = {}

      # Create expected grpc response
      expected_response = Gapic::Protobuf.coerce {}, to: Google::Showcase::V1beta1::EchoResponse

      # Mock Grpc layer
      mock_method = proc do |requests|
        request = requests.first
        OpenStruct.new execute: [expected_response]
      end
      mock_stub = MockGrpcClientStubV1.new :chat, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "chat"

      Google::Showcase::V1beta1::Echo::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Echo::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Echo::Client.new

          # Call method
          response = client.chat [request]

          # Verify the response
          assert_equal 1, response.count
          assert_equal expected_response, response.first
        end
      end
    end

    it "invokes chat with error" do
      # Create request parameters
      request = {}

      # Mock Grpc layer
      mock_method = proc { raise custom_error }
      mock_stub = MockGrpcClientStubV1.new :chat, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "chat"

      Google::Showcase::V1beta1::Echo::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Echo::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Echo::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.chat [request]
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "paged_expand" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1beta1::Echo::Client#paged_expand."
    end

    it "invokes paged_expand without error" do
      # Create request parameters
      content = "hello world"
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      expected_response = Gapic::Protobuf.coerce {}, to: Google::Showcase::V1beta1::PagedExpandResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::PagedExpandRequest, request
      assert_equal content, request.content
      assert_equal page_size, request.page_size
      assert_equal page_token, request.page_token
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :paged_expand, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "paged_expand"

      Google::Showcase::V1beta1::Echo::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Echo::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Echo::Client.new

          # Call method
          response = client.paged_expand content, page_size, page_token

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.paged_expand content, page_size, page_token do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes paged_expand with error" do
      # Create request parameters
      content = "hello world"
      page_size = 42
      page_token = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::PagedExpandRequest, request
      assert_equal content, request.content
      assert_equal page_size, request.page_size
      assert_equal page_token, request.page_token
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :paged_expand, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "paged_expand"

      Google::Showcase::V1beta1::Echo::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Echo::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Echo::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.paged_expand content, page_size, page_token
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "wait" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1beta1::Echo::Client#wait."
    end

    it "invokes wait without error" do
      # Create request parameters
      end_time = {}
      ttl = {}
      error = {}
      success = {}

      # Create expected grpc response
      expected_response = Gapic::Protobuf.coerce {}, to: Google::Longrunning::Operation
      result = Google::Protobuf::Any.new
      result.pack expected_response
      operation = Google::Longrunning::Operation.new(
        name: "operations/wait_test",
        done: true,
        response: result
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::WaitRequest, request
      assert_equal Gapic::Protobuf.coerce(end_time, to: Google::Protobuf::Timestamp), request.end_time
      assert_equal Gapic::Protobuf.coerce(ttl, to: Google::Protobuf::Duration), request.ttl
      assert_equal Gapic::Protobuf.coerce(error, to: Google::Rpc::Status), request.error
      assert_equal Gapic::Protobuf.coerce(success, to: Google::Showcase::V1beta1::WaitResponse), request.success
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :wait, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "wait"

      Google::Showcase::V1beta1::Echo::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Echo::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Echo::Client.new

          # Call method
          response = client.wait end_time, ttl, error, success

          # Verify the response
          assert_equal expected_response, response.response
        end
      end
    end

    it "invokes wait and returns an operation error." do
      # Create request parameters
      end_time = {}
      ttl = {}
      error = {}
      success = {}

      # Create expected grpc response
      operation_error = Google::Rpc::Status.new(
        message: "Operation error for Google::Showcase::V1beta1::Echo::Client#wait."
      )
      operation = Google::Longrunning::Operation.new(
        name: "operations/wait_test",
        done: true,
        error: operation_error
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::WaitRequest, request
      assert_equal Gapic::Protobuf.coerce(end_time, to: Google::Protobuf::Timestamp), request.end_time
      assert_equal Gapic::Protobuf.coerce(ttl, to: Google::Protobuf::Duration), request.ttl
      assert_equal Gapic::Protobuf.coerce(error, to: Google::Rpc::Status), request.error
      assert_equal Gapic::Protobuf.coerce(success, to: Google::Showcase::V1beta1::WaitResponse), request.success
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :wait, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "wait"

      Google::Showcase::V1beta1::Echo::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Echo::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Echo::Client.new

          # Call method
          response = client.wait end_time, ttl, error, success

          # Verify the response
          assert response.error?
          assert_equal operation_error, response.error
        end
      end
    end

    it "invokes wait with error" do
      # Create request parameters
      end_time = {}
      ttl = {}
      error = {}
      success = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::WaitRequest, request
      assert_equal Gapic::Protobuf.coerce(end_time, to: Google::Protobuf::Timestamp), request.end_time
      assert_equal Gapic::Protobuf.coerce(ttl, to: Google::Protobuf::Duration), request.ttl
      assert_equal Gapic::Protobuf.coerce(error, to: Google::Rpc::Status), request.error
      assert_equal Gapic::Protobuf.coerce(success, to: Google::Showcase::V1beta1::WaitResponse), request.success
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :wait, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "wait"

      Google::Showcase::V1beta1::Echo::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Echo::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Echo::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.wait end_time, ttl, error, success
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "block" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1beta1::Echo::Client#block."
    end

    it "invokes block without error" do
      # Create request parameters
      response_delay = {}
      error = {}
      success = {}

      # Create expected grpc response
      expected_response = Gapic::Protobuf.coerce {}, to: Google::Showcase::V1beta1::BlockResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::BlockRequest, request
      assert_equal Gapic::Protobuf.coerce(response_delay, to: Google::Protobuf::Duration), request.response_delay
      assert_equal Gapic::Protobuf.coerce(error, to: Google::Rpc::Status), request.error
      assert_equal Gapic::Protobuf.coerce(success, to: Google::Showcase::V1beta1::BlockResponse), request.success
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :block, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "block"

      Google::Showcase::V1beta1::Echo::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Echo::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Echo::Client.new

          # Call method
          response = client.block response_delay, error, success

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.block response_delay, error, success do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes block with error" do
      # Create request parameters
      response_delay = {}
      error = {}
      success = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::BlockRequest, request
      assert_equal Gapic::Protobuf.coerce(response_delay, to: Google::Protobuf::Duration), request.response_delay
      assert_equal Gapic::Protobuf.coerce(error, to: Google::Rpc::Status), request.error
      assert_equal Gapic::Protobuf.coerce(success, to: Google::Showcase::V1beta1::BlockResponse), request.success
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :block, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "block"

      Google::Showcase::V1beta1::Echo::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Echo::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Echo::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.block response_delay, error, success
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end
end
