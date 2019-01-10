# frozen_string_literal: true

# Copyright [yyyy] [name of copyright owner]
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


require "google/gapic/generators/default_generator"

module Google
  module Gapic
    module Generators
      # The generator orchestrates the rendering of templates for
      # MyPlugin projects.
      class MyPluginGenerator < DefaultGenerator
        # Initializes the generator.
        #
        # @param api [Google::Gapic::Schema::Api] The API model/context to
        #   generate.
        def initialize api
          super

          # Configure to use prefer MyPlugin templates
          template_path = File.join __dir__,
                                    "../../../../templates/my_plugin"
          use_templates! template_path

          # Configure these helper method to be used by the generator
          # use_helpers! :helper_method1, :helper_method2, :helper_method3
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
      end
    end
  end
end
