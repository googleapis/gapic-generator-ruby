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

describe Google::Showcase::V1beta1::Identity::Client do
  before :all do
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
  end

  describe "create_user" do
    it "invokes create_user without error" do
      # Create request parameters
      user = {}

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Identity::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :create_user && !options.nil? &&
              Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::User) == request.user
          end
        end

        # Call method
        response = client.create_user user: user
        assert_equal mock_response, response

        # Call method with block
        client.create_user user: user do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "get_user" do
    it "invokes get_user without error" do
      # Create request parameters
      name = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Identity::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :get_user && !options.nil? &&
              request.name == "hello world"
          end
        end

        # Call method
        response = client.get_user name: name
        assert_equal mock_response, response

        # Call method with block
        client.get_user name: name do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "update_user" do
    it "invokes update_user without error" do
      # Create request parameters
      user = {}
      update_mask = {}

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Identity::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :update_user && !options.nil? &&
              Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::User) == request.user &&
              Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask) == request.update_mask
          end
        end

        # Call method
        response = client.update_user user: user, update_mask: update_mask
        assert_equal mock_response, response

        # Call method with block
        client.update_user user: user, update_mask: update_mask do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "delete_user" do
    it "invokes delete_user without error" do
      # Create request parameters
      name = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Identity::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :delete_user && !options.nil? &&
              request.name == "hello world"
          end
        end

        # Call method
        response = client.delete_user name: name
        assert_equal mock_response, response

        # Call method with block
        client.delete_user name: name do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "list_users" do
    it "invokes list_users without error" do
      # Create request parameters
      page_size = 42
      page_token = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Identity::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :list_users && !options.nil? &&
              request.page_size == 42 &&
              request.page_token == "hello world"
          end
        end

        # Call method
        response = client.list_users page_size: page_size, page_token: page_token
        assert_equal mock_response, response

        # Call method with block
        client.list_users page_size: page_size, page_token: page_token do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end
end
