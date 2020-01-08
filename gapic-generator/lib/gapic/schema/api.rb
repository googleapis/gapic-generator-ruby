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

require "yaml"
require "gapic/schema/loader"

module Gapic
  module Schema
    # rubocop:disable Metrics/ClassLength

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
      attr_accessor :request, :files

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
        @files.each { |f| f.parent = self }
      end

      def lookup address
        address = address.join "." if address.is_a? Array
        @files.each do |f|
          lookup = f.lookup address
          return lookup if lookup
        end
        nil
      end

      def file_for address
        address = address.join "." if address.is_a? Array
        matching_files = @files.select { |f| f.lookup address }
        matching_files.first
      end

      def fix_file_path str
        str = String str
        return str if configuration[:overrides].nil?
        return str if configuration[:overrides][:file_path].nil?
        configuration[:overrides][:file_path].fetch str, str
      end

      def fix_namespace str
        str = String str
        return str if configuration[:overrides].nil?
        return str if configuration[:overrides][:namespace].nil?
        configuration[:overrides][:namespace].fetch str, str
      end

      def generate_files
        @files.select(&:generate?)
      end

      def services
        @files.map(&:services).flatten
      end

      def messages
        @files.map(&:messages).flatten
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

      # Structured representation of the samples configuration files.
      # @return [Array<Hash>]
      #   An array of the sample file hashes.
      def samples
        @samples ||= begin
          protoc_options[:samples].to_s.split(";").flat_map do |sample_path|
            YAML.load_file sample_path
          end.compact
        end
      end

      # Structured representation of the standalone samples configuration files.
      # @return [Array<Hash>]
      #   An array of the standalone sample configuration hashes.
      def standalone_samples
        @standalone_samples ||= begin
          supported_types = [
            "com.google.api.codegen.SampleConfigProto",
            "com.google.api.codegen.samplegen.v1p2.SampleConfigProto"
          ]
          supported_sample_types = [nil, "standalone"]
          samples.select { |sample_file| supported_types.include? sample_file["type"] }
                 .select { |sample_file| sample_file["schema_version"] == "1.2.0" }
                 .map { |sample_file| sample_file["samples"] }
                 .flatten.compact
                 .select { |sample_config| supported_sample_types.include? sample_config["sample_type"] }
        end
      end

      # Structured representation of the standalone test samples configuration files.
      # @return [Array<Hash>]
      #   An array of the standalone sample configuration hashes.
      def standalone_test_samples
        @standalone_test_samples ||= begin
          samples.select { |sample| sample["type"] == "test/samples" }
                 .select { |sample| sample["schema_version"] == "1" || sample["schema_version"] == 1 }
                 .map { |sample| sample["samples"] }
                 .flatten.compact
        end
      end

      # Structured representation of the inline samples configuration files.
      # @return [Array<Hash>]
      #   An array of the incode sample configuration hashes, sorted by sample_type.
      def incode_samples
        @incode_samples ||= begin
          supported_types = [
            "com.google.api.codegen.SampleConfigProto",
            "com.google.api.codegen.samplegen.v1p2.SampleConfigProto"
          ]
          samples.select { |sample_file| supported_types.include? sample_file["type"] }
                 .select { |sample_file| sample_file["schema_version"] == "1.2.0" }
                 .map { |sample_file| sample_file["samples"] }
                 .flatten.compact
                 .select { |sample_config| sample_config["sample_type"]&.start_with? "incode/" }
                 .sort_by { |sample_config| sample_config["sample_type"] }
        end
      end

      # Structured Hash representation of the configuration file.
      # @return [Hash]
      #   A Hash of the configuration values.
      def configuration
        @configuration ||= begin
          config = {}

          if protoc_options[:configuration]
            config = YAML.load_file protoc_options[:configuration]
            config.merge! config
          end

          config
        end
      end
    end

    # rubocop:enable Metrics/ClassLength
  end
end
