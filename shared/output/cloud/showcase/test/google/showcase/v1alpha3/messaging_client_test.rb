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

require "google/showcase/v1alpha3/messaging_pb"
require "google/showcase/v1alpha3/messaging_services_pb"
require "google/showcase/v1alpha3/messaging_client"

class CustomTestErrorV1 < StandardError; end
# Mock for the GRPC::ClientStub class.
class MockGrpcClientStubV1
  # @param expected_symbol [Symbol] the symbol of the grpc method to be mocked.
  # @param mock_method [Proc] The method that is being mocked.
  def initialize expected_symbol, mock_method
    @expected_symbol = expected_symbol
    @mock_method = mock_method
  end

  # This overrides the Object#method method to return the mocked method when the mocked method
  # is being requested. For methods that aren"t being tested, this method returns a proc that
  # will raise an error when called. This is to assure that only the mocked grpc method is being
  # called.
  #
  # @param symbol [Symbol] The symbol of the method being requested.
  # @return [Proc] The proc of the requested method. If the requested method is not being mocked
  #   the proc returned will raise when called.
  def method symbol
    return @mock_method if symbol == @expected_symbol

    # The requested method is not being tested, raise if it called.
    proc do
      raise "The method #{symbol} was unexpectedly called during the " \
        "test for #{@expected_symbol}."
    end
  end
end

class MockMessagingCredentialsV1alpha3 < Google::Showcase::V1alpha3::Messaging::Credentials
  def initialize method_name
    @method_name = method_name
  end

  def updater_proc
    proc do
      raise "The method `#{@method_name}` was trying to make a grpc request. This should not " \
          "happen since the grpc layer is being mocked."
    end
  end
end

describe Google::Showcase::V1alpha3::Messaging::Client do
  describe "create_room" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Messaging::Client#create_room."
    end

    it "invokes create_room without error" do
      # Create request parameters
      room = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Showcase::V1alpha3::Room

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::CreateRoomRequest, request
        assert_equal Google::Gax.to_proto(room, Google::Showcase::V1alpha3::Room), request.room
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :create_room, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "create_room"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          response = client.create_room room

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.create_room room do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes create_room with error" do
      # Create request parameters
      room = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::CreateRoomRequest, request
        assert_equal Google::Gax.to_proto(room, Google::Showcase::V1alpha3::Room), request.room
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :create_room, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "create_room"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.create_room room
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "get_room" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Messaging::Client#get_room."
    end

    it "invokes get_room without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Showcase::V1alpha3::Room

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::GetRoomRequest, request
        assert_equal Google::Gax.to_proto(name), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :get_room, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_room"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          response = client.get_room name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.get_room name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes get_room with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::GetRoomRequest, request
        assert_equal Google::Gax.to_proto(name), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :get_room, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_room"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.get_room name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "update_room" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Messaging::Client#update_room."
    end

    it "invokes update_room without error" do
      # Create request parameters
      room = {}
      update_mask = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Showcase::V1alpha3::Room

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::UpdateRoomRequest, request
        assert_equal Google::Gax.to_proto(room, Google::Showcase::V1alpha3::Room), request.room
        assert_equal Google::Gax.to_proto(update_mask, Google::Protobuf::FieldMask), request.update_mask
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :update_room, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "update_room"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          response = client.update_room room, update_mask

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.update_room room, update_mask do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes update_room with error" do
      # Create request parameters
      room = {}
      update_mask = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::UpdateRoomRequest, request
        assert_equal Google::Gax.to_proto(room, Google::Showcase::V1alpha3::Room), request.room
        assert_equal Google::Gax.to_proto(update_mask, Google::Protobuf::FieldMask), request.update_mask
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :update_room, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "update_room"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.update_room room, update_mask
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "delete_room" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Messaging::Client#delete_room."
    end

    it "invokes delete_room without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Protobuf::Empty

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::DeleteRoomRequest, request
        assert_equal Google::Gax.to_proto(name), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :delete_room, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_room"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          response = client.delete_room name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.delete_room name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes delete_room with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::DeleteRoomRequest, request
        assert_equal Google::Gax.to_proto(name), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :delete_room, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_room"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.delete_room name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "list_rooms" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Messaging::Client#list_rooms."
    end

    it "invokes list_rooms without error" do
      # Create request parameters
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Showcase::V1alpha3::ListRoomsResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::ListRoomsRequest, request
        assert_equal Google::Gax.to_proto(page_size), request.page_size
        assert_equal Google::Gax.to_proto(page_token), request.page_token
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :list_rooms, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_rooms"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          response = client.list_rooms page_size, page_token

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.list_rooms page_size, page_token do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes list_rooms with error" do
      # Create request parameters
      page_size = 42
      page_token = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::ListRoomsRequest, request
        assert_equal Google::Gax.to_proto(page_size), request.page_size
        assert_equal Google::Gax.to_proto(page_token), request.page_token
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :list_rooms, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_rooms"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.list_rooms page_size, page_token
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "create_blurb" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Messaging::Client#create_blurb."
    end

    it "invokes create_blurb without error" do
      # Create request parameters
      parent = "hello world"
      blurb = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Showcase::V1alpha3::Blurb

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::CreateBlurbRequest, request
        assert_equal Google::Gax.to_proto(parent), request.parent
        assert_equal Google::Gax.to_proto(blurb, Google::Showcase::V1alpha3::Blurb), request.blurb
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :create_blurb, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "create_blurb"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          response = client.create_blurb parent, blurb

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.create_blurb parent, blurb do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes create_blurb with error" do
      # Create request parameters
      parent = "hello world"
      blurb = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::CreateBlurbRequest, request
        assert_equal Google::Gax.to_proto(parent), request.parent
        assert_equal Google::Gax.to_proto(blurb, Google::Showcase::V1alpha3::Blurb), request.blurb
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :create_blurb, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "create_blurb"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.create_blurb parent, blurb
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "get_blurb" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Messaging::Client#get_blurb."
    end

    it "invokes get_blurb without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Showcase::V1alpha3::Blurb

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::GetBlurbRequest, request
        assert_equal Google::Gax.to_proto(name), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :get_blurb, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_blurb"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          response = client.get_blurb name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.get_blurb name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes get_blurb with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::GetBlurbRequest, request
        assert_equal Google::Gax.to_proto(name), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :get_blurb, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_blurb"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.get_blurb name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "update_blurb" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Messaging::Client#update_blurb."
    end

    it "invokes update_blurb without error" do
      # Create request parameters
      blurb = {}
      update_mask = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Showcase::V1alpha3::Blurb

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::UpdateBlurbRequest, request
        assert_equal Google::Gax.to_proto(blurb, Google::Showcase::V1alpha3::Blurb), request.blurb
        assert_equal Google::Gax.to_proto(update_mask, Google::Protobuf::FieldMask), request.update_mask
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :update_blurb, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "update_blurb"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          response = client.update_blurb blurb, update_mask

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.update_blurb blurb, update_mask do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes update_blurb with error" do
      # Create request parameters
      blurb = {}
      update_mask = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::UpdateBlurbRequest, request
        assert_equal Google::Gax.to_proto(blurb, Google::Showcase::V1alpha3::Blurb), request.blurb
        assert_equal Google::Gax.to_proto(update_mask, Google::Protobuf::FieldMask), request.update_mask
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :update_blurb, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "update_blurb"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.update_blurb blurb, update_mask
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "delete_blurb" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Messaging::Client#delete_blurb."
    end

    it "invokes delete_blurb without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Protobuf::Empty

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::DeleteBlurbRequest, request
        assert_equal Google::Gax.to_proto(name), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :delete_blurb, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_blurb"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          response = client.delete_blurb name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.delete_blurb name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes delete_blurb with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::DeleteBlurbRequest, request
        assert_equal Google::Gax.to_proto(name), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :delete_blurb, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_blurb"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.delete_blurb name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "list_blurbs" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Messaging::Client#list_blurbs."
    end

    it "invokes list_blurbs without error" do
      # Create request parameters
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Showcase::V1alpha3::ListBlurbsResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::ListBlurbsRequest, request
        assert_equal Google::Gax.to_proto(parent), request.parent
        assert_equal Google::Gax.to_proto(page_size), request.page_size
        assert_equal Google::Gax.to_proto(page_token), request.page_token
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :list_blurbs, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_blurbs"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          response = client.list_blurbs parent, page_size, page_token

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.list_blurbs parent, page_size, page_token do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes list_blurbs with error" do
      # Create request parameters
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::ListBlurbsRequest, request
        assert_equal Google::Gax.to_proto(parent), request.parent
        assert_equal Google::Gax.to_proto(page_size), request.page_size
        assert_equal Google::Gax.to_proto(page_token), request.page_token
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :list_blurbs, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_blurbs"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.list_blurbs parent, page_size, page_token
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "search_blurbs" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Messaging::Client#search_blurbs."
    end

    it "invokes search_blurbs without error" do
      # Create request parameters
      query = "hello world"
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Longrunning::Operation
      result = Google::Protobuf::Any.new
      result.pack expected_response
      operation = Google::Longrunning::Operation.new(
        name: "operations/search_blurbs_test",
        done: true,
        response: result
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::SearchBlurbsRequest, request
        assert_equal Google::Gax.to_proto(query), request.query
        assert_equal Google::Gax.to_proto(parent), request.parent
        assert_equal Google::Gax.to_proto(page_size), request.page_size
        assert_equal Google::Gax.to_proto(page_token), request.page_token
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :search_blurbs, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "search_blurbs"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          response = client.search_blurbs query, parent, page_size, page_token

          # Verify the response
          assert_equal expected_response, response.response
        end
      end
    end

    it "invokes search_blurbs and returns an operation error." do
      # Create request parameters
      query = "hello world"
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      operation_error = Google::Rpc::Status.new(
        message: "Operation error for Google::Showcase::V1alpha3::Messaging::Client#search_blurbs."
      )
      operation = Google::Longrunning::Operation.new(
        name: "operations/search_blurbs_test",
        done: true,
        error: operation_error
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::SearchBlurbsRequest, request
        assert_equal Google::Gax.to_proto(query), request.query
        assert_equal Google::Gax.to_proto(parent), request.parent
        assert_equal Google::Gax.to_proto(page_size), request.page_size
        assert_equal Google::Gax.to_proto(page_token), request.page_token
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :search_blurbs, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "search_blurbs"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          response = client.search_blurbs query, parent, page_size, page_token

          # Verify the response
          assert response.error?
          assert_equal operation_error, response.error
        end
      end
    end

    it "invokes search_blurbs with error" do
      # Create request parameters
      query = "hello world"
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::SearchBlurbsRequest, request
        assert_equal Google::Gax.to_proto(query), request.query
        assert_equal Google::Gax.to_proto(parent), request.parent
        assert_equal Google::Gax.to_proto(page_size), request.page_size
        assert_equal Google::Gax.to_proto(page_token), request.page_token
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :search_blurbs, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "search_blurbs"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.search_blurbs query, parent, page_size, page_token
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "stream_blurbs" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Messaging::Client#stream_blurbs."
    end

    it "invokes stream_blurbs without error" do
      # Create request parameters
      name = "hello world"
      expire_time = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Showcase::V1alpha3::StreamBlurbsResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::StreamBlurbsRequest, request
        assert_equal Google::Gax.to_proto(name), request.name
        assert_equal Google::Gax.to_proto(expire_time, Google::Protobuf::Timestamp), request.expire_time
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :stream_blurbs, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "stream_blurbs"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          response = client.stream_blurbs [request]

          # Verify the response
          assert_equal 1, response.count
          assert_equal expected_response, response.first
        end
      end
    end

    it "invokes stream_blurbs with error" do
      # Create request parameters
      name = "hello world"
      expire_time = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Showcase::V1alpha3::StreamBlurbsRequest, request
        assert_equal Google::Gax.to_proto(name), request.name
        assert_equal Google::Gax.to_proto(expire_time, Google::Protobuf::Timestamp), request.expire_time
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :stream_blurbs, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "stream_blurbs"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.stream_blurbs name, expire_time
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "send_blurbs" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Messaging::Client#send_blurbs."
    end

    it "invokes send_blurbs without error" do
      # Create request parameters
      request = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Showcase::V1alpha3::SendBlurbsResponse

      # Mock Grpc layer
      mock_method = proc do |requests|
        request = requests.first
        OpenStruct.new execute: [expected_response]
      end
      mock_stub = MockGrpcClientStubV1.new :send_blurbs, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "send_blurbs"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          response = client.send_blurbs [request]

          # Verify the response
          assert_equal expected_response, response
        end
      end
    end

    it "invokes send_blurbs with error" do
      # Create request parameters
      request = {}

      # Mock Grpc layer
      mock_method = proc { raise custom_error }
      mock_stub = MockGrpcClientStubV1.new :send_blurbs, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "send_blurbs"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.send_blurbs [request]
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "connect" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Showcase::V1alpha3::Messaging::Client#connect."
    end

    it "invokes connect without error" do
      # Create request parameters
      request = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax.to_proto expected_response,
                                               Google::Showcase::V1alpha3::StreamBlurbsResponse

      # Mock Grpc layer
      mock_method = proc do |requests|
        request = requests.first
        OpenStruct.new execute: [expected_response]
      end
      mock_stub = MockGrpcClientStubV1.new :connect, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "connect"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          response = client.connect [request]

          # Verify the response
          assert_equal 1, response.count
          assert_equal expected_response, response.first
        end
      end
    end

    it "invokes connect with error" do
      # Create request parameters
      request = {}

      # Mock Grpc layer
      mock_method = proc { raise custom_error }
      mock_stub = MockGrpcClientStubV1.new :connect, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "connect"

      Google::Showcase::V1alpha3::Messaging::Stub.stub :new, mock_stub do
        Google::Showcase::V1alpha3::Messaging::Client.stub :default, mock_credentials do
          client = Google::Showcase::V1alpha3::Messaging::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.connect [request]
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end
end
