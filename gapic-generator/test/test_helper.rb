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

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "gapic/schema/api"
require "gapic/generator"
require "gapic/path_template"
require "gapic/resource_lookup"
require "action_controller"
require "action_view"
require "ostruct"

require "minitest/autorun"
require "minitest/focus"

class GeneratorTest < Minitest::Test
  def proto_input service
    File.binread "proto_input/#{service}_desc.bin"
  end

  def request service
    Google::Protobuf::Compiler::CodeGeneratorRequest.decode proto_input(service)
  end

  def api service
    Gapic::Schema::Api.new request(service)
  end

  def api_with_service_config service, grpc_service_config
    base_api = api service
    base_api.protoc_options["grpc_service_config"] = grpc_service_config
    base_api
  end

  def expected_content type, filename
    File.read "expected_output/templates/#{type}/#{filename}"
  end
end

class AnnotationTest < Minitest::Test
  def proto_input service
    File.binread "proto_input/#{service}_desc.bin"
  end

  def request service
    Google::Protobuf::Compiler::CodeGeneratorRequest.decode proto_input(service)
  end

  def api service
    Gapic::Schema::Api.new request(service)
  end
end

require_relative "../templates/default/helpers/default_helper"
require_relative "../templates/default/helpers/filepath_helper"
require_relative "../templates/default/helpers/namespace_helper"
require_relative "../templates/default/helpers/presenter_helper"

class PresenterTest < Minitest::Test
  def proto_input service
    File.binread "proto_input/#{service}_desc.bin"
  end

  def request service
    Google::Protobuf::Compiler::CodeGeneratorRequest.decode proto_input(service)
  end

  def api service
    Gapic::Schema::Api.new request(service)
  end

  def service_presenter api_name, service_name
    api_obj = api api_name
    service = api_obj.services.find { |s| s.name == service_name }
    refute_nil service
    ServicePresenter.new api_obj, service
  end

  def method_presenter api_name, service_name, method_name
    api_obj = api api_name
    service = api_obj.services.find { |s| s.name == service_name }
    refute_nil service
    method = service.methods.find { |s| s.name == method_name }
    refute_nil method
    MethodPresenter.new api_obj, method
  end

  def field_presenter api_name, message_name, field_name
    api_obj = api api_name
    message = api_obj.messages.find { |m| m.address.join(".") == message_name }
    field = message.fields.find { |f| f.name == field_name }
    FieldPresenter.new api_obj, message, field
  end
end

class GemTest < Minitest::Test
  def expected_content gem, filename
    File.read "expected_output/gems/#{gem}/#{filename}"
  end
end

##
# Test for URI path template parsing.
#
# @see https://tools.ietf.org/html/rfc6570 URI Template
#
class PathTemplateTest < Minitest::Test
  def assert_path_template path_template, *exp_segments
    act_segments = Gapic::PathTemplate.parse path_template

    assert_valid_segments act_segments
    assert_equal exp_segments, act_segments
  end

  def assert_valid_segments segments
    refute segments.any?(nil), "segments won't contain any nil segments"
    refute segments.any?(""), "segments won't contain any empty segments"
  end
end

class ResourceLookupTest < Minitest::Test
  def proto_input service
    File.binread "proto_input/#{service}_desc.bin"
  end

  def request service
    Google::Protobuf::Compiler::CodeGeneratorRequest.decode proto_input(service)
  end

  def api service
    Gapic::Schema::Api.new request(service)
  end

  def service api_name, service_name
    api_obj = api api_name
    service_obj = api_obj.services.find { |s| s.name == service_name }
    refute_nil service_obj
    service_obj
  end
end

# A fake api class for creating test fixtures
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
                                   @cur_services, nil, @cur_registry
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
    message = Gapic::Schema::Message.new descriptor, @cur_address, nil, @cur_fields, nil, nil, nil
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

  def fix_namespace name
    name
  end
end
