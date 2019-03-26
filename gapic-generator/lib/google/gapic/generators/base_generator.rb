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

require "action_controller"
require "google/protobuf/compiler/plugin.pb"
require "tempfile"

module Google
  module Gapic
    module Generators
      # The generator orchestrates the rendering of templates.
      class BaseGenerator
        # Initializes the generator.
        #
        # @param api [Google::Gapic::Schema::Api] The API model/context to
        #   generate.
        def initialize api
          @api = api
        end

        # Generates all the files for the API.
        #
        # @return [Array<
        #   Google::Protobuf::Compiler::CodeGeneratorResponse::File>]
        #   The files that were generated for the API.
        def generate
          raise "must implement"
        end

        private

        def use_templates! template_path
          template_path = File.expand_path template_path
          helpers_path = File.join template_path, "helpers"

          # Configure Dependencies to know how to load helpers
          ActiveSupport::Dependencies.autoload_paths.prepend helpers_path

          # Configure the controller to know about the templates and helpers
          controller.prepend_view_path template_path
          controller.class.helper \
            controller.class.all_helpers_from_path helpers_path
        end

        def use_helpers! *helper_methods
          helper_methods.each do |helper_method|
            define_singleton_method helper_method do |*args|
              controller.class.helpers.method(helper_method).call(*args)
            end
          end
        end

        def controller
          # Each controller gets a new class, so multiple generators can be
          # active at the same time without stomping on each other.
          @controller ||= Class.new(ActionController::Base).new
        end

        def generate_file template, filename, format: true, **args
          content = controller.render_to_string(
            template: template, formats: :text, locals: args
          )
          file = Google::Protobuf::Compiler::CodeGeneratorResponse::File.new(
            name: filename, content: content
          )
          format_file! file if format
          file
        end
        alias_method :g, :generate_file

        def format_file! file
          require "tmpdir"
          require "fileutils"
          Dir.mktmpdir do |dir|
            tmp_file = File.join dir, file.name
            FileUtils.mkdir_p File.dirname tmp_file
            File.write tmp_file, file.content
            system "rubocop --auto-correct #{tmp_file} -o #{tmp_file}.out " \
                   " -c #{format_config}"
            file.content = File.read tmp_file
          end
        end

        def format_config
          File.expand_path File.join __dir__, "../../../../.rubocop.yml"
        end
      end
    end
  end
end
