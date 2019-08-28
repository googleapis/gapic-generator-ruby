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

class Google::Cloud::Speech::V1::Speech::ClientTest < Minitest::Test
  def setup
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    @mock_stub = MiniTest::Mock.new
    @response = {}
    @options = {}
  end

  def test_recognize
    # Create request parameters
    config = {}
    audio = {}

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Speech::V1::Speech::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :recognize
          has_options = !options.nil?
          has_fields =
            Gapic::Protobuf.coerce({}, to: Google::Cloud::Speech::V1::RecognitionConfig) == request.config &&

            Gapic::Protobuf.coerce({}, to: Google::Cloud::Speech::V1::RecognitionAudio) == request.audio

          puts "invalid method call: #{name} (expected recognize)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.recognize config: config, audio: audio
      assert_equal @response, response

      # Call method with options
      response = client.recognize({ config: config, audio: audio }, @options)
      assert_equal @response, response

      # Call method with block
      client.recognize config: config, audio: audio do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.recognize({ config: config, audio: audio }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_long_running_recognize
    # Create request parameters
    config = {}
    audio = {}

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Speech::V1::Speech::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :long_running_recognize
          has_options = !options.nil?
          has_fields =
            Gapic::Protobuf.coerce({}, to: Google::Cloud::Speech::V1::RecognitionConfig) == request.config &&

            Gapic::Protobuf.coerce({}, to: Google::Cloud::Speech::V1::RecognitionAudio) == request.audio

          puts "invalid method call: #{name} (expected long_running_recognize)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.long_running_recognize config: config, audio: audio
      assert_equal @response, response

      # Call method with options
      response = client.long_running_recognize({ config: config, audio: audio }, @options)
      assert_equal @response, response

      # Call method with block
      client.long_running_recognize config: config, audio: audio do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.long_running_recognize({ config: config, audio: audio }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  # TODO
end
