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
require "gapic/generators/default_generator_parameters"
require "gapic/schema/loader"
require "gapic/schema/request_param_parser"
require "gapic/grpc_service_config/parser"
require "gapic/schema/service_config_parser"

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
      attr_accessor :request
      attr_accessor :files

      # Initializes an API object with the file descriptors that represent the
      # API.
      #
      # @param request [Google::Protobuf::Compiler::CodeGeneratorRequest]
      #   The request object.
      # @param parameter_schema [Gapic::Schema::ParameterSchema]
      #   The request parameters schema to use
      # @param error_output [IO] An IO to write any errors/warnings to.
      # @param configuration [Hash] Optional override of configuration.
      def initialize request, parameter_schema: nil, error_output: $stderr, configuration: nil
        @request = request
        loader = Loader.new
        @files = request.proto_file.map do |fd|
          loader.load_file fd, request.file_to_generate.include?(fd.name)
        end
        @files.each { |f| f.parent = self }
        @configuration = configuration
        @resource_types = analyze_resources

        parameter_schema ||= Gapic::Generators::DefaultGeneratorParameters.default_schema
        @protoc_parameters = parse_parameter request.parameter, parameter_schema, error_output
        sanity_checks error_output
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

      def overrides_of key
        configuration&.fetch(:overrides, nil)&.fetch(key, nil) || {}
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

      def fix_service_name str
        str = String str
        return str if configuration[:overrides].nil?
        return str if configuration[:overrides][:service].nil?
        configuration[:overrides][:service].fetch str, str
      end

       # @return [Enumerable<Gapic::Schema::File>]
      def generate_files
        @files.select(&:generate?)
      end

      # @return [Enumerable<Gapic::Schema::Service>]
      def services
        @files.map(&:services).flatten
      end

      # @return [Enumerable<Gapic::Schema::Message>]
      def messages
        @files.map(&:messages).flatten
      end

      # Structured Hash representation of the parameter values.
      # @return [Hash]
      def protoc_options
        @protoc_options ||= begin
          result = {}
          @protoc_parameters.each do |parameter|
            result[str_to_key(parameter.config_name)] = parameter.config_value
          end
          result
        end
      end

      # Reconstructed string representation of the protoc parameters
      # @return [String]
      def protoc_parameter
        Gapic::Schema::RequestParamParser.reconstruct_parameters_string @protoc_parameters
      end

      # Structured representation of the samples configuration files.
      # @return [Array<Hash>]
      #   An array of the sample file hashes.
      def samples
        @samples ||= protoc_options["samples"].to_s.split(";").flat_map do |sample_path|
          YAML.load_file sample_path
        end.compact
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
          test_samples = samples.select { |sample| sample["type"] == "test/samples" }
          test_samples.select { |sample| sample["schema_version"] == "1" || sample["schema_version"] == 1 }
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
            branch = parse_key(key_to_str(k)).reverse.inject(v) { |m, s| { str_to_key(s) => m } }
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

      # Whether to generate REST clients
      def generate_rest_clients?
        return false if configuration[:transports].nil?
        configuration[:transports].include? "rest"
      end

      # Whether to generate GRPC clients
      def generate_grpc_clients?
        return true if configuration[:transports].nil?
        configuration[:transports].include? "grpc"
      end

      # Whether to generate standalone snippets
      def generate_standalone_snippets?
        configuration[:generate_standalone_snippets] ||= false
      end

      # Whether to generate inline documentation snippets
      def generate_yardoc_snippets?
        configuration[:generate_yardoc_snippets] ||= false
      end

      # Whether to generate gapic metadata (drift manifest) file
      # @return [Boolean]
      def generate_metadata
        configuration[:generate_metadata] ||= false
      end

      # Whether the override_proto_namespaces parameter was given in the configuration
      def override_proto_namespaces_defined?
        configuration.key? :override_proto_namespaces
      end

      # Sets the override_proto_namespaces parameter in the configuration
      def override_proto_namespaces= value
        configuration[:override_proto_namespaces] = value
      end

      # Whether namespace overrides apply to proto/grpc class references
      def override_proto_namespaces?
        configuration[:override_proto_namespaces] ||= false
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
        @grpc_service_config ||= Gapic::GrpcServiceConfig::Parser.parse grpc_service_config_raw
      end

      # Raw text of the service.yaml if given as a parameter
      # or nil if no parameter given
      def service_config_raw
        @service_config_raw ||= begin
          filename = protoc_options[:service_yaml]
          ::File.read filename if filename
        end
      end

      # Parsed service config
      def service_config
        @service_config ||= Gapic::Schema::ServiceConfigParser.parse_service_yaml service_config_raw
      end

      # Get a resource given its type string
      def lookup_resource_type resource_type
        @resource_types[resource_type]
      end

      # Given a service, find all common services that use it as a delegate.
      def common_services_for delegate
        @delegate_to_common ||= (configuration[:common_services] || {}).each_with_object({}) do |(c, d), mapping|
          (mapping[d] ||= []) << c
        end
        all_services = services
        @delegate_to_common.fetch(delegate.address.join("."), []).map do |addr|
          addr = addr.split "."
          all_services.find { |s| s.address == addr }
        end.compact.uniq
      end

      # Given a common service, return its delegate.
      def delegate_service_for common
        addr = (configuration[:common_services] || {})[common.address.join "."]
        return nil unless addr
        addr = addr.split "."
        services.find { |s| s.address == addr }
      end

      ##
      # Whether configuration has an override for the wrapper gem name
      # @return [Boolean]
      def wrapper_gem_name_override?
        configuration.key?(:overrides) &&
          configuration[:overrides].key?(:wrapper_gem_name)
      end

      ##
      # An override for the wrapper gem name in the configuration
      # @return [String, nil]
      def wrapper_gem_name_override
        return nil unless wrapper_gem_name_override?
        return nil if configuration[:overrides][:wrapper_gem_name].nil?

        wrapper_name_config = configuration[:overrides][:wrapper_gem_name].strip
        return nil if wrapper_name_config.empty?

        wrapper_name_config
      end

      private

      # Perform a variety of sanity checks on the data, and prints errors to
      # the given output as appropriate.
      #
      # @param output [IO] Stream to write outputs to.
      def sanity_checks output
        addrs = services.map { |service| service.address.join "." }
        configuration[:common_services]&.each do |k, v|
          output.puts "WARNING: configured common service #{k} is not present" unless addrs.include? k
          output.puts "WARNING: configured common service delegate #{v} is not present" unless addrs.include? v
        end
      end

      # Does a pre-analysis of all resources defined in the job. This has
      # two effects:
      # * Side effect: each resource has its parent_resources field set.
      # * A mapping from resource type to resource wrapper is returned.
      def analyze_resources
        # In order to set parent_resources, we first populate a mapping from
        # parsed pattern to resources that use it (in the patterns variable).
        # Note that there may be multiple resources associated with a pattern.
        # (This is uncommon, but one example is monitoring v3 which uses
        # "projects/*" for its workspace type as well as inheriting the common
        # project type. We thus map each pattern to an array of resources.)
        # Constructing the patterns mapping is done in one pass along with
        # populating the type mapping (which maps only to single resources.)
        # Then, we go through all resources again, get each's expected parent
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
                            .flat_map { |pat| Array(patterns[pat]) }
                            .uniq
          resource.parent_resources.replace parents
        end
        types
      end

      def populate_resource_lookups resource, types, patterns
        types[resource.type] = resource
        resource.parsed_patterns.each do |pat|
          ((patterns[pat] ||= []) << resource).uniq!
        end
      end

      def populate_message_resource_lookups message, types, patterns
        populate_resource_lookups message.resource, types, patterns if message.resource
        message.nested_messages.each do |nested|
          populate_message_resource_lookups nested, types, patterns
        end
      end

      # Parse a comma-delimited list of equals-delimited lists of strings, while
      # mapping backslash-escaped commas and equal signs to literal characters.
      # @param str [String]
      # @param error_output [IO] Stream to write outputs to.
      # @return [Array<Gapic::Schema::RequestParameter>]
      def parse_parameter str, parameter_schema, error_output
        Gapic::Schema::RequestParamParser.parse_parameters_string str,
                                                                  param_schema: parameter_schema,
                                                                  error_output: error_output
      end

      # split the string on periods, but map backslash-escaped periods to
      # literal periods.
      def parse_key str
        str.scan(/\.|\\.|[^.\\]+/)
           .each_with_object([String.new]) do |tok, arr|
             if tok == "."
               arr.append String.new
             elsif tok.start_with? "\\"
               arr.last << tok[1]
             else
               arr.last << tok
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
