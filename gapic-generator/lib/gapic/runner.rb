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

require "gapic/generator"
require "gapic/schema"
require "google/protobuf/compiler/plugin.pb"

module Gapic
  # TODO: Enter docs
  # Dooooooooocs!!!
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
      # Create an API Schema from the FileDescriptorProtos
      api = Gapic::Schema::Api.new request

      write_binary_file! api

      # Retrieve generator type from protoc_options if not already provided.
      generator_type ||= api.protoc_options["generator"]
      # Find the generator for the generator type.
      generator = Gapic::Generator.find generator_type

      # Create and run the generator from the API.
      output_files = generator.new(api).generate

      # Create and write the response
      response = Google::Protobuf::Compiler::CodeGeneratorResponse.new \
        file: output_files
      response.supported_features = Google::Protobuf::Compiler::CodeGeneratorResponse::FEATURE_PROTO3_OPTIONAL
      response
    end

    # Run protoc generation.
    # @param [Google::Protobuf::Compiler::CodeGeneratorRequest] request
    # @param [String] generator
    # @return [Google::Protobuf::Compiler::CodeGeneratorResponse]
    def self.run request, generator: nil
      new(request).run generator_type: generator
    end

    private

    # Save binary file with the request
    # @param [Gapic::Schema::Api] api
    def write_binary_file! api
      return unless api.protoc_options["binary_output"]

      # First, strip the binary_output parameter out so it doesn't get saved
      binary_file = api.protoc_options.delete "binary_output"
      request.parameter = api.protoc_parameter

      # Write binary file if the binary_output option is set
      File.binwrite binary_file, request.to_proto
    end
  end
end
