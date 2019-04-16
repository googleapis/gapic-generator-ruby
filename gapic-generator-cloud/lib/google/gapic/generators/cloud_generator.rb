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

require "google/gapic/generators/default_generator"

module Google
  module Gapic
    module Generators
      # The generator orchestrates the rendering of templates for Google Cloud
      # projects.
      class CloudGenerator < DefaultGenerator
        # Initializes the generator.
        #
        # @param api [Google::Gapic::Schema::Api] The API model/context to
        #   generate.
        def initialize api
          super

          # Configure to use prefer Google Cloud templates
          use_templates! File.join __dir__, "../../../../templates/cloud"

          # Configure these helper method to be used by the generator
          use_helpers! :gem_presenter
        end

        # Disable Rubocop because we expect generate to grow and violate more
        # and more style rules.
        # rubocop:disable all

        # Generates all the files for the API.
        #
        # @return [Array<
        #   Google::Protobuf::Compiler::CodeGeneratorResponse::File>]
        #   The files that were generated for the API.
        def generate
          files = []

          gem = gem_presenter @api

          gem.packages.each do |package|
            # Package level files
            files << g("package.erb", "lib/#{package.version_file_path}",
                       package: package)

            package.services.each do |service|
              # Service level files
              files << g("client.erb", "lib/#{service.client_file_path}",
                         service: service)
              files << g("client/class.erb",
                         "lib/#{service.client_class_file_path}",
                         service: service)
              files << g("client/credentials.erb",
                         "lib/#{service.credentials_class_file_path}",
                         service: service)
              files << g("client/paths.erb",
                         "lib/#{service.paths_file_path}",
                         service: service) if service.paths?
              files << g("client_test.erb",
                         "test/#{service.client_test_file_path}",
                         service: service)
            end

            gem.proto_files.each do |file|
              files << g("doc/proto_file.erb",
                         "lib/doc/#{file.docs_file_path}",
                         file: file)
            end
          end

          # Gem level files
          files << g("version.erb", "lib/#{gem.version_file_path}", gem: gem)
          files << g("gemspec.erb",  "#{gem.name}.gemspec",         gem: gem)
          files << g("gemfile.erb",  "Gemfile",                     gem: gem)
          files << g("rakefile.erb", "Rakefile",                    gem: gem)
          files << g("rubocop.erb",  ".rubocop",                    gem: gem)
          files << g("license.erb",  "LICENSE.md",                  gem: gem)

          format_files files

          files
        end

        # rubocop:enable all

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
          File.expand_path File.join __dir__, "../../../../.rubocop.yml"
        end
      end
    end
  end
end
