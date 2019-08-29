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
    @mock_stub = MiniTest::Mock.new
    @response = {}
    @options = {}
    @operation_callback = -> { raise "Operation callback was executed!" }
  end

  def test_create_session
    # Create request parameters
    session = {}

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:|
          has_name = name == :create_session
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            Gapic::Protobuf.coerce({}, to: Google::Showcase::V1beta1::Session) == request.session

          assert has_name, "invalid method call: #{name} (expected create_session)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.create_session session: session
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.create_session(Google::Showcase::V1beta1::CreateSessionRequest.new(
                                         session: session
                                       ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.create_session request = { session: session }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.create_session request = Google::Showcase::V1beta1::CreateSessionRequest.new(
        session: session
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.create_session({ session: session }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.create_session(Google::Showcase::V1beta1::CreateSessionRequest.new(
                                         session: session
                                       ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.create_session request = { session: session }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.create_session request = Google::Showcase::V1beta1::CreateSessionRequest.new(
        session: session
      ), options = @options, &@operation_callback
      assert_equal @response, response

      @mock_stub.verify
    end
  end

  def test_get_session
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:|
          has_name = name == :get_session
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            request.name == "hello world"

          assert has_name, "invalid method call: #{name} (expected get_session)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.get_session name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.get_session(Google::Showcase::V1beta1::GetSessionRequest.new(
                                      name: name
                                    ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.get_session request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.get_session request = Google::Showcase::V1beta1::GetSessionRequest.new(
        name: name
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.get_session({ name: name }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.get_session(Google::Showcase::V1beta1::GetSessionRequest.new(
                                      name: name
                                    ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.get_session request = { name: name }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.get_session request = Google::Showcase::V1beta1::GetSessionRequest.new(
        name: name
      ), options = @options, &@operation_callback
      assert_equal @response, response

      @mock_stub.verify
    end
  end

  def test_list_sessions
    # Create request parameters
    page_size = 42
    page_token = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:, format_response:|
          has_name = name == :list_sessions
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            request.page_size == 42 &&

            request.page_token == "hello world"

          assert has_name, "invalid method call: #{name} (expected list_sessions)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.list_sessions page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.list_sessions(Google::Showcase::V1beta1::ListSessionsRequest.new(
                                        page_size: page_size, page_token: page_token
                                      ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.list_sessions request = { page_size: page_size, page_token: page_token }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.list_sessions request = Google::Showcase::V1beta1::ListSessionsRequest.new(
        page_size: page_size, page_token: page_token
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.list_sessions({ page_size: page_size, page_token: page_token }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.list_sessions(Google::Showcase::V1beta1::ListSessionsRequest.new(
                                        page_size: page_size, page_token: page_token
                                      ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.list_sessions request = { page_size: page_size, page_token: page_token }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.list_sessions request = Google::Showcase::V1beta1::ListSessionsRequest.new(
        page_size: page_size, page_token: page_token
      ), options = @options, &@operation_callback
      assert_equal @response, response

      @mock_stub.verify
    end
  end

  def test_delete_session
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:|
          has_name = name == :delete_session
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            request.name == "hello world"

          assert has_name, "invalid method call: #{name} (expected delete_session)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.delete_session name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.delete_session(Google::Showcase::V1beta1::DeleteSessionRequest.new(
                                         name: name
                                       ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.delete_session request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.delete_session request = Google::Showcase::V1beta1::DeleteSessionRequest.new(
        name: name
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.delete_session({ name: name }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.delete_session(Google::Showcase::V1beta1::DeleteSessionRequest.new(
                                         name: name
                                       ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.delete_session request = { name: name }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.delete_session request = Google::Showcase::V1beta1::DeleteSessionRequest.new(
        name: name
      ), options = @options, &@operation_callback
      assert_equal @response, response

      @mock_stub.verify
    end
  end

  def test_report_session
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:|
          has_name = name == :report_session
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            request.name == "hello world"

          assert has_name, "invalid method call: #{name} (expected report_session)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.report_session name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.report_session(Google::Showcase::V1beta1::ReportSessionRequest.new(
                                         name: name
                                       ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.report_session request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.report_session request = Google::Showcase::V1beta1::ReportSessionRequest.new(
        name: name
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.report_session({ name: name }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.report_session(Google::Showcase::V1beta1::ReportSessionRequest.new(
                                         name: name
                                       ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.report_session request = { name: name }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.report_session request = Google::Showcase::V1beta1::ReportSessionRequest.new(
        name: name
      ), options = @options, &@operation_callback
      assert_equal @response, response

      @mock_stub.verify
    end
  end

  def test_list_tests
    # Create request parameters
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:, format_response:|
          has_name = name == :list_tests
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            request.parent == "hello world" &&

            request.page_size == 42 &&

            request.page_token == "hello world"

          assert has_name, "invalid method call: #{name} (expected list_tests)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.list_tests parent: parent, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.list_tests(Google::Showcase::V1beta1::ListTestsRequest.new(
                                     parent: parent, page_size: page_size, page_token: page_token
                                   ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.list_tests request = { parent: parent, page_size: page_size, page_token: page_token }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.list_tests request = Google::Showcase::V1beta1::ListTestsRequest.new(
        parent: parent, page_size: page_size, page_token: page_token
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.list_tests({ parent: parent, page_size: page_size, page_token: page_token }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.list_tests(Google::Showcase::V1beta1::ListTestsRequest.new(
                                     parent: parent, page_size: page_size, page_token: page_token
                                   ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.list_tests request = { parent: parent, page_size: page_size, page_token: page_token }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.list_tests request = Google::Showcase::V1beta1::ListTestsRequest.new(
        parent: parent, page_size: page_size, page_token: page_token
      ), options = @options, &@operation_callback
      assert_equal @response, response

      @mock_stub.verify
    end
  end

  def test_delete_test
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:|
          has_name = name == :delete_test
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            request.name == "hello world"

          assert has_name, "invalid method call: #{name} (expected delete_test)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.delete_test name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.delete_test(Google::Showcase::V1beta1::DeleteTestRequest.new(
                                      name: name
                                    ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.delete_test request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.delete_test request = Google::Showcase::V1beta1::DeleteTestRequest.new(
        name: name
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.delete_test({ name: name }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.delete_test(Google::Showcase::V1beta1::DeleteTestRequest.new(
                                      name: name
                                    ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.delete_test request = { name: name }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.delete_test request = Google::Showcase::V1beta1::DeleteTestRequest.new(
        name: name
      ), options = @options, &@operation_callback
      assert_equal @response, response

      @mock_stub.verify
    end
  end

  def test_verify_test
    # Create request parameters
    name = "hello world"
    answer = "hello world"
    answers = ["hello world"]

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Showcase::V1beta1::Testing::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do |idx|
        @mock_stub.expect :call_rpc, @response do |name, request, options:, operation_callback:|
          has_name = name == :verify_test
          has_options = !options.nil?
          has_operation_callback = operation_callback == (idx >= 4 ? @operation_callback : nil)
          has_fields =
            request.name == "hello world" &&

            request.answer == "hello world" &&

            request.answers == ["hello world"]

          assert has_name, "invalid method call: #{name} (expected verify_test)"
          assert has_options, "invalid options: #{options} vs #{@options}"
          assert has_operation_callback, "invalid operation block"
          assert has_fields, "invalid field values"

          has_name && has_options && has_operation_callback && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.verify_test name: name, answer: answer, answers: answers
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.verify_test(Google::Showcase::V1beta1::VerifyTestRequest.new(
                                      name: name, answer: answer, answers: answers
                                    ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.verify_test request = { name: name, answer: answer, answers: answers }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.verify_test request = Google::Showcase::V1beta1::VerifyTestRequest.new(
        name: name, answer: answer, answers: answers
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.verify_test({ name: name, answer: answer, answers: answers }, @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.verify_test(Google::Showcase::V1beta1::VerifyTestRequest.new(
                                      name: name, answer: answer, answers: answers
                                    ), @options, &@operation_callback)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.verify_test request = { name: name, answer: answer, answers: answers }, options = @options, &@operation_callback
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.verify_test request = Google::Showcase::V1beta1::VerifyTestRequest.new(
        name: name, answer: answer, answers: answers
      ), options = @options, &@operation_callback
      assert_equal @response, response

      @mock_stub.verify
    end
  end
end
