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

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :create_room
          has_options = !options.nil?
          has_fields = Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Room) == request.room

          assert has_name, "invalid method call: #{name} (expected create_room)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.create_room room: room
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.create_room Google::Showcase::V1beta1::CreateRoomRequest.new(room: room)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.create_room request = { room: room }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.create_room request = Google::Showcase::V1beta1::CreateRoomRequest.new room: room
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.create_room({ room: room }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.create_room Google::Showcase::V1beta1::CreateRoomRequest.new(room: room), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.create_room request = { room: room }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.create_room request = Google::Showcase::V1beta1::CreateRoomRequest.new room: room, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
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

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :get_room
          has_options = !options.nil?
          has_fields = request.name == "hello world"

          assert has_name, "invalid method call: #{name} (expected get_room)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.get_room name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.get_room Google::Showcase::V1beta1::GetRoomRequest.new(name: name)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.get_room request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.get_room request = Google::Showcase::V1beta1::GetRoomRequest.new name: name
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.get_room({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.get_room Google::Showcase::V1beta1::GetRoomRequest.new(name: name), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.get_room request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.get_room request = Google::Showcase::V1beta1::GetRoomRequest.new name: name, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
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

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :update_room
          has_options = !options.nil?
          has_fields = Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Room) == request.room && Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask) == request.update_mask

          assert has_name, "invalid method call: #{name} (expected update_room)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.update_room room: room, update_mask: update_mask
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.update_room Google::Showcase::V1beta1::UpdateRoomRequest.new(room: room, update_mask: update_mask)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.update_room request = { room: room, update_mask: update_mask }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.update_room request = Google::Showcase::V1beta1::UpdateRoomRequest.new room: room, update_mask: update_mask
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.update_room({ room: room, update_mask: update_mask }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.update_room Google::Showcase::V1beta1::UpdateRoomRequest.new(room: room, update_mask: update_mask), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.update_room request = { room: room, update_mask: update_mask }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.update_room request = Google::Showcase::V1beta1::UpdateRoomRequest.new room: room, update_mask: update_mask, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
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

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :delete_room
          has_options = !options.nil?
          has_fields = request.name == "hello world"

          assert has_name, "invalid method call: #{name} (expected delete_room)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.delete_room name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.delete_room Google::Showcase::V1beta1::DeleteRoomRequest.new(name: name)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.delete_room request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.delete_room request = Google::Showcase::V1beta1::DeleteRoomRequest.new name: name
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.delete_room({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.delete_room Google::Showcase::V1beta1::DeleteRoomRequest.new(name: name), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.delete_room request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.delete_room request = Google::Showcase::V1beta1::DeleteRoomRequest.new name: name, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
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

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :list_rooms
          has_options = !options.nil?
          has_fields = request.page_size == 42 && request.page_token == "hello world"

          assert has_name, "invalid method call: #{name} (expected list_rooms)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.list_rooms page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.list_rooms Google::Showcase::V1beta1::ListRoomsRequest.new(page_size: page_size, page_token: page_token)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.list_rooms request = { page_size: page_size, page_token: page_token }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.list_rooms request = Google::Showcase::V1beta1::ListRoomsRequest.new page_size: page_size, page_token: page_token
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.list_rooms({ page_size: page_size, page_token: page_token }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.list_rooms Google::Showcase::V1beta1::ListRoomsRequest.new(page_size: page_size, page_token: page_token), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.list_rooms request = { page_size: page_size, page_token: page_token }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.list_rooms request = Google::Showcase::V1beta1::ListRoomsRequest.new page_size: page_size, page_token: page_token, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
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

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :create_blurb
          has_options = !options.nil?
          has_fields = request.parent == "hello world" && Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Blurb) == request.blurb

          assert has_name, "invalid method call: #{name} (expected create_blurb)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.create_blurb parent: parent, blurb: blurb
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.create_blurb Google::Showcase::V1beta1::CreateBlurbRequest.new(parent: parent, blurb: blurb)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.create_blurb request = { parent: parent, blurb: blurb }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.create_blurb request = Google::Showcase::V1beta1::CreateBlurbRequest.new parent: parent, blurb: blurb
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.create_blurb({ parent: parent, blurb: blurb }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.create_blurb Google::Showcase::V1beta1::CreateBlurbRequest.new(parent: parent, blurb: blurb), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.create_blurb request = { parent: parent, blurb: blurb }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.create_blurb request = Google::Showcase::V1beta1::CreateBlurbRequest.new parent: parent, blurb: blurb, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
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

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :get_blurb
          has_options = !options.nil?
          has_fields = request.name == "hello world"

          assert has_name, "invalid method call: #{name} (expected get_blurb)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.get_blurb name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.get_blurb Google::Showcase::V1beta1::GetBlurbRequest.new(name: name)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.get_blurb request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.get_blurb request = Google::Showcase::V1beta1::GetBlurbRequest.new name: name
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.get_blurb({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.get_blurb Google::Showcase::V1beta1::GetBlurbRequest.new(name: name), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.get_blurb request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.get_blurb request = Google::Showcase::V1beta1::GetBlurbRequest.new name: name, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
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

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :update_blurb
          has_options = !options.nil?
          has_fields = Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Blurb) == request.blurb && Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask) == request.update_mask

          assert has_name, "invalid method call: #{name} (expected update_blurb)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.update_blurb blurb: blurb, update_mask: update_mask
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.update_blurb Google::Showcase::V1beta1::UpdateBlurbRequest.new(blurb: blurb, update_mask: update_mask)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.update_blurb request = { blurb: blurb, update_mask: update_mask }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.update_blurb request = Google::Showcase::V1beta1::UpdateBlurbRequest.new blurb: blurb, update_mask: update_mask
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.update_blurb({ blurb: blurb, update_mask: update_mask }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.update_blurb Google::Showcase::V1beta1::UpdateBlurbRequest.new(blurb: blurb, update_mask: update_mask), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.update_blurb request = { blurb: blurb, update_mask: update_mask }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.update_blurb request = Google::Showcase::V1beta1::UpdateBlurbRequest.new blurb: blurb, update_mask: update_mask, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
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

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :delete_blurb
          has_options = !options.nil?
          has_fields = request.name == "hello world"

          assert has_name, "invalid method call: #{name} (expected delete_blurb)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.delete_blurb name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.delete_blurb Google::Showcase::V1beta1::DeleteBlurbRequest.new(name: name)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.delete_blurb request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.delete_blurb request = Google::Showcase::V1beta1::DeleteBlurbRequest.new name: name
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.delete_blurb({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.delete_blurb Google::Showcase::V1beta1::DeleteBlurbRequest.new(name: name), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.delete_blurb request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.delete_blurb request = Google::Showcase::V1beta1::DeleteBlurbRequest.new name: name, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
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

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :list_blurbs
          has_options = !options.nil?
          has_fields = request.parent == "hello world" && request.page_size == 42 && request.page_token == "hello world"

          assert has_name, "invalid method call: #{name} (expected list_blurbs)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.list_blurbs parent: parent, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.list_blurbs Google::Showcase::V1beta1::ListBlurbsRequest.new(parent: parent, page_size: page_size, page_token: page_token)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.list_blurbs request = { parent: parent, page_size: page_size, page_token: page_token }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.list_blurbs request = Google::Showcase::V1beta1::ListBlurbsRequest.new parent: parent, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.list_blurbs({ parent: parent, page_size: page_size, page_token: page_token }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.list_blurbs Google::Showcase::V1beta1::ListBlurbsRequest.new(parent: parent, page_size: page_size, page_token: page_token), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.list_blurbs request = { parent: parent, page_size: page_size, page_token: page_token }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.list_blurbs request = Google::Showcase::V1beta1::ListBlurbsRequest.new parent: parent, page_size: page_size, page_token: page_token, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
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

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :search_blurbs
          has_options = !options.nil?
          has_fields = request.query == "hello world" && request.parent == "hello world" && request.page_size == 42 && request.page_token == "hello world"

          assert has_name, "invalid method call: #{name} (expected search_blurbs)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.search_blurbs query: query, parent: parent, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.search_blurbs Google::Showcase::V1beta1::SearchBlurbsRequest.new(query: query, parent: parent, page_size: page_size, page_token: page_token)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.search_blurbs request = { query: query, parent: parent, page_size: page_size, page_token: page_token }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.search_blurbs request = Google::Showcase::V1beta1::SearchBlurbsRequest.new query: query, parent: parent, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.search_blurbs({ query: query, parent: parent, page_size: page_size, page_token: page_token }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.search_blurbs Google::Showcase::V1beta1::SearchBlurbsRequest.new(query: query, parent: parent, page_size: page_size, page_token: page_token), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.search_blurbs request = { query: query, parent: parent, page_size: page_size, page_token: page_token }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.search_blurbs request = Google::Showcase::V1beta1::SearchBlurbsRequest.new query: query, parent: parent, page_size: page_size, page_token: page_token, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
    end
  end

  # TODO

  # TODO

  # TODO
end
