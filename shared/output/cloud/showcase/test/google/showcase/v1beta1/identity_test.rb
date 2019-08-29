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
    @response = {}
    @options = {}
    @operation_callback = -> { raise "Operation callback was executed!" }
  end

  def test_create_user
    # Create request parameters
    user = {}

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Identity::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:|
          has_name = name == :create_user
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::User) == request.user

          assert has_name, "invalid method call: #{name} (expected create_user)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.create_user user: user
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.create_user(Google::Showcase::V1beta1::CreateUserRequest.new(
                                      user: user
                                    ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.create_user request = { user: user }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.create_user request = Google::Showcase::V1beta1::CreateUserRequest.new(
        user: user
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.create_user({ user: user }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.create_user(Google::Showcase::V1beta1::CreateUserRequest.new(
                                      user: user
                                    ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.create_user request = { user: user }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.create_user request = Google::Showcase::V1beta1::CreateUserRequest.new(
        user: user
      ), options = @options, &@operation_callback
      assert_equal @response, response

      @mock_stub.verify
    end
  end

  def test_get_user
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Identity::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:|
          has_name = name == :get_user
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            request.name == "hello world"

          assert has_name, "invalid method call: #{name} (expected get_user)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.get_user name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.get_user(Google::Showcase::V1beta1::GetUserRequest.new(
                                   name: name
                                 ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.get_user request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.get_user request = Google::Showcase::V1beta1::GetUserRequest.new(
        name: name
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.get_user({ name: name }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.get_user(Google::Showcase::V1beta1::GetUserRequest.new(
                                   name: name
                                 ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.get_user request = { name: name }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.get_user request = Google::Showcase::V1beta1::GetUserRequest.new(
        name: name
      ), options = @options, &@operation_callback
      assert_equal @response, response

      @mock_stub.verify
    end
  end

  def test_update_user
    # Create request parameters
    user = {}
    update_mask = {}

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Identity::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:|
          has_name = name == :update_user
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::User) == request.user &&

            Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask) == request.update_mask

          assert has_name, "invalid method call: #{name} (expected update_user)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.update_user user: user, update_mask: update_mask
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.update_user(Google::Showcase::V1beta1::UpdateUserRequest.new(
                                      user: user, update_mask: update_mask
                                    ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.update_user request = { user: user, update_mask: update_mask }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.update_user request = Google::Showcase::V1beta1::UpdateUserRequest.new(
        user: user, update_mask: update_mask
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.update_user({ user: user, update_mask: update_mask }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.update_user(Google::Showcase::V1beta1::UpdateUserRequest.new(
                                      user: user, update_mask: update_mask
                                    ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.update_user request = { user: user, update_mask: update_mask }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.update_user request = Google::Showcase::V1beta1::UpdateUserRequest.new(
        user: user, update_mask: update_mask
      ), options = @options, &@operation_callback
      assert_equal @response, response

      @mock_stub.verify
    end
  end

  def test_delete_user
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Identity::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:|
          has_name = name == :delete_user
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            request.name == "hello world"

          assert has_name, "invalid method call: #{name} (expected delete_user)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.delete_user name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.delete_user(Google::Showcase::V1beta1::DeleteUserRequest.new(
                                      name: name
                                    ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.delete_user request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.delete_user request = Google::Showcase::V1beta1::DeleteUserRequest.new(
        name: name
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.delete_user({ name: name }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.delete_user(Google::Showcase::V1beta1::DeleteUserRequest.new(
                                      name: name
                                    ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.delete_user request = { name: name }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.delete_user request = Google::Showcase::V1beta1::DeleteUserRequest.new(
        name: name
      ), options = @options, &@operation_callback
      assert_equal @response, response

      @mock_stub.verify
    end
  end

  def test_list_users
    # Create request parameters
    page_size = 42
    page_token = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Identity::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:, format_response:|
          has_name = name == :list_users
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            request.page_size == 42 &&

            request.page_token == "hello world"

          assert has_name, "invalid method call: #{name} (expected list_users)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.list_users page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.list_users(Google::Showcase::V1beta1::ListUsersRequest.new(
                                     page_size: page_size, page_token: page_token
                                   ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.list_users request = { page_size: page_size, page_token: page_token }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.list_users request = Google::Showcase::V1beta1::ListUsersRequest.new(
        page_size: page_size, page_token: page_token
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.list_users({ page_size: page_size, page_token: page_token }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.list_users(Google::Showcase::V1beta1::ListUsersRequest.new(
                                     page_size: page_size, page_token: page_token
                                   ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.list_users request = { page_size: page_size, page_token: page_token }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.list_users request = Google::Showcase::V1beta1::ListUsersRequest.new(
        page_size: page_size, page_token: page_token
      ), options = @options, &@operation_callback
      assert_equal @response, response

      @mock_stub.verify
    end
  end
end
