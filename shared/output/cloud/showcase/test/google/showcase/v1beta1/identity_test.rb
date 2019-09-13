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

require "google/showcase/v1beta1/identity_pb"
require "google/showcase/v1beta1/identity_services_pb"
require "google/showcase/v1beta1/identity"

class Google::Showcase::V1beta1::Identity::ClientTest < Minitest::Test
  def setup
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    @mock_stub = MiniTest::Mock.new
    @mock_page_enum = :mock_page_enum
    @response = :mock_response
    @grpc_operation = :mock_grpc_operation
    @options = {}
  end

  def with_stubs
    Gapic::ServiceStub.stub :new, @mock_stub do
      Gapic::PagedEnumerable.stub :new, @mock_page_enum do
        yield
      end
    end
  end

  def test_create_user
    # Create request parameters
    user = {}

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Identity::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :create_user, name
          refute_nil options
          refute_nil block
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::User), request.user

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.create_user user: user do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.create_user(Google::Showcase::V1beta1::CreateUserRequest.new(user: user)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.create_user request = { user: user } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.create_user request = Google::Showcase::V1beta1::CreateUserRequest.new({ user: user }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.create_user({ user: user }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.create_user(Google::Showcase::V1beta1::CreateUserRequest.new(user: user), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.create_user(request = { user: user }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.create_user(request = Google::Showcase::V1beta1::CreateUserRequest.new({ user: user }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_get_user
    # Create request parameters
    name = "hello world"

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Identity::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :get_user, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.get_user name: name do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.get_user(Google::Showcase::V1beta1::GetUserRequest.new(name: name)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.get_user request = { name: name } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.get_user request = Google::Showcase::V1beta1::GetUserRequest.new({ name: name }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.get_user({ name: name }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.get_user(Google::Showcase::V1beta1::GetUserRequest.new(name: name), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.get_user(request = { name: name }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.get_user(request = Google::Showcase::V1beta1::GetUserRequest.new({ name: name }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_update_user
    # Create request parameters
    user = {}
    update_mask = {}

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Identity::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :update_user, name
          refute_nil options
          refute_nil block
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::User), request.user
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.update_user user: user, update_mask: update_mask do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.update_user(Google::Showcase::V1beta1::UpdateUserRequest.new(user: user, update_mask: update_mask)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.update_user request = { user: user, update_mask: update_mask } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.update_user request = Google::Showcase::V1beta1::UpdateUserRequest.new({ user: user, update_mask: update_mask }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.update_user({ user: user, update_mask: update_mask }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.update_user(Google::Showcase::V1beta1::UpdateUserRequest.new(user: user, update_mask: update_mask), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.update_user(request = { user: user, update_mask: update_mask }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.update_user(request = Google::Showcase::V1beta1::UpdateUserRequest.new({ user: user, update_mask: update_mask }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_delete_user
    # Create request parameters
    name = "hello world"

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Identity::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :delete_user, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.delete_user name: name do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.delete_user(Google::Showcase::V1beta1::DeleteUserRequest.new(name: name)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.delete_user request = { name: name } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.delete_user request = Google::Showcase::V1beta1::DeleteUserRequest.new({ name: name }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.delete_user({ name: name }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.delete_user(Google::Showcase::V1beta1::DeleteUserRequest.new(name: name), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.delete_user(request = { name: name }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.delete_user(request = Google::Showcase::V1beta1::DeleteUserRequest.new({ name: name }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_list_users
    # Create request parameters
    page_size = 42
    page_token = "hello world"

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Identity::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :list_users, name
          refute_nil options
          refute_nil block
          assert_equal 42, request.page_size
          assert_equal "hello world", request.page_token

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.list_users page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.list_users(Google::Showcase::V1beta1::ListUsersRequest.new(page_size: page_size, page_token: page_token)) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.list_users request = { page_size: page_size, page_token: page_token } do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.list_users request = Google::Showcase::V1beta1::ListUsersRequest.new({ page_size: page_size, page_token: page_token }) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.list_users({ page_size: page_size, page_token: page_token }, @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.list_users(Google::Showcase::V1beta1::ListUsersRequest.new(page_size: page_size, page_token: page_token), @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.list_users(request = { page_size: page_size, page_token: page_token }, options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.list_users(request = Google::Showcase::V1beta1::ListUsersRequest.new({ page_size: page_size, page_token: page_token }), options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end
end
