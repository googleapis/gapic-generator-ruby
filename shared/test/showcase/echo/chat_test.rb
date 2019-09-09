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

class ChatTest < ShowcaseTest
  def setup
    @client = new_echo_client
  end

  def test_chat
    pull_count = 0

    stream_input = Gapic::StreamInput.new

    responses = @client.chat stream_input

    Thread.new do
      10.times do |n|
        puts "PUSH hello #{n}:1" if ENV["VERBOSE"]
        stream_input.push content: "hello #{n}:1"
        sleep rand
      end
    end

    Thread.new do
      sleep 20

      stream_input.close
    end

    responses.each do |response|
      puts "PULL #{response.content}" if ENV["VERBOSE"]
      pull_count += 1

      if pull_count >= 20
        stream_input.close
        break
      end

      Thread.new do
        sleep rand

        msg, count = response.content.split ":"
        count = count.to_i
        count += 1
        puts "PUSH #{msg}:#{count}" if ENV["VERBOSE"]
        stream_input.push content: "#{msg}:#{count}"
      end
    end

    assert pull_count >= 20, "should have pulled 20 messages by now"
  end

  def test_chat_with_metadata
    options = Gapic::CallOptions.new metadata: {
      'showcase-trailer': ["so", "much", "chat"],
      quiet:              ["please"]
    }
    stream_input = Gapic::StreamInput.new

    @client.chat stream_input, options do |response_enum, operation|
      # TODO: confusing? desirable?
      assert_nil operation.trailing_metadata

      chatty_thread = Thread.new do
        sleep rand

        ["a", "b", "cee"].each { |x| stream_input.push content: x }
        stream_input.close

        assert_equal ["a", "b", "cee"], response_enum.to_a.map(&:content)
      end

      chatty_thread.join

      assert_equal({
        'showcase-trailer' => ["so", "much", "chat"]
      }, operation.trailing_metadata)
    end
  end
end
