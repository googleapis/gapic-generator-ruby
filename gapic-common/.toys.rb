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
alias_tool :yard, :yardoc

expand :gem_build

expand :gem_build, name: "install", install_gem: true

tool "ci" do
  include :exec, e: true
  include :terminal

  def run
    puts "Running rubocop...", :bold
    exec_tool ["rubocop"] + verbosity_flags
    puts "Running tests...", :bold
    exec_tool ["test"] + verbosity_flags
    puts "Running yard...", :bold
    exec_tool ["yardoc"] + verbosity_flags
  end
end

tool "irb" do
  include :bundler

  def run
    require "irb"
    require "irb/completion"

    ARGV.clear
    IRB.start
  end
end

tool "fixtures" do
  include :exec, e: true
  include :bundler

  def run
    Dir.chdir context_directory
    cmd = [
      "grpc_tools_ruby_protoc",
      "--ruby_out=test/fixtures",
      "-I", "test/fixtures"
    ]
    cmd += Dir.glob "*.proto", base: "test/fixtures"
    exec cmd
  end
end
