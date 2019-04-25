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
require "google/showcase/v1alpha3/echo"

class ExpandTest < ShowcaseTest
  def test_expand
    client = Google::Showcase::V1alpha3::Echo.new(
      credentials: GRPC::Core::Channel.new("localhost:7469", nil, :this_channel_is_insecure)
    )

    request_content = "The quick brown fox jumps over the lazy dog"
    responses = Queue.new

    response_thread = client.expand content: request_content do |response|
      responses << response
    end

    response_thread.join

    responses_content_array = Array.new(responses.size) { responses.pop.content }

    assert_equal request_content, responses_content_array.join(" ")
  end
end
