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

mixin "golden-tools" do
  on_include do
    require "yaml"
    include :bundler unless include? :bundler
    include :exec, e: true unless include? :exec
    include :fileutils
    include :terminal
  end

  load File.join __dir__, "gem_defaults.rb"

  def run_protoc service, output_dir, extra_opts: nil, generator: nil
    mkdir_p "#{output_dir}/lib"

    protoc_cmd = [
      "grpc_tools_ruby_protoc",
      "--experimental_allow_proto3_optional=1",
      "-I", "../shared/protos",
      "-I", "../shared/api-common-protos",
      "-I", "../shared/googleapis"
    ]

    config = YAML.load_file "config/#{service}.yml"
    unless config[:gem]&.key? :version_dependencies
      protoc_cmd << "--ruby_out=#{output_dir}/lib"
      if !config[:transports] || config[:transports].include?("grpc")
        protoc_cmd << "--grpc_out=#{output_dir}/lib"
      end
    end

    protoc_cmd += [
      "--ruby_#{generator}_out=#{output_dir}",
      "--ruby_#{generator}_opt=configuration=../shared/config/#{service}.yml",
    ]

    # Add optional samples paths
    samples = samples_for service
    protoc_cmd << "--ruby_#{generator}_opt=samples=#{samples.join ';'}" if samples

    # Add optional grpc service config
    grpc_service_config = grpc_service_config_for service
    unless grpc_service_config.empty?
      protoc_cmd << "--ruby_#{generator}_opt=grpc-service-config=#{grpc_service_config.join ';'}"
    end

    # Add optional service.yaml
    service_yaml = service_yaml_for service
    if service_yaml
      protoc_cmd << "--ruby_#{generator}_opt=service-yaml=#{service_yaml}"
    end

    # Add snippet configs if present
    snippet_configs_path = "../shared/snippet_config/#{service}"
    if File.directory? snippet_configs_path
      protoc_cmd << "--ruby_#{generator}_opt=snippet-configs-path=#{snippet_configs_path}"
    end

    # Add any extra opts
    Array(extra_opts).each do |opt|
      protoc_cmd << "--ruby_#{generator}_opt=#{opt}"
    end

    # Add the proto files
    protoc_cmd += protos_for(service)

    exec protoc_cmd
  end

  def output_dir_for service, generator: nil
    generator ||= generator_for service
    target_dir =
      case generator
      when :cloud
        "output/cloud"
      when :ads
        "output/ads"
      when :gem_builder
        "output/gapic/gems"
      else
        "output/gapic/templates"
      end
    File.expand_path "#{target_dir}/#{service}"
  end
end

tool "gen" do
  desc "Regenerates output for goldens"

  remaining_args :services, accept: proc(&:to_sym)
  flag :generator, "--generator=GENERATOR", accept: proc(&:to_sym)

  include "golden-tools"

  def run
    cd context_directory
    set :services, all_service_names if services.empty?
    services.each do |service|
      puts "Generating output for #{service}", :bold
      service_generator = generator || generator_for(service)
      output_dir = output_dir_for service, generator: service_generator
      rm_rf output_dir
      mkdir_p output_dir
      if service_generator == :gem_builder
        run_gem_builder service, output_dir
      else
        run_protoc service, output_dir, generator: service_generator
      end
    end
  end

  def run_gem_builder service, output_dir
    require "gapic/gem_builder"
    builder = Gapic::GemBuilder.new service, output_dir
    builder.bootstrap
  end
end

tool "bin" do
  desc "Regenerates binary input for goldens"

  remaining_args :services, accept: proc(&:to_sym)

  include "golden-tools"

  def run
    require "tmpdir"
    Dir.chdir context_directory
    set :services, all_service_names(omit_generator: :gem_builder) if services.empty?
    services.each do |service|
      Dir.mktmpdir do |tmp|
        puts "Generating binary input for #{service}", :bold
        run_protoc service, tmp, extra_opts: "binary_output=input/#{service}_desc.bin"
      end
    end
  end
end

tool "test" do
  expand :minitest do |t|
    t.name = "showcase"
    t.libs = ["test"]
    t.files = ["test/**/*_test.rb"]
    t.bundler = true
  end

  tool "output" do
    desc "Runs tests on golden outputs"

    remaining_args :services, accept: proc(&:to_sym)
    static :test_output_exceptions, [:noservice, :googleads, :my_plugin]

    include "golden-tools"

    def run
      Dir.chdir context_directory
      set :services, all_service_names if services.empty?
      services.each do |service|
        next if test_output_exceptions.include? service
        # TEMP: Wrappers currently fail to bundle install because the Gemfiles
        # reference the gapic client directories by name.
        next if service.to_s.end_with? "_wrapper"
        puts "Running output test for #{service}", :bold
        Dir.chdir(output_dir_for service) do
          Bundler.with_unbundled_env do
            exec ["bundle", "install"]
            exec ["bundle", "exec", "rake", "rubocop"]
            exec ["bundle", "exec", "rake", "yard"]
            exec ["bundle", "exec", "rake", "test"]
          end
        end
      end
    end
  end

  include :exec, e: true

  def run
    exec_tool ["test", "showcase"] + verbosity_flags
    exec_tool ["test", "output"] + verbosity_flags
  end
end

tool "irb" do
  desc "Open an IRB console"

  include :bundler

  class GapicMain
    def schema service
      bin_proto = File.binread "input/#{service}_desc.bin"
      request = Google::Protobuf::Compiler::CodeGeneratorRequest.decode bin_proto
      Gapic::Schema::Api.new request
    end

    def to_s
      "gapic"
    end
  end

  def run
    require "irb"
    require "irb/completion"
    require "gapic/schema"
    require "gapic/model"

    Dir.chdir context_directory
    ARGV.clear
    IRB.setup nil
    irb = IRB::Irb.new IRB::WorkSpace.new GapicMain.new
    irb.run
  end
end
