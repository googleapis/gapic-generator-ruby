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

      8.times do
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

      # Call method (positional / hash)
      response = client.list_operations name: name, filter: filter, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.list_operations(Google::Longrunning::ListOperationsRequest.new(
                                          name: name, filter: filter, page_size: page_size, page_token: page_token
                                        ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.list_operations request = { name: name, filter: filter, page_size: page_size, page_token: page_token }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.list_operations request = Google::Longrunning::ListOperationsRequest.new(
        name: name, filter: filter, page_size: page_size, page_token: page_token
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.list_operations({ name: name, filter: filter, page_size: page_size, page_token: page_token }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.list_operations(Google::Longrunning::ListOperationsRequest.new(
                                          name: name, filter: filter, page_size: page_size, page_token: page_token
                                        ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.list_operations request = { name: name, filter: filter, page_size: page_size, page_token: page_token }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.list_operations request = Google::Longrunning::ListOperationsRequest.new(
        name: name, filter: filter, page_size: page_size, page_token: page_token
      ), options = @options
      assert_equal @response, response
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

      8.times do
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

      # Call method (positional / hash)
      response = client.get_operation name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.get_operation(Google::Longrunning::GetOperationRequest.new(
                                        name: name
                                      ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.get_operation request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.get_operation request = Google::Longrunning::GetOperationRequest.new(
        name: name
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.get_operation({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.get_operation(Google::Longrunning::GetOperationRequest.new(
                                        name: name
                                      ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.get_operation request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.get_operation request = Google::Longrunning::GetOperationRequest.new(
        name: name
      ), options = @options
      assert_equal @response, response
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

      8.times do
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

      # Call method (positional / hash)
      response = client.delete_operation name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.delete_operation(Google::Longrunning::DeleteOperationRequest.new(
                                           name: name
                                         ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.delete_operation request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.delete_operation request = Google::Longrunning::DeleteOperationRequest.new(
        name: name
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.delete_operation({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.delete_operation(Google::Longrunning::DeleteOperationRequest.new(
                                           name: name
                                         ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.delete_operation request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.delete_operation request = Google::Longrunning::DeleteOperationRequest.new(
        name: name
      ), options = @options
      assert_equal @response, response
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

      8.times do
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

      # Call method (positional / hash)
      response = client.cancel_operation name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.cancel_operation(Google::Longrunning::CancelOperationRequest.new(
                                           name: name
                                         ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.cancel_operation request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.cancel_operation request = Google::Longrunning::CancelOperationRequest.new(
        name: name
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.cancel_operation({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.cancel_operation(Google::Longrunning::CancelOperationRequest.new(
                                           name: name
                                         ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.cancel_operation request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.cancel_operation request = Google::Longrunning::CancelOperationRequest.new(
        name: name
      ), options = @options
      assert_equal @response, response
    end
  end
end
