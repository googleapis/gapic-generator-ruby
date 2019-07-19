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

module Gapic
  ##
  # File Formatter
  class FileFormatter
    attr_reader :configuration, :files

    ##
    # Create a new file formatter object
    #
    # @param path_template [String] The URI path template to be parsed.
    def initialize configuration, files
      @configuration = configuration
      @files = format! configuration, files
    end

    protected

    def format! configuration, files
      Dir.mktmpdir do |dir|
        files.each do |file|
          write_file dir, file
        end

        system "rubocop --auto-correct #{dir} -o #{dir}/rubocop.out " \
               "-c #{configuration}"

        files.each do |file|
          read_file dir, file
        end
      end
    end

    def write_file dir, file
      tmp_file = File.join dir, file.name
      FileUtils.mkdir_p File.dirname tmp_file
      File.write tmp_file, file.content
    end

    def read_file dir, file
      tmp_file = File.join dir, file.name
      file.content = File.read tmp_file
    end
  end
end
