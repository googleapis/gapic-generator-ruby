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

class Google::Showcase::V1beta1::Messaging::ClientTest < Minitest::Test
  def setup
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    @mock_stub = MiniTest::Mock.new
    @response = {}
    @options = {}
  end

  def test_create_room
    # Create request parameters
    room = {}

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :create_room
          has_options = !options.nil?
          has_fields =
            Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Room) == request.room

          puts "invalid method call: #{name} (expected create_room)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.create_room room: room
      assert_equal @response, response

      # Call method with options
      response = client.create_room({ room: room }, @options)
      assert_equal @response, response

      # Call method with block
      client.create_room room: room do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.create_room({ room: room }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_get_room
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :get_room
          has_options = !options.nil?
          has_fields =
            request.name == "hello world"

          puts "invalid method call: #{name} (expected get_room)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.get_room name: name
      assert_equal @response, response

      # Call method with options
      response = client.get_room({ name: name }, @options)
      assert_equal @response, response

      # Call method with block
      client.get_room name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.get_room({ name: name }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_update_room
    # Create request parameters
    room = {}
    update_mask = {}

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :update_room
          has_options = !options.nil?
          has_fields =
            Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Room) == request.room &&

            Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask) == request.update_mask

          puts "invalid method call: #{name} (expected update_room)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.update_room room: room, update_mask: update_mask
      assert_equal @response, response

      # Call method with options
      response = client.update_room({ room: room, update_mask: update_mask }, @options)
      assert_equal @response, response

      # Call method with block
      client.update_room room: room, update_mask: update_mask do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.update_room({ room: room, update_mask: update_mask }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_delete_room
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :delete_room
          has_options = !options.nil?
          has_fields =
            request.name == "hello world"

          puts "invalid method call: #{name} (expected delete_room)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.delete_room name: name
      assert_equal @response, response

      # Call method with options
      response = client.delete_room({ name: name }, @options)
      assert_equal @response, response

      # Call method with block
      client.delete_room name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.delete_room({ name: name }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_list_rooms
    # Create request parameters
    page_size = 42
    page_token = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :list_rooms
          has_options = !options.nil?
          has_fields =
            request.page_size == 42 &&

            request.page_token == "hello world"

          puts "invalid method call: #{name} (expected list_rooms)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.list_rooms page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method with options
      response = client.list_rooms({ page_size: page_size, page_token: page_token }, @options)
      assert_equal @response, response

      # Call method with block
      client.list_rooms page_size: page_size, page_token: page_token do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.list_rooms({ page_size: page_size, page_token: page_token }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_create_blurb
    # Create request parameters
    parent = "hello world"
    blurb = {}

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :create_blurb
          has_options = !options.nil?
          has_fields =
            request.parent == "hello world" &&

            Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Blurb) == request.blurb

          puts "invalid method call: #{name} (expected create_blurb)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.create_blurb parent: parent, blurb: blurb
      assert_equal @response, response

      # Call method with options
      response = client.create_blurb({ parent: parent, blurb: blurb }, @options)
      assert_equal @response, response

      # Call method with block
      client.create_blurb parent: parent, blurb: blurb do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.create_blurb({ parent: parent, blurb: blurb }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_get_blurb
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :get_blurb
          has_options = !options.nil?
          has_fields =
            request.name == "hello world"

          puts "invalid method call: #{name} (expected get_blurb)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.get_blurb name: name
      assert_equal @response, response

      # Call method with options
      response = client.get_blurb({ name: name }, @options)
      assert_equal @response, response

      # Call method with block
      client.get_blurb name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.get_blurb({ name: name }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_update_blurb
    # Create request parameters
    blurb = {}
    update_mask = {}

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :update_blurb
          has_options = !options.nil?
          has_fields =
            Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Blurb) == request.blurb &&

            Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask) == request.update_mask

          puts "invalid method call: #{name} (expected update_blurb)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.update_blurb blurb: blurb, update_mask: update_mask
      assert_equal @response, response

      # Call method with options
      response = client.update_blurb({ blurb: blurb, update_mask: update_mask }, @options)
      assert_equal @response, response

      # Call method with block
      client.update_blurb blurb: blurb, update_mask: update_mask do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.update_blurb({ blurb: blurb, update_mask: update_mask }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_delete_blurb
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :delete_blurb
          has_options = !options.nil?
          has_fields =
            request.name == "hello world"

          puts "invalid method call: #{name} (expected delete_blurb)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.delete_blurb name: name
      assert_equal @response, response

      # Call method with options
      response = client.delete_blurb({ name: name }, @options)
      assert_equal @response, response

      # Call method with block
      client.delete_blurb name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.delete_blurb({ name: name }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_list_blurbs
    # Create request parameters
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :list_blurbs
          has_options = !options.nil?
          has_fields =
            request.parent == "hello world" &&

            request.page_size == 42 &&

            request.page_token == "hello world"

          puts "invalid method call: #{name} (expected list_blurbs)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.list_blurbs parent: parent, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method with options
      response = client.list_blurbs({ parent: parent, page_size: page_size, page_token: page_token }, @options)
      assert_equal @response, response

      # Call method with block
      client.list_blurbs parent: parent, page_size: page_size, page_token: page_token do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.list_blurbs({ parent: parent, page_size: page_size, page_token: page_token }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_search_blurbs
    # Create request parameters
    query = "hello world"
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :search_blurbs
          has_options = !options.nil?
          has_fields =
            request.query == "hello world" &&

            request.parent == "hello world" &&

            request.page_size == 42 &&

            request.page_token == "hello world"

          puts "invalid method call: #{name} (expected search_blurbs)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.search_blurbs query: query, parent: parent, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method with options
      response = client.search_blurbs({ query: query, parent: parent, page_size: page_size, page_token: page_token }, @options)
      assert_equal @response, response

      # Call method with block
      client.search_blurbs query: query, parent: parent, page_size: page_size, page_token: page_token do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.search_blurbs({ query: query, parent: parent, page_size: page_size, page_token: page_token }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  # TODO

  # TODO

  # TODO
end
