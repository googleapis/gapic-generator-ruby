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

require "simplecov"
require "minitest/autorun"

require "gapic/grpc/service_stub"

require "google/showcase/v1beta1/messaging_pb"
require "google/showcase/v1beta1/messaging_services_pb"
require "google/showcase/v1beta1/messaging"

class ::Google::Showcase::V1beta1::Messaging::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_rpc_count, :requests

    def initialize response, operation, &block
      @response = response
      @operation = operation
      @block = block
      @call_rpc_count = 0
      @requests = []
    end

    def call_rpc *args
      @call_rpc_count += 1

      @requests << @block&.call(*args)

      yield @response, @operation if block_given?

      @response
    end
  end

  def test_create_room
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::Room.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    room = {}

    create_room_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_room, name
      assert_kind_of ::Google::Showcase::V1beta1::CreateRoomRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Showcase::V1beta1::Room), request.room
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_room_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_room({ room: room }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_room room: room do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_room ::Google::Showcase::V1beta1::CreateRoomRequest.new(room: room) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_room({ room: room }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_room ::Google::Showcase::V1beta1::CreateRoomRequest.new(room: room), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_room_client_stub.call_rpc_count
    end
  end

  def test_get_room
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::Room.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_room_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_room, name
      assert_kind_of ::Google::Showcase::V1beta1::GetRoomRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_room_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_room({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_room name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_room ::Google::Showcase::V1beta1::GetRoomRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_room({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_room ::Google::Showcase::V1beta1::GetRoomRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_room_client_stub.call_rpc_count
    end
  end

  def test_update_room
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::Room.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    room = {}
    update_mask = {}

    update_room_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_room, name
      assert_kind_of ::Google::Showcase::V1beta1::UpdateRoomRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Showcase::V1beta1::Room), request.room
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_room_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_room({ room: room, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_room room: room, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_room ::Google::Showcase::V1beta1::UpdateRoomRequest.new(room: room, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_room({ room: room, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_room ::Google::Showcase::V1beta1::UpdateRoomRequest.new(room: room, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_room_client_stub.call_rpc_count
    end
  end

  def test_delete_room
    # Create GRPC objects.
    grpc_response = ::Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_room_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_room, name
      assert_kind_of ::Google::Showcase::V1beta1::DeleteRoomRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_room_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_room({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_room name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_room ::Google::Showcase::V1beta1::DeleteRoomRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_room({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_room ::Google::Showcase::V1beta1::DeleteRoomRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_room_client_stub.call_rpc_count
    end
  end

  def test_list_rooms
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::ListRoomsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    page_size = 42
    page_token = "hello world"

    list_rooms_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_rooms, name
      assert_kind_of ::Google::Showcase::V1beta1::ListRoomsRequest, request
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_rooms_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_rooms({ page_size: page_size, page_token: page_token }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_rooms page_size: page_size, page_token: page_token do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_rooms ::Google::Showcase::V1beta1::ListRoomsRequest.new(page_size: page_size, page_token: page_token) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_rooms({ page_size: page_size, page_token: page_token }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_rooms ::Google::Showcase::V1beta1::ListRoomsRequest.new(page_size: page_size, page_token: page_token), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_rooms_client_stub.call_rpc_count
    end
  end

  def test_create_blurb
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::Blurb.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    blurb = {}

    create_blurb_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :create_blurb, name
      assert_kind_of ::Google::Showcase::V1beta1::CreateBlurbRequest, request
      assert_equal "hello world", request.parent
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Showcase::V1beta1::Blurb), request.blurb
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, create_blurb_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.create_blurb({ parent: parent, blurb: blurb }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.create_blurb parent: parent, blurb: blurb do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.create_blurb ::Google::Showcase::V1beta1::CreateBlurbRequest.new(parent: parent, blurb: blurb) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.create_blurb({ parent: parent, blurb: blurb }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.create_blurb ::Google::Showcase::V1beta1::CreateBlurbRequest.new(parent: parent, blurb: blurb), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, create_blurb_client_stub.call_rpc_count
    end
  end

  def test_get_blurb
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::Blurb.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_blurb_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :get_blurb, name
      assert_kind_of ::Google::Showcase::V1beta1::GetBlurbRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, get_blurb_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.get_blurb({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.get_blurb name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.get_blurb ::Google::Showcase::V1beta1::GetBlurbRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.get_blurb({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.get_blurb ::Google::Showcase::V1beta1::GetBlurbRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, get_blurb_client_stub.call_rpc_count
    end
  end

  def test_update_blurb
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::Blurb.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    blurb = {}
    update_mask = {}

    update_blurb_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :update_blurb, name
      assert_kind_of ::Google::Showcase::V1beta1::UpdateBlurbRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Showcase::V1beta1::Blurb), request.blurb
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::FieldMask), request.update_mask
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, update_blurb_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.update_blurb({ blurb: blurb, update_mask: update_mask }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.update_blurb blurb: blurb, update_mask: update_mask do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.update_blurb ::Google::Showcase::V1beta1::UpdateBlurbRequest.new(blurb: blurb, update_mask: update_mask) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.update_blurb({ blurb: blurb, update_mask: update_mask }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.update_blurb ::Google::Showcase::V1beta1::UpdateBlurbRequest.new(blurb: blurb, update_mask: update_mask), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, update_blurb_client_stub.call_rpc_count
    end
  end

  def test_delete_blurb
    # Create GRPC objects.
    grpc_response = ::Google::Protobuf::Empty.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    delete_blurb_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :delete_blurb, name
      assert_kind_of ::Google::Showcase::V1beta1::DeleteBlurbRequest, request
      assert_equal "hello world", request.name
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, delete_blurb_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.delete_blurb({ name: name }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.delete_blurb name: name do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.delete_blurb ::Google::Showcase::V1beta1::DeleteBlurbRequest.new(name: name) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.delete_blurb({ name: name }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.delete_blurb ::Google::Showcase::V1beta1::DeleteBlurbRequest.new(name: name), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, delete_blurb_client_stub.call_rpc_count
    end
  end

  def test_list_blurbs
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::ListBlurbsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    list_blurbs_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :list_blurbs, name
      assert_kind_of ::Google::Showcase::V1beta1::ListBlurbsRequest, request
      assert_equal "hello world", request.parent
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, list_blurbs_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.list_blurbs({ parent: parent, page_size: page_size, page_token: page_token }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.list_blurbs parent: parent, page_size: page_size, page_token: page_token do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.list_blurbs ::Google::Showcase::V1beta1::ListBlurbsRequest.new(parent: parent, page_size: page_size, page_token: page_token) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.list_blurbs({ parent: parent, page_size: page_size, page_token: page_token }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.list_blurbs ::Google::Showcase::V1beta1::ListBlurbsRequest.new(parent: parent, page_size: page_size, page_token: page_token), grpc_options do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, list_blurbs_client_stub.call_rpc_count
    end
  end

  def test_search_blurbs
    # Create GRPC objects.
    grpc_response = ::Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    query = "hello world"
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    search_blurbs_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :search_blurbs, name
      assert_kind_of ::Google::Showcase::V1beta1::SearchBlurbsRequest, request
      assert_equal "hello world", request.query
      assert_equal "hello world", request.parent
      assert_equal 42, request.page_size
      assert_equal "hello world", request.page_token
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, search_blurbs_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.search_blurbs({ query: query, parent: parent, page_size: page_size, page_token: page_token }) do |response, operation|
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
      client.search_blurbs ::Google::Showcase::V1beta1::SearchBlurbsRequest.new(query: query, parent: parent, page_size: page_size, page_token: page_token) do |response, operation|
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
      client.search_blurbs ::Google::Showcase::V1beta1::SearchBlurbsRequest.new(query: query, parent: parent, page_size: page_size, page_token: page_token), grpc_options do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, search_blurbs_client_stub.call_rpc_count
    end
  end

  def test_stream_blurbs
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::StreamBlurbsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a server streaming method.
    name = "hello world"
    expire_time = {}

    stream_blurbs_client_stub = ClientStub.new [grpc_response].to_enum, grpc_operation do |name, request, options:|
      assert_equal :stream_blurbs, name
      assert_kind_of ::Google::Showcase::V1beta1::StreamBlurbsRequest, request
      assert_equal "hello world", request.name
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::Timestamp), request.expire_time
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, stream_blurbs_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.stream_blurbs({ name: name, expire_time: expire_time }) do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::StreamBlurbsResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.stream_blurbs name: name, expire_time: expire_time do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::StreamBlurbsResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.stream_blurbs ::Google::Showcase::V1beta1::StreamBlurbsRequest.new(name: name, expire_time: expire_time) do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::StreamBlurbsResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.stream_blurbs({ name: name, expire_time: expire_time }, grpc_options) do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::StreamBlurbsResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.stream_blurbs ::Google::Showcase::V1beta1::StreamBlurbsRequest.new(name: name, expire_time: expire_time), grpc_options do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::StreamBlurbsResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, stream_blurbs_client_stub.call_rpc_count
    end
  end

  def test_send_blurbs
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::SendBlurbsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a client streaming method.
    parent = "hello world"
    blurb = {}

    send_blurbs_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :send_blurbs, name
      assert_kind_of Enumerable, request
      refute_nil options
      request
    end

    Gapic::ServiceStub.stub :new, send_blurbs_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use enumerable object with hash and protobuf object.
      request_hash = { parent: parent, blurb: blurb }
      request_proto = ::Google::Showcase::V1beta1::CreateBlurbRequest.new parent: parent, blurb: blurb
      enum_input = [request_hash, request_proto].to_enum
      client.send_blurbs enum_input do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use stream input object (from gapic-common).
      request_hash = { parent: parent, blurb: blurb }
      request_proto = ::Google::Showcase::V1beta1::CreateBlurbRequest.new parent: parent, blurb: blurb
      stream_input = Gapic::StreamInput.new
      client.send_blurbs stream_input do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end
      stream_input << request_hash
      stream_input << request_proto
      stream_input.close

      # Use enumerable object with hash and protobuf object with options.
      request_hash = { parent: parent, blurb: blurb }
      request_proto = ::Google::Showcase::V1beta1::CreateBlurbRequest.new parent: parent, blurb: blurb
      enum_input = [request_hash, request_proto].to_enum
      client.send_blurbs enum_input, grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use stream input object (from gapic-common) with options.
      request_hash = { parent: parent, blurb: blurb }
      request_proto = ::Google::Showcase::V1beta1::CreateBlurbRequest.new parent: parent, blurb: blurb
      stream_input = Gapic::StreamInput.new
      client.send_blurbs stream_input, grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end
      stream_input << request_hash
      stream_input << request_proto
      stream_input.close

      # Verify method calls
      assert_equal 4, send_blurbs_client_stub.call_rpc_count
      send_blurbs_client_stub.requests.each do |request|
        request.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::CreateBlurbRequest, r
          assert_equal "hello world", r.parent
          assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Showcase::V1beta1::Blurb), r.blurb
        end
      end
    end
  end

  def test_connect
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::StreamBlurbsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a bidi streaming method.
    config = {}

    connect_client_stub = ClientStub.new [grpc_response].to_enum, grpc_operation do |name, request, options:|
      assert_equal :connect, name
      assert_kind_of Enumerable, request
      refute_nil options
      request
    end

    Gapic::ServiceStub.stub :new, connect_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use enumerable object with hash and protobuf object.
      request_hash = { config: config }
      request_proto = ::Google::Showcase::V1beta1::ConnectRequest.new config: config
      enum_input = [request_hash, request_proto].to_enum
      client.connect enum_input do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::StreamBlurbsResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use stream input object (from gapic-common).
      request_hash = { config: config }
      request_proto = ::Google::Showcase::V1beta1::ConnectRequest.new config: config
      stream_input = Gapic::StreamInput.new
      client.connect stream_input do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::StreamBlurbsResponse, r
        end
        assert_equal grpc_operation, operation
      end
      stream_input << request_hash
      stream_input << request_proto
      stream_input.close

      # Use enumerable object with hash and protobuf object with options.
      request_hash = { config: config }
      request_proto = ::Google::Showcase::V1beta1::ConnectRequest.new config: config
      enum_input = [request_hash, request_proto].to_enum
      client.connect enum_input, grpc_options do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::StreamBlurbsResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use stream input object (from gapic-common) with options.
      request_hash = { config: config }
      request_proto = ::Google::Showcase::V1beta1::ConnectRequest.new config: config
      stream_input = Gapic::StreamInput.new
      client.connect stream_input, grpc_options do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::StreamBlurbsResponse, r
        end
        assert_equal grpc_operation, operation
      end
      stream_input << request_hash
      stream_input << request_proto
      stream_input.close

      # Verify method calls
      assert_equal 4, connect_client_stub.call_rpc_count
      connect_client_stub.requests.each do |request|
        request.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::ConnectRequest, r
          assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Showcase::V1beta1::ConnectRequest::ConnectConfig), r.config
        end
      end
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Showcase::V1beta1::Messaging::Client::Configuration, config
  end

  def test_operations_client
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = nil
    Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    assert_kind_of ::Google::Showcase::V1beta1::Messaging::Operations, client.operations_client
  end
end
