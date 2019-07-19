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
require "action_controller"
require "action_view"

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
