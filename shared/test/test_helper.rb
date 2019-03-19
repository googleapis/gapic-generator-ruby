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

require "minitest/autorun"
require "fileutils"
require "open3"
require "tmpdir"

def generate_library_for_test imports, protos
  client_lib = Dir.mktmpdir

  protoc_cmd = [
    "grpc_tools_ruby_protoc",
    "#{imports.map {|x| "-I#{x}"}.join " "}",
    "--ruby_out=#{client_lib}",
    "--grpc_out=#{client_lib}",
    "--ruby_gapic_out=#{client_lib}",
    "--ruby_gapic_opt=configuration=../shared/config/showcase.yml",
    "#{protos.join " "}",
  ].join " "
  puts "#{protoc_cmd}"
  puts `#{protoc_cmd}`
  client_lib
end

class ShowcaseTest < Minitest::Test
  @showcase_id = begin
    server_id = nil
    if ENV['CI'].nil?
      puts "Starting showcase server..."
      server_id, status = Open3.capture2 "docker run --rm -d -p 7469:7469/tcp -p 7469:7469/udp "\
        "gcr.io/gapic-showcase/gapic-showcase:0.0.12"
      raise "failed to start showcase" unless status.exitstatus.zero?

      server_id.chop!
      puts "Started with container id: #{server_id}"
    end

    server_id
  end

  @showcase_library = begin
    library = generate_library_for_test(
      %w[api-common-protos protos],
      %w[google/showcase/v1alpha3/echo.proto])
    $LOAD_PATH.unshift library
    library
  end

  Minitest.after_run do
    FileUtils.remove_dir @showcase_library, true

    unless @showcase_id.nil?
      puts "Stopping showcase server (id: #{@showcase_id})..."

      _, status = Open3.capture2 "docker stop #{@showcase_id}"
      raise "failed to stop showcase" unless status.exitstatus.zero?
    end
  end
end
