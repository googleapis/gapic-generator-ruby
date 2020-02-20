# frozen_string_literal: true

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

require "gapic/generators/default_generator"

module Gapic
  module Generators
    # The generator orchestrates the rendering of templates for Google Cloud
    # projects.
    class CloudGenerator < DefaultGenerator
      # Initializes the generator.
      #
      # @param api [Gapic::Schema::Api] The API model/context to
      #   generate.
      def initialize api
        gem_config = api.configuration[:gem] ||= {}
        gem_config[:homepage] ||= "https://github.com/googleapis/google-cloud-ruby"

        super

        # Configure to use prefer Google Cloud templates
        use_templates! File.join __dir__, "../../../templates/cloud"
      end

      # Generates all the files for the API.
      #
      # @return [Array<
      #   Google::Protobuf::Compiler::CodeGeneratorResponse::File>]
      #   The files that were generated for the API.
      def generate
        orig_files = super

        cloud_files = []

        gem = gem_presenter @api

        # Additional Gem level files
        cloud_files << g("gem/repo-metadata.erb",  ".repo-metadata.json", gem: gem)
        cloud_files << g("gem/authentication.erb", "AUTHENTICATION.md",   gem: gem) unless gem.services.empty?
        cloud_files << g("gem/dashed.erb",         "lib/#{gem.name}.rb",  gem: gem)

        format_files cloud_files

        orig_files + cloud_files
      end

      private

      ##
      # Override the default rubocop config file to be used.
      def format_config
        @api.configuration[:format_config] ||
          google_style_config
      end

      ##
      # Path to the rubocop file for this project, which uses google-style
      def google_style_config
        File.expand_path File.join __dir__, "../../../cloud-rubocop.yml"
      end
    end
  end
end
