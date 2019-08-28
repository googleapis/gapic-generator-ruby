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

require "google/cloud/speech/v1/cloud_speech_pb"
require "google/cloud/speech/v1/cloud_speech_services_pb"
require "google/cloud/speech/v1/speech"

describe Google::Cloud::Speech::V1::Speech::Client do
  before :all do
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
  end

  describe "recognize" do
    it "invokes recognize without error" do
      # Create request parameters
      config = {}
      audio = {}

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Cloud::Speech::V1::Speech::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :recognize && !options.nil? &&
              Gapic::Protobuf.coerce({}, to: Google::Cloud::Speech::V1::RecognitionConfig) == request.config &&
              Gapic::Protobuf.coerce({}, to: Google::Cloud::Speech::V1::RecognitionAudio) == request.audio
          end
        end

        # Call method
        response = client.recognize config: config, audio: audio
        assert_equal mock_response, response

        # Call method with block
        client.recognize config: config, audio: audio do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "long_running_recognize" do
    it "invokes long_running_recognize without error" do
      # Create request parameters
      config = {}
      audio = {}

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Cloud::Speech::V1::Speech::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :long_running_recognize && !options.nil? &&
              Gapic::Protobuf.coerce({}, to: Google::Cloud::Speech::V1::RecognitionConfig) == request.config &&
              Gapic::Protobuf.coerce({}, to: Google::Cloud::Speech::V1::RecognitionAudio) == request.audio
          end
        end

        # Call method
        response = client.long_running_recognize config: config, audio: audio
        assert_equal mock_response, response

        # Call method with block
        client.long_running_recognize config: config, audio: audio do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  # TODO
end
