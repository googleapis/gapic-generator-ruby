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
require "gapic/schema/request_param_parser"
require "google/protobuf/compiler/plugin.pb"

module Gapic
  # TODO: Enter docs
  # Dooooooooocs!!!
  class Runner
    attr_reader :request

    # Initializes the runner.
    # @param [Google::Protobuf::Compiler::CodeGeneratorRequest] request
    def initialize request
      # parse the parameters that apply to runner and not to the api and exclude them from the request
      runner_param_names = ["binary_output", "generator"]
      runner_schema = Gapic::Schema::ParameterSchema.create(
        string_params_list: runner_param_names
      )

      params = Gapic::Schema::RequestParamParser.parse_parameters_string request.parameter, param_schema: runner_schema
      @binary_output_path = params.filter { |p| p.config_name == "binary_output" }.first&.config_value
      @generator_type = params.filter { |p| p.config_name == "generator" }.first&.config_value

      # reconstruct the request parameter string without the runner parameters
      request.parameter = params.filter { |p| !runner_param_names.include? p.config_name }.map(&:input_str).join ","

      @request = request
    end

    # Run protoc generation.
    # @param [String] generator_type
    # @return [Google::Protobuf::Compiler::CodeGeneratorResponse]
    def run generator_type: nil
      # save the binary file if needed
      write_binary_file

      # Retrieve generator type from protoc_options if not already provided.
      generator_type ||= @generator_type
      # Find the generator for the generator type.
      generator = Gapic::Generator.find generator_type

      # Create an API Schema from the FileDescriptorProtos
      api = Gapic::Schema::Api.new request, parameter_schema: generator.parameter_schema

      # Create and run the generator from the API.
      output_files = generator.new(api).generate

      # Create and write the response
      response = Google::Protobuf::Compiler::CodeGeneratorResponse.new file: output_files
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
    # if the binary_output_path parameter is set
    def write_binary_file
      return unless @binary_output_path

      # Write binary file if the binary_output option is set
      File.binwrite @binary_output_path, request.to_proto
    end
  end
end
