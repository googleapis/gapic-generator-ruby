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

  def test_create_room
    # Create GRPC objects
    grpc_response = Google::Showcase::V1beta1::Room.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    room = {}

    create_room_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_room, name
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Room), request.room
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_room_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.create_room room: room do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_room room: room do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_room Google::Showcase::V1beta1::CreateRoomRequest.new(room: room) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_room({ room: room }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_room Google::Showcase::V1beta1::CreateRoomRequest.new(room: room), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_room_client_stub.call_rpc_count
    end
  end

  def test_get_room
    # Create GRPC objects
    grpc_response = Google::Showcase::V1beta1::Room.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    name = "hello world"

    get_room_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_room, name
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_room_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.get_room name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_room name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_room Google::Showcase::V1beta1::GetRoomRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_room({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_room Google::Showcase::V1beta1::GetRoomRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_room_client_stub.call_rpc_count
    end
  end

  def test_update_room
    # Create GRPC objects
    grpc_response = Google::Showcase::V1beta1::Room.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    room = {}
    update_mask = {}

    update_room_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_room, name
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Room), request.room
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_room_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.update_room room: room, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_room room: room, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_room Google::Showcase::V1beta1::UpdateRoomRequest.new(room: room, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_room({ room: room, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_room Google::Showcase::V1beta1::UpdateRoomRequest.new(room: room, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_room_client_stub.call_rpc_count
    end
  end

  def test_delete_room
    # Create GRPC objects
    grpc_response = Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    name = "hello world"

    delete_room_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_room, name
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_room_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.delete_room name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_room name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_room Google::Showcase::V1beta1::DeleteRoomRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_room({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_room Google::Showcase::V1beta1::DeleteRoomRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_room_client_stub.call_rpc_count
    end
  end

  def test_list_rooms
    # Create GRPC objects
    grpc_response = Google::Showcase::V1beta1::ListRoomsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    page_size = 42
    page_token = "hello world"

    list_rooms_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_rooms, name
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_rooms_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.list_rooms page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_rooms page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_rooms Google::Showcase::V1beta1::ListRoomsRequest.new(page_size: page_size, page_token: page_token) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_rooms({ page_size: page_size, page_token: page_token }, grpc_options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_rooms Google::Showcase::V1beta1::ListRoomsRequest.new(page_size: page_size, page_token: page_token), grpc_options do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_rooms_client_stub.call_rpc_count
    end
  end

  def test_create_blurb
    # Create GRPC objects
    grpc_response = Google::Showcase::V1beta1::Blurb.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    parent = "hello world"
    blurb = {}

    create_blurb_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_blurb, name
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Blurb), request.blurb
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_blurb_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.create_blurb parent: parent, blurb: blurb do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_blurb parent: parent, blurb: blurb do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_blurb Google::Showcase::V1beta1::CreateBlurbRequest.new(parent: parent, blurb: blurb) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_blurb({ parent: parent, blurb: blurb }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_blurb Google::Showcase::V1beta1::CreateBlurbRequest.new(parent: parent, blurb: blurb), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_blurb_client_stub.call_rpc_count
    end
  end

  def test_get_blurb
    # Create GRPC objects
    grpc_response = Google::Showcase::V1beta1::Blurb.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    name = "hello world"

    get_blurb_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_blurb, name
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_blurb_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.get_blurb name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_blurb name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_blurb Google::Showcase::V1beta1::GetBlurbRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_blurb({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_blurb Google::Showcase::V1beta1::GetBlurbRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_blurb_client_stub.call_rpc_count
    end
  end

  def test_update_blurb
    # Create GRPC objects
    grpc_response = Google::Showcase::V1beta1::Blurb.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    blurb = {}
    update_mask = {}

    update_blurb_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_blurb, name
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Blurb), request.blurb
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_blurb_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.update_blurb blurb: blurb, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_blurb blurb: blurb, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_blurb Google::Showcase::V1beta1::UpdateBlurbRequest.new(blurb: blurb, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_blurb({ blurb: blurb, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_blurb Google::Showcase::V1beta1::UpdateBlurbRequest.new(blurb: blurb, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_blurb_client_stub.call_rpc_count
    end
  end

  def test_delete_blurb
    # Create GRPC objects
    grpc_response = Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    name = "hello world"

    delete_blurb_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_blurb, name
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_blurb_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.delete_blurb name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_blurb name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_blurb Google::Showcase::V1beta1::DeleteBlurbRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_blurb({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_blurb Google::Showcase::V1beta1::DeleteBlurbRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_blurb_client_stub.call_rpc_count
    end
  end

  def test_list_blurbs
    # Create GRPC objects
    grpc_response = Google::Showcase::V1beta1::ListBlurbsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    list_blurbs_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_blurbs, name
      assert_equal "hello world", request.parent
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_blurbs_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.list_blurbs parent: parent, page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_blurbs parent: parent, page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_blurbs Google::Showcase::V1beta1::ListBlurbsRequest.new(parent: parent, page_size: page_size, page_token: page_token) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_blurbs({ parent: parent, page_size: page_size, page_token: page_token }, grpc_options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_blurbs Google::Showcase::V1beta1::ListBlurbsRequest.new(parent: parent, page_size: page_size, page_token: page_token), grpc_options do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_blurbs_client_stub.call_rpc_count
    end
  end

  def test_search_blurbs
    # Create GRPC objects
    grpc_response = Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    query = "hello world"
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    search_blurbs_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :search_blurbs, name
      assert_equal "hello world", request.query
      assert_equal "hello world", request.parent
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, search_blurbs_client_stub do
      # Create client
      client = Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.search_blurbs query: query, parent: parent, page_size: page_size, page_token: page_token do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.search_blurbs query: query, parent: parent, page_size: page_size, page_token: page_token do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.search_blurbs Google::Showcase::V1beta1::SearchBlurbsRequest.new(query: query, parent: parent, page_size: page_size, page_token: page_token) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.search_blurbs({ query: query, parent: parent, page_size: page_size, page_token: page_token }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.search_blurbs Google::Showcase::V1beta1::SearchBlurbsRequest.new(query: query, parent: parent, page_size: page_size, page_token: page_token), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, search_blurbs_client_stub.call_rpc_count
    end
  end

  # TODO

  # TODO

  # TODO
end
