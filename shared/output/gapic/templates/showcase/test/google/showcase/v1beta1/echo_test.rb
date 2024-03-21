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

require "gapic/grpc/service_stub"

require "google/showcase/v1beta1/echo_pb"
require "google/showcase/v1beta1/echo_services_pb"
require "google/showcase/v1beta1/echo"

class ::Google::Showcase::V1beta1::Echo::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_rpc_count, :requests

    def initialize response, operation, &block
      @response = response
      @operation = operation
      @block = block
      @call_rpc_count = 0
      @requests = []
    end

    def call_rpc *args, **kwargs
      @call_rpc_count += 1

      @requests << @block&.call(*args, **kwargs)

      yield @response, @operation if block_given?

      @response
    end

    def endpoint
      "endpoint.example.com"
    end

    def universe_domain
      "example.com"
    end
  end

  def test_echo
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::EchoResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    content = "hello world"
    severity = :UNNECESSARY
    header = "hello world"
    other_header = "hello world"
    request_id = "hello world"
    other_request_id = "hello world"

    echo_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :echo, name
      assert_kind_of ::Google::Showcase::V1beta1::EchoRequest, request
      assert_equal "hello world", request["content"]
      assert_equal :content, request.response
      assert_equal :UNNECESSARY, request["severity"]
      assert_equal "hello world", request["header"]
      assert_equal "hello world", request["other_header"]
      assert_equal "hello world", request["request_id"]
      assert_equal "hello world", request["other_request_id"]
      assert request.has_other_request_id?
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, echo_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.echo({ content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.echo content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.echo ::Google::Showcase::V1beta1::EchoRequest.new(content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.echo({ content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.echo(::Google::Showcase::V1beta1::EchoRequest.new(content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id), grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, echo_client_stub.call_rpc_count
    end
  end

  def test_echo_error_details
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::EchoErrorDetailsResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    single_detail_text = "hello world"
    multi_detail_text = ["hello world"]

    echo_error_details_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :echo_error_details, name
      assert_kind_of ::Google::Showcase::V1beta1::EchoErrorDetailsRequest, request
      assert_equal "hello world", request["single_detail_text"]
      assert_equal ["hello world"], request["multi_detail_text"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, echo_error_details_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.echo_error_details({ single_detail_text: single_detail_text, multi_detail_text: multi_detail_text }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.echo_error_details single_detail_text: single_detail_text, multi_detail_text: multi_detail_text do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.echo_error_details ::Google::Showcase::V1beta1::EchoErrorDetailsRequest.new(single_detail_text: single_detail_text, multi_detail_text: multi_detail_text) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.echo_error_details({ single_detail_text: single_detail_text, multi_detail_text: multi_detail_text }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.echo_error_details(::Google::Showcase::V1beta1::EchoErrorDetailsRequest.new(single_detail_text: single_detail_text, multi_detail_text: multi_detail_text), grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, echo_error_details_client_stub.call_rpc_count
    end
  end

  def test_expand
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::EchoResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a server streaming method.
    content = "hello world"
    error = {}
    stream_wait_time = {}

    expand_client_stub = ClientStub.new [grpc_response].to_enum, grpc_operation do |name, request, options:|
      assert_equal :expand, name
      assert_kind_of ::Google::Showcase::V1beta1::ExpandRequest, request
      assert_equal "hello world", request["content"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Rpc::Status), request["error"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::Duration), request["stream_wait_time"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, expand_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.expand({ content: content, error: error, stream_wait_time: stream_wait_time }) do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::EchoResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.expand content: content, error: error, stream_wait_time: stream_wait_time do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::EchoResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.expand ::Google::Showcase::V1beta1::ExpandRequest.new(content: content, error: error, stream_wait_time: stream_wait_time) do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::EchoResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.expand({ content: content, error: error, stream_wait_time: stream_wait_time }, grpc_options) do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::EchoResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.expand(::Google::Showcase::V1beta1::ExpandRequest.new(content: content, error: error, stream_wait_time: stream_wait_time), grpc_options) do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::EchoResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, expand_client_stub.call_rpc_count
    end
  end

  def test_collect
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::EchoResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a client streaming method.
    content = "hello world"
    severity = :UNNECESSARY
    header = "hello world"
    other_header = "hello world"
    request_id = "hello world"
    other_request_id = "hello world"

    collect_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :collect, name
      assert_kind_of Enumerable, request
      refute_nil options
      request
    end

    Gapic::ServiceStub.stub :new, collect_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use enumerable object with hash and protobuf object.
      request_hash = { content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id }
      request_proto = ::Google::Showcase::V1beta1::EchoRequest.new content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id
      enum_input = [request_hash, request_proto].to_enum
      client.collect enum_input do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use stream input object (from gapic-common).
      request_hash = { content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id }
      request_proto = ::Google::Showcase::V1beta1::EchoRequest.new content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id
      stream_input = Gapic::StreamInput.new
      client.collect stream_input do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end
      stream_input << request_hash
      stream_input << request_proto
      stream_input.close

      # Use enumerable object with hash and protobuf object with options.
      request_hash = { content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id }
      request_proto = ::Google::Showcase::V1beta1::EchoRequest.new content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id
      enum_input = [request_hash, request_proto].to_enum
      client.collect enum_input, grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use stream input object (from gapic-common) with options.
      request_hash = { content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id }
      request_proto = ::Google::Showcase::V1beta1::EchoRequest.new content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id
      stream_input = Gapic::StreamInput.new
      client.collect stream_input, grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end
      stream_input << request_hash
      stream_input << request_proto
      stream_input.close

      # Verify method calls
      assert_equal 4, collect_client_stub.call_rpc_count
      collect_client_stub.requests.each do |request|
        request.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::EchoRequest, r
          assert_equal "hello world", r["content"]
          assert_equal :content, r.response
          assert_equal :UNNECESSARY, r["severity"]
          assert_equal "hello world", r["header"]
          assert_equal "hello world", r["other_header"]
          assert_equal "hello world", r["request_id"]
          assert_equal "hello world", r["other_request_id"]
          assert r.has_other_request_id?
        end
      end
    end
  end

  def test_chat
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::EchoResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a bidi streaming method.
    content = "hello world"
    severity = :UNNECESSARY
    header = "hello world"
    other_header = "hello world"
    request_id = "hello world"
    other_request_id = "hello world"

    chat_client_stub = ClientStub.new [grpc_response].to_enum, grpc_operation do |name, request, options:|
      assert_equal :chat, name
      assert_kind_of Enumerable, request
      refute_nil options
      request
    end

    Gapic::ServiceStub.stub :new, chat_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use enumerable object with hash and protobuf object.
      request_hash = { content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id }
      request_proto = ::Google::Showcase::V1beta1::EchoRequest.new content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id
      enum_input = [request_hash, request_proto].to_enum
      client.chat enum_input do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::EchoResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use stream input object (from gapic-common).
      request_hash = { content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id }
      request_proto = ::Google::Showcase::V1beta1::EchoRequest.new content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id
      stream_input = Gapic::StreamInput.new
      client.chat stream_input do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::EchoResponse, r
        end
        assert_equal grpc_operation, operation
      end
      stream_input << request_hash
      stream_input << request_proto
      stream_input.close

      # Use enumerable object with hash and protobuf object with options.
      request_hash = { content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id }
      request_proto = ::Google::Showcase::V1beta1::EchoRequest.new content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id
      enum_input = [request_hash, request_proto].to_enum
      client.chat enum_input, grpc_options do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::EchoResponse, r
        end
        assert_equal grpc_operation, operation
      end

      # Use stream input object (from gapic-common) with options.
      request_hash = { content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id }
      request_proto = ::Google::Showcase::V1beta1::EchoRequest.new content: content, severity: severity, header: header, other_header: other_header, request_id: request_id, other_request_id: other_request_id
      stream_input = Gapic::StreamInput.new
      client.chat stream_input, grpc_options do |response, operation|
        assert_kind_of Enumerable, response
        response.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::EchoResponse, r
        end
        assert_equal grpc_operation, operation
      end
      stream_input << request_hash
      stream_input << request_proto
      stream_input.close

      # Verify method calls
      assert_equal 4, chat_client_stub.call_rpc_count
      chat_client_stub.requests.each do |request|
        request.to_a.each do |r|
          assert_kind_of ::Google::Showcase::V1beta1::EchoRequest, r
          assert_equal "hello world", r["content"]
          assert_equal :content, r.response
          assert_equal :UNNECESSARY, r["severity"]
          assert_equal "hello world", r["header"]
          assert_equal "hello world", r["other_header"]
          assert_equal "hello world", r["request_id"]
          assert_equal "hello world", r["other_request_id"]
          assert r.has_other_request_id?
        end
      end
    end
  end

  def test_paged_expand
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::PagedExpandResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    content = "hello world"
    page_size = 42
    page_token = "hello world"

    paged_expand_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :paged_expand, name
      assert_kind_of ::Google::Showcase::V1beta1::PagedExpandRequest, request
      assert_equal "hello world", request["content"]
      assert_equal 42, request["page_size"]
      assert_equal "hello world", request["page_token"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, paged_expand_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.paged_expand({ content: content, page_size: page_size, page_token: page_token }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.paged_expand content: content, page_size: page_size, page_token: page_token do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.paged_expand ::Google::Showcase::V1beta1::PagedExpandRequest.new(content: content, page_size: page_size, page_token: page_token) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.paged_expand({ content: content, page_size: page_size, page_token: page_token }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.paged_expand(::Google::Showcase::V1beta1::PagedExpandRequest.new(content: content, page_size: page_size, page_token: page_token), grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, paged_expand_client_stub.call_rpc_count
    end
  end

  def test_paged_expand_legacy
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::PagedExpandResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    content = "hello world"
    max_results = 42
    page_token = "hello world"

    paged_expand_legacy_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :paged_expand_legacy, name
      assert_kind_of ::Google::Showcase::V1beta1::PagedExpandLegacyRequest, request
      assert_equal "hello world", request["content"]
      assert_equal 42, request["max_results"]
      assert_equal "hello world", request["page_token"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, paged_expand_legacy_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.paged_expand_legacy({ content: content, max_results: max_results, page_token: page_token }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.paged_expand_legacy content: content, max_results: max_results, page_token: page_token do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.paged_expand_legacy ::Google::Showcase::V1beta1::PagedExpandLegacyRequest.new(content: content, max_results: max_results, page_token: page_token) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.paged_expand_legacy({ content: content, max_results: max_results, page_token: page_token }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.paged_expand_legacy(::Google::Showcase::V1beta1::PagedExpandLegacyRequest.new(content: content, max_results: max_results, page_token: page_token), grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, paged_expand_legacy_client_stub.call_rpc_count
    end
  end

  def test_paged_expand_legacy_mapped
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::PagedExpandLegacyMappedResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    content = "hello world"
    page_size = 42
    page_token = "hello world"

    paged_expand_legacy_mapped_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :paged_expand_legacy_mapped, name
      assert_kind_of ::Google::Showcase::V1beta1::PagedExpandRequest, request
      assert_equal "hello world", request["content"]
      assert_equal 42, request["page_size"]
      assert_equal "hello world", request["page_token"]
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, paged_expand_legacy_mapped_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.paged_expand_legacy_mapped({ content: content, page_size: page_size, page_token: page_token }) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.paged_expand_legacy_mapped content: content, page_size: page_size, page_token: page_token do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.paged_expand_legacy_mapped ::Google::Showcase::V1beta1::PagedExpandRequest.new(content: content, page_size: page_size, page_token: page_token) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.paged_expand_legacy_mapped({ content: content, page_size: page_size, page_token: page_token }, grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.paged_expand_legacy_mapped(::Google::Showcase::V1beta1::PagedExpandRequest.new(content: content, page_size: page_size, page_token: page_token), grpc_options) do |response, operation|
        assert_kind_of Gapic::PagedEnumerable, response
        assert_equal grpc_response, response.response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, paged_expand_legacy_mapped_client_stub.call_rpc_count
    end
  end

  def test_wait
    # Create GRPC objects.
    grpc_response = ::Google::Longrunning::Operation.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    end_time = {}
    error = {}

    wait_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :wait, name
      assert_kind_of ::Google::Showcase::V1beta1::WaitRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::Timestamp), request["end_time"]
      assert_equal :end_time, request.end
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Rpc::Status), request["error"]
      assert_equal :error, request.response
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, wait_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.wait({ end_time: end_time, error: error }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.wait end_time: end_time, error: error do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.wait ::Google::Showcase::V1beta1::WaitRequest.new(end_time: end_time, error: error) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.wait({ end_time: end_time, error: error }, grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.wait(::Google::Showcase::V1beta1::WaitRequest.new(end_time: end_time, error: error), grpc_options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal grpc_response, response.grpc_op
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, wait_client_stub.call_rpc_count
    end
  end

  def test_block
    # Create GRPC objects.
    grpc_response = ::Google::Showcase::V1beta1::BlockResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters for a unary method.
    response_delay = {}
    error = {}

    block_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :block, name
      assert_kind_of ::Google::Showcase::V1beta1::BlockRequest, request
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Protobuf::Duration), request["response_delay"]
      assert_equal Gapic::Protobuf.coerce({}, to: ::Google::Rpc::Status), request["error"]
      assert_equal :error, request.response
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, block_client_stub do
      # Create client
      client = ::Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      client.block({ response_delay: response_delay, error: error }) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.block response_delay: response_delay, error: error do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.block ::Google::Showcase::V1beta1::BlockRequest.new(response_delay: response_delay, error: error) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.block({ response_delay: response_delay, error: error }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.block(::Google::Showcase::V1beta1::BlockRequest.new(response_delay: response_delay, error: error), grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, block_client_stub.call_rpc_count
    end
  end

  def test_configure
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = block_config = config = nil
    dummy_stub = ClientStub.new nil, nil
    Gapic::ServiceStub.stub :new, dummy_stub do
      client = ::Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Showcase::V1beta1::Echo::Client::Configuration, config
  end

  def test_operations_client
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure

    client = nil
    dummy_stub = ClientStub.new nil, nil
    Gapic::ServiceStub.stub :new, dummy_stub do
      client = ::Google::Showcase::V1beta1::Echo::Client.new do |config|
        config.credentials = grpc_channel
      end
    end

    assert_kind_of ::Google::Showcase::V1beta1::Echo::Operations, client.operations_client
  end
end
