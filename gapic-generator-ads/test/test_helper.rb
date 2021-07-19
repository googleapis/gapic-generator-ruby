# frozen_string_literal: true

# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "gapic/schema/api"
require "gapic/generators/ads_generator"
require "gapic/presenters"

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

  def expected_content service, filename
    File.read "expected_output/#{service}/#{filename}"
  end
end

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
end
