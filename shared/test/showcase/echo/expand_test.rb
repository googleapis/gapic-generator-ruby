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

class ExpandTest < ShowcaseTest
  def setup
    @client = new_echo_client
  end

  def test_expand
    request_content = "The quick brown fox jumps over the lazy dog"

    response_enum = @client.expand content: request_content

    assert_equal request_content, response_enum.to_a.map(&:content).join(" ")
  end

  def test_expand_with_metadata
    request_content = "The quick brown fox jumps over the lazy dog"

    options = Gapic::CallOptions.new metadata: {
      'showcase-trailer': ["a", "b"],
      garbage:            ["xxx"]
    }

    @client.expand({ content: request_content }, options) do |response_enum, operation|
      # TODO: https://github.com/googleapis/gapic-generator-ruby/issues/241
      assert_nil operation.trailing_metadata

      assert_equal request_content, response_enum.to_a.map(&:content).join(" ")
      assert_instance_of GRPC::ActiveCall::Operation, operation

      assert_equal(
        { 'showcase-trailer' => ["a", "b"] },
        operation.trailing_metadata
      )
    end
  end
end
