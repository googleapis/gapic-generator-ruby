# frozen_string_literal: true

# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "gapic/generators/default_generator"
require "gapic/generators/default_generator_parameters"
require "gapic/presenters"

module Gapic
  module Generators
    # The generator orchestrates the rendering of templates for
    # Google Ads projects.
    class AdsGenerator < DefaultGenerator
      # Initializes the generator.
      #
      # @param api [Gapic::Schema::Api] The API model/context to
      #   generate.
      def initialize api
        super

        # if not specified otherwise in configuration, generate path helpers for the output messages in ads
        api.generate_path_helpers_output = true unless api.generate_path_helpers_output_defined?
        # if not specified otherwise in configuration, apply overrides to proto namespaces in ads
        api.override_proto_namespaces = true unless api.override_proto_namespaces_defined?

        # Configure to use prefer Ads templates
        use_templates! File.join __dir__, "../../../templates/ads"
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

        gem = Gapic::Presenters.gem_presenter @api

        gem.packages.each do |package|
          # Package level files
          files << g("package.erb", "lib/#{package.package_file_path}", package: package)
          package.services.each do |service|
            # Service level files
            files << g("service.erb",             "lib/#{service.service_file_path}",      service: service)
            files << g("service/client.erb",      "lib/#{service.client_file_path}",       service: service)
            files << g("service/credentials.erb", "lib/#{service.credentials_file_path}",  service: service)
            files << g("service/paths.erb",       "lib/#{service.paths_file_path}",        service: service) if service.paths?
            files << g("service/operations.erb",  "lib/#{service.operations_file_path}",   service: service) if service.lro?
          end
        end

        # Gem level files
        files << g("gem/version.erb", "lib/#{gem.version_file_path}", gem: gem)

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

      # Hook to override the default formatter
      def format_files files
        super
      end
    end
  end
end
