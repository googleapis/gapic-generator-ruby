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

class Google::Cloud::Vision::V1::ImageAnnotator::ClientTest < Minitest::Test
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

  def test_batch_annotate_images
    # Create request parameters
    requests = [{}]
    parent = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :batch_annotate_images, name
          refute_nil options
          refute_nil block
          assert_equal Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AnnotateImageRequest), request.requests
          assert_equal "hello world", request.parent

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.batch_annotate_images requests: requests, parent: parent do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.batch_annotate_images(Google::Cloud::Vision::V1::BatchAnnotateImagesRequest.new(requests: requests, parent: parent)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.batch_annotate_images request = { requests: requests, parent: parent } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.batch_annotate_images request = Google::Cloud::Vision::V1::BatchAnnotateImagesRequest.new({ requests: requests, parent: parent }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.batch_annotate_images({ requests: requests, parent: parent }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.batch_annotate_images(Google::Cloud::Vision::V1::BatchAnnotateImagesRequest.new(requests: requests, parent: parent), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.batch_annotate_images(request = { requests: requests, parent: parent }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.batch_annotate_images(request = Google::Cloud::Vision::V1::BatchAnnotateImagesRequest.new({ requests: requests, parent: parent }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_batch_annotate_files
    # Create request parameters
    requests = [{}]
    parent = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :batch_annotate_files, name
          refute_nil options
          refute_nil block
          assert_equal Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AnnotateFileRequest), request.requests
          assert_equal "hello world", request.parent

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.batch_annotate_files requests: requests, parent: parent do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.batch_annotate_files(Google::Cloud::Vision::V1::BatchAnnotateFilesRequest.new(requests: requests, parent: parent)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.batch_annotate_files request = { requests: requests, parent: parent } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.batch_annotate_files request = Google::Cloud::Vision::V1::BatchAnnotateFilesRequest.new({ requests: requests, parent: parent }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.batch_annotate_files({ requests: requests, parent: parent }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.batch_annotate_files(Google::Cloud::Vision::V1::BatchAnnotateFilesRequest.new(requests: requests, parent: parent), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.batch_annotate_files(request = { requests: requests, parent: parent }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.batch_annotate_files(request = Google::Cloud::Vision::V1::BatchAnnotateFilesRequest.new({ requests: requests, parent: parent }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_async_batch_annotate_images
    # Create request parameters
    requests = [{}]
    output_config = {}
    parent = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :async_batch_annotate_images, name
          refute_nil options
          refute_nil block
          assert_equal Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AnnotateImageRequest), request.requests
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::OutputConfig), request.output_config
          assert_equal "hello world", request.parent

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.async_batch_annotate_images requests: requests, output_config: output_config, parent: parent do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.async_batch_annotate_images(Google::Cloud::Vision::V1::AsyncBatchAnnotateImagesRequest.new(requests: requests, output_config: output_config, parent: parent)) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.async_batch_annotate_images request = { requests: requests, output_config: output_config, parent: parent } do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.async_batch_annotate_images request = Google::Cloud::Vision::V1::AsyncBatchAnnotateImagesRequest.new({ requests: requests, output_config: output_config, parent: parent }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.async_batch_annotate_images({ requests: requests, output_config: output_config, parent: parent }, @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.async_batch_annotate_images(Google::Cloud::Vision::V1::AsyncBatchAnnotateImagesRequest.new(requests: requests, output_config: output_config, parent: parent), @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.async_batch_annotate_images(request = { requests: requests, output_config: output_config, parent: parent }, options = @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.async_batch_annotate_images(request = Google::Cloud::Vision::V1::AsyncBatchAnnotateImagesRequest.new({ requests: requests, output_config: output_config, parent: parent }), options = @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_async_batch_annotate_files
    # Create request parameters
    requests = [{}]
    parent = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :async_batch_annotate_files, name
          refute_nil options
          refute_nil block
          assert_equal Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AsyncAnnotateFileRequest), request.requests
          assert_equal "hello world", request.parent

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.async_batch_annotate_files requests: requests, parent: parent do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.async_batch_annotate_files(Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest.new(requests: requests, parent: parent)) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.async_batch_annotate_files request = { requests: requests, parent: parent } do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.async_batch_annotate_files request = Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest.new({ requests: requests, parent: parent }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.async_batch_annotate_files({ requests: requests, parent: parent }, @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.async_batch_annotate_files(Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest.new(requests: requests, parent: parent), @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.async_batch_annotate_files(request = { requests: requests, parent: parent }, options = @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.async_batch_annotate_files(request = Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest.new({ requests: requests, parent: parent }), options = @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end
end
