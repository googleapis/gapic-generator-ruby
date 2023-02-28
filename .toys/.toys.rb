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
  def in_directories_with_bundles
    Dir.chdir context_directory do
      Dir.glob "*/Gemfile" do |gemfile|
        dir = File.dirname gemfile
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

      include :exec, e: true
      include :terminal
      include "repo_info"
      static :task_name, task_name

      def run
        in_directories_with_bundles do |dirname|
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

    include :exec, e: true
    include :terminal
    include "repo_info"
    static :task_name, task_name

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

  include :exec
  include :terminal
  include "repo_info"

  def run
    failures = []
    in_directories_with_bundles do |dirname|
      ["test", "rubocop"].each do |task_name|
        if tool_defined? task_name
          puts "Running #{task_name} in #{dirname}", :cyan, :bold
          result = exec_separate_tool [task_name]
          unless result.success?
            failures << "#{dirname}: #{task_name}"
            puts "FAILED: #{dirname} #{task_name}", :red, :bold
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
  desc "Runs the generator for all goldens"

  include :exec, e: true
  include :terminal
  include "repo_info"

  def run
    in_directories_with_bundles do |dirname|
      next if dirname == "shared"
      puts "Generating in #{dirname}", :cyan, :bold
      exec ["bundle", "exec", "rake", "gen"]
    end
  end

  ["garbage", "showcase"].each do |name|
    tool name do
      desc "Runs the generator for #{name}"

      include :exec, e: true
      static :name, name
  
      def run
        Dir.chdir "#{context_directory}/gapic-generator" do
          exec ["bundle", "exec", "rake", "gen:#{name}"]
        end
      end
    end
  end
end

tool "bin" do
  desc "Generates binary input for all goldens"

  include :exec, e: true

  def run
    Dir.chdir "#{context_directory}/shared" do
      exec ["bundle", "exec", "rake", "gen"]
    end
  end

  ["garbage", "showcase"].each do |name|
    tool name do
      desc "Generates binary input for #{name}"

      include :exec, e: true
      static :name, name
  
      def run
        Dir.chdir "#{context_directory}/shared" do
          exec ["bundle", "exec", "rake", "gen:#{name}"]
        end
      end
    end
  end
end
