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

require "google/cloud/speech/v1/cloud_speech_pb"
require "google/cloud/speech/v1/cloud_speech_services_pb"
require "google/cloud/speech/v1/speech"

class CustomTestErrorV1 < StandardError; end
# Mock for the GRPC::ClientStub class.
class MockGrpcClientStubV1
  # @param expected_symbol [Symbol] the symbol of the grpc method to be mocked.
  # @param mock_method [Proc] The method that is being mocked.
  def initialize expected_symbol, mock_method
    @expected_symbol = expected_symbol
    @mock_method = mock_method
  end

  # This overrides the Object#method method to return the mocked method when the mocked method
  # is being requested. For methods that aren"t being tested, this method returns a proc that
  # will raise an error when called. This is to assure that only the mocked grpc method is being
  # called.
  #
  # @param symbol [Symbol] The symbol of the method being requested.
  # @return [Proc] The proc of the requested method. If the requested method is not being mocked
  #   the proc returned will raise when called.
  def method symbol
    return @mock_method if symbol == @expected_symbol

    # The requested method is not being tested, raise if it called.
    proc do
      raise "The method #{symbol} was unexpectedly called during the " \
        "test for #{@expected_symbol}."
    end
  end
end

class MockSpeechCredentialsV1 < Google::Cloud::Speech::V1::Speech::Credentials
  def initialize method_name
    @method_name = method_name
  end

  def updater_proc
    proc do
      raise "The method `#{@method_name}` was trying to make a grpc request. This should not " \
          "happen since the grpc layer is being mocked."
    end
  end
end

describe Google::Cloud::Speech::V1::Speech::Client do
  describe "recognize" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Speech::V1::Speech::Client#recognize."
    end

    it "invokes recognize without error" do
      # Create request parameters
      config = {}
      audio = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Gapic::Protobuf.coerce expected_response, to: Google::Cloud::Speech::V1::RecognizeResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Speech::V1::RecognizeRequest, request
        assert_equal Gapic::Protobuf.coerce(config, to: Google::Cloud::Speech::V1::RecognitionConfig), request.config
        assert_equal Gapic::Protobuf.coerce(audio, to: Google::Cloud::Speech::V1::RecognitionAudio), request.audio
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :recognize, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "recognize"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Cloud::Speech::V1::Speech::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Speech::V1::Speech::Client.new

          # Call method
          response = client.recognize config, audio

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.recognize config, audio do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes recognize with error" do
      # Create request parameters
      config = {}
      audio = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Speech::V1::RecognizeRequest, request
        assert_equal Gapic::Protobuf.coerce(config, to: Google::Cloud::Speech::V1::RecognitionConfig), request.config
        assert_equal Gapic::Protobuf.coerce(audio, to: Google::Cloud::Speech::V1::RecognitionAudio), request.audio
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :recognize, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "recognize"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Cloud::Speech::V1::Speech::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Speech::V1::Speech::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.recognize config, audio
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "long_running_recognize" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Speech::V1::Speech::Client#long_running_recognize."
    end

    it "invokes long_running_recognize without error" do
      # Create request parameters
      config = {}
      audio = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Gapic::Protobuf.coerce expected_response, to: Google::Longrunning::Operation
      result = Google::Protobuf::Any.new
      result.pack expected_response
      operation = Google::Longrunning::Operation.new(
        name:     "operations/long_running_recognize_test",
        done:     true,
        response: result
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Speech::V1::LongRunningRecognizeRequest, request
        assert_equal Gapic::Protobuf.coerce(config, to: Google::Cloud::Speech::V1::RecognitionConfig), request.config
        assert_equal Gapic::Protobuf.coerce(audio, to: Google::Cloud::Speech::V1::RecognitionAudio), request.audio
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :long_running_recognize, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "long_running_recognize"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Cloud::Speech::V1::Speech::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Speech::V1::Speech::Client.new

          # Call method
          response = client.long_running_recognize config, audio

          # Verify the response
          assert_equal expected_response, response.response
        end
      end
    end

    it "invokes long_running_recognize and returns an operation error." do
      # Create request parameters
      config = {}
      audio = {}

      # Create expected grpc response
      operation_error = Google::Rpc::Status.new(
        message: "Operation error for Google::Cloud::Speech::V1::Speech::Client#long_running_recognize."
      )
      operation = Google::Longrunning::Operation.new(
        name:  "operations/long_running_recognize_test",
        done:  true,
        error: operation_error
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Speech::V1::LongRunningRecognizeRequest, request
        assert_equal Gapic::Protobuf.coerce(config, to: Google::Cloud::Speech::V1::RecognitionConfig), request.config
        assert_equal Gapic::Protobuf.coerce(audio, to: Google::Cloud::Speech::V1::RecognitionAudio), request.audio
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :long_running_recognize, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "long_running_recognize"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Cloud::Speech::V1::Speech::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Speech::V1::Speech::Client.new

          # Call method
          response = client.long_running_recognize config, audio

          # Verify the response
          assert response.error?
          assert_equal operation_error, response.error
        end
      end
    end

    it "invokes long_running_recognize with error" do
      # Create request parameters
      config = {}
      audio = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Speech::V1::LongRunningRecognizeRequest, request
        assert_equal Gapic::Protobuf.coerce(config, to: Google::Cloud::Speech::V1::RecognitionConfig), request.config
        assert_equal Gapic::Protobuf.coerce(audio, to: Google::Cloud::Speech::V1::RecognitionAudio), request.audio
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :long_running_recognize, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "long_running_recognize"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Cloud::Speech::V1::Speech::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Speech::V1::Speech::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.long_running_recognize config, audio
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "streaming_recognize" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Speech::V1::Speech::Client#streaming_recognize."
    end

    it "invokes streaming_recognize without error" do
      # Create request parameters
      request = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Gapic::Protobuf.coerce expected_response, to: Google::Cloud::Speech::V1::StreamingRecognizeResponse

      # Mock Grpc layer
      mock_method = proc do |requests|
        request = requests.first
        OpenStruct.new execute: [expected_response]
      end
      mock_stub = MockGrpcClientStubV1.new :streaming_recognize, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "streaming_recognize"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Cloud::Speech::V1::Speech::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Speech::V1::Speech::Client.new

          # Call method
          response = client.streaming_recognize [request]

          # Verify the response
          assert_equal 1, response.count
          assert_equal expected_response, response.first
        end
      end
    end

    it "invokes streaming_recognize with error" do
      # Create request parameters
      request = {}

      # Mock Grpc layer
      mock_method = proc { raise custom_error }
      mock_stub = MockGrpcClientStubV1.new :streaming_recognize, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "streaming_recognize"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Cloud::Speech::V1::Speech::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Speech::V1::Speech::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.streaming_recognize [request]
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end
end
