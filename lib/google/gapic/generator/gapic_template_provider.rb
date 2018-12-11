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

require 'google/gapic/generator/template_provider'

module Google
  module Gapic
    module Generator
      # Abstract base class exposes a method that provides templates.
      class GapicTemplateProvider < TemplateProvider
        # Initializes the GapicTemplateProvider.
        #
        # @param path [string] The path to search for erb files.
        def initialize path
          @path = path
        end

        # Returns the content of the templates found at the given path.
        # This will ignore any template that starts with '_' in their file name
        # because those are understood to be utility templates.
        #
        # @return [Array<String>] The templates.
        def templates
          Dir.glob(File.join(@path, "**/*.erb"))
            .reject { |file| File.directory? file }
            .reject { |file| File.split(file).last.start_with? '_' }
            .map { |file| File.read(file)  }
        end

        # Returns a Hash<Symbol, String> that maps the symbol to access the
        # template by to the template content.
        #
        # @return [Hash<Symbol, String>] A mapping of the symbol to access the
        # template by to the template content.
        def utility_templates
          Dir.glob(File.join(@path, "**/_*.erb"))
            .reject { |file| File.directory? file }
            .reduce({}) do |memo, file|
              name = File.split(file).last[1..-5]
              memo.merge({name.to_sym => File.read(file)})
            end
        end
      end
    end
  end
end

        # Private.        private :templates
