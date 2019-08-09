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

desc "Builds all gems."
task :build do
  gem_dirs.each do |gem|
    Dir.chdir gem do
      Bundler.with_original_env do
        puts "Running build for #{gem}"
        sh "bundle exec rake build"
      end
    end
  end
end

desc "Installs all gems."
task :install do
  gem_dirs.each do |gem|
    Dir.chdir gem do
      Bundler.with_original_env do
        puts "Running install for #{gem}"
        sh "bundle exec rake install"
      end
    end
  end
end

desc "Runs tests for all gems."
task :test do
  Dir.chdir "shared" do
    Bundler.with_clean_env do
      puts "Running shared tests"
      sh "bundle exec rake test"
    end
  end

  gem_dirs.each do |gem|
    Dir.chdir gem do
      Bundler.with_original_env do
        puts "Running tests for #{gem}"
        sh "bundle exec rake test"
      end
    end
  end
end

desc "Runs file generation for binary input files and all gems."
task :gen do
  Dir.chdir "shared" do
    Bundler.with_original_env do
      puts "Running binary input file generation"
      sh "bundle exec rake gen"
    end
  end

  gem_dirs.each do |gem|
    Dir.chdir gem do
      Bundler.with_original_env do
        puts "Running file generation for #{gem}"
        sh "bundle exec rake gen"
      end
    end
  end
end

desc "Runs rubocop for all gems."
task :rubocop do
  gem_dirs.each do |gem|
    Dir.chdir gem do
      Bundler.with_original_env do
        puts "Running rubocop for #{gem}"
        sh "bundle exec rake rubocop"
      end
    end
  end
end

desc "Runs CI for all gems."
task :ci do
  Dir.chdir "shared" do
    Bundler.with_clean_env do
      puts "Running CI for shared"
      sh "bundle exec rake ci"
    end
  end

  gem_dirs.each do |gem|
    Dir.chdir gem do
      Bundler.with_original_env do
        puts "Running CI for #{gem}"
        sh "bundle exec rake ci"
      end
    end
  end
end

desc "Runs bundle update for all gems."
task :update do
  Dir.chdir "shared" do
    Bundler.with_original_env do
      puts "Running bundle update for shared"
      sh "bundle update"
    end
  end

  gem_dirs.each do |gem|
    Dir.chdir gem do
      Bundler.with_original_env do
        puts "Running bundle update for #{gem}"
        sh "bundle update"
      end
    end
  end
end

def gem_dirs
  `git ls-files -- */*.gemspec`.split("\n").map { |gem| gem.split("/").first }.sort
end

task default: :ci
