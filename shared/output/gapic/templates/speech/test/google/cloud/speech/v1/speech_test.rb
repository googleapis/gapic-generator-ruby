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
