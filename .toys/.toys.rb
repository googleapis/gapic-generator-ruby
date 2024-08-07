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

mixin "repo_info" do
  ##
  # Helper method that iterates over directories with bundles, i.e. all gems
  # plus the shared directory. For each directory, it runs the given block,
  # with the current directory set to that directory, and also passing the
  # directory name to the block.
  #
  def in_directories_with_bundles generator_only: false, include_toys: false
    non_generator_directories = ["gapic-common"]
    Dir.chdir context_directory do
      gemfiles = Dir.glob "*/Gemfile"
      gemfiles += Dir.glob ".toys/**/Gemfile" if include_toys && !generator_only
      gemfiles.each do |gemfile|
        dir = File.dirname gemfile
        next if dir == "tmp"
        next if generator_only && non_generator_directories.include?(dir)
        Dir.chdir dir do
          yield dir
        end
      end
    end
  end

  ##
  # Helper method that determines if a given named tool is defined in the
  # current directory.
  #
  def tool_defined? name
    result = exec_separate_tool ["system", "tools", "show", "--local", name], e: false, out: :null
    result.success?
  end
end

expand :clean, paths: :gitignore

tool "bundle" do
  ["install", "update"].each do |task_name|
    tool task_name do
      desc "Runs bundle #{task_name} in all directories"

      static :task_name, task_name

      include :exec, e: true
      include :terminal
      include "repo_info"

      def run
        in_directories_with_bundles include_toys: true do |dirname|
          puts "Bundle #{task_name} in #{dirname}", :cyan, :bold
          exec ["bundle", task_name, "--retry=3"]
        end
      end
    end
  end
end

["test", "rubocop"].each do |task_name|
  tool task_name do
    desc "Runs #{task_name} in all directories"

    static :task_name, task_name

    include :exec, e: true
    include :terminal
    include "repo_info"

    def run
      in_directories_with_bundles do |dirname|
        if tool_defined? task_name
          puts "Running #{task_name} in #{dirname}", :cyan, :bold
          exec_separate_tool [task_name]
        else
          puts "No #{task_name} task defined in #{dirname}", :yellow
        end
      end
    end
  end
end

tool "ci" do
  desc "Runs CI in all directories"

  flag :generator_only

  include :exec
  include :terminal
  include "repo_info"

  def run
    failures = []
    in_directories_with_bundles generator_only: generator_only do |dirname|
      ["test", "rubocop"].each do |task_name|
        if tool_defined? task_name
          full_task_name = "#{dirname}: #{task_name}"
          puts "Running #{full_task_name}", :cyan, :bold
          result = exec_separate_tool [task_name]
          unless result.success?
            failures << "#{full_task_name}"
            puts "FAILED: #{full_task_name}", :red, :bold
          end
        else
          puts "No #{task_name} task defined in #{dirname}", :yellow
        end
      end
    end
    return if failures.empty?
    puts "FAILURES:", :bold
    failures.each { |failure| puts failure, :bold }
    exit 1
  end
end

tool "gen" do
  desc "Regenerates output for goldens"

  remaining_args :services
  flag :generator, "--generator=GENERATOR"

  include :exec, e: true
  include :terminal

  def run
    Dir.chdir "#{context_directory}/shared" do
      cmd = ["gen"] + services + verbosity_flags
      cmd += ["--generator", generator] if generator
      exec_separate_tool cmd
    end
  end
end

tool "bin" do
  desc "Regenerates binary input for goldens"

  remaining_args :services

  include :exec, e: true
  include :terminal

  def run
    Dir.chdir "#{context_directory}/shared" do
      exec_separate_tool ["bin"] + services + verbosity_flags
    end
  end
end
