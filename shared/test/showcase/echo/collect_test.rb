# frozen_string_literal: true

# Copyright 2019 Google LLC
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

class CollectTest < ShowcaseTest
  def setup
    @client = new_echo_client
  end

  def test_collect
    stream_input = Gapic::StreamInput.new

    Thread.new do
      "well hello there old friend".split(" ").each do |c|
        stream_input.push content: c
        sleep rand
      end
      stream_input.close
    end

    response = @client.collect stream_input

    assert_equal "well hello there old friend", response.content
  end

  def test_collect_with_metadata
    stream_input = Gapic::StreamInput.new

    Thread.new do
      "well hello there old friend".split(" ").each do |c|
        stream_input.push content: c
        sleep rand
      end
      stream_input.close
    end

    options = Gapic::CallOptions.new metadata: {
      'showcase-trailer': ["a", "b"],
      garbage:            ["xxx"]
    }

    @client.collect stream_input, options do |response, operation|
      assert_equal ["a", "b"], operation.trailing_metadata["showcase-trailer"]

      assert_equal "well hello there old friend", response.content
      assert_instance_of GRPC::ActiveCall::Operation, operation

      assert_equal ["a", "b"], operation.trailing_metadata["showcase-trailer"]
    end
  end
end
