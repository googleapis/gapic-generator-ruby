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

require "google/showcase/v1alpha3/testing_pb"
require "google/showcase/v1alpha3/testing_services_pb"
require "google/showcase/v1alpha3/testing"

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

class MockTestingCredentialsV1alpha3 < Google::Showcase::V1alpha3::Testing::Credentials
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

describe Google::Showcase::V1alpha3::Testing::Client do
  describe "create_session" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Testing::Client#create_session."
    end

    it "invokes create_session without error" do
      # Create request parameters
      session = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Showcase::V1alpha3::Session

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::CreateSessionRequest, request
        assert_equal Google::Gax::Protobuf.coerce(session, to: Google::Showcase::V1alpha3::Session), request.session
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :create_session, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "create_session"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          response = client.create_session session

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.create_session session do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes create_session with error" do
      # Create request parameters
      session = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::CreateSessionRequest, request
        assert_equal Google::Gax::Protobuf.coerce(session, to: Google::Showcase::V1alpha3::Session), request.session
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :create_session, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "create_session"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.create_session session
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "get_session" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Testing::Client#get_session."
    end

    it "invokes get_session without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Showcase::V1alpha3::Session

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::GetSessionRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :get_session, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_session"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          response = client.get_session name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.get_session name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes get_session with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::GetSessionRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :get_session, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_session"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.get_session name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "list_sessions" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Testing::Client#list_sessions."
    end

    it "invokes list_sessions without error" do
      # Create request parameters
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Showcase::V1alpha3::ListSessionsResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::ListSessionsRequest, request
        assert_equal Google::Gax::Protobuf.coerce(page_size, to: ), request.page_size
        assert_equal Google::Gax::Protobuf.coerce(page_token, to: ), request.page_token
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :list_sessions, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_sessions"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          response = client.list_sessions page_size, page_token

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.list_sessions page_size, page_token do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes list_sessions with error" do
      # Create request parameters
      page_size = 42
      page_token = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::ListSessionsRequest, request
        assert_equal Google::Gax::Protobuf.coerce(page_size, to: ), request.page_size
        assert_equal Google::Gax::Protobuf.coerce(page_token, to: ), request.page_token
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :list_sessions, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_sessions"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.list_sessions page_size, page_token
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "delete_session" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Testing::Client#delete_session."
    end

    it "invokes delete_session without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Protobuf::Empty

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::DeleteSessionRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :delete_session, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_session"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          response = client.delete_session name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.delete_session name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes delete_session with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::DeleteSessionRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :delete_session, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_session"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.delete_session name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "report_session" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Testing::Client#report_session."
    end

    it "invokes report_session without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Showcase::V1alpha3::ReportSessionResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::ReportSessionRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :report_session, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "report_session"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          response = client.report_session name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.report_session name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes report_session with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::ReportSessionRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :report_session, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "report_session"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.report_session name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "list_tests" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Testing::Client#list_tests."
    end

    it "invokes list_tests without error" do
      # Create request parameters
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Showcase::V1alpha3::ListTestsResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::ListTestsRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(page_size, to: ), request.page_size
        assert_equal Google::Gax::Protobuf.coerce(page_token, to: ), request.page_token
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :list_tests, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_tests"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          response = client.list_tests parent, page_size, page_token

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.list_tests parent, page_size, page_token do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes list_tests with error" do
      # Create request parameters
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::ListTestsRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(page_size, to: ), request.page_size
        assert_equal Google::Gax::Protobuf.coerce(page_token, to: ), request.page_token
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :list_tests, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_tests"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.list_tests parent, page_size, page_token
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "delete_test" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Testing::Client#delete_test."
    end

    it "invokes delete_test without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Protobuf::Empty

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::DeleteTestRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :delete_test, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_test"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          response = client.delete_test name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.delete_test name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes delete_test with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::DeleteTestRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :delete_test, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_test"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.delete_test name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "verify_test" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Testing::Client#verify_test."
    end

    it "invokes verify_test without error" do
      # Create request parameters
      name = "hello world"
      answer = "hello world"
      answers = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Showcase::V1alpha3::VerifyTestResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::VerifyTestRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        assert_equal Google::Gax::Protobuf.coerce(answer, to: ), request.answer
        assert_equal Google::Gax::Protobuf.coerce(answers, to: ), request.answers
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :verify_test, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "verify_test"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          response = client.verify_test name, answer, answers

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.verify_test name, answer, answers do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes verify_test with error" do
      # Create request parameters
      name = "hello world"
      answer = "hello world"
      answers = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::VerifyTestRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        assert_equal Google::Gax::Protobuf.coerce(answer, to: ), request.answer
        assert_equal Google::Gax::Protobuf.coerce(answers, to: ), request.answers
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :verify_test, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "verify_test"

      Google::Showcase::V1alpha3::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Testing::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.verify_test name, answer, answers
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end
end
