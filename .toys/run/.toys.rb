# frozen_string_literal: true

# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

desc "Run the generator manually"

long_desc \
  "Run the generator manually",
  "",
  "This tool can be used to do ad hoc generator runs for testing purposes. " \
    "You much provide the input proto files (as individual files or " \
    "directories). Those inputs must be within the googleapis directory " \
    "structure. (You can use the googleapis submodule or provide your own " \
    "clone of googleapis.) The tool also requires a BUILD.bazel file; you " \
    "can provide the path to it directly or have the tool search for one " \
    "colocated with the input protos. The tool will then generate the gem " \
    "output files in the current directory or a configured output directory.",
  "",
  "Note that the tool reads some settings from the BUILD.bazel file, but " \
    "cannot determine the protos to compile from the bazel settings, so you " \
    "must explicitly include all such proto paths on the command line.",
  "",
  "Example:",
  ["  toys run google/cloud/secretmanager/v1 --output=tmp"]

include :bundler
include :exec, e: true
include :fileutils

remaining_args :inputs do
  desc "Paths to input protos or directories that will be searched for protos"
end
flag :bazel_file, "--bazel-file=PATH" do
  desc "Path to the bazel file."
  long_desc \
    "Path to the bazel file. If omitted, uses the first BUILD.bazel file " \
      "found either at the top level of an input directory or as a sibling " \
      "of an input proto file."
end
flag :proto_dir, "--proto-dir=PATH" do
  desc "Path to the protos dir. Defaults to shared/googleapis in this repo."
end
flag :output_dir, "--output-dir=PATH" do
  desc "Path to the directory to write output files. Defaults to the current directory."
end

def run
  setup
  load_bazel_params
  cmd = [
    "grpc_tools_ruby_protoc",
    "--ruby_out", output_dir,
    "--grpc_out", output_dir,
    "--ruby_cloud_out", output_dir,
    "--proto_path", proto_dir,
    "--ruby_cloud_opt", @protoc_params.join(","),
  ] + inputs
  exec cmd
end

def setup
  set :proto_dir, File.join(context_directory, "shared", "googleapis") unless proto_dir
  set :output_dir, File.expand_path(output_dir, Dir.getwd)
  mkdir_p output_dir
  search_inputs
  unless bazel_file
    puts "Did not find BUILD.bazel"
    exit 1
  end
  if inputs.empty?
    puts "Did not find any input proto files"
    exit 1
  end
end

def search_inputs
  found_inputs = []
  found_bazel_file = nil
  inputs.each do |input|
    input = File.expand_path(input, proto_dir)
    if File.directory? input
      found_inputs += Dir.glob("#{input}/**/*.proto")
    elsif File.file? input
      found_inputs << input
      input = File.dirname input
    end
    next if found_bazel_file
    file = File.join input, "BUILD.bazel"
    found_bazel_file = file if File.file? file
  end
  set :inputs, found_inputs
  set :bazel_file, found_bazel_file
end

def load_bazel_params
  content = File.read bazel_file
  unless /ruby_cloud_gapic_library\(\n((?: .*\n)+)\)\n/ =~ content
    logger.error "Unable to find ruby_cloud_gapic_library in #{bazel_file}"
    exit 1
  end
  content = Regexp.last_match[1]
  unless /extra_protoc_parameters = \[([^\]]+)\],/m =~ content
    logger.error "Unable to find ruby extra_protoc_parameters in #{bazel_file}"
    exit 1
  end
  @protoc_params = Regexp.last_match[1].scan(/"([^"]+)"/)
  interpret_bazel_field(content, "grpc_service_config") { |str| interpret_path str }
  interpret_bazel_field(content, "service_yaml") { |str| interpret_path str }
  interpret_bazel_field content, "ruby_cloud_description"
  interpret_bazel_field content, "ruby_cloud_title"
  interpret_bazel_field(content, "transport", "transports") { |str| str.split("+").join ";" }
end

def interpret_bazel_field content, name, flag = nil
  if /#{name}\s*=\s*"([^"]+)"/ =~ content
    str = Regexp.last_match[1]
    str = yield str if block_given?
    str = str.gsub(",", "\\,").gsub("=", "\\=")
    flag ||= name.tr "_", "-"
    @protoc_params.append("#{flag}=#{str}")
  end
end

def interpret_path str
  if str.start_with? "//"
    File.join proto_dir, str.sub(%r{^//}, "").tr(":", "/")
  else
    File.join File.dirname(bazel_file), str.sub(/^:/, "")
  end
end
