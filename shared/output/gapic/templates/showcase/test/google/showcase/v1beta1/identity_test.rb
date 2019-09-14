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

require "google/showcase/v1beta1/identity_pb"
require "google/showcase/v1beta1/identity_services_pb"
require "google/showcase/v1beta1/identity"

class Google::Showcase::V1beta1::Identity::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_rpc_count

    def initialize response, operation, &block
      @response = response
      @operation = operation
      @block = block
      @call_rpc_count = 0
    end

    def call_rpc *args
      @call_rpc_count += 1

      @block&.call *args

      yield @response, @operation if block_given?

      @response
    end
  end

  def test_create_user
    # Create GRPC objects
    grpc_response = Google::Showcase::V1beta1::User.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    user = {}

    create_user_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_user, name
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::User), request.user
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_user_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Identity::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.create_user user: user do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_user user: user do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_user Google::Showcase::V1beta1::CreateUserRequest.new(user: user) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_user({ user: user }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_user Google::Showcase::V1beta1::CreateUserRequest.new(user: user), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_user_client_stub.call_rpc_count
    end
  end

  def test_get_user
    # Create GRPC objects
    grpc_response = Google::Showcase::V1beta1::User.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    name = "hello world"

    get_user_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_user, name
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_user_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Identity::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.get_user name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_user name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_user Google::Showcase::V1beta1::GetUserRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_user({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_user Google::Showcase::V1beta1::GetUserRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_user_client_stub.call_rpc_count
    end
  end

  def test_update_user
    # Create GRPC objects
    grpc_response = Google::Showcase::V1beta1::User.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    user = {}
    update_mask = {}

    update_user_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_user, name
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::User), request.user
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_user_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Identity::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.update_user user: user, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_user user: user, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_user Google::Showcase::V1beta1::UpdateUserRequest.new(user: user, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_user({ user: user, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_user Google::Showcase::V1beta1::UpdateUserRequest.new(user: user, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_user_client_stub.call_rpc_count
    end
  end

  def test_delete_user
    # Create GRPC objects
    grpc_response = Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    name = "hello world"

    delete_user_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_user, name
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_user_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Identity::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.delete_user name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_user name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_user Google::Showcase::V1beta1::DeleteUserRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_user({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_user Google::Showcase::V1beta1::DeleteUserRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_user_client_stub.call_rpc_count
    end
  end

  def test_list_users
    # Create GRPC objects
    grpc_response = Google::Showcase::V1beta1::ListUsersResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    page_size = 42
    page_token = "hello world"

    list_users_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_users, name
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_users_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Identity::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.list_users page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_users page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_users Google::Showcase::V1beta1::ListUsersRequest.new(page_size: page_size, page_token: page_token) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_users({ page_size: page_size, page_token: page_token }, grpc_options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_users Google::Showcase::V1beta1::ListUsersRequest.new(page_size: page_size, page_token: page_token), grpc_options do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_users_client_stub.call_rpc_count
    end
  end
end
