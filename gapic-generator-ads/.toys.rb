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

expand :rubocop, bundler: true

expand :minitest do |t|
  t.libs = ["lib", "test"]
  t.files = ["test/**/*_test.rb"]
  t.bundler = true
end

expand :yardoc do |t|
  t.generate_output_flag = true
  t.fail_on_warning = true
  t.fail_on_undocumented_objects = false # TODO: Fix so this can be enabled
  t.bundler = true
end

tool "yard", delegate_to: "yardoc"

expand :gem_build

tool "gen" do
  desc "Regenerates output for goldens"

  remaining_args :services

  include :exec, e: true
  include :terminal
  load File.expand_path "../shared/gem_defaults.rb", context_directory

  def run
    set :services, all_service_names(generator: :ads) if services.empty?
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
    set :services, all_service_names(generator: :ads) if services.empty?
    Dir.chdir "#{context_directory}/shared" do
      exec_separate_tool ["bin"] + services + verbosity_flags
    end
  end
end

tool "irb" do
  desc "Open an IRB console with the gem loaded"

  include :bundler

  def run
    require "irb"
    require "irb/completion"

    ARGV.clear
    IRB.start
  end
end
