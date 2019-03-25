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

require "google/showcase/v1alpha3/identity_pb"
require "google/showcase/v1alpha3/identity_services_pb"
require "google/showcase/v1alpha3/identity"

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

class MockIdentityCredentialsV1alpha3 < Google::Showcase::V1alpha3::Identity::Credentials
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

describe Google::Showcase::V1alpha3::Identity do
  describe "create_user" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Identity#create_user."
    end

    it "invokes create_user without error" do
      # Create request parameters
      user = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Showcase::V1alpha3::User

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::CreateUserRequest, request
        assert_equal Google::Gax.to_proto(user, Google::Showcase::V1alpha3::User), request.user
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :create_user, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "create_user"

      Google::Showcase::V1alpha3::Identity::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Identity::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Identity.new

          # Call method
          response = client.create_user user

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.create_user user do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes create_user with error" do
      # Create request parameters
      user = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::CreateUserRequest, request
        assert_equal Google::Gax.to_proto(user, Google::Showcase::V1alpha3::User), request.user
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :create_user, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "create_user"

      Google::Showcase::V1alpha3::Identity::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Identity::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Identity.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.create_user user
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "get_user" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Identity#get_user."
    end

    it "invokes get_user without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Showcase::V1alpha3::User

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::GetUserRequest, request
        assert_equal Google::Gax.to_proto(name), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :get_user, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_user"

      Google::Showcase::V1alpha3::Identity::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Identity::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Identity.new

          # Call method
          response = client.get_user name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.get_user name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes get_user with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::GetUserRequest, request
        assert_equal Google::Gax.to_proto(name), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :get_user, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_user"

      Google::Showcase::V1alpha3::Identity::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Identity::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Identity.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.get_user name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "update_user" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Identity#update_user."
    end

    it "invokes update_user without error" do
      # Create request parameters
      user = {}
      update_mask = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Showcase::V1alpha3::User

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::UpdateUserRequest, request
        assert_equal Google::Gax.to_proto(user, Google::Showcase::V1alpha3::User), request.user
        assert_equal Google::Gax.to_proto(update_mask, Google::Protobuf::FieldMask), request.update_mask
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :update_user, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "update_user"

      Google::Showcase::V1alpha3::Identity::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Identity::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Identity.new

          # Call method
          response = client.update_user user, update_mask

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.update_user user, update_mask do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes update_user with error" do
      # Create request parameters
      user = {}
      update_mask = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::UpdateUserRequest, request
        assert_equal Google::Gax.to_proto(user, Google::Showcase::V1alpha3::User), request.user
        assert_equal Google::Gax.to_proto(update_mask, Google::Protobuf::FieldMask), request.update_mask
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :update_user, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "update_user"

      Google::Showcase::V1alpha3::Identity::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Identity::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Identity.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.update_user user, update_mask
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "delete_user" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Identity#delete_user."
    end

    it "invokes delete_user without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Protobuf::Empty

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::DeleteUserRequest, request
        assert_equal Google::Gax.to_proto(name), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :delete_user, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_user"

      Google::Showcase::V1alpha3::Identity::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Identity::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Identity.new

          # Call method
          response = client.delete_user name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.delete_user name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes delete_user with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::DeleteUserRequest, request
        assert_equal Google::Gax.to_proto(name), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :delete_user, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_user"

      Google::Showcase::V1alpha3::Identity::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Identity::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Identity.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.delete_user name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "list_users" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Identity#list_users."
    end

    it "invokes list_users without error" do
      # Create request parameters
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Showcase::V1alpha3::ListUsersResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::ListUsersRequest, request
        assert_equal Google::Gax.to_proto(page_size), request.page_size
        assert_equal Google::Gax.to_proto(page_token), request.page_token
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :list_users, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_users"

      Google::Showcase::V1alpha3::Identity::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Identity::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Identity.new

          # Call method
          response = client.list_users page_size, page_token

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.list_users page_size, page_token do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes list_users with error" do
      # Create request parameters
      page_size = 42
      page_token = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::ListUsersRequest, request
        assert_equal Google::Gax.to_proto(page_size), request.page_size
        assert_equal Google::Gax.to_proto(page_token), request.page_token
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :list_users, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_users"

      Google::Showcase::V1alpha3::Identity::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Identity::Credentials.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Identity.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.list_users page_size, page_token
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end
end
