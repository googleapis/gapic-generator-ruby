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

require "google/showcase/v1beta1/echo_pb"
require "google/showcase/v1beta1/echo_services_pb"
require "google/showcase/v1beta1/echo"

describe Google::Showcase::V1beta1::Echo::Client do
  before :all do
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
  end

  describe "echo" do
    it "invokes echo without error" do
      # Create request parameters
      content = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Echo::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :echo && !options.nil? &&
              request.content == "hello world"
          end
        end

        # Call method
        response = client.echo content: content
        assert_equal mock_response, response

        # Call method with block
        client.echo content: content do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  # TODO

  # TODO

  # TODO

  describe "paged_expand" do
    it "invokes paged_expand without error" do
      # Create request parameters
      content = "hello world"
      page_size = 42
      page_token = "hello world"

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Echo::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :paged_expand && !options.nil? &&
              request.content == "hello world" &&
              request.page_size == 42 &&
              request.page_token == "hello world"
          end
        end

        # Call method
        response = client.paged_expand content: content, page_size: page_size, page_token: page_token
        assert_equal mock_response, response

        # Call method with block
        client.paged_expand content: content, page_size: page_size, page_token: page_token do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "wait" do
    it "invokes wait without error" do
      # Create request parameters
      end_time = {}
      error = {}

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Echo::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :wait && !options.nil? &&
              Gapic::Protobuf.coerce({}, to: Google::Protobuf::Timestamp) == request.end_time &&
              Gapic::Protobuf.coerce({}, to: Google::Rpc::Status) == request.error
          end
        end

        # Call method
        response = client.wait end_time: end_time, error: error
        assert_equal mock_response, response

        # Call method with block
        client.wait end_time: end_time, error: error do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end

  describe "block" do
    it "invokes block without error" do
      # Create request parameters
      response_delay = {}

      mock_stub = MiniTest::Mock.new
      mock_response = {}

      Gapic::ServiceStub.stub :new, mock_stub do
        # Create client
        client = Google::Showcase::V1beta1::Echo::Client.new do |config|
          config.credentials = @test_channel
        end

        2.times do
          mock_stub.expect :call_rpc, mock_response do |name, request, options|
            name == :block && !options.nil? &&
              Gapic::Protobuf.coerce({}, to: Google::Protobuf::Duration) == request.response_delay
          end
        end

        # Call method
        response = client.block response_delay: response_delay
        assert_equal mock_response, response

        # Call method with block
        client.block response_delay: response_delay do |block_response, operation|
          assert_equal expected_response, block_response
          refute_nil operation
        end
      end
    end
  end
end
