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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!

require "helper"
require "gapic/rest"
require "google/showcase/v1beta1/identity_pb"
require "google/showcase/v1beta1/identity/rest"


class ::Google::Showcase::V1beta1::Identity::Rest::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_count, :requests

    def initialize response, &block
      @response = response
      @block = block
      @call_count = 0
      @requests = []
    end

    def make_get_request uri:, params: {}, options: {}
      make_http_request :get, uri: uri, body: nil, params: params, options: options
    end

    def make_delete_request uri:, params: {}, options: {}
      make_http_request :delete, uri: uri, body: nil, params: params, options: options
    end

    def make_post_request uri:, body: nil, params: {}, options: {}
      make_http_request :post, uri: uri, body: body, params: params, options: options
    end

    def make_patch_request uri:, body:, params: {}, options: {}
      make_http_request :patch, uri: uri, body: body, params: params, options: options
    end

    def make_put_request uri:, body:, params: {}, options: {}
      make_http_request :put, uri: uri, body: body, params: params, options: options
    end

    def make_http_request *args, **kwargs
      @call_count += 1

      @requests << @block&.call(*args, **kwargs)

      @response
    end
  end

  def test_create_user
    # Create test objects.
    client_result = ::Google::Showcase::V1beta1::User.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    user = {}

    create_user_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::Identity::Rest::ServiceStub.stub :transcode_create_user_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, create_user_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::Identity::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.create_user({ user: user }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.create_user user: user do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.create_user ::Google::Showcase::V1beta1::CreateUserRequest.new(user: user) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.create_user({ user: user }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.create_user(::Google::Showcase::V1beta1::CreateUserRequest.new(user: user), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, create_user_client_stub.call_count
      end
    end
  end

  def test_get_user
    # Create test objects.
    client_result = ::Google::Showcase::V1beta1::User.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_user_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::Identity::Rest::ServiceStub.stub :transcode_get_user_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, get_user_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::Identity::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.get_user({ name: name }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.get_user name: name do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.get_user ::Google::Showcase::V1beta1::GetUserRequest.new(name: name) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.get_user({ name: name }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.get_user(::Google::Showcase::V1beta1::GetUserRequest.new(name: name), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, get_user_client_stub.call_count
      end
    end
  end

  def test_update_user
    # Create test objects.
    client_result = ::Google::Showcase::V1beta1::User.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    user = {}
    update_mask = {}

    update_user_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::Identity::Rest::ServiceStub.stub :transcode_update_user_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, update_user_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::Identity::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.update_user({ user: user, update_mask: update_mask }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.update_user user: user, update_mask: update_mask do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.update_user ::Google::Showcase::V1beta1::UpdateUserRequest.new(user: user, update_mask: update_mask) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.update_user({ user: user, update_mask: update_mask }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.update_user(::Google::Showcase::V1beta1::UpdateUserRequest.new(user: user, update_mask: update_mask), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, update_user_client_stub.call_count
      end
    end
  end

  def test_delete_user
    # Create test objects.
    client_result = ::Google::Protobuf::Empty.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_user_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::Identity::Rest::ServiceStub.stub :transcode_delete_user_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, delete_user_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::Identity::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.delete_user({ name: name }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.delete_user name: name do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.delete_user ::Google::Showcase::V1beta1::DeleteUserRequest.new(name: name) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.delete_user({ name: name }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.delete_user(::Google::Showcase::V1beta1::DeleteUserRequest.new(name: name), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, delete_user_client_stub.call_count
      end
    end
  end

  def test_list_users
    # Create test objects.
    client_result = ::Google::Showcase::V1beta1::ListUsersResponse.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    page_size = 42
    page_token = "hello world"

    list_users_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::Identity::Rest::ServiceStub.stub :transcode_list_users_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, list_users_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::Identity::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.list_users({ page_size: page_size, page_token: page_token }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.list_users page_size: page_size, page_token: page_token do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.list_users ::Google::Showcase::V1beta1::ListUsersRequest.new(page_size: page_size, page_token: page_token) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.list_users({ page_size: page_size, page_token: page_token }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.list_users(::Google::Showcase::V1beta1::ListUsersRequest.new(page_size: page_size, page_token: page_token), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, list_users_client_stub.call_count
      end
    end
  end

  def test_configure
    credentials_token = :dummy_value

    client = block_config = config = nil
    Gapic::Rest::ClientStub.stub :new, nil do
      client = ::Google::Showcase::V1beta1::Identity::Rest::Client.new do |config|
        config.credentials = credentials_token
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Showcase::V1beta1::Identity::Rest::Client::Configuration, config
  end
end
