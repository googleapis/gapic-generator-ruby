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
require "google/cloud/pubsub/v1/subscriber_client"
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

class MockSubscriberCredentials_v1 < Google::Cloud::Pubsub::V1::Credentials
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

describe Google::Cloud::Pubsub::V1::SubscriberClient do

  describe 'create_subscription' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#create_subscription."

    it 'invokes create_subscription without error' do
      # Create request parameters
      formatted_name = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
      formatted_topic = Google::Cloud::Pubsub::V1::SubscriberClient.topic_path("[PROJECT]", "[TOPIC]")

      # Create expected grpc response
      name_2 = "name2-1052831874"
      topic_2 = "topic2-1139259102"
      ack_deadline_seconds = 2135351438
      retain_acked_messages = false
      expected_response = {
        name: name_2,
        topic: topic_2,
        ack_deadline_seconds: ack_deadline_seconds,
        retain_acked_messages: retain_acked_messages
      }
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::Subscription)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::Subscription, request)
        assert_equal(formatted_name, request.name)
        assert_equal(formatted_topic, request.topic)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:create_subscription, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("create_subscription")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          response = client.create_subscription(formatted_name, formatted_topic)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.create_subscription(formatted_name, formatted_topic) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes create_subscription with error' do
      # Create request parameters
      formatted_name = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
      formatted_topic = Google::Cloud::Pubsub::V1::SubscriberClient.topic_path("[PROJECT]", "[TOPIC]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::Subscription, request)
        assert_equal(formatted_name, request.name)
        assert_equal(formatted_topic, request.topic)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:create_subscription, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("create_subscription")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.create_subscription(formatted_name, formatted_topic)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'get_subscription' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#get_subscription."

    it 'invokes get_subscription without error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")

      # Create expected grpc response
      name = "name3373707"
      topic = "topic110546223"
      ack_deadline_seconds = 2135351438
      retain_acked_messages = false
      expected_response = {
        name: name,
        topic: topic,
        ack_deadline_seconds: ack_deadline_seconds,
        retain_acked_messages: retain_acked_messages
      }
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::Subscription)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::GetSubscriptionRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:get_subscription, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("get_subscription")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          response = client.get_subscription(formatted_subscription)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.get_subscription(formatted_subscription) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes get_subscription with error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::GetSubscriptionRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:get_subscription, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("get_subscription")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.get_subscription(formatted_subscription)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'update_subscription' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#update_subscription."

    it 'invokes update_subscription without error' do
      # Create request parameters
      ack_deadline_seconds = 42
      subscription = { ack_deadline_seconds: ack_deadline_seconds }
      paths_element = "ack_deadline_seconds"
      paths = [paths_element]
      update_mask = { paths: paths }

      # Create expected grpc response
      name = "name3373707"
      topic = "topic110546223"
      ack_deadline_seconds_2 = 921632575
      retain_acked_messages = false
      expected_response = {
        name: name,
        topic: topic,
        ack_deadline_seconds: ack_deadline_seconds_2,
        retain_acked_messages: retain_acked_messages
      }
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::Subscription)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::UpdateSubscriptionRequest, request)
        assert_equal(Google::Gax::to_proto(subscription, Google::Pubsub::V1::Subscription), request.subscription)
        assert_equal(Google::Gax::to_proto(update_mask, Google::Protobuf::FieldMask), request.update_mask)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:update_subscription, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("update_subscription")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          response = client.update_subscription(subscription, update_mask)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.update_subscription(subscription, update_mask) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes update_subscription with error' do
      # Create request parameters
      ack_deadline_seconds = 42
      subscription = { ack_deadline_seconds: ack_deadline_seconds }
      paths_element = "ack_deadline_seconds"
      paths = [paths_element]
      update_mask = { paths: paths }

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::UpdateSubscriptionRequest, request)
        assert_equal(Google::Gax::to_proto(subscription, Google::Pubsub::V1::Subscription), request.subscription)
        assert_equal(Google::Gax::to_proto(update_mask, Google::Protobuf::FieldMask), request.update_mask)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:update_subscription, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("update_subscription")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.update_subscription(subscription, update_mask)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'list_subscriptions' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#list_subscriptions."

    it 'invokes list_subscriptions without error' do
      # Create request parameters
      formatted_project = Google::Cloud::Pubsub::V1::SubscriberClient.project_path("[PROJECT]")

      # Create expected grpc response
      next_page_token = ""
      subscriptions_element = {}
      subscriptions = [subscriptions_element]
      expected_response = { next_page_token: next_page_token, subscriptions: subscriptions }
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::ListSubscriptionsResponse)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::ListSubscriptionsRequest, request)
        assert_equal(formatted_project, request.project)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:list_subscriptions, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("list_subscriptions")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          response = client.list_subscriptions(formatted_project)

          # Verify the response
          assert(response.instance_of?(Google::Gax::PagedEnumerable))
          assert_equal(expected_response, response.page.response)
          assert_nil(response.next_page)
          assert_equal(expected_response.subscriptions.to_a, response.to_a)
        end
      end
    end

    it 'invokes list_subscriptions with error' do
      # Create request parameters
      formatted_project = Google::Cloud::Pubsub::V1::SubscriberClient.project_path("[PROJECT]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::ListSubscriptionsRequest, request)
        assert_equal(formatted_project, request.project)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:list_subscriptions, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("list_subscriptions")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.list_subscriptions(formatted_project)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'delete_subscription' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#delete_subscription."

    it 'invokes delete_subscription without error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::DeleteSubscriptionRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        OpenStruct.new(execute: nil)
      end
      mock_stub = MockGrpcClientStub_v1.new(:delete_subscription, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("delete_subscription")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          response = client.delete_subscription(formatted_subscription)

          # Verify the response
          assert_nil(response)

          # Call method with block
          client.delete_subscription(formatted_subscription) do |response, operation|
            # Verify the response
            assert_nil(response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes delete_subscription with error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::DeleteSubscriptionRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:delete_subscription, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("delete_subscription")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.delete_subscription(formatted_subscription)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'modify_ack_deadline' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#modify_ack_deadline."

    it 'invokes modify_ack_deadline without error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
      ack_ids = []
      ack_deadline_seconds = 0

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::ModifyAckDeadlineRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        assert_equal(ack_ids, request.ack_ids)
        assert_equal(ack_deadline_seconds, request.ack_deadline_seconds)
        OpenStruct.new(execute: nil)
      end
      mock_stub = MockGrpcClientStub_v1.new(:modify_ack_deadline, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("modify_ack_deadline")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          response = client.modify_ack_deadline(
            formatted_subscription,
            ack_ids,
            ack_deadline_seconds
          )

          # Verify the response
          assert_nil(response)

          # Call method with block
          client.modify_ack_deadline(
            formatted_subscription,
            ack_ids,
            ack_deadline_seconds
          ) do |response, operation|
            # Verify the response
            assert_nil(response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes modify_ack_deadline with error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
      ack_ids = []
      ack_deadline_seconds = 0

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::ModifyAckDeadlineRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        assert_equal(ack_ids, request.ack_ids)
        assert_equal(ack_deadline_seconds, request.ack_deadline_seconds)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:modify_ack_deadline, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("modify_ack_deadline")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.modify_ack_deadline(
              formatted_subscription,
              ack_ids,
              ack_deadline_seconds
            )
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'acknowledge' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#acknowledge."

    it 'invokes acknowledge without error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
      ack_ids = []

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::AcknowledgeRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        assert_equal(ack_ids, request.ack_ids)
        OpenStruct.new(execute: nil)
      end
      mock_stub = MockGrpcClientStub_v1.new(:acknowledge, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("acknowledge")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          response = client.acknowledge(formatted_subscription, ack_ids)

          # Verify the response
          assert_nil(response)

          # Call method with block
          client.acknowledge(formatted_subscription, ack_ids) do |response, operation|
            # Verify the response
            assert_nil(response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes acknowledge with error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
      ack_ids = []

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::AcknowledgeRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        assert_equal(ack_ids, request.ack_ids)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:acknowledge, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("acknowledge")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.acknowledge(formatted_subscription, ack_ids)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'pull' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#pull."

    it 'invokes pull without error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
      max_messages = 0

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::PullResponse)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::PullRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        assert_equal(max_messages, request.max_messages)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:pull, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("pull")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          response = client.pull(formatted_subscription, max_messages)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.pull(formatted_subscription, max_messages) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes pull with error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
      max_messages = 0

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::PullRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        assert_equal(max_messages, request.max_messages)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:pull, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("pull")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.pull(formatted_subscription, max_messages)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'streaming_pull' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#streaming_pull."

    it 'invokes streaming_pull without error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
      stream_ack_deadline_seconds = 0
      request = { subscription: formatted_subscription, stream_ack_deadline_seconds: stream_ack_deadline_seconds }

      # Create expected grpc response
      received_messages_element = {}
      received_messages = [received_messages_element]
      expected_response = { received_messages: received_messages }
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::StreamingPullResponse)

      # Mock Grpc layer
      mock_method = proc do |requests|
        request = requests.first
        assert_instance_of(Google::Pubsub::V1::StreamingPullRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        assert_equal(stream_ack_deadline_seconds, request.stream_ack_deadline_seconds)
        OpenStruct.new(execute: [expected_response])
      end
      mock_stub = MockGrpcClientStub_v1.new(:streaming_pull, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("streaming_pull")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          response = client.streaming_pull([request])

          # Verify the response
          assert_equal(1, response.count)
          assert_equal(expected_response, response.first)
        end
      end
    end

    it 'invokes streaming_pull with error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
      stream_ack_deadline_seconds = 0
      request = { subscription: formatted_subscription, stream_ack_deadline_seconds: stream_ack_deadline_seconds }

      # Mock Grpc layer
      mock_method = proc do |requests|
        request = requests.first
        assert_instance_of(Google::Pubsub::V1::StreamingPullRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        assert_equal(stream_ack_deadline_seconds, request.stream_ack_deadline_seconds)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:streaming_pull, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("streaming_pull")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.streaming_pull([request])
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'modify_push_config' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#modify_push_config."

    it 'invokes modify_push_config without error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
      push_config = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::ModifyPushConfigRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        assert_equal(Google::Gax::to_proto(push_config, Google::Pubsub::V1::PushConfig), request.push_config)
        OpenStruct.new(execute: nil)
      end
      mock_stub = MockGrpcClientStub_v1.new(:modify_push_config, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("modify_push_config")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          response = client.modify_push_config(formatted_subscription, push_config)

          # Verify the response
          assert_nil(response)

          # Call method with block
          client.modify_push_config(formatted_subscription, push_config) do |response, operation|
            # Verify the response
            assert_nil(response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes modify_push_config with error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
      push_config = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::ModifyPushConfigRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        assert_equal(Google::Gax::to_proto(push_config, Google::Pubsub::V1::PushConfig), request.push_config)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:modify_push_config, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("modify_push_config")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.modify_push_config(formatted_subscription, push_config)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'list_snapshots' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#list_snapshots."

    it 'invokes list_snapshots without error' do
      # Create request parameters
      formatted_project = Google::Cloud::Pubsub::V1::SubscriberClient.project_path("[PROJECT]")

      # Create expected grpc response
      next_page_token = ""
      snapshots_element = {}
      snapshots = [snapshots_element]
      expected_response = { next_page_token: next_page_token, snapshots: snapshots }
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::ListSnapshotsResponse)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::ListSnapshotsRequest, request)
        assert_equal(formatted_project, request.project)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:list_snapshots, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("list_snapshots")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          response = client.list_snapshots(formatted_project)

          # Verify the response
          assert(response.instance_of?(Google::Gax::PagedEnumerable))
          assert_equal(expected_response, response.page.response)
          assert_nil(response.next_page)
          assert_equal(expected_response.snapshots.to_a, response.to_a)
        end
      end
    end

    it 'invokes list_snapshots with error' do
      # Create request parameters
      formatted_project = Google::Cloud::Pubsub::V1::SubscriberClient.project_path("[PROJECT]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::ListSnapshotsRequest, request)
        assert_equal(formatted_project, request.project)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:list_snapshots, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("list_snapshots")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.list_snapshots(formatted_project)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'create_snapshot' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#create_snapshot."

    it 'invokes create_snapshot without error' do
      # Create request parameters
      formatted_name = Google::Cloud::Pubsub::V1::SubscriberClient.snapshot_path("[PROJECT]", "[SNAPSHOT]")
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")

      # Create expected grpc response
      name_2 = "name2-1052831874"
      topic = "topic110546223"
      expected_response = { name: name_2, topic: topic }
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::Snapshot)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::CreateSnapshotRequest, request)
        assert_equal(formatted_name, request.name)
        assert_equal(formatted_subscription, request.subscription)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:create_snapshot, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("create_snapshot")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          response = client.create_snapshot(formatted_name, formatted_subscription)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.create_snapshot(formatted_name, formatted_subscription) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes create_snapshot with error' do
      # Create request parameters
      formatted_name = Google::Cloud::Pubsub::V1::SubscriberClient.snapshot_path("[PROJECT]", "[SNAPSHOT]")
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::CreateSnapshotRequest, request)
        assert_equal(formatted_name, request.name)
        assert_equal(formatted_subscription, request.subscription)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:create_snapshot, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("create_snapshot")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.create_snapshot(formatted_name, formatted_subscription)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'update_snapshot' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#update_snapshot."

    it 'invokes update_snapshot without error' do
      # Create request parameters
      seconds = 123456
      expire_time = { seconds: seconds }
      snapshot = { expire_time: expire_time }
      paths_element = "expire_time"
      paths = [paths_element]
      update_mask = { paths: paths }

      # Create expected grpc response
      name = "name3373707"
      topic = "topic110546223"
      expected_response = { name: name, topic: topic }
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::Snapshot)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::UpdateSnapshotRequest, request)
        assert_equal(Google::Gax::to_proto(snapshot, Google::Pubsub::V1::Snapshot), request.snapshot)
        assert_equal(Google::Gax::to_proto(update_mask, Google::Protobuf::FieldMask), request.update_mask)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:update_snapshot, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("update_snapshot")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          response = client.update_snapshot(snapshot, update_mask)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.update_snapshot(snapshot, update_mask) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes update_snapshot with error' do
      # Create request parameters
      seconds = 123456
      expire_time = { seconds: seconds }
      snapshot = { expire_time: expire_time }
      paths_element = "expire_time"
      paths = [paths_element]
      update_mask = { paths: paths }

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::UpdateSnapshotRequest, request)
        assert_equal(Google::Gax::to_proto(snapshot, Google::Pubsub::V1::Snapshot), request.snapshot)
        assert_equal(Google::Gax::to_proto(update_mask, Google::Protobuf::FieldMask), request.update_mask)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:update_snapshot, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("update_snapshot")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.update_snapshot(snapshot, update_mask)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'delete_snapshot' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#delete_snapshot."

    it 'invokes delete_snapshot without error' do
      # Create request parameters
      formatted_snapshot = Google::Cloud::Pubsub::V1::SubscriberClient.snapshot_path("[PROJECT]", "[SNAPSHOT]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::DeleteSnapshotRequest, request)
        assert_equal(formatted_snapshot, request.snapshot)
        OpenStruct.new(execute: nil)
      end
      mock_stub = MockGrpcClientStub_v1.new(:delete_snapshot, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("delete_snapshot")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          response = client.delete_snapshot(formatted_snapshot)

          # Verify the response
          assert_nil(response)

          # Call method with block
          client.delete_snapshot(formatted_snapshot) do |response, operation|
            # Verify the response
            assert_nil(response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes delete_snapshot with error' do
      # Create request parameters
      formatted_snapshot = Google::Cloud::Pubsub::V1::SubscriberClient.snapshot_path("[PROJECT]", "[SNAPSHOT]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::DeleteSnapshotRequest, request)
        assert_equal(formatted_snapshot, request.snapshot)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:delete_snapshot, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("delete_snapshot")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.delete_snapshot(formatted_snapshot)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'seek' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#seek."

    it 'invokes seek without error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::to_proto(expected_response, Google::Pubsub::V1::SeekResponse)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::SeekRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub_v1.new(:seek, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("seek")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          response = client.seek(formatted_subscription)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.seek(formatted_subscription) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes seek with error' do
      # Create request parameters
      formatted_subscription = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Pubsub::V1::SeekRequest, request)
        assert_equal(formatted_subscription, request.subscription)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:seek, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("seek")

      Google::Pubsub::V1::Subscriber::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.seek(formatted_subscription)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'set_iam_policy' do
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#set_iam_policy."

    it 'invokes set_iam_policy without error' do
      # Create request parameters
      formatted_resource = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
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
      mock_credentials = MockSubscriberCredentials_v1.new("set_iam_policy")

      Google::Iam::V1::IAMPolicy::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

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
      formatted_resource = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
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
      mock_credentials = MockSubscriberCredentials_v1.new("set_iam_policy")

      Google::Iam::V1::IAMPolicy::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

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
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#get_iam_policy."

    it 'invokes get_iam_policy without error' do
      # Create request parameters
      formatted_resource = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")

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
      mock_credentials = MockSubscriberCredentials_v1.new("get_iam_policy")

      Google::Iam::V1::IAMPolicy::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

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
      formatted_resource = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Iam::V1::GetIamPolicyRequest, request)
        assert_equal(formatted_resource, request.resource)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub_v1.new(:get_iam_policy, mock_method)

      # Mock auth layer
      mock_credentials = MockSubscriberCredentials_v1.new("get_iam_policy")

      Google::Iam::V1::IAMPolicy::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

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
    custom_error = CustomTestError_v1.new "Custom test error for Google::Cloud::Pubsub::V1::SubscriberClient#test_iam_permissions."

    it 'invokes test_iam_permissions without error' do
      # Create request parameters
      formatted_resource = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
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
      mock_credentials = MockSubscriberCredentials_v1.new("test_iam_permissions")

      Google::Iam::V1::IAMPolicy::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

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
      formatted_resource = Google::Cloud::Pubsub::V1::SubscriberClient.subscription_path("[PROJECT]", "[SUBSCRIPTION]")
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
      mock_credentials = MockSubscriberCredentials_v1.new("test_iam_permissions")

      Google::Iam::V1::IAMPolicy::Stub.stub(:new, mock_stub) do
        Google::Cloud::Pubsub::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Pubsub::Subscriber.new(version: :v1)

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