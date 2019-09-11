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
    @response = {}
    @options = {}
  end

  def test_batch_annotate_images
    # Create request parameters
    requests = [{}]
    parent = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :batch_annotate_images
          has_options = !options.nil?
          has_fields = Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AnnotateImageRequest) == request.requests && request.parent == "hello world"

          assert has_name, "invalid method call: #{name} (expected batch_annotate_images)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.batch_annotate_images requests: requests, parent: parent
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.batch_annotate_images Google::Cloud::Vision::V1::BatchAnnotateImagesRequest.new(requests: requests, parent: parent)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.batch_annotate_images request = { requests: requests, parent: parent }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.batch_annotate_images request = Google::Cloud::Vision::V1::BatchAnnotateImagesRequest.new requests: requests, parent: parent
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.batch_annotate_images({ requests: requests, parent: parent }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.batch_annotate_images Google::Cloud::Vision::V1::BatchAnnotateImagesRequest.new(requests: requests, parent: parent), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.batch_annotate_images request = { requests: requests, parent: parent }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.batch_annotate_images request = Google::Cloud::Vision::V1::BatchAnnotateImagesRequest.new requests: requests, parent: parent, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_batch_annotate_files
    # Create request parameters
    requests = [{}]
    parent = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :batch_annotate_files
          has_options = !options.nil?
          has_fields = Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AnnotateFileRequest) == request.requests && request.parent == "hello world"

          assert has_name, "invalid method call: #{name} (expected batch_annotate_files)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.batch_annotate_files requests: requests, parent: parent
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.batch_annotate_files Google::Cloud::Vision::V1::BatchAnnotateFilesRequest.new(requests: requests, parent: parent)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.batch_annotate_files request = { requests: requests, parent: parent }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.batch_annotate_files request = Google::Cloud::Vision::V1::BatchAnnotateFilesRequest.new requests: requests, parent: parent
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.batch_annotate_files({ requests: requests, parent: parent }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.batch_annotate_files Google::Cloud::Vision::V1::BatchAnnotateFilesRequest.new(requests: requests, parent: parent), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.batch_annotate_files request = { requests: requests, parent: parent }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.batch_annotate_files request = Google::Cloud::Vision::V1::BatchAnnotateFilesRequest.new requests: requests, parent: parent, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_async_batch_annotate_images
    # Create request parameters
    requests = [{}]
    output_config = {}
    parent = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :async_batch_annotate_images
          has_options = !options.nil?
          has_fields = Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AnnotateImageRequest) == request.requests && Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::OutputConfig) == request.output_config && request.parent == "hello world"

          assert has_name, "invalid method call: #{name} (expected async_batch_annotate_images)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.async_batch_annotate_images requests: requests, output_config: output_config, parent: parent
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.async_batch_annotate_images Google::Cloud::Vision::V1::AsyncBatchAnnotateImagesRequest.new(requests: requests, output_config: output_config, parent: parent)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.async_batch_annotate_images request = { requests: requests, output_config: output_config, parent: parent }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.async_batch_annotate_images request = Google::Cloud::Vision::V1::AsyncBatchAnnotateImagesRequest.new requests: requests, output_config: output_config, parent: parent
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.async_batch_annotate_images({ requests: requests, output_config: output_config, parent: parent }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.async_batch_annotate_images Google::Cloud::Vision::V1::AsyncBatchAnnotateImagesRequest.new(requests: requests, output_config: output_config, parent: parent), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.async_batch_annotate_images request = { requests: requests, output_config: output_config, parent: parent }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.async_batch_annotate_images request = Google::Cloud::Vision::V1::AsyncBatchAnnotateImagesRequest.new requests: requests, output_config: output_config, parent: parent, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_async_batch_annotate_files
    # Create request parameters
    requests = [{}]
    parent = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ImageAnnotator::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :async_batch_annotate_files
          has_options = !options.nil?
          has_fields = Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AsyncAnnotateFileRequest) == request.requests && request.parent == "hello world"

          assert has_name, "invalid method call: #{name} (expected async_batch_annotate_files)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.async_batch_annotate_files requests: requests, parent: parent
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.async_batch_annotate_files Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest.new(requests: requests, parent: parent)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.async_batch_annotate_files request = { requests: requests, parent: parent }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.async_batch_annotate_files request = Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest.new requests: requests, parent: parent
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.async_batch_annotate_files({ requests: requests, parent: parent }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.async_batch_annotate_files Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest.new(requests: requests, parent: parent), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.async_batch_annotate_files request = { requests: requests, parent: parent }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.async_batch_annotate_files request = Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest.new requests: requests, parent: parent, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
    end
  end
end
