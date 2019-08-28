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

require "google/cloud/vision/v1/image_annotator_pb"
require "google/cloud/vision/v1/image_annotator_services_pb"
require "google/cloud/vision/v1/image_annotator"

class Google::Cloud::Vision::V1::ImageAnnotator::OperationsTest < Minitest::Test
  def setup
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
  end

  def test_list_operations
    # Create request parameters
    name = "hello world"
    filter = "hello world"
    page_size = 42
    page_token = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :list_operations && !options.nil? &&
            request.name == "hello world" &&
            request.filter == "hello world" &&
            request.page_size == 42 &&
            request.page_token == "hello world"
        end
      end

      # Call method
      response = client.list_operations name: name, filter: filter, page_size: page_size, page_token: page_token
      assert_equal mock_response, response

      # Call method with block
      client.list_operations name: name, filter: filter, page_size: page_size, page_token: page_token do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_get_operation
    # Create request parameters
    name = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :get_operation && !options.nil? &&
            request.name == "hello world"
        end
      end

      # Call method
      response = client.get_operation name: name
      assert_equal mock_response, response

      # Call method with block
      client.get_operation name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_delete_operation
    # Create request parameters
    name = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :delete_operation && !options.nil? &&
            request.name == "hello world"
        end
      end

      # Call method
      response = client.delete_operation name: name
      assert_equal mock_response, response

      # Call method with block
      client.delete_operation name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_cancel_operation
    # Create request parameters
    name = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Operations.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :cancel_operation && !options.nil? &&
            request.name == "hello world"
        end
      end

      # Call method
      response = client.cancel_operation name: name
      assert_equal mock_response, response

      # Call method with block
      client.cancel_operation name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end
end
