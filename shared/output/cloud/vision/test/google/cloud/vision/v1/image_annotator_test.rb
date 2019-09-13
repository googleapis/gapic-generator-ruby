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
