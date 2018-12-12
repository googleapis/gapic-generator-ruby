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

require 'erubis'
require 'google/gapic/generator/util'
require 'protobuf/descriptors'

module Google
  module Gapic
    module Generator
      # The generator orchestrates the rendering of templates giving the
      # templates context for generation. Explicitly this means that every
      # template will be given two objects: a Google::Gapic::Schema::Api object
      # accessible through @api, and a Google::Gapic::Generator::Util object
      # accessible through @util.
      class Generator
        # Initializes the generator.
        #
        # @param api [Google::Gapic::Schema::Api] the API to generate.
        # @param template_provider [Google::Gapic::TemplateProvider] provides
        #   the templates to render.
        def initialize api, template_provider
          @api = api
          @template_provider = template_provider
          @util = Util.new(template_provider)
        end

        # Renders the template files giving them the context of the API.
        #
        # @return [Array<Google::Protobuf::Compiler::CodeGeneratorResponse::File>]
        #   The files that were generated for the API.
        def generate
          # TODO(landrito) add some exception handling to give more information
          # about which template failed.
          @template_provider.templates
            .map { |template| Erubis::Eruby.new(template) }
            .map { |template| template.evaluate(api: @api, util: @util) }
            .map { |rendered| @util.split_files(rendered) }
            .flat_map do |hsh|
              hsh.each.map do |name, content|
                Google::Protobuf::Compiler::CodeGeneratorResponse::File.new(
                  name: name,
                  content: content)
              end
            end
        end
      end
    end
  end
end
