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

require "test_helper"
require "google/showcase/v1beta1/echo"
require "grpc"

class EchoGRPCTest < ShowcaseTest
  def setup
    @client = new_echo_client
  end

  def test_universe_domain
    assert_equal "googleapis.com", @client.universe_domain
  end

  def test_echo
    response = @client.echo content: "hi there!"
    assert_equal "hi there!", response.content
  end

  def test_echo_with_block
    @client.echo content: "hello again!" do |response, operation|
      assert_equal "hello again!", response.content
      assert_instance_of GRPC::ActiveCall::Operation, operation
      refute_equal({}, operation.trailing_metadata)
    end
  end

  def test_echo_with_metadata
    options = Gapic::CallOptions.new metadata: {
      'showcase-trailer': ["one", "two"],
      garbage:            ["baz"]
    }
    @client.echo({ content: "hi there!" }, options) do |response, operation|
      assert_equal "hi there!", response.content
      assert_instance_of GRPC::ActiveCall::Operation, operation
      assert_equal ["one", "two"], operation.trailing_metadata["showcase-trailer"]
    end
  end

  def test_echo_with_api_version_metadata
    @client.echo({ content: "api version" }) do |response, operation|
      assert_equal "api version", response.content
      assert_instance_of GRPC::ActiveCall::Operation, operation
      assert_equal "v1_20240408", operation.trailing_metadata["x-goog-api-version"]
    end
  end

  def test_echo_api_version_constant
    assert_equal "v1_20240408", Google::Showcase::V1beta1::Echo::Client::API_VERSION
  end
end

class EchoRestTest < ShowcaseTest
  def setup
    @client = new_echo_rest_client
  end

  def test_universe_domain
    assert_equal "googleapis.com", @client.universe_domain
  end

  def test_echo
    response = @client.echo content: "hi there!"
    assert_equal "hi there!", response.content
  end

  def test_echo_auto_populate
    uuid_call_count = 0
    expected_uuid_call_count = 2 # request_id, other_request_id
    original_uuid_method = SecureRandom.method(:uuid)
    SecureRandom.define_singleton_method(:uuid) do
      uuid_call_count += 1
      case uuid_call_count
      when 1
        "request_id"
      when 2
        "other_request_id"
      else
        "default-id-should-not-be-set"
      end
    end
    response = @client.echo content: "auto_populate"
    assert_equal expected_uuid_call_count, uuid_call_count
    assert_equal "request_id", response.request_id
    assert_equal "other_request_id", response.other_request_id
    SecureRandom.define_singleton_method :uuid, original_uuid_method
  end

  def test_echo_auto_populate_non_explicit_presence_value_set_default
    expected_content = "non_explicit_presence_value_set_default"
    request = Google::Showcase::V1beta1::EchoRequest.new content: expected_content
    assert_raises NoMethodError do
      request.has_request_id?
    end
    request.request_id = ""

    response = @client.echo request
    assert_equal expected_content, request.content
    refute_equal "", request.request_id
  end

  def test_echo_auto_populate_with_explicit_presence_value_not_set
    expected_content = "with_explicit_presence_value_not_set"
    request = Google::Showcase::V1beta1::EchoRequest.new content: expected_content
    refute request.has_other_request_id?

    response = @client.echo request
    assert_equal expected_content, response.content
    refute_equal "", response.other_request_id
  end

  def test_echo_auto_populate_with_explicit_presence_value_set_default
    expected_content = "with_explicit_presence_value_set_default"
    request = Google::Showcase::V1beta1::EchoRequest.new content: expected_content
    refute request.has_other_request_id?

    request.other_request_id = "" # Empty string sets field presence.
    response = @client.echo request
    assert_equal expected_content, response.content
    assert_equal "", response.other_request_id
  end

  def test_echo_not_auto_populate_hash_key_as_string
    expected_content = "hash_key_as_string"
    expected_request_id = "request_id_from_string"
    request = { "content" => expected_content, "request_id" => expected_request_id }
    response = @client.echo request
    assert_equal expected_content, response.content
    assert_equal expected_request_id, response.request_id
  end

  def test_echo_not_auto_populate_hash_key_as_symbol
    expected_content = "hash_key_as_symbol"
    expected_request_id = "request_id_from_symbol"
    request = { content: expected_content, request_id: expected_request_id }
    response = @client.echo request
    assert_equal expected_content, response.content
    assert_equal expected_request_id, response.request_id
  end

  def test_echo_with_api_version_rest_metadata
    @client.echo({ content: "api version rest" }) do |response, operation|
      assert_equal "api version rest", response.content
      assert_instance_of Gapic::Rest::TransportOperation, operation
      assert_equal "v1_20240408", operation.underlying_op.headers["x-showcase-request-x-goog-api-version"]
    end
  end

  def test_echo_api_version_constant
    assert_equal "v1_20240408", Google::Showcase::V1beta1::Echo::Rest::Client::API_VERSION
  end
end
