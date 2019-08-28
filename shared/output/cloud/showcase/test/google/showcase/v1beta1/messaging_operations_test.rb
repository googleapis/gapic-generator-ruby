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

require "google/showcase/v1beta1/messaging_pb"
require "google/showcase/v1beta1/messaging_services_pb"
require "google/showcase/v1beta1/messaging"

describe Google::Showcase::V1beta1::Messaging::Operations do
  before :all do
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
  end

  describe "list_operations" do
    it "invokes list_operations without error" do
      # Create request parameters
      name = "hello world"
      filter = "hello world"
      page_size = 42
      page_token = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Messaging::Operations.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :list_operations && !options.nil? &&
              request.name == "hello world" &&
              request.filter == "hello world" &&
              request.page_size == 42 &&
              request.page_token == "hello world"
          end
        end

        # Call method
        response = client.list_operations name: name, filter: filter, page_size: page_size, page_token: page_token
        assert_equal mock_response, response

        # Call method with block
        client.list_operations name: name, filter: filter, page_size: page_size, page_token: page_token do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "get_operation" do
    it "invokes get_operation without error" do
      # Create request parameters
      name = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Messaging::Operations.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :get_operation && !options.nil? &&
              request.name == "hello world"
          end
        end

        # Call method
        response = client.get_operation name: name
        assert_equal mock_response, response

        # Call method with block
        client.get_operation name: name do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "delete_operation" do
    it "invokes delete_operation without error" do
      # Create request parameters
      name = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Messaging::Operations.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :delete_operation && !options.nil? &&
              request.name == "hello world"
          end
        end

        # Call method
        response = client.delete_operation name: name
        assert_equal mock_response, response

        # Call method with block
        client.delete_operation name: name do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "cancel_operation" do
    it "invokes cancel_operation without error" do
      # Create request parameters
      name = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Messaging::Operations.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :cancel_operation && !options.nil? &&
              request.name == "hello world"
          end
        end

        # Call method
        response = client.cancel_operation name: name
        assert_equal mock_response, response

        # Call method with block
        client.cancel_operation name: name do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end
end
