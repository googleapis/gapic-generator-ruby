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

require "google/cloud/language/v1beta1/language_service_pb"
require "google/cloud/language/v1beta1/language_service_services_pb"
require "google/cloud/language/v1beta1/language_service"

class Google::Cloud::Language::V1beta1::LanguageService::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_rpc_count

    def initialize response, operation, &block
      @response = response
      @operation = operation
      @block = block
      @call_rpc_count = 0
    end

    def call_rpc *args
      @call_rpc_count += 1

      @block&.call *args

      yield @response, @operation if block_given?

      @response
    end
  end

  def test_analyze_sentiment
    # Create GRPC objects
    grpc_response = Google::Cloud::Language::V1beta1::AnalyzeSentimentResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    document = {}
    encoding_type = :NONE

    analyze_sentiment_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :analyze_sentiment, name
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Language::V1beta1::Document), request.document
      assert_equal :NONE, request.encoding_type
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, analyze_sentiment_client_stub do
      # Create client
      client = Google::Cloud::Language::V1beta1::LanguageService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.analyze_sentiment document: document, encoding_type: encoding_type do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.analyze_sentiment document: document, encoding_type: encoding_type do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.analyze_sentiment Google::Cloud::Language::V1beta1::AnalyzeSentimentRequest.new(document: document, encoding_type: encoding_type) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.analyze_sentiment({ document: document, encoding_type: encoding_type }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.analyze_sentiment Google::Cloud::Language::V1beta1::AnalyzeSentimentRequest.new(document: document, encoding_type: encoding_type), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, analyze_sentiment_client_stub.call_rpc_count
    end
  end

  def test_analyze_entities
    # Create GRPC objects
    grpc_response = Google::Cloud::Language::V1beta1::AnalyzeEntitiesResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    document = {}
    encoding_type = :NONE

    analyze_entities_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :analyze_entities, name
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Language::V1beta1::Document), request.document
      assert_equal :NONE, request.encoding_type
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, analyze_entities_client_stub do
      # Create client
      client = Google::Cloud::Language::V1beta1::LanguageService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.analyze_entities document: document, encoding_type: encoding_type do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.analyze_entities document: document, encoding_type: encoding_type do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.analyze_entities Google::Cloud::Language::V1beta1::AnalyzeEntitiesRequest.new(document: document, encoding_type: encoding_type) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.analyze_entities({ document: document, encoding_type: encoding_type }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.analyze_entities Google::Cloud::Language::V1beta1::AnalyzeEntitiesRequest.new(document: document, encoding_type: encoding_type), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, analyze_entities_client_stub.call_rpc_count
    end
  end

  def test_analyze_syntax
    # Create GRPC objects
    grpc_response = Google::Cloud::Language::V1beta1::AnalyzeSyntaxResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    document = {}
    encoding_type = :NONE

    analyze_syntax_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :analyze_syntax, name
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Language::V1beta1::Document), request.document
      assert_equal :NONE, request.encoding_type
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, analyze_syntax_client_stub do
      # Create client
      client = Google::Cloud::Language::V1beta1::LanguageService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.analyze_syntax document: document, encoding_type: encoding_type do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.analyze_syntax document: document, encoding_type: encoding_type do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.analyze_syntax Google::Cloud::Language::V1beta1::AnalyzeSyntaxRequest.new(document: document, encoding_type: encoding_type) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.analyze_syntax({ document: document, encoding_type: encoding_type }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.analyze_syntax Google::Cloud::Language::V1beta1::AnalyzeSyntaxRequest.new(document: document, encoding_type: encoding_type), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, analyze_syntax_client_stub.call_rpc_count
    end
  end

  def test_annotate_text
    # Create GRPC objects
    grpc_response = Google::Cloud::Language::V1beta1::AnnotateTextResponse.new
    grpc_operation = GRPC::ActiveCall::Operation.new nil
    grpc_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    grpc_options = {}

    # Create request parameters
    document = {}
    features = {}
    encoding_type = :NONE

    annotate_text_client_stub = ClientStub.new grpc_response, grpc_operation do |name, request, options:|
      assert_equal :annotate_text, name
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Language::V1beta1::Document), request.document
      assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Language::V1beta1::AnnotateTextRequest::Features), request.features
      assert_equal :NONE, request.encoding_type
      refute_nil options
    end

    Gapic::ServiceStub.stub :new, annotate_text_client_stub do
      # Create client
      client = Google::Cloud::Language::V1beta1::LanguageService::Client.new do |config|
        config.credentials = grpc_channel
      end

      # Use hash object
      # TODO: parens and curly braces are getting removed by rubocop, plz fix
      client.annotate_text document: document, features: features, encoding_type: encoding_type do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use named arguments
      client.annotate_text document: document, features: features, encoding_type: encoding_type do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object
      client.annotate_text Google::Cloud::Language::V1beta1::AnnotateTextRequest.new(document: document, features: features, encoding_type: encoding_type) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use hash object with options
      client.annotate_text({ document: document, features: features, encoding_type: encoding_type }, grpc_options) do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Use protobuf object with options
      client.annotate_text Google::Cloud::Language::V1beta1::AnnotateTextRequest.new(document: document, features: features, encoding_type: encoding_type), grpc_options do |response, operation|
        assert_equal grpc_response, response
        assert_equal grpc_operation, operation
      end

      # Verify method calls
      assert_equal 5, annotate_text_client_stub.call_rpc_count
    end
  end
end
