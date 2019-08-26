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

require "minitest/autorun"

require "google/cloud/vision/v1/image_annotator_pb"
require "google/cloud/vision/v1/image_annotator_services_pb"
require "google/cloud/vision/v1/image_annotator"

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

class MockImageAnnotatorCredentialsV1 < Google::Cloud::Vision::V1::ImageAnnotator::Credentials
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

describe Google::Cloud::Vision::V1::ImageAnnotator::Operations do
  describe "list_operations" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ImageAnnotator::Operations#list_operations."
    end

    it "invokes list_operations without error" do
      # Create request parameters
      name = "hello world"
      filter = "hello world"
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Gapic::Protobuf.coerce expected_response, to: Google::Longrunning::ListOperationsResponse
      result = Google::Protobuf::Any.new
      result.pack expected_response
      operation = Google::Longrunning::Operation.new(
        name: "operations/list_operations_test",
        done: true,
        response: result
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Longrunning::ListOperationsRequest, request
        assert_equal Gapic::Protobuf.coerce(name, to: ), request.name
        assert_equal Gapic::Protobuf.coerce(filter, to: ), request.filter
        assert_equal Gapic::Protobuf.coerce(page_size, to: ), request.page_size
        assert_equal Gapic::Protobuf.coerce(page_token, to: ), request.page_token
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :list_operations, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_operations"

      Google::Longrunning::Operations::Stub.stub :new, mock_stub do
        Google::Longrunning::Operations::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new

          # Call method
          response = client.list_operations name, filter, page_size, page_token

          # Verify the response
          assert_equal expected_response, response.response
        end
      end
    end

    it "invokes list_operations and returns an operation error." do
      # Create request parameters
      name = "hello world"
      filter = "hello world"
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      operation_error = Google::Rpc::Status.new(
        message: "Operation error for Google::Cloud::Vision::V1::ImageAnnotator::Operations#list_operations."
      )
      operation = Google::Longrunning::Operation.new(
        name: "operations/list_operations_test",
        done: true,
        error: operation_error
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Longrunning::ListOperationsRequest, request
        assert_equal Gapic::Protobuf.coerce(name, to: ), request.name
        assert_equal Gapic::Protobuf.coerce(filter, to: ), request.filter
        assert_equal Gapic::Protobuf.coerce(page_size, to: ), request.page_size
        assert_equal Gapic::Protobuf.coerce(page_token, to: ), request.page_token
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :list_operations, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_operations"

      Google::Longrunning::Operations::Stub.stub :new, mock_stub do
        Google::Longrunning::Operations::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new

          # Call method
          response = client.list_operations name, filter, page_size, page_token

          # Verify the response
          assert response.error?
          assert_equal operation_error, response.error
        end
      end
    end

    it "invokes list_operations with error" do
      # Create request parameters
      name = "hello world"
      filter = "hello world"
      page_size = 42
      page_token = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Longrunning::ListOperationsRequest, request
        assert_equal Gapic::Protobuf.coerce(name, to: ), request.name
        assert_equal Gapic::Protobuf.coerce(filter, to: ), request.filter
        assert_equal Gapic::Protobuf.coerce(page_size, to: ), request.page_size
        assert_equal Gapic::Protobuf.coerce(page_token, to: ), request.page_token
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :list_operations, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_operations"

      Google::Longrunning::Operations::Stub.stub :new, mock_stub do
        Google::Longrunning::Operations::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.list_operations name, filter, page_size, page_token
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "get_operation" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ImageAnnotator::Operations#get_operation."
    end

    it "invokes get_operation without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Gapic::Protobuf.coerce expected_response, to: Google::Longrunning::Operation
      result = Google::Protobuf::Any.new
      result.pack expected_response
      operation = Google::Longrunning::Operation.new(
        name: "operations/get_operation_test",
        done: true,
        response: result
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Longrunning::GetOperationRequest, request
        assert_equal Gapic::Protobuf.coerce(name, to: ), request.name
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :get_operation, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_operation"

      Google::Longrunning::Operations::Stub.stub :new, mock_stub do
        Google::Longrunning::Operations::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new

          # Call method
          response = client.get_operation name

          # Verify the response
          assert_equal expected_response, response.response
        end
      end
    end

    it "invokes get_operation and returns an operation error." do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      operation_error = Google::Rpc::Status.new(
        message: "Operation error for Google::Cloud::Vision::V1::ImageAnnotator::Operations#get_operation."
      )
      operation = Google::Longrunning::Operation.new(
        name: "operations/get_operation_test",
        done: true,
        error: operation_error
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Longrunning::GetOperationRequest, request
        assert_equal Gapic::Protobuf.coerce(name, to: ), request.name
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :get_operation, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_operation"

      Google::Longrunning::Operations::Stub.stub :new, mock_stub do
        Google::Longrunning::Operations::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new

          # Call method
          response = client.get_operation name

          # Verify the response
          assert response.error?
          assert_equal operation_error, response.error
        end
      end
    end

    it "invokes get_operation with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Longrunning::GetOperationRequest, request
        assert_equal Gapic::Protobuf.coerce(name, to: ), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :get_operation, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_operation"

      Google::Longrunning::Operations::Stub.stub :new, mock_stub do
        Google::Longrunning::Operations::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.get_operation name
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "delete_operation" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ImageAnnotator::Operations#delete_operation."
    end

    it "invokes delete_operation without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Gapic::Protobuf.coerce expected_response, to: Google::Protobuf::Empty

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Longrunning::DeleteOperationRequest, request
        assert_equal Gapic::Protobuf.coerce(name, to: ), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :delete_operation, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_operation"

      Google::Longrunning::Operations::Stub.stub :new, mock_stub do
        Google::Longrunning::Operations::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new

          # Call method
          response = client.delete_operation name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.delete_operation name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes delete_operation with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Longrunning::DeleteOperationRequest, request
        assert_equal Gapic::Protobuf.coerce(name, to: ), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :delete_operation, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_operation"

      Google::Longrunning::Operations::Stub.stub :new, mock_stub do
        Google::Longrunning::Operations::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.delete_operation name
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "cancel_operation" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ImageAnnotator::Operations#cancel_operation."
    end

    it "invokes cancel_operation without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Gapic::Protobuf.coerce expected_response, to: Google::Protobuf::Empty

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Longrunning::CancelOperationRequest, request
        assert_equal Gapic::Protobuf.coerce(name, to: ), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :cancel_operation, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "cancel_operation"

      Google::Longrunning::Operations::Stub.stub :new, mock_stub do
        Google::Longrunning::Operations::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new

          # Call method
          response = client.cancel_operation name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.cancel_operation name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes cancel_operation with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Longrunning::CancelOperationRequest, request
        assert_equal Gapic::Protobuf.coerce(name, to: ), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :cancel_operation, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "cancel_operation"

      Google::Longrunning::Operations::Stub.stub :new, mock_stub do
        Google::Longrunning::Operations::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.cancel_operation name
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

end
