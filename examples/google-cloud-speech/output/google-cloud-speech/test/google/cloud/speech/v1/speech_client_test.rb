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
require "minitest/spec"

require "google/gax"

require "google/cloud/speech"
require "google/cloud/speech/v1/speech_client"
require "google/cloud/speech/v1/cloud_speech_services_pb"
require "google/longrunning/operations_pb"
require "google/longrunning/operations_services_pb"

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

class MockSpeechCredentialsV1 < Google::Cloud::Speech::V1::Credentials
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

describe Google::Cloud::Speech::V1::SpeechClient do

  describe "recognize" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Speech::V1::SpeechClient#recognize."
    end

    it "invokes recognize without error" do
      # Create request parameters
      encoding = :FLAC
      sample_rate_hertz = 44100
      language_code = "en-US"
      config = {
        encoding: encoding,
        sample_rate_hertz: sample_rate_hertz,
        language_code: language_code
      }
      uri = "gs://bucket_name/file_name.flac"
      audio = { uri: uri }

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response, Google::Cloud::Speech::V1::RecognizeResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Speech::V1::RecognizeRequest, request
        assert_equal Google::Gax.to_proto(config, Google::Cloud::Speech::V1::RecognitionConfig), request.config
        assert_equal Google::Gax.to_proto(audio, Google::Cloud::Speech::V1::RecognitionAudio), request.audio
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :recognize, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "recognize"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Cloud::Speech::V1::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Speech.new version: :v1

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
      encoding = :FLAC
      sample_rate_hertz = 44100
      language_code = "en-US"
      config = {
        encoding: encoding,
        sample_rate_hertz: sample_rate_hertz,
        language_code: language_code
      }
      uri = "gs://bucket_name/file_name.flac"
      audio = { uri: uri }

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Speech::V1::RecognizeRequest, request
        assert_equal Google::Gax.to_proto(config, Google::Cloud::Speech::V1::RecognitionConfig), request.config
        assert_equal Google::Gax.to_proto(audio, Google::Cloud::Speech::V1::RecognitionAudio), request.audio
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :recognize, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "recognize"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Cloud::Speech::V1::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Speech.new version: :v1

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.recognize config, audio
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "long_running_recognize" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Speech::V1::SpeechClient#long_running_recognize."
    end

    it "invokes long_running_recognize without error" do
      # Create request parameters
      encoding = :FLAC
      sample_rate_hertz = 44100
      language_code = "en-US"
      config = {
        encoding: encoding,
        sample_rate_hertz: sample_rate_hertz,
        language_code: language_code
      }
      uri = "gs://bucket_name/file_name.flac"
      audio = { uri: uri }

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Cloud::Speech::V1::LongRunningRecognizeResponse
      result = Google::Protobuf::Any.new
      result.pack expected_response
      operation = Google::Longrunning::Operation.new(
        name: "operations/long_running_recognize_test",
        done: true,
        response: result
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Speech::V1::LongRunningRecognizeRequest, request
        assert_equal Google::Gax.to_proto(config, Google::Cloud::Speech::V1::RecognitionConfig), request.config
        assert_equal Google::Gax.to_proto(audio, Google::Cloud::Speech::V1::RecognitionAudio), request.audio
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :long_running_recognize, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "long_running_recognize"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Cloud::Speech::V1::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Speech.new version: :v1

          # Call method
          response = client.long_running_recognize config, audio

          # Verify the response
          assert_equal expected_response, response.response
        end
      end
    end

    it "invokes long_running_recognize and returns an operation error." do
      # Create request parameters
      encoding = :FLAC
      sample_rate_hertz = 44100
      language_code = "en-US"
      config = {
        encoding: encoding,
        sample_rate_hertz: sample_rate_hertz,
        language_code: language_code
      }
      uri = "gs://bucket_name/file_name.flac"
      audio = { uri: uri }

      # Create expected grpc response
      operation_error = Google::Rpc::Status.new(
        message: "Operation error for Google::Cloud::Speech::V1::SpeechClient#long_running_recognize."
      )
      operation = Google::Longrunning::Operation.new(
        name: "operations/long_running_recognize_test",
        done: true,
        error: operation_error
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Speech::V1::LongRunningRecognizeRequest, request
        assert_equal Google::Gax.to_proto(config, Google::Cloud::Speech::V1::RecognitionConfig), request.config
        assert_equal Google::Gax.to_proto(audio, Google::Cloud::Speech::V1::RecognitionAudio), request.audio
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :long_running_recognize, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "long_running_recognize"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Cloud::Speech::V1::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Speech.new version: :v1

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
      encoding = :FLAC
      sample_rate_hertz = 44100
      language_code = "en-US"
      config = {
        encoding: encoding,
        sample_rate_hertz: sample_rate_hertz,
        language_code: language_code
      }
      uri = "gs://bucket_name/file_name.flac"
      audio = { uri: uri }

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Speech::V1::LongRunningRecognizeRequest, request
        assert_equal Google::Gax.to_proto(config, Google::Cloud::Speech::V1::RecognitionConfig), request.config
        assert_equal Google::Gax.to_proto(audio, Google::Cloud::Speech::V1::RecognitionAudio), request.audio
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :long_running_recognize, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "long_running_recognize"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Cloud::Speech::V1::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Speech.new version: :v1

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.long_running_recognize config, audio
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "streaming_recognize" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Speech::V1::SpeechClient#streaming_recognize."
    end

    it "invokes streaming_recognize without error" do
      # Create request parameters
      request = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Cloud::Speech::V1::StreamingRecognizeResponse

      # Mock Grpc layer
      mock_method = proc do |requests|
        request = requests.first
        OpenStruct.new execute: [expected_response]
      end
      mock_stub = MockGrpcClientStubV1.new :streaming_recognize, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "streaming_recognize"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Cloud::Speech::V1::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Speech.new version: :v1

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
        Google::Cloud::Speech::V1::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Speech.new version: :v1

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.streaming_recognize [request]
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "get_operation" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Speech::V1::SpeechClient#get_operation."
    end

    it "invokes get_operation without error" do
      # Create request parameters
      name = "operation123"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Cloud::Speech::V1::LongRunningRecognizeResponse
      result = Google::Protobuf::Any.new
      result.pack expected_response
      operation = Google::Longrunning::Operation.new(
        name: "operations/get_operation_test",
        done: true,
        response: result
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Longrunning::GetOperationRequest, request
        assert_equal name, request.name
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :get_operation, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_operation"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Longrunning::Operations::Stub.stub :new, mock_stub do
          Google::Cloud::Speech::V1::Credentials.stub :default, mock_credentials do
            client = Google::Cloud::Speech.new version: :v1

            # Call method
            response = client.get_operation name

            # Verify the response
            assert_equal expected_response, response.response
          end
        end
      end
    end

    it "invokes get_operation and returns an operation error." do
      # Create request parameters
      name = "operation123"

      # Create expected grpc response
      operation_error = Google::Rpc::Status.new(
        message: "Operation error for Google::Cloud::Speech::V1::SpeechClient#get_operation."
      )
      operation = Google::Longrunning::Operation.new(
        name: "operations/get_operation_test",
        done: true,
        error: operation_error
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Longrunning::GetOperationRequest, request
        assert_equal name, request.name
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :get_operation, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_operation"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Longrunning::Operations::Stub.stub :new, mock_stub do
          Google::Cloud::Speech::V1::Credentials.stub :default, mock_credentials do
            client = Google::Cloud::Speech.new version: :v1

            # Call method
            response = client.get_operation name

            # Verify the response
            assert response.error?
            assert_equal operation_error, response.error
          end
        end
      end
    end

    it "invokes get_operation with error" do
      # Create request parameters
      name = "operation123"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Longrunning::GetOperationRequest, request
        assert_equal name, request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :get_operation, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_operation"

      Google::Cloud::Speech::V1::Speech::Stub.stub :new, mock_stub do
        Google::Longrunning::Operations::Stub.stub :new, mock_stub do
          Google::Cloud::Speech::V1::Credentials.stub :default, mock_credentials do
            client = Google::Cloud::Speech.new version: :v1

            # Call method
            err = assert_raises Google::Gax::GaxError do
              client.get_operation name
            end

            # Verify the GaxError wrapped the custom error that was raised.
            assert_match custom_error.message, err.message
          end
        end
      end
    end
  end
end
