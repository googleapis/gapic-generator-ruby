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

require "google/gapic/schema/loader"

module Google
  module Gapic
    module Schema
      # A representation of a full API.
      #
      # @!attribute [r] files
      #   @return [Array<File>] The files represented by this API.
      # @!attribute [r] services
      #   @return [<Array<Service>] The services seen across all files in this
      #     API.
      # @!attribute [r] messages
      #   @return [Array<Message>] The top level messages seen across all files
      #     in this API.
      # @!attribute [r] enums
      #   @return [Array<Enum>] The top level enums seen across all files in
      #     this API.
      class Api
        attr_accessor :request, :files, :services, :messages, :enums

        # Initializes an API object with the file descriptors that represent the
        # API.
        #
        # @param request [Google::Protobuf::Compiler::CodeGeneratorRequest]
        #   The request object.
        def initialize request
          @request = request
          loader = Loader.new
          @files = request.proto_file.map do |fd|
            loader.load_file fd, request.file_to_generate.include?(fd.name)
          end
          @services = @files.flat_map(&:services)
          @messages = @files.flat_map(&:messages)
          @enums = @files.flat_map(&:enums)
        end

        # Structured Hash representation of the parameter values.
        # @return [Hash]
        #   A Hash of the request parameters.
        def protoc_options
          @protoc_options ||= begin
            parameters = request.parameter.split(",").map do |parameter|
              key, value = parameter.split "="
              value = value.first if value.size == 1
              value = nil if value.empty? # String or Array
              [key.to_sym, value]
            end
            Hash[parameters]
          end
        end

        # Structured Hash representation of the configuration file.
        # @return [Hash]
        #   A Hash of the configuration values.
        def configuration
          @configuration ||= begin
            config = {}

            if protoc_options[:configuration]
              require "yaml"

              config = YAML.load_file protoc_options[:configuration]
              config.merge! config
            end

            config
          end
        end
      end
    end
  end
end
