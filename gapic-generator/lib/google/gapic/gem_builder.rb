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

require "fileutils"
require "action_controller"
require "active_support/inflector"

module Google
  module Gapic
    ##
    # The builder created files for new extension gems.
    class GemBuilder
      ##
      # Initializes the builder.
      #
      # @param name [String] The name of the new extension gem.
      # @param path [String] The directory to write the gem files.
      #
      def initialize name, path
        @name = name
        @path = path
      end

      ##
      # Writes all the files for the gem.
      #
      def bootstrap
        gen "readme.erb",    "README.md"
        gen "gemspec.erb",   "gapic-generator-#{gem_name}.gemspec"
        gen "rakefile.erb",  "Rakefile"
        gen "gemfile.erb",   "Gemfile"
        gen "gitignore.erb", ".gitignore"
        gen "rubocop.erb",   ".rubocop.yml"
        gen "binary.erb",    "bin/protoc-gen-ruby_#{gem_name}"
        gen "generator.erb",
            "lib/google/gapic/generators/#{gem_name}_generator.rb"
        gen "version.erb",
            "lib/google/gapic/generator/#{gem_name}/version.rb"
        gen "test_helper.erb",    "test/test_helper.rb"
        gen "test_generator.erb", "test/generators/#{gem_name}_test.rb"
        cp  "speech_desc.bin",    "proto_input/speech_desc.bin"
      end

      private

      def template_path
        File.join __dir__, "../../../gem_templates"
      end

      def gem_name
        ActiveSupport::Inflector.underscore @name
      end

      def gem_class_prefix
        ActiveSupport::Inflector.classify @name
      end

      def controller
        @controller ||= Class.new(ActionController::Base).new.tap do |c|
          # Configure the controller to know about the templates
          c.prepend_view_path template_path
        end
      end

      def cp from, to
        input_path = File.join template_path, from
        target_path = File.join @path, to
        FileUtils.mkdir_p File.dirname(target_path)
        FileUtils.cp input_path, target_path
      end

      def gen template, filename
        content = controller.render_to_string(
          template: template,
          formats:  :text,
          locals:   { gem_name: gem_name, gem_class_prefix: gem_class_prefix }
        )
        target_path = File.join @path, filename
        FileUtils.mkdir_p File.dirname(target_path)
        File.write target_path, content
      end
    end
  end
end
