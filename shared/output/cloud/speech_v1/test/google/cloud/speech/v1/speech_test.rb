# frozen_string_literal: true

# Copyright 2020 Google LLC
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

require "helper"

require "gapic/grpc/service_stub"

require "google/cloud/speech/v1/cloud_speech_pb"
require "google/cloud/speech/v1/cloud_speech_services_pb"
require "google/cloud/speech/v1/speech"

class ::Google::Cloud::Speech::V1::Speech::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_rpc_count, :requests

    def initialize response, operation, &block
      @response = response
      @operation = operation
      @block = block
      @call_rpc_count = 0
      @requests = []
    end

    def call_rpc *args
      @call_rpc_count += 1

      @requests << @block&.call(*args)

      yield @response, @operation if block_given?

      @response
    end
  end

  def test_recognize
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Speech::V1::RecognizeResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    config = {}
    audio = {}

    recognize_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :recognize, name
      assert_kind_of ::Google::Cloud::Speech::V1::RecognizeRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Speech::V1::RecognitionConfig), request.config
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Speech::V1::RecognitionAudio), request.audio
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, recognize_client_stub do
      # Create client
      client = ::Google::Cloud::Speech::V1::Speech::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.recognize({ config: config, audio: audio }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.recognize config: config, audio: audio do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.recognize ::Google::Cloud::Speech::V1::RecognizeRequest.new(config: config, audio: audio) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.recognize({ config: config, audio: audio }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.recognize ::Google::Cloud::Speech::V1::RecognizeRequest.new(config: config, audio: audio), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, recognize_client_stub.call_rpc_count
    end
  end

  def test_long_running_recognize
    # Create GRPC objects.
    grpc_response = ::Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    config = {}
    audio = {}

    long_running_recognize_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :long_running_recognize, name
      assert_kind_of ::Google::Cloud::Speech::V1::LongRunningRecognizeRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Speech::V1::RecognitionConfig), request.config
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Speech::V1::RecognitionAudio), request.audio
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, long_running_recognize_client_stub do
      # Create client
      client = ::Google::Cloud::Speech::V1::Speech::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.long_running_recognize({ config: config, audio: audio }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.long_running_recognize config: config, audio: audio do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.long_running_recognize ::Google::Cloud::Speech::V1::LongRunningRecognizeRequest.new(config: config, audio: audio) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.long_running_recognize({ config: config, audio: audio }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.long_running_recognize ::Google::Cloud::Speech::V1::LongRunningRecognizeRequest.new(config: config, audio: audio), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, long_running_recognize_client_stub.call_rpc_count
    end
  end

  def test_streaming_recognize
    # Create GRPC objects.
    grpc_response = ::Google::Cloud::Speech::V1::StreamingRecognizeResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a bidi streaming method.
    streaming_config = {}

    streaming_recognize_client_stub = ClientStub.new [grpc_response].to_enum, grpc_operation do |name, request, options:|
      assert_equal :streaming_recognize, name
      assert_kind_of Enumerable, request
      refute_nil options
      request
    end

    Gapic::ServiceStub.stub :new, streaming_recognize_client_stub do
      # Create client
      client = ::Google::Cloud::Speech::V1::Speech::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use enumerable object with hash and protobuf object.
      request_hash = { streaming_config: streaming_config }
      request_proto = ::Google::Cloud::Speech::V1::StreamingRecognizeRequest.new streaming_config: streaming_config
      enum_input = [request_hash, request_proto].to_enum
      client.streaming_recognize enum_input do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Cloud::Speech::V1::StreamingRecognizeResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use stream input object (from gapic-common).
      request_hash = { streaming_config: streaming_config }
      request_proto = ::Google::Cloud::Speech::V1::StreamingRecognizeRequest.new streaming_config: streaming_config
      stream_input = Gapic::StreamInput.new
      client.streaming_recognize stream_input do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Cloud::Speech::V1::StreamingRecognizeResponse, r
        end
        assert_equal grpc_operation, operation
      end
      stream_input << request_hash
      stream_input << request_proto
      stream_input.close

      # Use enumerable object with hash and protobuf object with options.
      request_hash = { streaming_config: streaming_config }
      request_proto = ::Google::Cloud::Speech::V1::StreamingRecognizeRequest.new streaming_config: streaming_config
      enum_input = [request_hash, request_proto].to_enum
      client.streaming_recognize enum_input, grpc_options do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Cloud::Speech::V1::StreamingRecognizeResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use stream input object (from gapic-common) with options.
      request_hash = { streaming_config: streaming_config }
      request_proto = ::Google::Cloud::Speech::V1::StreamingRecognizeRequest.new streaming_config: streaming_config
      stream_input = Gapic::StreamInput.new
      client.streaming_recognize stream_input, grpc_options do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Cloud::Speech::V1::StreamingRecognizeResponse, r
        end
        assert_equal grpc_operation, operation
      end
      stream_input << request_hash
      stream_input << request_proto
      stream_input.close

      # Verify method calls
      assert_equal 4, streaming_recognize_client_stub.call_rpc_count
      streaming_recognize_client_stub.requests.each do |request|
        request.to_a.each do |r|
          assert_kind_of ::Google::Cloud::Speech::V1::StreamingRecognizeRequest, r
          assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Cloud::Speech::V1::StreamingRecognitionConfig), r.streaming_config
        end
      end
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Speech::V1::Speech::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Cloud::Speech::V1::Speech::Client::Configuration, config
  end

  def test_operations_client
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Cloud::Speech::V1::Speech::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    assert_kind_of ::Google::Cloud::Speech::V1::Speech::Operations, client.operations_client
  end
end
