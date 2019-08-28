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

describe Google::Showcase::V1beta1::Messaging::Client do
  before :all do
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
  end

  describe "create_room" do
    it "invokes create_room without error" do
      # Create request parameters
      room = {}

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :create_room && !options.nil? &&
              Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Room) == request.room
          end
        end

        # Call method
        response = client.create_room room: room
        assert_equal mock_response, response

        # Call method with block
        client.create_room room: room do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "get_room" do
    it "invokes get_room without error" do
      # Create request parameters
      name = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :get_room && !options.nil? &&
              request.name == "hello world"
          end
        end

        # Call method
        response = client.get_room name: name
        assert_equal mock_response, response

        # Call method with block
        client.get_room name: name do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "update_room" do
    it "invokes update_room without error" do
      # Create request parameters
      room = {}
      update_mask = {}

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :update_room && !options.nil? &&
              Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Room) == request.room &&
              Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask) == request.update_mask
          end
        end

        # Call method
        response = client.update_room room: room, update_mask: update_mask
        assert_equal mock_response, response

        # Call method with block
        client.update_room room: room, update_mask: update_mask do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "delete_room" do
    it "invokes delete_room without error" do
      # Create request parameters
      name = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :delete_room && !options.nil? &&
              request.name == "hello world"
          end
        end

        # Call method
        response = client.delete_room name: name
        assert_equal mock_response, response

        # Call method with block
        client.delete_room name: name do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "list_rooms" do
    it "invokes list_rooms without error" do
      # Create request parameters
      page_size = 42
      page_token = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :list_rooms && !options.nil? &&
              request.page_size == 42 &&
              request.page_token == "hello world"
          end
        end

        # Call method
        response = client.list_rooms page_size: page_size, page_token: page_token
        assert_equal mock_response, response

        # Call method with block
        client.list_rooms page_size: page_size, page_token: page_token do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "create_blurb" do
    it "invokes create_blurb without error" do
      # Create request parameters
      parent = "hello world"
      blurb = {}

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :create_blurb && !options.nil? &&
              request.parent == "hello world" &&
              Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Blurb) == request.blurb
          end
        end

        # Call method
        response = client.create_blurb parent: parent, blurb: blurb
        assert_equal mock_response, response

        # Call method with block
        client.create_blurb parent: parent, blurb: blurb do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "get_blurb" do
    it "invokes get_blurb without error" do
      # Create request parameters
      name = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :get_blurb && !options.nil? &&
              request.name == "hello world"
          end
        end

        # Call method
        response = client.get_blurb name: name
        assert_equal mock_response, response

        # Call method with block
        client.get_blurb name: name do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "update_blurb" do
    it "invokes update_blurb without error" do
      # Create request parameters
      blurb = {}
      update_mask = {}

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :update_blurb && !options.nil? &&
              Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Blurb) == request.blurb &&
              Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask) == request.update_mask
          end
        end

        # Call method
        response = client.update_blurb blurb: blurb, update_mask: update_mask
        assert_equal mock_response, response

        # Call method with block
        client.update_blurb blurb: blurb, update_mask: update_mask do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "delete_blurb" do
    it "invokes delete_blurb without error" do
      # Create request parameters
      name = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :delete_blurb && !options.nil? &&
              request.name == "hello world"
          end
        end

        # Call method
        response = client.delete_blurb name: name
        assert_equal mock_response, response

        # Call method with block
        client.delete_blurb name: name do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "list_blurbs" do
    it "invokes list_blurbs without error" do
      # Create request parameters
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :list_blurbs && !options.nil? &&
              request.parent == "hello world" &&
              request.page_size == 42 &&
              request.page_token == "hello world"
          end
        end

        # Call method
        response = client.list_blurbs parent: parent, page_size: page_size, page_token: page_token
        assert_equal mock_response, response

        # Call method with block
        client.list_blurbs parent: parent, page_size: page_size, page_token: page_token do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "search_blurbs" do
    it "invokes search_blurbs without error" do
      # Create request parameters
      query = "hello world"
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :search_blurbs && !options.nil? &&
              request.query == "hello world" &&
              request.parent == "hello world" &&
              request.page_size == 42 &&
              request.page_token == "hello world"
          end
        end

        # Call method
        response = client.search_blurbs query: query, parent: parent, page_size: page_size, page_token: page_token
        assert_equal mock_response, response

        # Call method with block
        client.search_blurbs query: query, parent: parent, page_size: page_size, page_token: page_token do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  # TODO

  # TODO

  # TODO
end
