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
require "google/gapic/schema/api"
require "google/gapic/generator"
require "google/gapic/path_template"
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
    Google::Gapic::Schema::Api.new request(service)
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
    Google::Gapic::Schema::Api.new request(service)
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
    act_segments = Google::Gapic::PathTemplate.parse path_template

    assert_valid_segments act_segments
    assert_equal exp_segments, act_segments
  end

  def assert_valid_segments segments
    refute segments.any?(nil), "segments won't contain any nil segments"
    refute segments.any?(""), "segments won't contain any empty segments"
  end
end
