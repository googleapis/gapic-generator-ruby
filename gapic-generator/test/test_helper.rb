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

$LOAD_PATH.unshift ::File.expand_path("../lib", __dir__)
$LOAD_PATH.unshift ::File.expand_path("../../shared/test_resources", __dir__)
require "gapic/schema/api"
require "gapic/schema/request_param_parser"
require "gapic/schema/service_config_parser"
require "gapic/generator"
require "gapic/path_pattern"
require "gapic/presenters"
require "gapic/resource_lookup"
require "action_controller"
require "action_view"
require "ostruct"

require "minitest/autorun"
require "minitest/focus"

class GeneratorTest < Minitest::Test
  ##
  # @param service [Symbol]
  # @return [String]
  def proto_input service
    File.binread "proto_input/#{service}_desc.bin"
  end

  ##
  # @param service [Symbol]
  # @param params_override [Hash<String, String>, Hash{String(frozen)=>String(frozen)}, nil]
  # @param params_purge [Array<String>, Array{String(frozen)}]
  # @return [Google::Protobuf::Compiler::CodeGeneratorRequest]
  def request service, params_override: nil, params_purge: nil
    request = Google::Protobuf::Compiler::CodeGeneratorRequest.decode proto_input(service)

    unless params_override.nil? && params_purge.nil?
      params_override ||= {}
      params_purge ||= []
      # create a parameter string for the override
      params_str = params_override.map { |name, value| "#{name}=#{value}" }.join(",")

      schema = Gapic::Generators::DefaultGeneratorParameters.default_schema
      params = Gapic::Schema::RequestParamParser.parse_parameters_string(request.parameter,
                                                                         param_schema: schema)
      # filter out parameters that are going to be overridden and purged and reconstruct the param string
      filtered_params = params.filter { |p| !params_override.key?(p.config_name) && !params_purge.include?(p.config_name)}
      filtered_params_str = Gapic::Schema::RequestParamParser.reconstruct_parameters_string filtered_params

      # comma to separate only if there are parameters left
      separator = filtered_params_str.empty? || params_str.empty? ? "" : ","

      # new param string with the overrides
      request.parameter = "#{filtered_params_str}#{separator}#{params_str}"
    end

    request
  end

  ##
  # @param service [Symbol]
  # @param params_override [Hash<String, String>, Hash{String(frozen)=>String(frozen)}, nil]
  # @param params_purge [Array<String>, Array{String(frozen)}]
  # @return [Gapic::Schema::Api]
  def api service, params_override: nil, params_purge: nil
    default_params = case service 
      when :showcase
        { "service-yaml" => "protofiles_input/google/showcase/v1beta1/showcase_v1beta1.yaml".freeze }
      when :testing
        grpc_service_config_paths = [
          "protofiles_input/testing/grpc_service_config/grpc_service_config.json",
          "protofiles_input/testing/grpc_service_config/grpc_service_config2.json"
        ]
        { "grpc_service_config" =>  grpc_service_config_paths.join(";") }
      else
        { }
      end

    params_override = default_params.merge(params_override || {})  

    Gapic::Schema::Api.new request(service, params_override: params_override, params_purge: params_purge)
  end

  ##
  # @param service [Symbol]
  # @param grpc_service_config [String]
  # @return [Gapic::Schema::Api]
  def api_with_grpc_service_config service, grpc_service_config
    grpc_service_config_str = grpc_service_config.is_a?(Array) ? grpc_service_config.join(";")
                                                      : grpc_service_config.to_s

    api service, params_override: {"grpc_service_config" => grpc_service_config_str.freeze}
  end

  ##
  # @param service [Symbol]
  # @param service_yaml [String]
  # @return [Gapic::Schema::Api]
  def api_with_service_yaml service, service_yaml_str
    api service, params_override: {"service-yaml" => service_yaml_str.freeze}
  end

  ##
  # @param service [Symbol]
  # @param filename [String]
  # @return [String]
  def expected_content service, filename
    File.read "expected_output/templates/#{service}/#{filename}"
  end
end

class AnnotationTest < GeneratorTest
end

class PresenterTest < GeneratorTest
  def service_presenter api_name, service_name
    api_obj = api api_name
    service = api_obj.services.find { |s| s.name == service_name }
    refute_nil service
    gem_presenter = Gapic::Presenters::GemPresenter.new api_obj
    Gapic::Presenters::ServicePresenter.new gem_presenter, api_obj, service
  end

  def method_presenter api_name, service_name, method_name
    api_obj = api api_name
    service = api_obj.services.find { |s| s.name == service_name }
    refute_nil service
    method = service.methods.find { |s| s.name == method_name }
    refute_nil method
    gem_presenter = Gapic::Presenters::GemPresenter.new api_obj
    service_presenter = Gapic::Presenters::ServicePresenter.new gem_presenter, api_obj, service
    Gapic::Presenters::MethodPresenter.new service_presenter, api_obj, method
  end

  def field_presenter api_name, message_name, field_name
    api_obj = api api_name
    message = api_obj.messages.find { |m| m.address.join(".") == message_name }
    field = message.fields.find { |f| f.name == field_name }
    Gapic::Presenters::FieldPresenter.new api_obj, message, field
  end

  def resource_presenter api_name, message_name
    api_obj = api api_name
    message = api_obj.messages.find { |m| m.address.join(".") == message_name }
    Gapic::Presenters::ResourcePresenter.new message.resource
  end
end

class GemTest < Minitest::Test
  def expected_content gem, filename
    File.read "expected_output/gems/#{gem}/#{filename}"
  end
end

##
# Test for URI path pattern parsing
#
# @see https://google.aip.dev/122 AIP-122 Resource names
# @see https://google.aip.dev/123 AIP-123 Resource types
#
class PathPatternTest < Minitest::Test
  def assert_path_pattern path_pattern, *exp_segments
    pattern = Gapic::PathPattern.parse path_pattern
    act_segments = pattern.segments

    assert_valid_segments act_segments
    assert_equal exp_segments, act_segments

    pattern
  end

  def assert_valid_segments segments
    refute segments.any?(nil), "segments won't contain any nil segments"
    refute segments.any?{|segment| segment.pattern.empty?}, "segments won't contain any empty segments"
  end
end

class ResourceLookupTest < GeneratorTest
  def service api_name, service_name
    api_obj = api api_name
    service_obj = api_obj.services.find { |s| s.name == service_name }
    refute_nil service_obj
    service_obj
  end
end

# A fake api class for creating test fixtures
# TODO: Rework this to use the real Schema::Api and the FakeRequest below.
class FakeApi
  def initialize
    @files = []
    yield self if block_given?
  end

  def add_file! package, ruby_package = nil
    @cur_registry = {}
    @cur_messages = []
    @cur_enums = []
    @cur_services = []
    @cur_address = package.split "."
    yield if block_given?
    descriptor = OpenStruct.new options: { ruby_package: ruby_package }, package: package
    file = Gapic::Schema::File.new descriptor, @cur_address, nil, @cur_messages, @cur_enums,
                                   @cur_services, [], nil, @cur_registry
    file.parent = self
    @files << file
    @cur_messages = @cur_enums = @cur_services = @cur_registry = @cur_address = nil
    self
  end

  def add_message! name
    old_address = @cur_address
    @cur_address += [name]
    @cur_fields = []
    yield if block_given?
    descriptor = OpenStruct.new name: name
    message = Gapic::Schema::Message.new descriptor, @cur_address, nil, @cur_fields, nil, nil, nil, nil
    @cur_messages << message
    @cur_registry[@cur_address.join "."] = message
    @cur_address = old_address
    @cur_fields = nil
    self
  end

  def add_field! name
    old_address = @cur_address
    @cur_address += [name]
    descriptor = OpenStruct.new name: name
    field = Gapic::Schema::Field.new descriptor, @cur_address, nil, nil, nil
    @cur_fields << field
    @cur_registry[@cur_address.join "."] = field
    @cur_address = old_address
    self
  end

  def add_service! name
    old_address = @cur_address
    @cur_address += [name]
    @cur_methods = []
    yield if block_given?
    descriptor = OpenStruct.new name: name
    service = Gapic::Schema::Service.new descriptor, @cur_address, nil, @cur_methods
    @cur_services << service
    @cur_registry[@cur_address.join "."] = service
    @cur_address = old_address
    @cur_methods = nil
    self
  end

  def add_method! name
    old_address = @cur_address
    @cur_address += [name]
    descriptor = OpenStruct.new name: name
    method = Gapic::Schema::Method.new descriptor, @cur_address, nil, nil, nil
    @cur_methods << method
    @cur_registry[@cur_address.join "."] = method
    @cur_address = old_address
    self
  end

  def add_enum! name
    old_address = @cur_address
    @cur_address += [name]
    @cur_values = []
    yield if block_given?
    descriptor = OpenStruct.new name: name
    enum = Gapic::Schema::Enum.new descriptor, @cur_address, nil, @cur_values
    @cur_enums << enum
    @cur_registry[@cur_address.join "."] = enum
    @cur_address = old_address
    @cur_values = nil
    self
  end

  def add_value! name
    old_address = @cur_address
    @cur_address += [name]
    descriptor = OpenStruct.new name: name
    value = Gapic::Schema::EnumValue.new descriptor, @cur_address, nil
    @cur_values << value
    @cur_registry[@cur_address.join "."] = value
    @cur_address = old_address
    self
  end

  def lookup address
    @files.each do |file|
      object = file.lookup address
      return object unless object.nil?
    end
    nil
  end

  def containing_api
    self
  end

  def fix_namespace name
    name
  end
end

# A fake request builder
class FakeRequest < OpenStruct
  def initialize
    super
    @cur_descriptor = self
    self.proto_file = []
    self.file_to_generate = []
    self.parameter = ""
    yield self if block_given?
  end

  def add_file! package
    outer_descriptor = @cur_descriptor
    @cur_descriptor = OpenStruct.new
    @cur_descriptor.name = package
    @cur_descriptor.package = package
    @cur_descriptor.source_code_info = OpenStruct.new location: []
    @cur_descriptor.enum_type = []
    @cur_descriptor.message_type = []
    @cur_descriptor.service = []
    @cur_descriptor.options = {}
    yield @cur_descriptor if block_given?
    outer_descriptor.proto_file << @cur_descriptor
    @cur_descriptor = outer_descriptor
    @cur_descriptor.file_to_generate << package
    self
  end

  def add_toplevel_resource! type, patterns
    resources = @cur_descriptor.options[:".google.api.resource_definition"] ||= []
    resource_descriptor = OpenStruct.new
    resource_descriptor.type = type
    resource_descriptor.pattern = Array(patterns)
    resources << resource_descriptor
    self
  end

  def add_message! name
    outer_descriptor = @cur_descriptor
    @cur_descriptor = OpenStruct.new
    @cur_descriptor.name = name
    @cur_descriptor.nested_type = []
    @cur_descriptor.enum_type = []
    @cur_descriptor.field = []
    @cur_descriptor.extension = []
    @cur_descriptor.options = {}
    yield @cur_descriptor if block_given?
    if outer_descriptor.nested_type
      outer_descriptor.nested_type << @cur_descriptor
    else
      outer_descriptor.message_type << @cur_descriptor
    end
    @cur_descriptor = outer_descriptor
    self
  end

  def set_message_resource! type, patterns
    resource_descriptor = OpenStruct.new
    resource_descriptor.type = type
    resource_descriptor.pattern = Array(patterns)
    @cur_descriptor.options[:".google.api.resource"] = resource_descriptor
    self
  end

  def add_field! name, type_name
    outer_descriptor = @cur_descriptor
    @cur_descriptor = OpenStruct.new
    @cur_descriptor.name = name
    @cur_descriptor.type_name = type_name
    yield @cur_descriptor if block_given?
    outer_descriptor.field << @cur_descriptor
    @cur_descriptor = outer_descriptor
    self
  end

  def add_service! name
    outer_descriptor = @cur_descriptor
    @cur_descriptor = OpenStruct.new
    @cur_descriptor.singleton_class.class_eval do
      attr_accessor :method
    end
    @cur_descriptor.name = name
    @cur_descriptor.method = []
    yield @cur_descriptor if block_given?
    outer_descriptor.service << @cur_descriptor
    @cur_descriptor = outer_descriptor
    self
  end

  def add_method! name, input_type, output_type
    outer_descriptor = @cur_descriptor
    @cur_descriptor = OpenStruct.new
    @cur_descriptor.input_type = input_type
    @cur_descriptor.output_type = output_type
    yield @cur_descriptor if block_given?
    outer_descriptor.method << @cur_descriptor
    @cur_descriptor = outer_descriptor
    self
  end

  def add_enum! name
    outer_descriptor = @cur_descriptor
    @cur_descriptor = OpenStruct.new
    @cur_descriptor.name = name
    @cur_descriptor.value = []
    yield @cur_descriptor if block_given?
    outer_descriptor.enum_type << @cur_descriptor
    @cur_descriptor = outer_descriptor
    self
  end

  def add_value! name
    outer_descriptor = @cur_descriptor
    @cur_descriptor = OpenStruct.new
    @cur_descriptor.name = name
    yield @cur_descriptor if block_given?
    outer_descriptor.value << @cur_descriptor
    @cur_descriptor = outer_descriptor
    self
  end
end
