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
  "This tool runs the generator using the current local generator code. It " \
    "can be invoked either as part of a production codegen pipeline, or for " \
    "ad hoc testing runs.",
  "",
  "You much provide the input proto files (as individual files or " \
    "directories that will be searched for proto files). You should also " \
    "provide proto include paths (which will default to the googleapis " \
    "submodule in this repo.) Finally, you will need to provide a source for " \
    "generator configuration, either a configuration YAML file or a bazel " \
    "build file. The tool will then generate the gem output files in the " \
    "provided output directory.",
  "",
  "Note that the tool reads some settings from the BUILD.bazel file, but " \
    "cannot determine the protos to compile from the bazel settings, so you " \
    "must always explicitly specify proto files on the command line.",
  "",
  "Example:",
  ["  toys run google/cloud/secretmanager/v1 --output=tmp"]

include :bundler
include :exec, e: true
include :fileutils

remaining_args :inputs do
  desc "Paths to input protos or directories that will be searched for protos"
end
flag :generator, "--generator=GENERATOR" do
  desc "Specify which generator to use. Valid values are cloud, ads, and gapic. Default is cloud."
  accept [:cloud, :ads, :gapic]
  default :cloud
end
flag :base_dir, "--base-dir=PATH" do
  desc "The base directory within which other directory paths are resolved. Defaults to the current directory."
end
flag :proto_paths, "--proto-path=PATH", "-IPATH" do
  desc "Provide an include path for protos."
  long_desc \
    "Provide an include path for protos. Relative paths are resolved " \
      "relative to the base-dir. You can add any number of paths. If none " \
      "are provided, shared/googleapis in this repo is used by default."
  handler :push
end
flag :input_dir, "--input-dir=PATH" do
  desc "The directory within which relative input file paths are resolved. Defaults to shared/googleapis."
end
flag :output_dir, "--output-dir=PATH" do
  desc "Path to the directory to write output files. Defaults to the base-dir."
end
flag :clean do
  desc "Clean output directory before generating"
end
at_most_one desc: "Configuration source" do
  long_desc \
    "Specify the configuration source file using at most one of these flags. " \
      "If no flag is provided, the tool will search for a BUILD.bazel either " \
      "at the top level of an input directory or as a sibling of an input " \
      "proto file, and use the first one it finds. If it doesn't find any " \
      "such file, an error is reported."
  flag :bazel_file, "--bazel-file=PATH" do
    desc "Path to the BUILD.bazel file."
  end
  flag :config_file, "--config-file=PATH" do
    desc "Path to the configuration YAML file."
  end
end

def run
  resolve_paths
  search_inputs
  load_configs
  rm_rf output_dir if clean
  output_lib_dir = File.join output_dir, "lib"
  mkdir_p output_lib_dir
  cmd = [
    "grpc_tools_ruby_protoc",
    "--ruby_out", output_lib_dir,
    "--grpc_out", output_lib_dir,
    "--ruby_#{generator}_out", output_dir,
    "--ruby_#{generator}_opt", @protoc_params.join(","),
  ] + proto_paths.map { |path| "--proto_path=#{path}" } + inputs
  exec cmd
end

def resolve_paths
  googleapis_dir = File.join context_directory, "shared", "googleapis"
  set :base_dir, Dir.getwd unless base_dir
  set :input_dir, googleapis_dir unless input_dir
  set :input_dir, File.expand_path(input_dir, base_dir)
  set :proto_paths, [googleapis_dir] unless proto_paths
  set :proto_paths, proto_paths.map { |path| File.expand_path path, base_dir }
  set :proto_paths, (proto_paths + [input_dir]).uniq
  set :output_dir, File.expand_path(output_dir || context_directory, base_dir)
  set :bazel_file, File.expand_path(bazel_file, base_dir) if bazel_file
  set :config_file, File.expand_path(config_file, base_dir) if config_file
  set :inputs, inputs.map { |path| File.expand_path path, input_dir }
end

def search_inputs
  found_inputs = []
  found_bazel_file = nil
  inputs.each do |input|
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
  if found_inputs.empty?
    puts "Did not find any input proto files"
    exit 1
  end
  set :inputs, found_inputs
  set :bazel_file, found_bazel_file unless config_file || bazel_file
end

def load_configs
  if config_file
    @protoc_params = ["configuration=#{config_file}"]
  elsif bazel_file
    load_bazel_params
  else
    puts "Did not find any configuration or bazel file"
    exit 1
  end
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
