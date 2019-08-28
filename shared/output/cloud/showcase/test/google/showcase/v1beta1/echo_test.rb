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

class Google::Showcase::V1beta1::Echo::ClientTest < Minitest::Test
  def setup
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    @mock_stub = MiniTest::Mock.new
    @response = {}
    @options = {}
  end

  def test_echo
    # Create request parameters
    content = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :echo
          has_options = !options.nil?
          has_fields =
            request.content == "hello world"

          puts "invalid method call: #{name} (expected echo)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.echo content: content
      assert_equal @response, response

      # Call method with options
      response = client.echo({ content: content }, @options)
      assert_equal @response, response

      # Call method with block
      client.echo content: content do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.echo({ content: content }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  # TODO

  # TODO

  # TODO

  def test_paged_expand
    # Create request parameters
    content = "hello world"
    page_size = 42
    page_token = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :paged_expand
          has_options = !options.nil?
          has_fields =
            request.content == "hello world" &&

            request.page_size == 42 &&

            request.page_token == "hello world"

          puts "invalid method call: #{name} (expected paged_expand)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.paged_expand content: content, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method with options
      response = client.paged_expand({ content: content, page_size: page_size, page_token: page_token }, @options)
      assert_equal @response, response

      # Call method with block
      client.paged_expand content: content, page_size: page_size, page_token: page_token do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.paged_expand({ content: content, page_size: page_size, page_token: page_token }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_wait
    # Create request parameters
    end_time = {}
    error = {}

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :wait
          has_options = !options.nil?
          has_fields =
            Gapic::Protobuf.coerce({}, to: Google::Protobuf::Timestamp) == request.end_time &&

            Gapic::Protobuf.coerce({}, to: Google::Rpc::Status) == request.error

          puts "invalid method call: #{name} (expected wait)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.wait end_time: end_time, error: error
      assert_equal @response, response

      # Call method with options
      response = client.wait({ end_time: end_time, error: error }, @options)
      assert_equal @response, response

      # Call method with block
      client.wait end_time: end_time, error: error do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.wait({ end_time: end_time, error: error }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_block
    # Create request parameters
    response_delay = {}

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :block
          has_options = !options.nil?
          has_fields =
            Gapic::Protobuf.coerce({}, to: Google::Protobuf::Duration) == request.response_delay

          puts "invalid method call: #{name} (expected block)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.block response_delay: response_delay
      assert_equal @response, response

      # Call method with options
      response = client.block({ response_delay: response_delay }, @options)
      assert_equal @response, response

      # Call method with block
      client.block response_delay: response_delay do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.block({ response_delay: response_delay }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end
end
