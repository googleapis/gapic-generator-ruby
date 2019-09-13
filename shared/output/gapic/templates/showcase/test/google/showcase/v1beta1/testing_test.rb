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

require "google/showcase/v1beta1/testing_pb"
require "google/showcase/v1beta1/testing_services_pb"
require "google/showcase/v1beta1/testing"

class Google::Showcase::V1beta1::Testing::ClientTest < Minitest::Test
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

  def test_create_session
    # Create request parameters
    session = {}

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :create_session, name
          refute_nil options
          refute_nil block
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Session), request.session

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.create_session session: session do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.create_session(Google::Showcase::V1beta1::CreateSessionRequest.new(session: session)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.create_session request = { session: session } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.create_session request = Google::Showcase::V1beta1::CreateSessionRequest.new({ session: session }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.create_session({ session: session }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.create_session(Google::Showcase::V1beta1::CreateSessionRequest.new(session: session), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.create_session(request = { session: session }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.create_session(request = Google::Showcase::V1beta1::CreateSessionRequest.new({ session: session }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_get_session
    # Create request parameters
    name = "hello world"

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :get_session, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.get_session name: name do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.get_session(Google::Showcase::V1beta1::GetSessionRequest.new(name: name)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.get_session request = { name: name } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.get_session request = Google::Showcase::V1beta1::GetSessionRequest.new({ name: name }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.get_session({ name: name }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.get_session(Google::Showcase::V1beta1::GetSessionRequest.new(name: name), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.get_session(request = { name: name }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.get_session(request = Google::Showcase::V1beta1::GetSessionRequest.new({ name: name }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_list_sessions
    # Create request parameters
    page_size = 42
    page_token = "hello world"

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :list_sessions, name
          refute_nil options
          refute_nil block
          assert_equal 42, request.page_size
          assert_equal "hello world", request.page_token

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.list_sessions page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.list_sessions(Google::Showcase::V1beta1::ListSessionsRequest.new(page_size: page_size, page_token: page_token)) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.list_sessions request = { page_size: page_size, page_token: page_token } do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.list_sessions request = Google::Showcase::V1beta1::ListSessionsRequest.new({ page_size: page_size, page_token: page_token }) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.list_sessions({ page_size: page_size, page_token: page_token }, @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.list_sessions(Google::Showcase::V1beta1::ListSessionsRequest.new(page_size: page_size, page_token: page_token), @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.list_sessions(request = { page_size: page_size, page_token: page_token }, options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.list_sessions(request = Google::Showcase::V1beta1::ListSessionsRequest.new({ page_size: page_size, page_token: page_token }), options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_delete_session
    # Create request parameters
    name = "hello world"

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :delete_session, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.delete_session name: name do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.delete_session(Google::Showcase::V1beta1::DeleteSessionRequest.new(name: name)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.delete_session request = { name: name } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.delete_session request = Google::Showcase::V1beta1::DeleteSessionRequest.new({ name: name }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.delete_session({ name: name }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.delete_session(Google::Showcase::V1beta1::DeleteSessionRequest.new(name: name), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.delete_session(request = { name: name }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.delete_session(request = Google::Showcase::V1beta1::DeleteSessionRequest.new({ name: name }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_report_session
    # Create request parameters
    name = "hello world"

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :report_session, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.report_session name: name do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.report_session(Google::Showcase::V1beta1::ReportSessionRequest.new(name: name)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.report_session request = { name: name } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.report_session request = Google::Showcase::V1beta1::ReportSessionRequest.new({ name: name }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.report_session({ name: name }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.report_session(Google::Showcase::V1beta1::ReportSessionRequest.new(name: name), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.report_session(request = { name: name }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.report_session(request = Google::Showcase::V1beta1::ReportSessionRequest.new({ name: name }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_list_tests
    # Create request parameters
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :list_tests, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.parent
          assert_equal 42, request.page_size
          assert_equal "hello world", request.page_token

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.list_tests parent: parent, page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.list_tests(Google::Showcase::V1beta1::ListTestsRequest.new(parent: parent, page_size: page_size, page_token: page_token)) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.list_tests request = { parent: parent, page_size: page_size, page_token: page_token } do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.list_tests request = Google::Showcase::V1beta1::ListTestsRequest.new({ parent: parent, page_size: page_size, page_token: page_token }) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.list_tests({ parent: parent, page_size: page_size, page_token: page_token }, @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.list_tests(Google::Showcase::V1beta1::ListTestsRequest.new(parent: parent, page_size: page_size, page_token: page_token), @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.list_tests(request = { parent: parent, page_size: page_size, page_token: page_token }, options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.list_tests(request = Google::Showcase::V1beta1::ListTestsRequest.new({ parent: parent, page_size: page_size, page_token: page_token }), options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_delete_test
    # Create request parameters
    name = "hello world"

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :delete_test, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.delete_test name: name do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.delete_test(Google::Showcase::V1beta1::DeleteTestRequest.new(name: name)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.delete_test request = { name: name } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.delete_test request = Google::Showcase::V1beta1::DeleteTestRequest.new({ name: name }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.delete_test({ name: name }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.delete_test(Google::Showcase::V1beta1::DeleteTestRequest.new(name: name), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.delete_test(request = { name: name }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.delete_test(request = Google::Showcase::V1beta1::DeleteTestRequest.new({ name: name }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_verify_test
    # Create request parameters
    name = "hello world"
    answer = "hello world"
    answers = ["hello world"]

    with_stubs do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :verify_test, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name
          assert_equal "hello world", request.answer
          assert_equal ["hello world"], request.answers

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.verify_test name: name, answer: answer, answers: answers do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.verify_test(Google::Showcase::V1beta1::VerifyTestRequest.new(name: name, answer: answer, answers: answers)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.verify_test request = { name: name, answer: answer, answers: answers } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.verify_test request = Google::Showcase::V1beta1::VerifyTestRequest.new({ name: name, answer: answer, answers: answers }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.verify_test({ name: name, answer: answer, answers: answers }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.verify_test(Google::Showcase::V1beta1::VerifyTestRequest.new(name: name, answer: answer, answers: answers), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.verify_test(request = { name: name, answer: answer, answers: answers }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.verify_test(request = Google::Showcase::V1beta1::VerifyTestRequest.new({ name: name, answer: answer, answers: answers }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end
end
