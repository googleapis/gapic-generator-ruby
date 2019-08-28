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

class Google::Showcase::V1beta1::Echo::OperationsTest < Minitest::Test
  def setup
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    @mock_stub = MiniTest::Mock.new
    @response = {}
    @options = {}
  end

  def test_list_operations
    # Create request parameters
    name = "hello world"
    filter = "hello world"
    page_size = 42
    page_token = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Operations.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :list_operations
          has_options = !options.nil?
          has_fields =
            request.name == "hello world" &&

            request.filter == "hello world" &&

            request.page_size == 42 &&

            request.page_token == "hello world"

          puts "invalid method call: #{name} (expected list_operations)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.list_operations name: name, filter: filter, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method with options
      response = client.list_operations({ name: name, filter: filter, page_size: page_size, page_token: page_token }, @options)
      assert_equal @response, response

      # Call method with block
      client.list_operations name: name, filter: filter, page_size: page_size, page_token: page_token do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.list_operations({ name: name, filter: filter, page_size: page_size, page_token: page_token }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_get_operation
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Operations.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :get_operation
          has_options = !options.nil?
          has_fields =
            request.name == "hello world"

          puts "invalid method call: #{name} (expected get_operation)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.get_operation name: name
      assert_equal @response, response

      # Call method with options
      response = client.get_operation({ name: name }, @options)
      assert_equal @response, response

      # Call method with block
      client.get_operation name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.get_operation({ name: name }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_delete_operation
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Operations.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :delete_operation
          has_options = !options.nil?
          has_fields =
            request.name == "hello world"

          puts "invalid method call: #{name} (expected delete_operation)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.delete_operation name: name
      assert_equal @response, response

      # Call method with options
      response = client.delete_operation({ name: name }, @options)
      assert_equal @response, response

      # Call method with block
      client.delete_operation name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.delete_operation({ name: name }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_cancel_operation
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Operations.new do |config|
        config.credentials = @test_channel
      end

      4.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :cancel_operation
          has_options = !options.nil?
          has_fields =
            request.name == "hello world"

          puts "invalid method call: #{name} (expected cancel_operation)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method
      response = client.cancel_operation name: name
      assert_equal @response, response

      # Call method with options
      response = client.cancel_operation({ name: name }, @options)
      assert_equal @response, response

      # Call method with block
      client.cancel_operation name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end

      # Call method with block and options
      client.cancel_operation({ name: name }, @options) do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end
end
