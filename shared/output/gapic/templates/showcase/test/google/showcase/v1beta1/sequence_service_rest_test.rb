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
require "google/showcase/v1beta1/sequence_pb"
require "google/showcase/v1beta1/sequence_service/rest"


class ::Google::Showcase::V1beta1::SequenceService::Rest::ClientTest < Minitest::Test
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

    def endpoint
      "endpoint.example.com"
    end

    def universe_domain
      "example.com"
    end
  end

  def test_create_sequence
    # Create test objects.
    client_result = ::Google::Showcase::V1beta1::Sequence.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    sequence = {}

    create_sequence_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::SequenceService::Rest::ServiceStub.stub :transcode_create_sequence_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, create_sequence_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::SequenceService::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.create_sequence({ sequence: sequence }) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.create_sequence sequence: sequence do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.create_sequence ::Google::Showcase::V1beta1::CreateSequenceRequest.new(sequence: sequence) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.create_sequence({ sequence: sequence }, call_options) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.create_sequence(::Google::Showcase::V1beta1::CreateSequenceRequest.new(sequence: sequence), call_options) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, create_sequence_client_stub.call_count
      end
    end
  end

  def test_create_streaming_sequence
    # Create test objects.
    client_result = ::Google::Showcase::V1beta1::StreamingSequence.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    streaming_sequence = {}

    create_streaming_sequence_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::SequenceService::Rest::ServiceStub.stub :transcode_create_streaming_sequence_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, create_streaming_sequence_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::SequenceService::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.create_streaming_sequence({ streaming_sequence: streaming_sequence }) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.create_streaming_sequence streaming_sequence: streaming_sequence do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.create_streaming_sequence ::Google::Showcase::V1beta1::CreateStreamingSequenceRequest.new(streaming_sequence: streaming_sequence) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.create_streaming_sequence({ streaming_sequence: streaming_sequence }, call_options) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.create_streaming_sequence(::Google::Showcase::V1beta1::CreateStreamingSequenceRequest.new(streaming_sequence: streaming_sequence), call_options) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, create_streaming_sequence_client_stub.call_count
      end
    end
  end

  def test_get_sequence_report
    # Create test objects.
    client_result = ::Google::Showcase::V1beta1::SequenceReport.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_sequence_report_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::SequenceService::Rest::ServiceStub.stub :transcode_get_sequence_report_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, get_sequence_report_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::SequenceService::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.get_sequence_report({ name: name }) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.get_sequence_report name: name do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.get_sequence_report ::Google::Showcase::V1beta1::GetSequenceReportRequest.new(name: name) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.get_sequence_report({ name: name }, call_options) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.get_sequence_report(::Google::Showcase::V1beta1::GetSequenceReportRequest.new(name: name), call_options) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, get_sequence_report_client_stub.call_count
      end
    end
  end

  def test_get_streaming_sequence_report
    # Create test objects.
    client_result = ::Google::Showcase::V1beta1::StreamingSequenceReport.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    get_streaming_sequence_report_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::SequenceService::Rest::ServiceStub.stub :transcode_get_streaming_sequence_report_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, get_streaming_sequence_report_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::SequenceService::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.get_streaming_sequence_report({ name: name }) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.get_streaming_sequence_report name: name do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.get_streaming_sequence_report ::Google::Showcase::V1beta1::GetStreamingSequenceReportRequest.new(name: name) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.get_streaming_sequence_report({ name: name }, call_options) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.get_streaming_sequence_report(::Google::Showcase::V1beta1::GetStreamingSequenceReportRequest.new(name: name), call_options) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, get_streaming_sequence_report_client_stub.call_count
      end
    end
  end

  def test_attempt_sequence
    # Create test objects.
    client_result = ::Google::Protobuf::Empty.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    name = "hello world"

    attempt_sequence_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::SequenceService::Rest::ServiceStub.stub :transcode_attempt_sequence_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, attempt_sequence_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::SequenceService::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.attempt_sequence({ name: name }) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use named arguments
        client.attempt_sequence name: name do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use protobuf object
        client.attempt_sequence ::Google::Showcase::V1beta1::AttemptSequenceRequest.new(name: name) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use hash object with options
        client.attempt_sequence({ name: name }, call_options) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Use protobuf object with options
        client.attempt_sequence(::Google::Showcase::V1beta1::AttemptSequenceRequest.new(name: name), call_options) do |_result, response|
          assert_equal http_response, response.underlying_op
        end

        # Verify method calls
        assert_equal 5, attempt_sequence_client_stub.call_count
      end
    end
  end

  def test_attempt_streaming_sequence
    # Create test objects.
    client_result = ::Google::Showcase::V1beta1::AttemptStreamingSequenceResponse.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    name = "hello world"
    last_fail_index = 42

    attempt_streaming_sequence_client_stub = ClientStub.new http_response do |_verb, uri:, body:, params:, options:, is_server_streaming:|
      assert options.metadata.key? :"x-goog-api-client"
      assert options.metadata[:"x-goog-api-client"].include? "rest"
      refute options.metadata[:"x-goog-api-client"].include? "grpc"
    end

    ::Google::Showcase::V1beta1::SequenceService::Rest::ServiceStub.stub :transcode_attempt_streaming_sequence_request, ["", "", {}] do
      Gapic::Rest::ClientStub.stub :new, attempt_streaming_sequence_client_stub do
        # Create client
        client = ::Google::Showcase::V1beta1::SequenceService::Rest::Client.new do |config|
          config.credentials = :dummy_value
        end

        # Use hash object
        client.attempt_streaming_sequence({ name: name, last_fail_index: last_fail_index }) do |_result, response|
          assert_equal http_response, response.underlying_op
        end.first

        # Use named arguments
        client.attempt_streaming_sequence name: name, last_fail_index: last_fail_index do |_result, response|
          assert_equal http_response, response.underlying_op
        end.first

        # Use protobuf object
        client.attempt_streaming_sequence ::Google::Showcase::V1beta1::AttemptStreamingSequenceRequest.new(name: name, last_fail_index: last_fail_index) do |_result, response|
          assert_equal http_response, response.underlying_op
        end.first

        # Use hash object with options
        client.attempt_streaming_sequence({ name: name, last_fail_index: last_fail_index }, call_options) do |_result, response|
          assert_equal http_response, response.underlying_op
        end.first

        # Use protobuf object with options
        client.attempt_streaming_sequence(::Google::Showcase::V1beta1::AttemptStreamingSequenceRequest.new(name: name, last_fail_index: last_fail_index), call_options) do |_result, response|
          assert_equal http_response, response.underlying_op
        end.first

        # Verify method calls
        assert_equal 5, attempt_streaming_sequence_client_stub.call_count
      end
    end
  end

  def test_configure
    credentials_token = :dummy_value

    client = block_config = config = nil
    dummy_stub = ClientStub.new nil
    Gapic::Rest::ClientStub.stub :new, dummy_stub do
      client = ::Google::Showcase::V1beta1::SequenceService::Rest::Client.new do |config|
        config.credentials = credentials_token
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Showcase::V1beta1::SequenceService::Rest::Client::Configuration, config
  end
end
