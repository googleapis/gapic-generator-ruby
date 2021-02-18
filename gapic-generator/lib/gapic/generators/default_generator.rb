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

require "gapic/generators/base_generator"
require "gapic/generators/default_generator_parameters"
require "gapic/presenters"

require "json"

module Gapic
  module Generators
    # The generator orchestrates the rendering of templates.
    class DefaultGenerator < BaseGenerator
      # Initializes the generator.
      #
      # @param api [Gapic::Schema::Api] The API model/context to
      #   generate.
      def initialize api
        super

        # Configure to use a custom templates directory
        use_templates! File.join __dir__, "../../../templates/default"
      end

      # Disable Rubocop because we expect generate to grow and violate more
      # and more style rules.
      # rubocop:disable all

      # Generates all the files for the API.
      #
      # @return [Array<
      #   Google::Protobuf::Compiler::CodeGeneratorResponse::File>]
      #   The files that were generated for the API.
      def generate gem_presenter: nil
        files = []

        gem = gem_presenter || Gapic::Presenters.gem_presenter(@api)

        gem.packages.each do |package|
          # Package level files
          files << g("package.erb", "lib/#{package.package_file_path}", package: package)

          package.services.each do |service|
            # Service level files
            files << g("service.erb",                        "lib/#{service.service_file_path}",                 service: service)
            files << g("service/client.erb",                 "lib/#{service.client_file_path}",                  service: service)
            files << g("service/credentials.erb",            "lib/#{service.credentials_file_path}",             service: service) unless gem.generic_endpoint?
            files << g("service/paths.erb",                  "lib/#{service.paths_file_path}",                   service: service) if service.paths?
            files << g("service/operations.erb",             "lib/#{service.operations_file_path}",              service: service) if service.lro?
            files << g("service/test/client.erb",            "test/#{service.test_client_file_path}",            service: service)
            files << g("service/test/client_paths.erb",      "test/#{service.test_paths_file_path}",             service: service) if service.paths?
            files << g("service/test/client_operations.erb", "test/#{service.test_client_operations_file_path}", service: service) if service.lro?
          end
        end

        # Gem level files
        files << g("gem/gitignore.erb",   ".gitignore",                   gem: gem)
        files << g("gem/version.erb",     "lib/#{gem.version_file_path}", gem: gem)
        files << g("gem/test_helper.erb", "test/helper.rb",               gem: gem)
        files << g("gem/gemspec.erb",     "#{gem.name}.gemspec",          gem: gem)
        files << g("gem/gemfile.erb",     "Gemfile",                      gem: gem)
        files << g("gem/rakefile.erb",    "Rakefile",                     gem: gem)
        files << g("gem/readme.erb",      "README.md",                    gem: gem)
        files << g("gem/changelog.erb",   "CHANGELOG.md",                 gem: gem)
        files << g("gem/rubocop.erb",     ".rubocop.yml",                 gem: gem)
        files << g("gem/yardopts.erb",    ".yardopts",                    gem: gem)
        files << g("gem/license.erb",     "LICENSE.md",                   gem: gem)
        files << g("gem/entrypoint.erb",  "lib/#{gem.name}.rb",           gem: gem)
        files << generate_nontemplate_file(
          filename: "gapic_metadata.json",
          content: JSON::pretty_generate(gem.first_package_drift_manifest)
        )

        gem.proto_files.each do |proto_file|
          files << g("proto_docs/proto_file.erb", "proto_docs/#{proto_file.docs_file_path}", file: proto_file)
        end
        files << g("proto_docs/readme.erb", "proto_docs/README.md", gem: gem)

        format_files files

        files
      end

      # rubocop:enable all

      # Schema of the parameters that the generator accepts
      # @return [Gapic::Schema::ParameterSchema]
      def self.parameter_schema
        DefaultGeneratorParameters.default_schema
      end

      private

      ##
      # Override the default rubocop config file to be used.
      def format_config
        @api.configuration[:format_config] ||
          super
      end
    end
  end
end
