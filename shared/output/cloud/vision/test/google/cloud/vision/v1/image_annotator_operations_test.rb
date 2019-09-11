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

require "google/cloud/vision/v1/image_annotator_pb"
require "google/cloud/vision/v1/image_annotator_services_pb"
require "google/cloud/vision/v1/image_annotator"

class Google::Cloud::Vision::V1::ImageAnnotator::OperationsTest < Minitest::Test
  def setup
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    @mock_stub = MiniTest::Mock.new
    @response = {}
    @options = {}
  end

  def test_list_operations
    # Create request parameters
    name = "hello world"
    filter = "hello world"
    page_size = 42
    page_token = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :list_operations
          has_options = !options.nil?
          has_fields = request.name == "hello world" && request.filter == "hello world" && request.page_size == 42 && request.page_token == "hello world"

          assert has_name, "invalid method call: #{name} (expected list_operations)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.list_operations name: name, filter: filter, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.list_operations Google::Longrunning::ListOperationsRequest.new(name: name, filter: filter, page_size: page_size, page_token: page_token)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.list_operations request = { name: name, filter: filter, page_size: page_size, page_token: page_token }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.list_operations request = Google::Longrunning::ListOperationsRequest.new name: name, filter: filter, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.list_operations({ name: name, filter: filter, page_size: page_size, page_token: page_token }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.list_operations Google::Longrunning::ListOperationsRequest.new(name: name, filter: filter, page_size: page_size, page_token: page_token), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.list_operations request = { name: name, filter: filter, page_size: page_size, page_token: page_token }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.list_operations request = Google::Longrunning::ListOperationsRequest.new name: name, filter: filter, page_size: page_size, page_token: page_token, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_get_operation
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :get_operation
          has_options = !options.nil?
          has_fields = request.name == "hello world"

          assert has_name, "invalid method call: #{name} (expected get_operation)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.get_operation name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.get_operation Google::Longrunning::GetOperationRequest.new(name: name)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.get_operation request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.get_operation request = Google::Longrunning::GetOperationRequest.new name: name
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.get_operation({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.get_operation Google::Longrunning::GetOperationRequest.new(name: name), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.get_operation request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.get_operation request = Google::Longrunning::GetOperationRequest.new name: name, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_delete_operation
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :delete_operation
          has_options = !options.nil?
          has_fields = request.name == "hello world"

          assert has_name, "invalid method call: #{name} (expected delete_operation)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.delete_operation name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.delete_operation Google::Longrunning::DeleteOperationRequest.new(name: name)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.delete_operation request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.delete_operation request = Google::Longrunning::DeleteOperationRequest.new name: name
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.delete_operation({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.delete_operation Google::Longrunning::DeleteOperationRequest.new(name: name), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.delete_operation request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.delete_operation request = Google::Longrunning::DeleteOperationRequest.new name: name, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_cancel_operation
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :cancel_operation
          has_options = !options.nil?
          has_fields = request.name == "hello world"

          assert has_name, "invalid method call: #{name} (expected cancel_operation)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.cancel_operation name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.cancel_operation Google::Longrunning::CancelOperationRequest.new(name: name)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.cancel_operation request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.cancel_operation request = Google::Longrunning::CancelOperationRequest.new name: name
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.cancel_operation({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.cancel_operation Google::Longrunning::CancelOperationRequest.new(name: name), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.cancel_operation request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.cancel_operation request = Google::Longrunning::CancelOperationRequest.new name: name, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
    end
  end
end
