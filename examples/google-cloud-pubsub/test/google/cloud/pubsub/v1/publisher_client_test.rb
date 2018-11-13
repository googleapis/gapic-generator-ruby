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
require "minitest/spec"

require "google/gax"

require "google/cloud/pubsub"
require "google/cloud/pubsub/v1/publisher_client"
require "google/iam/v1/iam_policy_services_pb"
require "google/pubsub/v1/pubsub_services_pb"

class CustomTestError_v1 < StandardError; end

# Mock for the GRPC::ClientStub class.
class MockGrpcClientStub_v1

  # @param expected_symbol [Symbol] the symbol of the grpc method to be mocked.
  # @param mock_method [Proc] The method that is being mocked.
  def initialize(expected_symbol, mock_method)
    @expected_symbol = expected_symbol
    @mock_method = mock_method
  end

  # This overrides the Object#method method to return the mocked method when the mocked method
  # is being requested. For methods that aren't being tested, this method returns a proc that
  # will raise an error when called. This is to assure that only the mocked grpc method is being
  # called.
  #
  # @param symbol [Symbol] The symbol of the method being requested.
  # @return [Proc] The proc of the requested method. If the requested method is not being mocked
  #   the proc returned will raise when called.
  def method(symbol)
    return @mock_method if symbol == @expected_symbol

    # The requested method is not being tested, raise if it called.
    proc do
      raise "The method #{symbol} was unexpectedly called during the " \
        "test for #{@expected_symbol}."
    end
  end
end

class MockPublisherCredentials_v1 < Google::Cloud::Pubsub::V1::Credentials
  def initialize(method_name)
    @method_name = method_name
  end

  def updater_proc
    proc do
      raise "The method `#{@method_name}` was trying to make a grpc request. This should not " \
          "happen since the grpc layer is being mocked."
    end
  end
end

describe Google::Cloud::Pubsub::V1::PublisherClient do

  describe 'create_topic' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::PublisherClient#create_topic."

    it 'invokes create_topic without error' do
      # Create request parameters
      formatted_name = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")

      # Create expected grpc response
      name_2 = "name2-1052831874"
      expected_response = { name: name_2 }
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::Topic)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::Topic, request)
        assert_equal(formatted_name, request.name)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:create_topic, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("create_topic")

      Google::Pubsub::V1::Publisher::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          response = client.create_topic(formatted_name)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.create_topic(formatted_name) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes create_topic with error' do
      # Create request parameters
      formatted_name = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::Topic, request)
        assert_equal(formatted_name, request.name)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:create_topic, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("create_topic")

      Google::Pubsub::V1::Publisher::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.create_topic(formatted_name)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'update_topic' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::PublisherClient#update_topic."

    it 'invokes update_topic without error' do
      # Create request parameters
      topic = {}
      update_mask = {}

      # Create expected grpc response
      name = "name3373707"
      expected_response = { name: name }
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::Topic)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::UpdateTopicRequest, request)
        assert_equal(Google::Gax::to_proto(topic, Google::Pubsub::V1::Topic), request.topic)
        assert_equal(Google::Gax::to_proto(update_mask, Google::Protobuf::FieldMask), request.update_mask)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:update_topic, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("update_topic")

      Google::Pubsub::V1::Publisher::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          response = client.update_topic(topic, update_mask)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.update_topic(topic, update_mask) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes update_topic with error' do
      # Create request parameters
      topic = {}
      update_mask = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::UpdateTopicRequest, request)
        assert_equal(Google::Gax::to_proto(topic, Google::Pubsub::V1::Topic), request.topic)
        assert_equal(Google::Gax::to_proto(update_mask, Google::Protobuf::FieldMask), request.update_mask)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:update_topic, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("update_topic")

      Google::Pubsub::V1::Publisher::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.update_topic(topic, update_mask)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'publish' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::PublisherClient#publish."

    it 'invokes publish without error' do
      # Create request parameters
      formatted_topic = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")
      data = ''
      messages_element = { data: data }
      messages = [messages_element]

      # Create expected grpc response
      message_ids_element = "messageIdsElement-744837059"
      message_ids = [message_ids_element]
      expected_response = { message_ids: message_ids }
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::PublishResponse)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::PublishRequest, request)
        assert_equal(formatted_topic, request.topic)
        messages = messages.map do |req|
          Google::Gax::to_proto(req, Google::Pubsub::V1::PubsubMessage)
        end
        assert_equal(messages, request.messages)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:publish, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("publish")

      Google::Pubsub::V1::Publisher::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          response = client.publish(formatted_topic, messages)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.publish(formatted_topic, messages) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes publish with error' do
      # Create request parameters
      formatted_topic = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")
      data = ''
      messages_element = { data: data }
      messages = [messages_element]

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::PublishRequest, request)
        assert_equal(formatted_topic, request.topic)
        messages = messages.map do |req|
          Google::Gax::to_proto(req, Google::Pubsub::V1::PubsubMessage)
        end
        assert_equal(messages, request.messages)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:publish, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("publish")

      Google::Pubsub::V1::Publisher::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.publish(formatted_topic, messages)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'get_topic' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::PublisherClient#get_topic."

    it 'invokes get_topic without error' do
      # Create request parameters
      formatted_topic = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")

      # Create expected grpc response
      name = "name3373707"
      expected_response = { name: name }
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::Topic)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::GetTopicRequest, request)
        assert_equal(formatted_topic, request.topic)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:get_topic, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("get_topic")

      Google::Pubsub::V1::Publisher::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          response = client.get_topic(formatted_topic)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.get_topic(formatted_topic) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes get_topic with error' do
      # Create request parameters
      formatted_topic = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::GetTopicRequest, request)
        assert_equal(formatted_topic, request.topic)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:get_topic, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("get_topic")

      Google::Pubsub::V1::Publisher::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.get_topic(formatted_topic)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'list_topics' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::PublisherClient#list_topics."

    it 'invokes list_topics without error' do
      # Create request parameters
      formatted_project = Google::Cloud::Pubsub::V1::PublisherClient.project_path("[PROJECT]")

      # Create expected grpc response
      next_page_token = ""
      topics_element = {}
      topics = [topics_element]
      expected_response = { next_page_token: next_page_token, topics: topics }
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::ListTopicsResponse)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::ListTopicsRequest, request)
        assert_equal(formatted_project, request.project)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:list_topics, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("list_topics")

      Google::Pubsub::V1::Publisher::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          response = client.list_topics(formatted_project)

          # Verify the response
          assert(response.instance_of?(Google::Gax::PagedEnumerable))
          assert_equal(expected_response, response.page.response)
          assert_nil(response.next_page)
          assert_equal(expected_response.topics.to_a, response.to_a)
        end
      end
    end

    it 'invokes list_topics with error' do
      # Create request parameters
      formatted_project = Google::Cloud::Pubsub::V1::PublisherClient.project_path("[PROJECT]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::ListTopicsRequest, request)
        assert_equal(formatted_project, request.project)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:list_topics, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("list_topics")

      Google::Pubsub::V1::Publisher::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.list_topics(formatted_project)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'list_topic_subscriptions' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::PublisherClient#list_topic_subscriptions."

    it 'invokes list_topic_subscriptions without error' do
      # Create request parameters
      formatted_topic = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")

      # Create expected grpc response
      next_page_token = ""
      subscriptions_element = "subscriptionsElement1698708147"
      subscriptions = [subscriptions_element]
      expected_response = { next_page_token: next_page_token, subscriptions: subscriptions }
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::ListTopicSubscriptionsResponse)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::ListTopicSubscriptionsRequest, request)
        assert_equal(formatted_topic, request.topic)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:list_topic_subscriptions, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("list_topic_subscriptions")

      Google::Pubsub::V1::Publisher::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          response = client.list_topic_subscriptions(formatted_topic)

          # Verify the response
          assert(response.instance_of?(Google::Gax::PagedEnumerable))
          assert_equal(expected_response, response.page.response)
          assert_nil(response.next_page)
          assert_equal(expected_response.subscriptions.to_a, response.to_a)
        end
      end
    end

    it 'invokes list_topic_subscriptions with error' do
      # Create request parameters
      formatted_topic = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::ListTopicSubscriptionsRequest, request)
        assert_equal(formatted_topic, request.topic)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:list_topic_subscriptions, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("list_topic_subscriptions")

      Google::Pubsub::V1::Publisher::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.list_topic_subscriptions(formatted_topic)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'delete_topic' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::PublisherClient#delete_topic."

    it 'invokes delete_topic without error' do
      # Create request parameters
      formatted_topic = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::DeleteTopicRequest, request)
        assert_equal(formatted_topic, request.topic)
        OpenStruct.new(execute: nil)
      end
      mock_stub = MockGrpcClientStub_v1.new(:delete_topic, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("delete_topic")

      Google::Pubsub::V1::Publisher::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          response = client.delete_topic(formatted_topic)

          # Verify the response
          assert_nil(response)

          # Call method with block
          client.delete_topic(formatted_topic) do |response, operation|
            # Verify the response
            assert_nil(response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes delete_topic with error' do
      # Create request parameters
      formatted_topic = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::DeleteTopicRequest, request)
        assert_equal(formatted_topic, request.topic)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:delete_topic, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("delete_topic")

      Google::Pubsub::V1::Publisher::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.delete_topic(formatted_topic)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'set_iam_policy' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::PublisherClient#set_iam_policy."

    it 'invokes set_iam_policy without error' do
      # Create request parameters
      formatted_resource = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")
      policy = {}

      # Create expected grpc response
      version = 351608024
      etag = "21"
      expected_response = { version: version, etag: etag }
      expected_response = Google::Gax::to_proto(expected_response, Google::Iam::V1::Policy)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Iam::V1::SetIamPolicyRequest, request)
        assert_equal(formatted_resource, request.resource)
        assert_equal(Google::Gax::to_proto(policy, Google::Iam::V1::Policy), request.policy)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:set_iam_policy, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("set_iam_policy")

      Google::Iam::V1::IAMPolicy::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          response = client.set_iam_policy(formatted_resource, policy)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.set_iam_policy(formatted_resource, policy) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes set_iam_policy with error' do
      # Create request parameters
      formatted_resource = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")
      policy = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Iam::V1::SetIamPolicyRequest, request)
        assert_equal(formatted_resource, request.resource)
        assert_equal(Google::Gax::to_proto(policy, Google::Iam::V1::Policy), request.policy)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:set_iam_policy, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("set_iam_policy")

      Google::Iam::V1::IAMPolicy::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.set_iam_policy(formatted_resource, policy)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'get_iam_policy' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::PublisherClient#get_iam_policy."

    it 'invokes get_iam_policy without error' do
      # Create request parameters
      formatted_resource = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")

      # Create expected grpc response
      version = 351608024
      etag = "21"
      expected_response = { version: version, etag: etag }
      expected_response = Google::Gax::to_proto(expected_response, Google::Iam::V1::Policy)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Iam::V1::GetIamPolicyRequest, request)
        assert_equal(formatted_resource, request.resource)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:get_iam_policy, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("get_iam_policy")

      Google::Iam::V1::IAMPolicy::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          response = client.get_iam_policy(formatted_resource)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.get_iam_policy(formatted_resource) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes get_iam_policy with error' do
      # Create request parameters
      formatted_resource = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Iam::V1::GetIamPolicyRequest, request)
        assert_equal(formatted_resource, request.resource)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:get_iam_policy, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("get_iam_policy")

      Google::Iam::V1::IAMPolicy::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.get_iam_policy(formatted_resource)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'test_iam_permissions' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::PublisherClient#test_iam_permissions."

    it 'invokes test_iam_permissions without error' do
      # Create request parameters
      formatted_resource = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")
      permissions = []

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::to_proto(expected_response, Google::Iam::V1::TestIamPermissionsResponse)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Iam::V1::TestIamPermissionsRequest, request)
        assert_equal(formatted_resource, request.resource)
        assert_equal(permissions, request.permissions)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:test_iam_permissions, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("test_iam_permissions")

      Google::Iam::V1::IAMPolicy::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          response = client.test_iam_permissions(formatted_resource, permissions)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.test_iam_permissions(formatted_resource, permissions) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes test_iam_permissions with error' do
      # Create request parameters
      formatted_resource = Google::Cloud::Pubsub::V1::PublisherClient.topic_path("[PROJECT]", "[TOPIC]")
      permissions = []

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Iam::V1::TestIamPermissionsRequest, request)
        assert_equal(formatted_resource, request.resource)
        assert_equal(permissions, request.permissions)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:test_iam_permissions, mock_method)

      # Mock auth layer
      mock_credentials = MockPublisherCredentials_v1.new("test_iam_permissions")

      Google::Iam::V1::IAMPolicy::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Publisher.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.test_iam_permissions(formatted_resource, permissions)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end
end