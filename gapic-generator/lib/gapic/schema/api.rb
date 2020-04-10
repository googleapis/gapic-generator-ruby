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
require "json"
require "gapic/schema/loader"
require "gapic/grpc_service_config/parser"

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
        @resource_types = analyze_resources
      end

      def containing_api
        self
      end

      def containing_file
        nil
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
          result = {}
          parameters = parse_parameter request.parameter
          parameters.each do |param_array|
            key = param_array.first
            next if key.empty?
            value = param_array[1..-1]
            value = value.first if value.size == 1
            value = nil if value.empty?
            result[str_to_key(key)] = value
          end
          result
        end
      end

      # Reconstructed string representation of the protoc options
      # @return [String]
      def protoc_parameter
        protoc_options.map do |k, v|
          v = Array(v).map do |s|
            s.gsub("\\", "\\\\\\\\").gsub(",", "\\\\,").gsub("=", "\\\\=")
          end.join("=")
          k = key_to_str k
          "#{k}=#{v}"
        end.join ","
      end

      # Structured representation of the samples configuration files.
      # @return [Array<Hash>]
      #   An array of the sample file hashes.
      def samples
        @samples ||= begin
          protoc_options["samples"].to_s.split(";").flat_map do |sample_path|
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
          config_file = protoc_options["configuration"]
          config = config_file ? YAML.load_file(config_file) : {}
          protoc_options.each do |k, v|
            next if k == "configuration"
            branch = key_to_str(k).split(".").reverse.inject(v) { |m, s| { str_to_key(s) => m } }
            config = deep_merge config, branch
          end
          config
        end
      end

      # Whether the generate_path_helpers_output parameter was given in the configuration
      def generate_path_helpers_output_defined?
        configuration.key? :generate_path_helpers_output
      end

      # Sets the generate_path_helpers_output parameter in the configuration
      def generate_path_helpers_output= value
        configuration[:generate_path_helpers_output] = value
      end

      # Whether to generate path helpers for output as well as input messages
      def generate_path_helpers_output?
        # if not set in configuration, false by default
        configuration[:generate_path_helpers_output] ||= false
      end

      # Raw parsed json of the combined grpc service config files if provided
      # or an empty hash if no config was provided
      def grpc_service_config_raw
        @grpc_service_config_raw ||= begin
          filenames = protoc_options["grpc_service_config"].to_s.split ";"
          filenames.inject({}) do |running_hash, filename|
            file_hash = JSON.parse ::File.read filename
            deep_merge running_hash, file_hash
          end
        end
      end

      # Parsed grpc service config
      def grpc_service_config
        @grpc_service_config ||= begin
          Gapic::GrpcServiceConfig::Parser.parse grpc_service_config_raw
        end
      end

      # Get a resource given its type string
      def lookup_resource_type resource_type
        @resource_types[resource_type]
      end

      private

      # Does a pre-analysis of all resources defined in the job. This has
      # two effects:
      # * Side effect: each resource has its parent_resources field set.
      # * A mapping from resource type to resource wrapper is returned.
      def analyze_resources
        # In order to set parent_resources, we first populate a mapping from
        # parsed pattern to resource mapping (in the patterns variable). This
        # is done in one pass along with populating the resource type mapping.
        # Then, we go through all resources again, get its expected parent
        # patterns, and anything that shows up in the patterns mapping is taken
        # to be a parent.
        types = {}
        patterns = {}
        @files.each do |file|
          file.resources.each { |resource| populate_resource_lookups resource, types, patterns }
          file.messages.each { |message| populate_message_resource_lookups message, types, patterns }
        end
        types.each do |_type, resource|
          parents = resource.parsed_parent_patterns
                            .map { |pat| patterns[pat] }
                            .compact.uniq
          resource.parent_resources.replace parents
        end
        types
      end

      def populate_resource_lookups resource, types, patterns
        types[resource.type] = resource
        resource.parsed_patterns.each do |pat|
          patterns[pat] = resource
        end
      end

      def populate_message_resource_lookups message, types, patterns
        populate_resource_lookups message.resource, types, patterns if message.resource
        message.nested_messages.each do |nested|
          populate_message_resource_lookups nested, types, patterns
        end
      end

      def parse_parameter str
        str.scan(/\\.|,|=|[^\\,=]+/)
           .each_with_object([[String.new]]) do |tok, arr|
             if tok == ","
               arr.append [String.new]
             elsif tok == "="
               arr.last.append String.new
             elsif tok.start_with? "\\"
               arr.last.last << tok[1]
             else
               arr.last.last << tok
             end
             arr
           end
      end

      def str_to_key str
        str = str.to_s
        str.start_with?(":") ? str[1..-1].to_sym : str
      end

      def key_to_str key
        key.is_a?(::Symbol) ? ":#{key}" : key.to_s
      end

      def deep_merge left, right
        left.merge right do |_k, lt, rt|
          if lt.is_a?(Hash) && rt.is_a?(Hash)
            deep_merge lt, rt
          elsif lt.is_a?(Array) && rt.is_a?(Array)
            lt + rt
          else
            rt
          end
        end
      end
    end

    # rubocop:enable Metrics/ClassLength
  end
end
