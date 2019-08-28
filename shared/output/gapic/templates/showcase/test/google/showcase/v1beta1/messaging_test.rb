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

require "google/showcase/v1beta1/messaging_pb"
require "google/showcase/v1beta1/messaging_services_pb"
require "google/showcase/v1beta1/messaging"

class Google::Showcase::V1beta1::Messaging::ClientTest < Minitest::Test
  def setup
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
  end

  def test_create_room
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

  def test_get_room
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

  def test_update_room
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

  def test_delete_room
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

  def test_list_rooms
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

  def test_create_blurb
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

  def test_get_blurb
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

  def test_update_blurb
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

  def test_delete_blurb
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

  def test_list_blurbs
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

  def test_search_blurbs
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

  # TODO

  # TODO

  # TODO
end
