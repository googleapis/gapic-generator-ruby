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

class Google::Showcase::V1beta1::Echo::ClientTest < Minitest::Test
  def setup
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    @mock_stub = MiniTest::Mock.new
    @mock_page_enum = :mock_page_enum
    @response = :mock_response
    @grpc_operation = :mock_grpc_operation
    @options = {}
  end

  def with_stubs
    Gapic::ServiceStub.stub :new, @mock_stub do
      Gapic::PagedEnumerable.stub :new, @mock_page_enum do
        yield
      end
    end
  end

  def test_echo
    # Create request parameters
    content = "hello world"

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :echo, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.content

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.echo content: content do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.echo(Google::Showcase::V1beta1::EchoRequest.new(content: content)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.echo request = { content: content } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.echo request = Google::Showcase::V1beta1::EchoRequest.new({ content: content }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.echo({ content: content }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.echo(Google::Showcase::V1beta1::EchoRequest.new(content: content), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.echo(request = { content: content }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.echo(request = Google::Showcase::V1beta1::EchoRequest.new({ content: content }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
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

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :paged_expand, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.content
          assert_equal 42, request.page_size
          assert_equal "hello world", request.page_token

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.paged_expand content: content, page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.paged_expand(Google::Showcase::V1beta1::PagedExpandRequest.new(content: content, page_size: page_size, page_token: page_token)) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.paged_expand request = { content: content, page_size: page_size, page_token: page_token } do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.paged_expand request = Google::Showcase::V1beta1::PagedExpandRequest.new({ content: content, page_size: page_size, page_token: page_token }) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.paged_expand({ content: content, page_size: page_size, page_token: page_token }, @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.paged_expand(Google::Showcase::V1beta1::PagedExpandRequest.new(content: content, page_size: page_size, page_token: page_token), @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.paged_expand(request = { content: content, page_size: page_size, page_token: page_token }, options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.paged_expand(request = Google::Showcase::V1beta1::PagedExpandRequest.new({ content: content, page_size: page_size, page_token: page_token }), options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_wait
    # Create request parameters
    end_time = {}
    error = {}

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :wait, name
          refute_nil options
          refute_nil block
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::Timestamp), request.end_time
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Rpc::Status), request.error

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.wait end_time: end_time, error: error do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.wait(Google::Showcase::V1beta1::WaitRequest.new(end_time: end_time, error: error)) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.wait request = { end_time: end_time, error: error } do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.wait request = Google::Showcase::V1beta1::WaitRequest.new({ end_time: end_time, error: error }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.wait({ end_time: end_time, error: error }, @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.wait(Google::Showcase::V1beta1::WaitRequest.new(end_time: end_time, error: error), @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.wait(request = { end_time: end_time, error: error }, options = @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.wait(request = Google::Showcase::V1beta1::WaitRequest.new({ end_time: end_time, error: error }), options = @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_block
    # Create request parameters
    response_delay = {}

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :block, name
          refute_nil options
          refute_nil block
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::Duration), request.response_delay

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.block response_delay: response_delay do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.block(Google::Showcase::V1beta1::BlockRequest.new(response_delay: response_delay)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.block request = { response_delay: response_delay } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.block request = Google::Showcase::V1beta1::BlockRequest.new({ response_delay: response_delay }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.block({ response_delay: response_delay }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.block(Google::Showcase::V1beta1::BlockRequest.new(response_delay: response_delay), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.block(request = { response_delay: response_delay }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.block(request = Google::Showcase::V1beta1::BlockRequest.new({ response_delay: response_delay }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end
end
