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
    Gapic::Schema::Api.new request(service),
                           parameter_schema: Gapic::Generators::CloudGeneratorParameters.default_schema
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
end
