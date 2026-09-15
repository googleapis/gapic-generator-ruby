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
require "openssl"
require "tmpdir"

# @private
GAPIC_SHOWCASE_VERSION = "0.44.0"

# @private
SHOWCASE_PORT = 7469

# @private
# File Showcase is asked to write its CA to.
SHOWCASE_CA_FILE = "ca.pem"

# @private
# Blocks until Showcase writes the CA requested via --ca-cert-output-file.
#
# Showcase binds its port before generating TLS material, so the CA lands up to
# 3.2s later (median 1.4s over 40 boots) - too variable for a fixed sleep. The
# file is parsed, not merely tested for existence, since it is briefly visible
# mid-write.
#
# @param ca_path [String]
# @param timeout [Numeric]
# @return [String] ca_path, once it holds a usable certificate.
def wait_for_showcase_ca ca_path, timeout: 30
  deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + timeout
  begin
    OpenSSL::X509::Certificate.new File.read ca_path
  rescue Errno::ENOENT, OpenSSL::X509::CertificateError
    if Process.clock_gettime(Process::CLOCK_MONOTONIC) > deadline
      raise "showcase did not write a CA certificate to #{ca_path} within #{timeout}s"
    end
    sleep 0.05
    retry
  end
  ca_path
end

# @private
# Starts a Showcase server over TLS and returns once it is usable.
#
# @param binary [String] Path to the gapic-showcase executable.
# @param port [Integer]
# @param ca_path [String] Where Showcase should publish its CA certificate.
# @param log_file [String]
# @param extra_args [Array<String>] Additional flags, e.g. --tls-groups.
# @return [Integer] The server's pid.
def spawn_showcase binary, port:, ca_path:, log_file:, extra_args: []
  # A stale CA would satisfy the wait instantly, then fail verification.
  FileUtils.rm_f ca_path
  # err: [:child, :out] rather than a second redirect to log_file: two redirects
  # to one path get independent offsets and would overwrite each other.
  pid = Process.spawn(
    binary, "run", "--port", ":#{port}",
    "--tls", "--ca-cert-output-file", ca_path, *extra_args,
    out: [log_file, "w"], err: [:child, :out]
  )
  begin
    wait_for_showcase_ca ca_path
  rescue StandardError
    # Otherwise it survives holding the port and the next run silently reuses it.
    stop_showcase pid
    raise
  end
  pid
end

# @private
# Terminates a Showcase server, tolerating one that has already gone away.
#
# @param pid [Integer, nil]
# @return [void]
def stop_showcase pid
  return if pid.nil?
  Process.kill "TERM", pid
  Process.wait pid
rescue Errno::ESRCH, Errno::ECHILD
  nil
end

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
      config.credentials = ShowcaseTest.channel_credentials
    end
  end

  def new_echo_rest_client
    Google::Showcase::V1beta1::Echo::Rest::Client.new do |config|
      config.endpoint = "https://localhost:#{SHOWCASE_PORT}"
      config.credentials = :this_channel_is_insecure
    end
  end

  def new_identity_client
    Google::Showcase::V1beta1::Identity::Client.new do |config|
      config.credentials = ShowcaseTest.channel_credentials
    end
  end

  def new_echo_operations_client
    Google::Showcase::V1beta1::Echo::Operations.new do |config|
      config.credentials = ShowcaseTest.channel_credentials
    end
  end

  def new_compliance_rest_client
    Google::Showcase::V1beta1::Compliance::Rest::Client.new do |config|
      config.endpoint = "https://localhost:#{SHOWCASE_PORT}"
      config.credentials = :this_channel_is_insecure
    end
  end

  # Env vars pointing REST at Showcase's CA, saved so after_run can restore them
  # rather than leak a test-only root. REST only: Net::HTTP re-reads
  # SSL_CERT_FILE per connection, while the gRPC C core resolves
  # GRPC_DEFAULT_SSL_ROOTS_FILE_PATH once per process and gets credentials
  # explicitly instead.
  TLS_ENV_KEYS = ["SSL_CERT_FILE"].freeze

  @original_tls_env = TLS_ENV_KEYS.to_h { |key| [key, ENV[key]] }
  @showcase_dir = nil
  @showcase_ca_path = nil

  # Channel credentials trusting the CA of the Showcase server under test.
  #
  # Each --tls server mints its own CA, so trust cannot be set once per process;
  # every channel must be handed its roots.
  #
  # @param ca_path [String, nil] Defaults to the server this helper started; nil
  #   falls back to system roots, all that is possible for an external server
  #   with no SHOWCASE_TLS_CERT.
  # @return [GRPC::Core::ChannelCredentials]
  def self.channel_credentials ca_path = @showcase_ca_path
    return GRPC::Core::ChannelCredentials.new if ca_path.nil?
    GRPC::Core::ChannelCredentials.new File.read ca_path
  end

  @showcase_id = begin
    server_id = nil
    if gapic_showcase_running?
      puts "Existing showcase server is available. Continuing..." if ENV["VERBOSE"]
      # Tests speak TLS unconditionally, so an external server must publish its CA.
      if ENV["SHOWCASE_TLS_CERT"]
        @showcase_ca_path = ENV["SHOWCASE_TLS_CERT"]
        TLS_ENV_KEYS.each { |key| ENV[key] = @showcase_ca_path }
      else
        warn "WARNING: reusing a running showcase server without SHOWCASE_TLS_CERT set; " \
             "TLS verification will fail unless it was started with a trusted certificate."
      end
    else
      @showcase_dir = Dir.mktmpdir "gapic-show-case-#{Time.now.to_i}"
      log_file = "#{@showcase_dir}/gapic-showcase.log"
      url = "https://github.com/googleapis/gapic-showcase/releases/download/v#{GAPIC_SHOWCASE_VERSION}/#{tar_file_name}"
      _, status = Open3.capture2 "curl -sSL #{url} | tar -zx --directory #{@showcase_dir}/"
      raise "failed to start showcase" unless status.exitstatus.zero?

      # Showcase generates its own serving cert under --tls and publishes the
      # signing CA, so the harness runs no certificate authority of its own.
      @showcase_ca_path = File.join @showcase_dir, SHOWCASE_CA_FILE
      server_id = spawn_showcase "#{@showcase_dir}/gapic-showcase",
                                 port: SHOWCASE_PORT,
                                 ca_path: @showcase_ca_path,
                                 log_file: log_file
      TLS_ENV_KEYS.each { |key| ENV[key] = @showcase_ca_path }
      puts "Started showcase server v#{GAPIC_SHOWCASE_VERSION} (pid: #{server_id}) > #{log_file}." if ENV["VERBOSE"]
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
          %w[google/showcase/v1beta1/compliance.proto google/showcase/v1beta1/echo.proto google/showcase/v1beta1/identity.proto google/showcase/v1beta1/resumable_upload.proto])
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

    @original_tls_env.each { |key, value| ENV[key] = value }
    FileUtils.remove_entry @showcase_dir, true if @showcase_dir
  end
end
