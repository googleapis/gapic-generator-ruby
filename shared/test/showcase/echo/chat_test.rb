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
require "google/showcase/v1alpha3/echo"
require "grpc"

class ChatTest < ShowcaseTest
  def test_chat
    client = Google::Showcase::V1alpha3::Echo::Client.new do |config|
      config.credentials = GRPC::Core::Channel.new(
        "localhost:7469", nil, :this_channel_is_insecure
      )
    end

    pull_count = 0

    stream_input = Gapic::StreamInput.new

    responses = client.chat stream_input

    Thread.new do
      10.times do |n|
        puts "PUSH hello #{n}:1"
        stream_input.push content: "hello #{n}:1"
        sleep rand
      end
    end

    Thread.new do
      sleep 20

      stream_input.close
    end

    responses.each do |response|
      puts "PULL #{response.content}"
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
        puts "PUSH #{msg}:#{count}"
        stream_input.push content: "#{msg}:#{count}"
      end
    end

    assert pull_count >= 20, "should have pulled 20 messages by now"
  end
end
