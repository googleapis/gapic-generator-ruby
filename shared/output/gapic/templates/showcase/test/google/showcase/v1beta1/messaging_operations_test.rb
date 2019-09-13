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

require "gapic/grpc/service_stub"

require "google/showcase/v1beta1/messaging_pb"
require "google/showcase/v1beta1/messaging_services_pb"
require "google/showcase/v1beta1/messaging"

class Google::Showcase::V1beta1::Messaging::OperationsTest < Minitest::Test
  def setup
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    @mock_stub = MiniTest::Mock.new
    @mock_page_enum = :mock_page_enum
    @response = :mock_response
    @grpc_operation = :mock_grpc_operation
    @options = {}
  end

  def with_stubs
    Gapic::ServiceStub.stub :new, @mock_stub do
      Gapic::PagedEnumerable.stub :new, @mock_page_enum do
        yield
      end
    end
  end

  def test_list_operations
    # Create request parameters
    name = "hello world"
    filter = "hello world"
    page_size = 42
    page_token = "hello world"

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Operations.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :list_operations, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name
          assert_equal "hello world", request.filter
          assert_equal 42, request.page_size
          assert_equal "hello world", request.page_token

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.list_operations name: name, filter: filter, page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.list_operations(Google::Longrunning::ListOperationsRequest.new(name: name, filter: filter, page_size: page_size, page_token: page_token)) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.list_operations request = { name: name, filter: filter, page_size: page_size, page_token: page_token } do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.list_operations request = Google::Longrunning::ListOperationsRequest.new({ name: name, filter: filter, page_size: page_size, page_token: page_token }) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.list_operations({ name: name, filter: filter, page_size: page_size, page_token: page_token }, @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.list_operations(Google::Longrunning::ListOperationsRequest.new(name: name, filter: filter, page_size: page_size, page_token: page_token), @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.list_operations(request = { name: name, filter: filter, page_size: page_size, page_token: page_token }, options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.list_operations(request = Google::Longrunning::ListOperationsRequest.new({ name: name, filter: filter, page_size: page_size, page_token: page_token }), options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_get_operation
    # Create request parameters
    name = "hello world"

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Operations.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :get_operation, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.get_operation name: name do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.get_operation(Google::Longrunning::GetOperationRequest.new(name: name)) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.get_operation request = { name: name } do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.get_operation request = Google::Longrunning::GetOperationRequest.new({ name: name }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.get_operation({ name: name }, @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.get_operation(Google::Longrunning::GetOperationRequest.new(name: name), @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.get_operation(request = { name: name }, options = @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.get_operation(request = Google::Longrunning::GetOperationRequest.new({ name: name }), options = @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_delete_operation
    # Create request parameters
    name = "hello world"

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Operations.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :delete_operation, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.delete_operation name: name do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.delete_operation(Google::Longrunning::DeleteOperationRequest.new(name: name)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.delete_operation request = { name: name } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.delete_operation request = Google::Longrunning::DeleteOperationRequest.new({ name: name }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.delete_operation({ name: name }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.delete_operation(Google::Longrunning::DeleteOperationRequest.new(name: name), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.delete_operation(request = { name: name }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.delete_operation(request = Google::Longrunning::DeleteOperationRequest.new({ name: name }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_cancel_operation
    # Create request parameters
    name = "hello world"

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Operations.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :cancel_operation, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.cancel_operation name: name do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.cancel_operation(Google::Longrunning::CancelOperationRequest.new(name: name)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.cancel_operation request = { name: name } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.cancel_operation request = Google::Longrunning::CancelOperationRequest.new({ name: name }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.cancel_operation({ name: name }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.cancel_operation(Google::Longrunning::CancelOperationRequest.new(name: name), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.cancel_operation(request = { name: name }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.cancel_operation(request = Google::Longrunning::CancelOperationRequest.new({ name: name }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

end
