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

require "protobuf/descriptors"

module Google
  module Gapic
    module Generator
      # The generator orchestrates the rendering of templates giving the
      # templates context for generation. Every
      # template will be given a Google::Gapic::Schema::Api object
      # accessible through `@api`.
      class Generator
        # Initializes the generator.
        #
        # @param api [Google::Gapic::Schema::Api] The API model/context to
        #   generate.
        # @param controller [ActionController::Base] The controller that will
        #   render the templates.
        # @param templates [Array<String>] The relative paths (excluding the
        #   .erb file extension) of templates for the controller to render.
        def initialize api, controller, templates
          @api = api
          @controller = controller
          @templates = templates
        end

        # Renders the template files giving them the context of the API.
        #
        # @return [Array<
        #   Google::Protobuf::Compiler::CodeGeneratorResponse::File>]
        #   The files that were generated for the API.
        def generate
          generate_output_files.map do |file_name, content|
            Google::Protobuf::Compiler::CodeGeneratorResponse::File.new(
              name: file_name,
              content: content
            )
          end
        end

        protected

        def generate_output_files
          output_files = {}
          @templates.each do |template|
            @controller.render_to_string(
              template: template,
              formats: :text,
              layout: nil,
              assigns: { api: @api, output_files: output_files }
            )
          end
          output_files
        end
      end
    end
  end
end
