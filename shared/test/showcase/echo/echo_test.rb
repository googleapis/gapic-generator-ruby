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
      assert_equal({}, operation.trailing_metadata)
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
      assert_equal(
        { 'showcase-trailer' => ["one", "two"] },
        operation.trailing_metadata
      )
    end
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

  def test_echo_with_auto_populated_fields
    uuid_call_count = 0
    expected_uuid_call_count = 1 # request_id
    original_uuid_method = SecureRandom.method(:uuid)
    SecureRandom.define_singleton_method(:uuid) do
      uuid_call_count += 1
      original_uuid_method.call
    end
    response = @client.echo content: "auto populated fields"
    assert_equal expected_uuid_call_count, uuid_call_count
  end
end
