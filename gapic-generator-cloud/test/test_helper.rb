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
require "gapic/generator"
require "gapic/generators/cloud_generator"

require "action_controller"
require "action_view"

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
    Gapic::Schema::Api.new request(service, params_override: params_override, params_purge: params_purge),
                           parameter_schema: Gapic::Generators::CloudGeneratorParameters.default_schema
  end

  ##
  # @param service [Symbol]
  # @param filename [String]
  # @return [String]
  def expected_content service, filename
    File.read "expected_output/#{service}/#{filename}"
  end
end

class PresenterTest < GeneratorTest
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
end
