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

# @private
GAPIC_SHOWCASE_VERSION = '0.37.0'

def generate_library_for_test imports, protos
  client_lib = Dir.mktmpdir
  FileUtils.mkdir "#{client_lib}/lib"

  protoc_cmd = [
    "grpc_tools_ruby_protoc",
    "--experimental_allow_proto3_optional=1",
    "#{imports.map {|x| "-I#{x}"}.join " "}",
    "--ruby_out=#{client_lib}/lib",
    "--grpc_out=#{client_lib}/lib",
    "--ruby_gapic_out=#{client_lib}",
    "--ruby_gapic_opt=configuration=../shared/config/showcase.yml",
    "--ruby_gapic_opt=service-yaml=../shared/protos/google/showcase/v1beta1/showcase_v1beta1.yaml",
    "#{protos.join " "}",
  ].join " "
  puts protoc_cmd if ENV["VERBOSE"]
  protoc_cmd_output = `#{protoc_cmd}`
  puts protoc_cmd_output if ENV["VERBOSE"]
  client_lib
end

def gapic_showcase_running?
  system("ps aux | grep 'gapic-showcase run' | grep -v grep > /dev/null")
end

def tar_file_name
  file_name = "gapic-showcase-#{GAPIC_SHOWCASE_VERSION}-"
  case RUBY_PLATFORM
  when /x86_64-linux/
    file_name += "linux-amd64.tar.gz"
  when /x86_64-darwin\d+/
    file_name += "darwin-amd64.tar.gz"
  when /arm-linux/
    file_name += "linux-arm.tar.gz"
  when /arm64-darwin\d+/
    file_name += "darwin-arm64.tar.gz"
  else
    raise "Generator not supported for platform #{RUBY_PLATFORM}."
  end
  file_name
end

class ShowcaseTest < Minitest::Test
  def new_echo_client
    Google::Showcase::V1beta1::Echo::Client.new do |config|
      config.credentials = :this_channel_is_insecure
    end
  end

  def new_echo_rest_client
    Google::Showcase::V1beta1::Echo::Rest::Client.new do |config|
      config.endpoint = "http://localhost:7469"
      config.credentials = :this_channel_is_insecure
    end
  end

  def new_identity_client
    Google::Showcase::V1beta1::Identity::Client.new do |config|
      config.credentials = :this_channel_is_insecure
    end
  end

  def new_echo_operations_client
    Google::Showcase::V1beta1::Echo::Operations.new do |config|
      config.credentials = :this_channel_is_insecure
    end
  end

  def new_compliance_rest_client
    Google::Showcase::V1beta1::Compliance::Rest::Client.new do |config|
      config.endpoint = "http://localhost:7469"
      config.credentials = :this_channel_is_insecure
    end
  end

  @showcase_id = begin
    server_id = nil
    unless gapic_showcase_running?
      tmp_dir = Dir.mktmpdir "gapic-show-case-#{Time.now.to_i}"
      log_file = "#{tmp_dir}/gapic-showcase.log"
      url = "https://github.com/googleapis/gapic-showcase/releases/download/v#{GAPIC_SHOWCASE_VERSION}/#{tar_file_name}"
      _, status = Open3.capture2 "curl -sSL #{url} | tar -zx --directory #{tmp_dir}/"
      raise "failed to start showcase" unless status.exitstatus.zero?
      server_id = Process.spawn("#{tmp_dir}/gapic-showcase run", :out => [log_file, "w"])
      puts "Started showcase server v#{GAPIC_SHOWCASE_VERSION} (pid: #{server_id}) > #{log_file}." if ENV["VERBOSE"]
    else
      puts "Existing showcase server is available. Continuing..." if ENV["VERBOSE"]
    end

    server_id
  end

  @showcase_library = begin
    library =
      if ENV["SHOWCASE_USE_EXISTING_LIBRARY"]
        shared_dir = File.dirname File.dirname __dir__
        File.join(shared_dir, "output", "gapic", "templates", "showcase")
      else
        generate_library_for_test(
          %w[protos googleapis],
          %w[google/showcase/v1beta1/compliance.proto google/showcase/v1beta1/echo.proto google/showcase/v1beta1/identity.proto])
      end
    $LOAD_PATH.unshift "#{library}/lib"
    library
  end

  Minitest.after_run do
    FileUtils.remove_dir @showcase_library, true unless ENV["SHOWCASE_USE_EXISTING_LIBRARY"]

    unless @showcase_id.nil?
      puts "Stopping showcase server (id: #{@showcase_id})..." if ENV["VERBOSE"]
      _, status = Open3.capture2 "kill #{@showcase_id}"
      raise "failed to kill showcase" unless status.exitstatus.zero?
    end
  end
end
