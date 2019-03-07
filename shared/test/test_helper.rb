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

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "minitest/autorun"
require "open3"

class ShowcaseTest < Minitest::Test
  @showcase_id = begin
    puts "Starting showcase server..."

    server_id, status = Open3.capture2 "docker run --rm -d "\
        "gcr.io/gapic-showcase/gapic-showcase:0.0.12"
    raise "failed to start showcase" unless status.exitstatus.zero?

    server_id.chop!
    puts "Started with container id: #{server_id}"
    server_id
  end

  Minitest.after_run do
    puts "Stopping showcase server (id: #{@showcase_id})..."

    _, status = Open3.capture2 "docker stop #{@showcase_id}"
    raise "failed to stop showcase" unless status.exitstatus.zero?
  end
end
