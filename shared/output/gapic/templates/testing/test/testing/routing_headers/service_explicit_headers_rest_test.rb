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
require "testing/routing_headers/routing_headers_pb"
require "testing/routing_headers/service_explicit_headers/rest"


class ::Testing::RoutingHeaders::ServiceExplicitHeaders::Rest::ClientTest < Minitest::Test
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

  def test_plain_no_template
    # Create test objects.
    client_result = ::Testing::RoutingHeaders::Response.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    table_name = "hello world"
    app_profile_id = "hello world"
    resource = {}

    plain_no_template_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Testing::RoutingHeaders::ServiceExplicitHeaders::Rest::ServiceStub.stub :transcode_plain_no_template_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, plain_no_template_client_stub do
        # Create client
        client = ::Testing::RoutingHeaders::ServiceExplicitHeaders::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.plain_no_template({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.plain_no_template table_name: table_name, app_profile_id: app_profile_id, resource: resource do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.plain_no_template ::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.plain_no_template({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.plain_no_template(::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, plain_no_template_client_stub.call_count
      end
    end
  end

  def test_plain_full_field
    # Create test objects.
    client_result = ::Testing::RoutingHeaders::Response.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    table_name = "hello world"
    app_profile_id = "hello world"
    resource = {}

    plain_full_field_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Testing::RoutingHeaders::ServiceExplicitHeaders::Rest::ServiceStub.stub :transcode_plain_full_field_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, plain_full_field_client_stub do
        # Create client
        client = ::Testing::RoutingHeaders::ServiceExplicitHeaders::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.plain_full_field({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.plain_full_field table_name: table_name, app_profile_id: app_profile_id, resource: resource do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.plain_full_field ::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.plain_full_field({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.plain_full_field(::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, plain_full_field_client_stub.call_count
      end
    end
  end

  def test_plain_extract
    # Create test objects.
    client_result = ::Testing::RoutingHeaders::Response.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    table_name = "hello world"
    app_profile_id = "hello world"
    resource = {}

    plain_extract_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Testing::RoutingHeaders::ServiceExplicitHeaders::Rest::ServiceStub.stub :transcode_plain_extract_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, plain_extract_client_stub do
        # Create client
        client = ::Testing::RoutingHeaders::ServiceExplicitHeaders::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.plain_extract({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.plain_extract table_name: table_name, app_profile_id: app_profile_id, resource: resource do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.plain_extract ::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.plain_extract({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.plain_extract(::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, plain_extract_client_stub.call_count
      end
    end
  end

  def test_complex
    # Create test objects.
    client_result = ::Testing::RoutingHeaders::Response.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    table_name = "hello world"
    app_profile_id = "hello world"
    resource = {}

    complex_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Testing::RoutingHeaders::ServiceExplicitHeaders::Rest::ServiceStub.stub :transcode_complex_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, complex_client_stub do
        # Create client
        client = ::Testing::RoutingHeaders::ServiceExplicitHeaders::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.complex({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.complex table_name: table_name, app_profile_id: app_profile_id, resource: resource do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.complex ::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.complex({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.complex(::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, complex_client_stub.call_count
      end
    end
  end

  def test_with_sub_message
    # Create test objects.
    client_result = ::Testing::RoutingHeaders::Response.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    table_name = "hello world"
    app_profile_id = "hello world"
    resource = {}

    with_sub_message_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Testing::RoutingHeaders::ServiceExplicitHeaders::Rest::ServiceStub.stub :transcode_with_sub_message_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, with_sub_message_client_stub do
        # Create client
        client = ::Testing::RoutingHeaders::ServiceExplicitHeaders::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.with_sub_message({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.with_sub_message table_name: table_name, app_profile_id: app_profile_id, resource: resource do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.with_sub_message ::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.with_sub_message({ table_name: table_name, app_profile_id: app_profile_id, resource: resource }, call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.with_sub_message(::Testing::RoutingHeaders::Request.new(table_name: table_name, app_profile_id: app_profile_id, resource: resource), call_options) do |_result, response|
          assert_kind_of ::Gapic::Rest::TransportOperation, response
        assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, with_sub_message_client_stub.call_count
      end
    end
  end

  def test_configure
    credentials_token = :dummy_value

    client = block_config = config = nil
    Gapic::Rest::ClientStub.stub :new, nil do
      client = ::Testing::RoutingHeaders::ServiceExplicitHeaders::Rest::Client.new do |config|
        config.credentials = credentials_token
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Testing::RoutingHeaders::ServiceExplicitHeaders::Rest::Client::Configuration, config
  end
end
