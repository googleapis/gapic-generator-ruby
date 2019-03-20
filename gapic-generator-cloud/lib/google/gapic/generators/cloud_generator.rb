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
          use_helpers! :gem_name, :gem_path, :client_file_path,
                       :client_test_file_path
        end

        # Generates all the files for the API.
        #
        # @return [Array<
        #   Google::Protobuf::Compiler::CodeGeneratorResponse::File>]
        #   The files that were generated for the API.
        def generate
          files = []

          api_services(@api).each do |service|
            files << cop(gen("client.erb",
                             "lib/#{client_file_path service}",
                             api: @api, service: service))
            files << cop(gen("client_test.erb",
                             "test/#{client_test_file_path service}",
                             api: @api, service: service))
          end

          files << gen("gemspec.erb", "#{gem_name @api}.gemspec",
                       api: @api, service: api_services(@api).first)
          files << gen("gemfile.erb", "Gemfile", api: @api)
          files << gen("rakefile.erb", "Rakefile",
                       api: @api, service: api_services(@api).first)
          files << gen("license.erb", "LICENSE.md", api: @api)

          files
        end
      end
    end
  end
end
