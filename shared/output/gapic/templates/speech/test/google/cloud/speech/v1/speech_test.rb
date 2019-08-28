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
