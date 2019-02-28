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
require "google/protobuf/compiler/plugin.pb"

module Google
  module Gapic
    class Runner
      attr_reader :request

      # Initializes the runner.
      # @param [Google::Protobuf::Compiler::CodeGeneratorRequest] request
      def initialize request
        @request = request
      end

      # Run protoc generation.
      # @param [String] generator_type
      # @return [Google::Protobuf::Compiler::CodeGeneratorResponse]
      def run generator_type: nil
        write_binary_file!

        # Create an API Schema from the FileDescriptorProtos
        api = Google::Gapic::Schema::Api.new request

        # Retrieve generator type from parameters if not already provided.
        generator_type ||= parameters[:generator]
        # Find the generator for the generator type.
        generator = Google::Gapic::Generator.find generator_type

        # Create and run the generator from the API.
        output_files = generator.new(api).generate

        # Create and write the response
        Google::Protobuf::Compiler::CodeGeneratorResponse.new \
          file: output_files
      end

      # Run protoc generation.
      # @param [Google::Protobuf::Compiler::CodeGeneratorRequest] request
      # @param [String] generator
      # @return [Google::Protobuf::Compiler::CodeGeneratorResponse]
      def self.run request, generator: nil
        new(request).run generator_type: generator
      end

      private

      def write_binary_file!
        return unless parameters[:binary_output]

        # First, strip the binary_output parameter out so it doesn't get saved
        binary_file = parameters.delete :binary_output
        request.parameter = parameters.map do |key, value|
          "#{key}=#{Array(value).join '='}"
        end.join ","

        # Write binary file if the binary_output option is set
        File.binwrite binary_file, request.to_proto
      end

      # Structured Hash representation of CodeGeneratorRequest#parameter
      # @return [Hash]
      #   A Hash of the request parameters.
      def parameters
        @parameters ||= begin
          parameters = request.parameter.split(",").map do |parameter|
            key, value = parameter.split "="
            value = value.first if value.size == 1
            value = nil if value.empty? # String or Array
            [key.to_sym, value]
          end
          Hash[parameters]
        end
      end
    end
  end
end
