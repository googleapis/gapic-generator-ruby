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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!

require "helper"
require "gapic/rest"
require "google/showcase/v1beta1/echo_pb"
require "google/showcase/v1beta1/echo/rest"


class ::Google::Showcase::V1beta1::Echo::Rest::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_count, :requests

    def initialize response, &block
      @response = response
      @block = block
      @call_count = 0
      @requests = []
    end

    def make_get_request uri:, params: {}, options: {}
      make_http_request :get, uri: uri, body: nil, params: params, options: options
    end

    def make_delete_request uri:, params: {}, options: {}
      make_http_request :delete, uri: uri, body: nil, params: params, options: options
    end

    def make_post_request uri:, body: nil, params: {}, options: {}
      make_http_request :post, uri: uri, body: body, params: params, options: options
    end

    def make_patch_request uri:, body:, params: {}, options: {}
      make_http_request :patch, uri: uri, body: body, params: params, options: options
    end

    def make_put_request uri:, body:, params: {}, options: {}
      make_http_request :put, uri: uri, body: body, params: params, options: options
    end

    def make_http_request *args, **kwargs
      @call_count += 1

      @requests << @block&.call(*args, **kwargs)

      @response
    end
  end

  def test_echo
    # Create test objects.
    client_result = ::Google::Showcase::V1beta1::EchoResponse.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    content = "hello world"
    severity = :UNNECESSARY
    header = "hello world"
    other_header = "hello world"

    echo_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::Echo::Rest::ServiceStub.stub :transcode_echo_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, echo_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::Echo::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.echo({ content: content, severity: severity, header: header, other_header: other_header }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.echo content: content, severity: severity, header: header, other_header: other_header do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.echo ::Google::Showcase::V1beta1::EchoRequest.new(content: content, severity: severity, header: header, other_header: other_header) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.echo({ content: content, severity: severity, header: header, other_header: other_header }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.echo(::Google::Showcase::V1beta1::EchoRequest.new(content: content, severity: severity, header: header, other_header: other_header), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, echo_client_stub.call_count
      end
    end
  end

  def test_expand
    # Create test objects.
    client_result = ::Google::Showcase::V1beta1::EchoResponse.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    content = "hello world"
    error = {}

    expand_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:, is_server_streaming:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::Echo::Rest::ServiceStub.stub :transcode_expand_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, expand_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::Echo::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.expand({ content: content, error: error }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end.first

        # Use named arguments
        client.expand content: content, error: error do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end.first

        # Use protobuf object
        client.expand ::Google::Showcase::V1beta1::ExpandRequest.new(content: content, error: error) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end.first

        # Use hash object with options
        client.expand({ content: content, error: error }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end.first

        # Use protobuf object with options
        client.expand(::Google::Showcase::V1beta1::ExpandRequest.new(content: content, error: error), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end.first

        # Verify method calls
        assert_equal 5, expand_client_stub.call_count
      end
    end
  end

  def test_paged_expand
    # Create test objects.
    client_result = ::Google::Showcase::V1beta1::PagedExpandResponse.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    content = "hello world"
    page_size = 42
    page_token = "hello world"

    paged_expand_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::Echo::Rest::ServiceStub.stub :transcode_paged_expand_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, paged_expand_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::Echo::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.paged_expand({ content: content, page_size: page_size, page_token: page_token }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.paged_expand content: content, page_size: page_size, page_token: page_token do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.paged_expand ::Google::Showcase::V1beta1::PagedExpandRequest.new(content: content, page_size: page_size, page_token: page_token) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.paged_expand({ content: content, page_size: page_size, page_token: page_token }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.paged_expand(::Google::Showcase::V1beta1::PagedExpandRequest.new(content: content, page_size: page_size, page_token: page_token), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, paged_expand_client_stub.call_count
      end
    end
  end

  def test_paged_expand_legacy
    # Create test objects.
    client_result = ::Google::Showcase::V1beta1::PagedExpandResponse.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    content = "hello world"
    max_results = 42
    page_token = "hello world"

    paged_expand_legacy_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::Echo::Rest::ServiceStub.stub :transcode_paged_expand_legacy_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, paged_expand_legacy_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::Echo::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.paged_expand_legacy({ content: content, max_results: max_results, page_token: page_token }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.paged_expand_legacy content: content, max_results: max_results, page_token: page_token do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.paged_expand_legacy ::Google::Showcase::V1beta1::PagedExpandLegacyRequest.new(content: content, max_results: max_results, page_token: page_token) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.paged_expand_legacy({ content: content, max_results: max_results, page_token: page_token }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.paged_expand_legacy(::Google::Showcase::V1beta1::PagedExpandLegacyRequest.new(content: content, max_results: max_results, page_token: page_token), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, paged_expand_legacy_client_stub.call_count
      end
    end
  end

  def test_paged_expand_legacy_mapped
    # Create test objects.
    client_result = ::Google::Showcase::V1beta1::PagedExpandLegacyMappedResponse.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    content = "hello world"
    page_size = 42
    page_token = "hello world"

    paged_expand_legacy_mapped_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::Echo::Rest::ServiceStub.stub :transcode_paged_expand_legacy_mapped_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, paged_expand_legacy_mapped_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::Echo::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.paged_expand_legacy_mapped({ content: content, page_size: page_size, page_token: page_token }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.paged_expand_legacy_mapped content: content, page_size: page_size, page_token: page_token do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.paged_expand_legacy_mapped ::Google::Showcase::V1beta1::PagedExpandRequest.new(content: content, page_size: page_size, page_token: page_token) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.paged_expand_legacy_mapped({ content: content, page_size: page_size, page_token: page_token }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.paged_expand_legacy_mapped(::Google::Showcase::V1beta1::PagedExpandRequest.new(content: content, page_size: page_size, page_token: page_token), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, paged_expand_legacy_mapped_client_stub.call_count
      end
    end
  end

  def test_wait
    # Create test objects.
    client_result = ::Google::Longrunning::Operation.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    end_time = {}
    error = {}

    wait_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::Echo::Rest::ServiceStub.stub :transcode_wait_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, wait_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::Echo::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.wait({ end_time: end_time, error: error }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.wait end_time: end_time, error: error do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.wait ::Google::Showcase::V1beta1::WaitRequest.new(end_time: end_time, error: error) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.wait({ end_time: end_time, error: error }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.wait(::Google::Showcase::V1beta1::WaitRequest.new(end_time: end_time, error: error), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, wait_client_stub.call_count
      end
    end
  end

  def test_block
    # Create test objects.
    client_result = ::Google::Showcase::V1beta1::BlockResponse.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    response_delay = {}
    error = {}

    block_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::Echo::Rest::ServiceStub.stub :transcode_block_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, block_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::Echo::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.block({ response_delay: response_delay, error: error }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.block response_delay: response_delay, error: error do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.block ::Google::Showcase::V1beta1::BlockRequest.new(response_delay: response_delay, error: error) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.block({ response_delay: response_delay, error: error }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.block(::Google::Showcase::V1beta1::BlockRequest.new(response_delay: response_delay, error: error), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, block_client_stub.call_count
      end
    end
  end

  def test_configure
    credentials_token = :dummy_value

    client = block_config = config = nil
    Gapic::Rest::ClientStub.stub :new, nil do
      client = ::Google::Showcase::V1beta1::Echo::Rest::Client.new do |config|
        config.credentials = credentials_token
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Showcase::V1beta1::Echo::Rest::Client::Configuration, config
  end
end
