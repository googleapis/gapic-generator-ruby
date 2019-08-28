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

require "google/showcase/v1beta1/testing_pb"
require "google/showcase/v1beta1/testing_services_pb"
require "google/showcase/v1beta1/testing"

class Google::Showcase::V1beta1::Testing::ClientTest < Minitest::Test
  def setup
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
  end

  def test_create_session
    # Create request parameters
    session = {}

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :create_session && !options.nil? &&
            Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Session) == request.session
        end
      end

      # Call method
      response = client.create_session session: session
      assert_equal mock_response, response

      # Call method with block
      client.create_session session: session do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_get_session
    # Create request parameters
    name = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :get_session && !options.nil? &&
            request.name == "hello world"
        end
      end

      # Call method
      response = client.get_session name: name
      assert_equal mock_response, response

      # Call method with block
      client.get_session name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_list_sessions
    # Create request parameters
    page_size = 42
    page_token = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :list_sessions && !options.nil? &&
            request.page_size == 42 &&
            request.page_token == "hello world"
        end
      end

      # Call method
      response = client.list_sessions page_size: page_size, page_token: page_token
      assert_equal mock_response, response

      # Call method with block
      client.list_sessions page_size: page_size, page_token: page_token do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_delete_session
    # Create request parameters
    name = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :delete_session && !options.nil? &&
            request.name == "hello world"
        end
      end

      # Call method
      response = client.delete_session name: name
      assert_equal mock_response, response

      # Call method with block
      client.delete_session name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_report_session
    # Create request parameters
    name = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :report_session && !options.nil? &&
            request.name == "hello world"
        end
      end

      # Call method
      response = client.report_session name: name
      assert_equal mock_response, response

      # Call method with block
      client.report_session name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_list_tests
    # Create request parameters
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :list_tests && !options.nil? &&
            request.parent == "hello world" &&
            request.page_size == 42 &&
            request.page_token == "hello world"
        end
      end

      # Call method
      response = client.list_tests parent: parent, page_size: page_size, page_token: page_token
      assert_equal mock_response, response

      # Call method with block
      client.list_tests parent: parent, page_size: page_size, page_token: page_token do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_delete_test
    # Create request parameters
    name = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :delete_test && !options.nil? &&
            request.name == "hello world"
        end
      end

      # Call method
      response = client.delete_test name: name
      assert_equal mock_response, response

      # Call method with block
      client.delete_test name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_verify_test
    # Create request parameters
    name = "hello world"
    answer = "hello world"
    answers = ["hello world"]

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :verify_test && !options.nil? &&
            request.name == "hello world" &&
            request.answer == "hello world" &&
            request.answers == ["hello world"]
        end
      end

      # Call method
      response = client.verify_test name: name, answer: answer, answers: answers
      assert_equal mock_response, response

      # Call method with block
      client.verify_test name: name, answer: answer, answers: answers do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end
end
