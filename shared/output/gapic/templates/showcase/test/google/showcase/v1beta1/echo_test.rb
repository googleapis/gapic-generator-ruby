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

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :echo
          has_options = !options.nil?
          has_fields = request.content == "hello world"

          assert has_name, "invalid method call: #{name} (expected echo)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.echo content: content
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.echo Google::Showcase::V1beta1::EchoRequest.new(content: content)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.echo request = { content: content }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.echo request = Google::Showcase::V1beta1::EchoRequest.new content: content
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.echo({ content: content }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.echo Google::Showcase::V1beta1::EchoRequest.new(content: content), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.echo request = { content: content }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.echo request = Google::Showcase::V1beta1::EchoRequest.new content: content, options = @options
      assert_equal @response, response

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

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :paged_expand
          has_options = !options.nil?
          has_fields = request.content == "hello world" && request.page_size == 42 && request.page_token == "hello world"

          assert has_name, "invalid method call: #{name} (expected paged_expand)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.paged_expand content: content, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.paged_expand Google::Showcase::V1beta1::PagedExpandRequest.new(content: content, page_size: page_size, page_token: page_token)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.paged_expand request = { content: content, page_size: page_size, page_token: page_token }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.paged_expand request = Google::Showcase::V1beta1::PagedExpandRequest.new content: content, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.paged_expand({ content: content, page_size: page_size, page_token: page_token }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.paged_expand Google::Showcase::V1beta1::PagedExpandRequest.new(content: content, page_size: page_size, page_token: page_token), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.paged_expand request = { content: content, page_size: page_size, page_token: page_token }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.paged_expand request = Google::Showcase::V1beta1::PagedExpandRequest.new content: content, page_size: page_size, page_token: page_token, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
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

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :wait
          has_options = !options.nil?
          has_fields = Gapic::Protobuf.coerce({}, to: Google::Protobuf::Timestamp) == request.end_time && Gapic::Protobuf.coerce({}, to: Google::Rpc::Status) == request.error

          assert has_name, "invalid method call: #{name} (expected wait)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.wait end_time: end_time, error: error
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.wait Google::Showcase::V1beta1::WaitRequest.new(end_time: end_time, error: error)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.wait request = { end_time: end_time, error: error }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.wait request = Google::Showcase::V1beta1::WaitRequest.new end_time: end_time, error: error
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.wait({ end_time: end_time, error: error }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.wait Google::Showcase::V1beta1::WaitRequest.new(end_time: end_time, error: error), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.wait request = { end_time: end_time, error: error }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.wait request = Google::Showcase::V1beta1::WaitRequest.new end_time: end_time, error: error, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
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

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:|
          has_name = name == :block
          has_options = !options.nil?
          has_fields = Gapic::Protobuf.coerce({}, to: Google::Protobuf::Duration) == request.response_delay

          assert has_name, "invalid method call: #{name} (expected block)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_fields, "invalid field values"

          # TODO: what to do with block?

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.block response_delay: response_delay
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.block Google::Showcase::V1beta1::BlockRequest.new(response_delay: response_delay)
      assert_equal @response, response

      # Call method (named / hash)
      response = client.block request = { response_delay: response_delay }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.block request = Google::Showcase::V1beta1::BlockRequest.new response_delay: response_delay
      assert_equal @response, response

      # TODO: add block arg to these tests!?

      # Call method with options (positional / hash)
      response = client.block({ response_delay: response_delay }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.block Google::Showcase::V1beta1::BlockRequest.new(response_delay: response_delay), @options
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.block request = { response_delay: response_delay }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.block request = Google::Showcase::V1beta1::BlockRequest.new response_delay: response_delay, options = @options
      assert_equal @response, response

      # Verify method calls
      @mock_stub.verify
    end
  end
end
