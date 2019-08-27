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

require "google/showcase/v1beta1/testing_pb"
require "google/showcase/v1beta1/testing_services_pb"
require "google/showcase/v1beta1/testing"

class CustomTestTestingErrorV1beta1 < StandardError; end

# Mock for the GRPC::ClientStub class.
class MockGrpcTestingStubV1beta1
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

class MockTestingCredentialsV1beta1 < Google::Showcase::V1beta1::Testing::Credentials
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

describe Google::Showcase::V1beta1::Testing::Client do
  describe "create_session" do
    let :custom_error do
      CustomTestTestingErrorV1beta1.new "Custom test error for Google::Showcase::V1beta1::Testing::Client#create_session."
    end

    it "invokes create_session without error" do
      # Create request parameters
      session = {}

      # Create expected grpc response
      expected_response = Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Session)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::CreateSessionRequest, request
        assert_equal Gapic::Protobuf.coerce(session, to: Google::Showcase::V1beta1::Session), request.session
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :create_session, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "create_session"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          response = client.create_session session: session

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.create_session session: session do |resp, operation|
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
        assert_instance_of Google::Showcase::V1beta1::CreateSessionRequest, request
        assert_equal Gapic::Protobuf.coerce(session, to: Google::Showcase::V1beta1::Session), request.session
        raise custom_error
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :create_session, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "create_session"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.create_session session: session
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "get_session" do
    let :custom_error do
      CustomTestTestingErrorV1beta1.new "Custom test error for Google::Showcase::V1beta1::Testing::Client#get_session."
    end

    it "invokes get_session without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Session)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::GetSessionRequest, request
        assert_equal name, request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :get_session, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "get_session"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          response = client.get_session name: name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.get_session name: name do |resp, operation|
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
        assert_instance_of Google::Showcase::V1beta1::GetSessionRequest, request
        assert_equal name, request.name
        raise custom_error
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :get_session, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "get_session"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.get_session name: name
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "list_sessions" do
    let :custom_error do
      CustomTestTestingErrorV1beta1.new "Custom test error for Google::Showcase::V1beta1::Testing::Client#list_sessions."
    end

    it "invokes list_sessions without error" do
      # Create request parameters
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      expected_response = Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::ListSessionsResponse)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::ListSessionsRequest, request
        assert_equal page_size, request.page_size
        assert_equal page_token, request.page_token
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :list_sessions, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "list_sessions"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          response = client.list_sessions page_size: page_size, page_token: page_token

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.list_sessions page_size: page_size, page_token: page_token do |resp, operation|
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
        assert_instance_of Google::Showcase::V1beta1::ListSessionsRequest, request
        assert_equal page_size, request.page_size
        assert_equal page_token, request.page_token
        raise custom_error
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :list_sessions, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "list_sessions"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.list_sessions page_size: page_size, page_token: page_token
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "delete_session" do
    let :custom_error do
      CustomTestTestingErrorV1beta1.new "Custom test error for Google::Showcase::V1beta1::Testing::Client#delete_session."
    end

    it "invokes delete_session without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = Gapic::Protobuf.coerce({}, to: Google::Protobuf::Empty)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::DeleteSessionRequest, request
        assert_equal name, request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :delete_session, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "delete_session"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          response = client.delete_session name: name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.delete_session name: name do |resp, operation|
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
        assert_instance_of Google::Showcase::V1beta1::DeleteSessionRequest, request
        assert_equal name, request.name
        raise custom_error
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :delete_session, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "delete_session"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.delete_session name: name
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "report_session" do
    let :custom_error do
      CustomTestTestingErrorV1beta1.new "Custom test error for Google::Showcase::V1beta1::Testing::Client#report_session."
    end

    it "invokes report_session without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::ReportSessionResponse)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::ReportSessionRequest, request
        assert_equal name, request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :report_session, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "report_session"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          response = client.report_session name: name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.report_session name: name do |resp, operation|
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
        assert_instance_of Google::Showcase::V1beta1::ReportSessionRequest, request
        assert_equal name, request.name
        raise custom_error
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :report_session, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "report_session"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.report_session name: name
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "list_tests" do
    let :custom_error do
      CustomTestTestingErrorV1beta1.new "Custom test error for Google::Showcase::V1beta1::Testing::Client#list_tests."
    end

    it "invokes list_tests without error" do
      # Create request parameters
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      expected_response = Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::ListTestsResponse)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::ListTestsRequest, request
        assert_equal parent, request.parent
        assert_equal page_size, request.page_size
        assert_equal page_token, request.page_token
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :list_tests, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "list_tests"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          response = client.list_tests parent: parent, page_size: page_size, page_token: page_token

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.list_tests parent: parent, page_size: page_size, page_token: page_token do |resp, operation|
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
        assert_instance_of Google::Showcase::V1beta1::ListTestsRequest, request
        assert_equal parent, request.parent
        assert_equal page_size, request.page_size
        assert_equal page_token, request.page_token
        raise custom_error
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :list_tests, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "list_tests"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.list_tests parent: parent, page_size: page_size, page_token: page_token
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "delete_test" do
    let :custom_error do
      CustomTestTestingErrorV1beta1.new "Custom test error for Google::Showcase::V1beta1::Testing::Client#delete_test."
    end

    it "invokes delete_test without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = Gapic::Protobuf.coerce({}, to: Google::Protobuf::Empty)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::DeleteTestRequest, request
        assert_equal name, request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :delete_test, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "delete_test"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          response = client.delete_test name: name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.delete_test name: name do |resp, operation|
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
        assert_instance_of Google::Showcase::V1beta1::DeleteTestRequest, request
        assert_equal name, request.name
        raise custom_error
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :delete_test, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "delete_test"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.delete_test name: name
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "verify_test" do
    let :custom_error do
      CustomTestTestingErrorV1beta1.new "Custom test error for Google::Showcase::V1beta1::Testing::Client#verify_test."
    end

    it "invokes verify_test without error" do
      # Create request parameters
      name = "hello world"
      answer = "hello world"
      answers = "hello world"

      # Create expected grpc response
      expected_response = Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::VerifyTestResponse)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1beta1::VerifyTestRequest, request
        assert_equal name, request.name
        assert_equal answer, request.answer
        assert_equal answers, request.answers
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :verify_test, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "verify_test"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          response = client.verify_test name: name, answer: answer, answers: answers

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.verify_test name: name, answer: answer, answers: answers do |resp, operation|
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
        assert_instance_of Google::Showcase::V1beta1::VerifyTestRequest, request
        assert_equal name, request.name
        assert_equal answer, request.answer
        assert_equal answers, request.answers
        raise custom_error
      end
      mock_stub = MockGrpcTestingStubV1beta1.new :verify_test, mock_method

      # Mock auth layer
      mock_credentials = MockTestingCredentialsV1beta1.new "verify_test"

      Google::Showcase::V1beta1::Testing::Stub.stub :new, mock_stub do
        Google::Showcase::V1beta1::Testing::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1beta1::Testing::Client.new

          # Call method
          err = assert_raises Gapic::GapicError do
            client.verify_test name: name, answer: answer, answers: answers
          end

          # Verify the GapicError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end
end
