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
require "gapic/generators/cloud_generator_parameters"
require "gapic/presenters"
require "gapic/presenters/cloud_gem_presenter"
require "gapic/presenters/wrapper_gem_presenter"

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
      def generate gem_presenter: nil
        gem_config = @api.configuration[:gem] ||= {}
        return generate_wrapper if gem_config[:version_dependencies]

        gem = gem_presenter || Gapic::Presenters.cloud_gem_presenter(@api)
        orig_files = super gem_presenter: gem

        # Additional Gem level files
        cloud_files = []
        cloud_files << g("gem/repo-metadata.erb", ".repo-metadata.json", gem: gem)
        cloud_files << g("gem/yardopts-cloudrad.erb", ".yardopts-cloudrad", gem: gem)
        unless gem.services.empty? || gem.generic_endpoint?
          cloud_files << g("gem/authentication.erb", "AUTHENTICATION.md", gem: gem)
        end

        format_files cloud_files

        orig_files + cloud_files
      end

      # Disable Rubocop because we expect generate to grow and violate more
      # and more style rules.
      # rubocop:disable all

      # Generates the files for a wrapper.
      #
      # @return [Array<Google::Protobuf::Compiler::CodeGeneratorResponse::File>]
      #   The files that were generated for the API.
      #
      def generate_wrapper
        files = []

        gem = Gapic::Presenters.wrapper_gem_presenter @api

        files << g("gem/gitignore.erb",                 ".gitignore",                                    gem: gem)
        files << g("gem/repo-metadata.erb",             ".repo-metadata.json",                           gem: gem)
        files << g("wrapper_gem/rubocop.erb",           ".rubocop.yml",                                  gem: gem)
        files << g("wrapper_gem/yardopts.erb",          ".yardopts",                                     gem: gem)
        files << g("wrapper_gem/yardopts-cloudrad.erb", ".yardopts-cloudrad",                            gem: gem)
        files << g("gem/authentication.erb",            "AUTHENTICATION.md",                             gem: gem) unless gem.generic_endpoint?
        files << g("gem/changelog.erb",                 "CHANGELOG.md",                                  gem: gem)
        files << g("wrapper_gem/gemfile.erb",           "Gemfile",                                       gem: gem)
        files << g("gem/license.erb",                   "LICENSE.md",                                    gem: gem)
        files << g("wrapper_gem/rakefile.erb",          "Rakefile",                                      gem: gem)
        files << g("wrapper_gem/readme.erb",            "README.md",                                     gem: gem)
        files << g("wrapper_gem/gemspec.erb",           "#{gem.name}.gemspec",                           gem: gem)
        files << g("wrapper_gem/entrypoint.erb",        "lib/#{gem.name}.rb",                            gem: gem) if gem.needs_entrypoint?
        files << g("wrapper_gem/main.erb",              "lib/#{gem.namespace_file_path}",                gem: gem)
        files << g("gem/version.erb",                   "lib/#{gem.version_file_path}",                  gem: gem)
        files << g("gem/test_helper.erb",               "test/helper.rb",                                gem: gem)
        files << g("wrapper_gem/client_test.erb",       "test/#{gem.namespace_require}/client_test.rb",  gem: gem)
        files << g("wrapper_gem/version_test.erb",      "test/#{gem.namespace_require}/version_test.rb", gem: gem)

        format_files files

        files
      end

      # rubocop:enable all

      # Schema of the parameters that the generator accepts
      # @return [Gapic::Schema::ParameterSchema]
      def self.parameter_schema
        CloudGeneratorParameters.default_schema
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
