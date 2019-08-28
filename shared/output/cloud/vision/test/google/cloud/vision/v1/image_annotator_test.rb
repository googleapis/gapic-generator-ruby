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

describe Google::Cloud::Vision::V1::ImageAnnotator::Client do
  before :all do
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
  end

  describe "batch_annotate_images" do
    it "invokes batch_annotate_images without error" do
      # Create request parameters
      requests = [{}]
      parent = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Cloud::Vision::V1::ImageAnnotator::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :batch_annotate_images && !options.nil? &&
              Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AnnotateImageRequest) == request.requests &&
              request.parent == "hello world"
          end
        end

        # Call method
        response = client.batch_annotate_images requests: requests, parent: parent
        assert_equal mock_response, response

        # Call method with block
        client.batch_annotate_images requests: requests, parent: parent do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "batch_annotate_files" do
    it "invokes batch_annotate_files without error" do
      # Create request parameters
      requests = [{}]
      parent = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Cloud::Vision::V1::ImageAnnotator::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :batch_annotate_files && !options.nil? &&
              Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AnnotateFileRequest) == request.requests &&
              request.parent == "hello world"
          end
        end

        # Call method
        response = client.batch_annotate_files requests: requests, parent: parent
        assert_equal mock_response, response

        # Call method with block
        client.batch_annotate_files requests: requests, parent: parent do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "async_batch_annotate_images" do
    it "invokes async_batch_annotate_images without error" do
      # Create request parameters
      requests = [{}]
      output_config = {}
      parent = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Cloud::Vision::V1::ImageAnnotator::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :async_batch_annotate_images && !options.nil? &&
              Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AnnotateImageRequest) == request.requests &&
              Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::OutputConfig) == request.output_config &&
              request.parent == "hello world"
          end
        end

        # Call method
        response = client.async_batch_annotate_images requests: requests, output_config: output_config, parent: parent
        assert_equal mock_response, response

        # Call method with block
        client.async_batch_annotate_images requests: requests, output_config: output_config, parent: parent do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "async_batch_annotate_files" do
    it "invokes async_batch_annotate_files without error" do
      # Create request parameters
      requests = [{}]
      parent = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Cloud::Vision::V1::ImageAnnotator::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :async_batch_annotate_files && !options.nil? &&
              Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AsyncAnnotateFileRequest) == request.requests &&
              request.parent == "hello world"
          end
        end

        # Call method
        response = client.async_batch_annotate_files requests: requests, parent: parent
        assert_equal mock_response, response

        # Call method with block
        client.async_batch_annotate_files requests: requests, parent: parent do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end
end
