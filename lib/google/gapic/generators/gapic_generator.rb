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
      # The generator orchestrates the rendering of templates using the gapic
      # templates.
      class GapicGenerator < BaseGenerator
        # Initializes the generator.
        #
        # @param api [Google::Gapic::Schema::Api] The API model/context to
        #   generate.
        def initialize api
          super

          # Configure to use the gapic templates
          use_templates! "templates/gapic"
        end

        # Renders the template files giving them the context of the API.
        #
        # @return [Array<
        #   Google::Protobuf::Compiler::CodeGeneratorResponse::File>]
        #   The files that were generated for the API.
        def generate
          # fail controller.inspect
          generate_output_files.map do |file_name, content|
            Google::Protobuf::Compiler::CodeGeneratorResponse::File.new(
              name: file_name,
              content: content
            )
          end
        end

        private

        def generate_output_files
          output_files = {}
          templates.each do |template|
            controller.render_to_string(
              template: template,
              formats: :text,
              layout: nil,
              assigns: { api: @api, output_files: output_files }
            )
          end
          output_files
        end

        # Returns the template files found at the given path.
        # This will ignore any template that starts with '_' in their file name
        # because those are understood to be partial templates.
        #
        # @return [Array<String>] The templates.
        def templates
          Dir.new("templates/gapic").each
             .select { |file| file.end_with? ".erb" }
             .reject { |file| File.directory? file }
             .reject { |file| File.split(file).last.start_with? "_" }
             .map { |file| file.chomp ".erb" }
        end
      end
    end
  end
end
