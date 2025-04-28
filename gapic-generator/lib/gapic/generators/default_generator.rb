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
require "gapic/package_snippets"

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

        if @api.generate_rest_clients? && gem.packages.find(&:generate_rest_clients?).nil?
          raise "Rest transport specified but no services have HTTP bindings"
        end

        gem.packages.each do |package|
          package_snippets = PackageSnippets.new snippet_dir: "snippets",
                                                 proto_package: package.name,
                                                 gem_name: gem.name

          # Package level files
          files << g("package", "lib/#{package.package_file_path}", package: package)
          files << g("package_rest", "lib/#{package.package_rest_file_path}", package: package) if package.generate_rest_clients?
          files << g("binding_override", "lib/#{package.mixin_binding_overrides_file_path}", package: package) if package.mixin_binding_overrides? && package.generate_rest_clients?

          package.services.each do |service|
            should_generate_grpc = service.generate_grpc_clients?
            should_generate_rest = service.generate_rest_clients?

            # Service level files
            files << g("service",                        "lib/#{service.service_file_path}",                 service: service)
            files << g("service/credentials",            "lib/#{service.credentials_file_path}",             service: service) unless gem.generic_endpoint?
            files << g("service/paths",                  "lib/#{service.paths_file_path}",                   service: service) if service.paths?

            # Rest module file
            files << g("service/rest",                   "lib/#{service.rest.service_rest_file_path}",       service: service) if should_generate_rest

            # client.rb
            files << g("service/client",                 "lib/#{service.client_file_path}",                  service: service) if should_generate_grpc
            files << g("service/rest/client",            "lib/#{service.rest.client_file_path}",             service: service) if should_generate_rest

            # Standard LRO shim
            files << g("service/operations",             "lib/#{service.operations_file_path}",              service: service) if service.lro? && should_generate_grpc
            files << g("service/rest/operations",        "lib/#{service.rest.operations_file_path}",         service: service) if service.rest.lro? && should_generate_rest

            # Nonstandard LRO shim
            files << g("service/nonstandard_lro",        "lib/#{service.nonstandard_lro_file_path}",         service: service) if service.nonstandard_lro_provider? && should_generate_grpc
            files << g("service/rest/nonstandard_lro",   "lib/#{service.rest.nonstandard_lro_file_path}",    service: service) if service.rest.nonstandard_lro_provider? && should_generate_rest
            
            # Rest-only `service.stub` file
            files << g("service/rest/service_stub",      "lib/#{service.rest.service_stub_file_path}",       service: service) if should_generate_rest

            # Unit tests for `client.rb`
            files << g("service/test/client",            "test/#{service.test_client_file_path}",            service: service) if should_generate_grpc
            files << g("service/rest/test/client",       "test/#{service.rest.test_client_file_path}",       service: service) if should_generate_rest

            # Unit tests for `paths.rb`
            files << g("service/test/client_paths",      "test/#{service.test_paths_file_path}",             service: service) if service.paths? && should_generate_grpc

            # Unit tests for standard LRO shim
            files << g("service/test/client_operations", "test/#{service.test_client_operations_file_path}", service: service) if service.lro? && should_generate_grpc

            if @api.generate_standalone_snippets?
              service.methods.each do |method|
                method.all_snippets.each do |snippet|
                  snippet_file = g("snippets/standalone", "snippets/#{snippet.snippet_file_path}", snippet: snippet)
                  package_snippets.add(method_presenter: method, snippet_presenter: snippet, snippet_file: snippet_file)
                end
              end
            end
          end

          files += package_snippets.files if @api.generate_standalone_snippets?
        end

        # Gem level files
        files << g("gem/gitignore",           ".gitignore",                   gem: gem)
        files << g("gem/version",             "lib/#{gem.version_file_path}", gem: gem)
        files << g("gem/test_helper",         "test/helper.rb",               gem: gem)
        files << g("gem/gemspec",             "#{gem.name}.gemspec",          gem: gem)
        files << g("gem/gemfile",             "Gemfile",                      gem: gem)
        files << g("gem/rakefile",            "Rakefile",                     gem: gem)
        files << g("gem/readme",              "README.md",                    gem: gem)
        files << g("gem/changelog",           "CHANGELOG.md",                 gem: gem)
        files << g("gem/rubocop",             ".rubocop.yml",                 gem: gem)
        files << g("gem/toys",                ".toys.rb",                     gem: gem)
        files << g("gem/yardopts",            ".yardopts",                    gem: gem)
        files << g("gem/license",             "LICENSE.md",                   gem: gem)
        files << g("gem/entrypoint",          "lib/#{gem.name}.rb",           gem: gem)
        files << g("gem/gapic_metadata_json", "gapic_metadata.json",          gem: gem) if @api.generate_metadata

        files << g("snippets/gemfile",        "snippets/Gemfile",             gem: gem) if @api.generate_standalone_snippets?

        gem.proto_files.each do |proto_file|
          files << g("proto_docs/proto_file", "proto_docs/#{proto_file.docs_file_path}", file: proto_file)
        end
        files << g("proto_docs/readme",       "proto_docs/README.md", gem: gem)

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
