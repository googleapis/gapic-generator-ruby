#!/usr/bin/env ruby
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

require 'google/gapic/schema'
require 'google/gapic/generator'
require 'protobuf/descriptors'

module Google
  module Gapic
    module Runner
      class ProtoCompilerRunner
        # Initializes the runner.
        def initialize
          # Ensure that no encoding conversions are done on STDIN and STDOUT since
          # we are passing binary data back and forth. Otherwise these streams
          # will be mangled on Windows.
          STDIN.binmode
          STDOUT.binmode
        end

        # Run protoc generation.
        def run
          # Create an API Schema from the FileDescriptorProtos
          api = Google::Gapic::Schema::Api.new(request.proto_file, request.file_to_generate)

          # Create a generator from the API.
          generator = Google::Gapic::Generator::Generator.new(api, template_provider)

          # Generate and format the files.
          files = generator.generate.map { |f| format_file f }

          # Create and write the response
          response = Google::Protobuf::Compiler::CodeGeneratorResponse.new(file: files)
          write_response response
        end

        # Private.
        # Read in the CodeGeneratorRequest and return it.
        # @return [Google::Protobuf::Compiler::CodeGeneratorRequest]
        #   The CodeGeneratorRequest.
        def request
          # Memoize so that the request is only read in once.
          return @request if @request
          request_bytes = STDIN.read
          @request = Google::Protobuf::Compiler::CodeGeneratorRequest.decode(request_bytes)
        end
        private :request

        # Private.
        # The path where the templates are located.
        # TODO: Support custom paths here via env variable.
        # @return [String]
        def template_path
          relative = File.join(*['..']*5, 'templates')
          File.expand_path(relative, __FILE__)
        end
        private :template_path

        # Private.
        # The template provider for this run.
        # @return [Google::Gapic::Generator::TemplateProvider]
        def template_provider
          # Specify where to load the templates from.
          template_provider = Google::Gapic::Generator::TemplateProvider.new(template_path)
        end
        private :template_path

        # Private.
        # Formats a file if it is a file that has a name with a '.rb' file
        # extension.
        # @param file [Google::Protobuf::Compiler::CodeGeneratorResponse::File]
        #   The file to be formatted.
        # @return [Google::Protobuf::Compiler::CodeGeneratorResponse::File]
        #   The formatted file.
        def format_file file
          # Only autocorrect ruby files.
          return file unless file.name.end_with? '.rb'

          # Write generated file to a tmp file.
          tmp_file = File.expand_path('../../tmp.rb', __FILE__)
          log_file = File.expand_path('../../tmp.log', __FILE__)
          f = File.new(tmp_file, 'w')
          f.write(file.content)
          f.close

          # Autocorrect file with rubocop.
          # TODO(landrito) make this call system agnostic.
          system("rubocop -a #{tmp_file} -o #{log_file}")

          # Read the corrected file.
          content = File.read(tmp_file)

          # Delete temp file.
          File.delete(tmp_file)
          File.delete(log_file)

          # Return the new file.
          Google::Protobuf::Compiler::CodeGeneratorResponse::File.new(
            name: file.name,
            content: content)
        end
        private :format_file

        # Private.
        # Writes the response.
        # @param response [Google::Protobuf::Compiler::CodeGeneratorResponse]
        def write_response response
          STDOUT.print(response.serialize)
        end
        private :write_response
      end
    end
  end
end
