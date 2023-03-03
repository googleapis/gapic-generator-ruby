# frozen_string_literal: true

# Copyright 2019 Google LLC
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

require "tmpdir"
require "fileutils"
require "English"

module Gapic
  ##
  # File Formatter
  class FileFormatter
    attr_reader :configuration
    attr_reader :files

    ##
    # Create a new file formatter object
    #
    def initialize configuration, files
      @configuration = configuration
      @files = format! files
    end

    protected

    def format! files
      Dir.mktmpdir do |dir|
        Dir.chdir dir do
          files.each do |file|
            FileUtils.mkdir_p File.dirname file.name
            File.write file.name, file.content
          end

          # Use the current Ruby binary path and invoke the CLI class directly
          # rather than the normal rubocop executable, since the latter uses
          # "/usr/bin/env ruby" which doesn't seem to work in the current bazel
          # environment.
          script = 'require "rubocop"; begin; RuboCop::CLI.new.run; rescue => e; p e; exit 1; end'
          rubocop_cmd = "#{RbConfig.ruby} -e '#{script}' -- --cache false -a -o rubocop.out -c #{configuration}"
          output = `#{rubocop_cmd}`.strip
          unless output.empty?
            warn "**** Rubocop output:"
            warn output
          end
          raise "Rubocop failed" unless $CHILD_STATUS.success?

          files.each do |file|
            file.content = File.read file.name
          end
        end
      end
    end
  end
end
