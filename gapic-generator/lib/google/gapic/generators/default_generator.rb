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

require "google/gapic/generators/base_generator"

module Google
  module Gapic
    module Generators
      # The generator orchestrates the rendering of templates.
      class DefaultGenerator < BaseGenerator
        # Initializes the generator.
        #
        # @param api [Google::Gapic::Schema::Api] The API model/context to
        #   generate.
        def initialize api
          super

          # Configure to use the default templates
          use_templates! File.join __dir__, "../../../../templates/default"

          # Configure to use a custom template directory
          custom_templates = ENV["GOOGLE_GAPIC_GENERATOR_RUBY_TEMPLATES"]
          use_templates! custom_templates if custom_templates

          # Configure these helper method to be used by the generator
          use_helpers! :ruby_file_path, :api_services
        end

        # Generates all the files for the API.
        #
        # @return [Array<
        #   Google::Protobuf::Compiler::CodeGeneratorResponse::File>]
        #   The files that were generated for the API.
        def generate
          files = []

          api_services(@api).each do |service|
            files << cop(gen("client.erb", ruby_file_path(service),
                             api: @api, service: service))
          end

          files
        end

        private

        def cop file
          Tempfile.open ["input", ".rb"] do |input|
            Tempfile.open ["output", ".rb"] do |output|
              input.write file.content

              # Autocorrect file with rubocop.
              # TODO(landrito) make this call system agnostic.
              system "rubocop --auto-correct #{input.path} -o #{output.path}" \
                " -c ./.rubocop.yml"

              # Read the corrected file.
              input.rewind
              file.content = input.read
            end
          end
          file
        end
      end
    end
  end
end
