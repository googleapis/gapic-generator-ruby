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

require "google/gapic/generator"
require "google/gapic/schema"
require "protobuf/descriptors"

module Google
  module Gapic
    class Runner
      # Initializes the runner.
      def initialize generator
        @generator = generator

        # Ensure that no encoding conversions are done on STDIN and STDOUT
        # since we are passing binary data back and forth. Otherwise these
        # streams will be mangled on Windows.
        STDIN.binmode
        STDOUT.binmode
      end

      # Run protoc generation.
      def run
        # Create an API Schema from the FileDescriptorProtos
        api = Google::Gapic::Schema::Api.new request

        # Create and run the generator from the API.
        output_files = generate api

        # Create and write the response
        response = Google::Protobuf::Compiler::CodeGeneratorResponse.new \
          file: output_files
        write_response response
      end

      private

      # Create the generator from the generator type and generate the files.
      def generate api
        @generator.new(api).generate
      end

      # Private.
      # Read in the CodeGeneratorRequest and return it.
      # @return [Google::Protobuf::Compiler::CodeGeneratorRequest]
      #   The CodeGeneratorRequest.
      def request
        @request ||= \
          Google::Protobuf::Compiler::CodeGeneratorRequest.decode STDIN.read
      end

      # Private.
      # Writes the response.
      # @param response [Google::Protobuf::Compiler::CodeGeneratorResponse]
      def write_response response
        STDOUT.print response.serialize
      end
    end
  end
end
