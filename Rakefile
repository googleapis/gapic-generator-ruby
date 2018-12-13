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

require "bundler/gem_tasks"
require "rubocop/rake_task"
require "rake/testtask"

RuboCop::RakeTask.new # Configuration is in .rubocop.yml
Rake::TestTask.new :test do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end


desc "Run the CI build"
task :ci do
  puts "\nBUILDING gapic-generator-ruby\n"
  puts "\ngapic-generator-ruby rubocop\n"
  Rake::Task[:rubocop].invoke
  puts "\ngapic-generator-ruby test\n"
  Rake::Task[:test].invoke
end

task default: :ci
