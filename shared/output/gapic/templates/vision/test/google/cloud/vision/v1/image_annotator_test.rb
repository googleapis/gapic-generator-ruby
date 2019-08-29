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
    @response = {}
    @options = {}
    @operation_callback = -> { raise "Operation callback was executed!" }
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

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:|
          has_name = name == :batch_annotate_images
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AnnotateImageRequest) == request.requests &&

            request.parent == "hello world"

          assert has_name, "invalid method call: #{name} (expected batch_annotate_images)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.batch_annotate_images requests: requests, parent: parent
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.batch_annotate_images(Google::Cloud::Vision::V1::BatchAnnotateImagesRequest.new(
                                                requests: requests, parent: parent
                                              ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.batch_annotate_images request = { requests: requests, parent: parent }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.batch_annotate_images request = Google::Cloud::Vision::V1::BatchAnnotateImagesRequest.new(
        requests: requests, parent: parent
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.batch_annotate_images({ requests: requests, parent: parent }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.batch_annotate_images(Google::Cloud::Vision::V1::BatchAnnotateImagesRequest.new(
                                                requests: requests, parent: parent
                                              ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.batch_annotate_images request = { requests: requests, parent: parent }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.batch_annotate_images request = Google::Cloud::Vision::V1::BatchAnnotateImagesRequest.new(
        requests: requests, parent: parent
      ), options = @options, &@operation_callback
      assert_equal @response, response

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

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:|
          has_name = name == :batch_annotate_files
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AnnotateFileRequest) == request.requests &&

            request.parent == "hello world"

          assert has_name, "invalid method call: #{name} (expected batch_annotate_files)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.batch_annotate_files requests: requests, parent: parent
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.batch_annotate_files(Google::Cloud::Vision::V1::BatchAnnotateFilesRequest.new(
                                               requests: requests, parent: parent
                                             ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.batch_annotate_files request = { requests: requests, parent: parent }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.batch_annotate_files request = Google::Cloud::Vision::V1::BatchAnnotateFilesRequest.new(
        requests: requests, parent: parent
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.batch_annotate_files({ requests: requests, parent: parent }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.batch_annotate_files(Google::Cloud::Vision::V1::BatchAnnotateFilesRequest.new(
                                               requests: requests, parent: parent
                                             ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.batch_annotate_files request = { requests: requests, parent: parent }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.batch_annotate_files request = Google::Cloud::Vision::V1::BatchAnnotateFilesRequest.new(
        requests: requests, parent: parent
      ), options = @options, &@operation_callback
      assert_equal @response, response

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

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:, format_response:|
          has_name = name == :async_batch_annotate_images
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AnnotateImageRequest) == request.requests &&

            Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::OutputConfig) == request.output_config &&

            request.parent == "hello world"

          assert has_name, "invalid method call: #{name} (expected async_batch_annotate_images)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.async_batch_annotate_images requests: requests, output_config: output_config, parent: parent
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.async_batch_annotate_images(Google::Cloud::Vision::V1::AsyncBatchAnnotateImagesRequest.new(
                                                      requests: requests, output_config: output_config, parent: parent
                                                    ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.async_batch_annotate_images request = { requests: requests, output_config: output_config, parent: parent }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.async_batch_annotate_images request = Google::Cloud::Vision::V1::AsyncBatchAnnotateImagesRequest.new(
        requests: requests, output_config: output_config, parent: parent
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.async_batch_annotate_images({ requests: requests, output_config: output_config, parent: parent }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.async_batch_annotate_images(Google::Cloud::Vision::V1::AsyncBatchAnnotateImagesRequest.new(
                                                      requests: requests, output_config: output_config, parent: parent
                                                    ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.async_batch_annotate_images request = { requests: requests, output_config: output_config, parent: parent }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.async_batch_annotate_images request = Google::Cloud::Vision::V1::AsyncBatchAnnotateImagesRequest.new(
        requests: requests, output_config: output_config, parent: parent
      ), options = @options, &@operation_callback
      assert_equal @response, response

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

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:, format_response:|
          has_name = name == :async_batch_annotate_files
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            Gapic::Protobuf.coerce([{}], to: Google::Cloud::Vision::V1::AsyncAnnotateFileRequest) == request.requests &&

            request.parent == "hello world"

          assert has_name, "invalid method call: #{name} (expected async_batch_annotate_files)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.async_batch_annotate_files requests: requests, parent: parent
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.async_batch_annotate_files(Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest.new(
                                                     requests: requests, parent: parent
                                                   ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.async_batch_annotate_files request = { requests: requests, parent: parent }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.async_batch_annotate_files request = Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest.new(
        requests: requests, parent: parent
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.async_batch_annotate_files({ requests: requests, parent: parent }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.async_batch_annotate_files(Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest.new(
                                                     requests: requests, parent: parent
                                                   ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.async_batch_annotate_files request = { requests: requests, parent: parent }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.async_batch_annotate_files request = Google::Cloud::Vision::V1::AsyncBatchAnnotateFilesRequest.new(
        requests: requests, parent: parent
      ), options = @options, &@operation_callback
      assert_equal @response, response

      @mock_stub.verify
    end
  end
end
