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
require "minitest/focus"
require "fileutils"
require "open3"
require "tmpdir"

def generate_library_for_test imports, protos
  client_lib = Dir.mktmpdir

  protoc_cmd = [
    "grpc_tools_ruby_protoc",
    "#{imports.map {|x| "-I#{x}"}.join " "}",
    "--ruby_out=#{client_lib}/lib",
    "--grpc_out=#{client_lib}/lib",
    "--ruby_gapic_out=#{client_lib}",
    "--ruby_gapic_opt=configuration=../shared/config/showcase.yml",
    "#{protos.join " "}",
  ].join " "
  puts "#{protoc_cmd}" if ENV["VERBOSE"]
  protoc_cmd_output = `#{protoc_cmd}`
  puts protoc_cmd_output if ENV["VERBOSE"]
  client_lib
end

class ShowcaseTest < Minitest::Test
  def new_echo_client
    Google::Showcase::V1beta1::Echo::Client.new do |config|
      config.credentials = GRPC::Core::Channel.new "localhost:7469", nil, :this_channel_is_insecure
    end
  end

  def new_echo_operations_client
    Google::Showcase::V1beta1::Echo::Operations.new do |config|
      config.credentials = GRPC::Core::Channel.new "localhost:7469", nil, :this_channel_is_insecure
    end
  end

  @showcase_id = begin
    server_id = nil
    if ENV['CI'].nil?
      puts "Starting showcase server..." if ENV["VERBOSE"]
      server_id, status = Open3.capture2 "docker run --rm -d -p 7469:7469/tcp -p 7469:7469/udp "\
        "gcr.io/gapic-images/gapic-showcase:0.4.0"
      raise "failed to start showcase" unless status.exitstatus.zero?

      server_id.chop!
      puts "Started with container id: #{server_id}" if ENV["VERBOSE"]
    end

    server_id
  end

  @showcase_library = begin
    library = generate_library_for_test(
      %w[api-common-protos protos],
      %w[google/showcase/v1beta1/echo.proto])
    $LOAD_PATH.unshift "#{library}/lib"
    library
  end

  Minitest.after_run do
    FileUtils.remove_dir @showcase_library, true

    unless @showcase_id.nil?
      puts "Stopping showcase server (id: #{@showcase_id})..." if ENV["VERBOSE"]

      _, status = Open3.capture2 "docker kill #{@showcase_id}"
      raise "failed to kill showcase" unless status.exitstatus.zero?
    end
  end
end
