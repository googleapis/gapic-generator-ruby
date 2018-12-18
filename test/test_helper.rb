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
require "google/gapic/helpers"
require "action_controller"
require "action_view"

require "minitest/autorun"
require "minitest/focus"

class GeneratorTest < Minitest::Test
  def proto_input service
    File.read "test/proto_input/#{service}.bin", mode: "rb"
  end

  def request service
    Google::Protobuf::Compiler::CodeGeneratorRequest.decode proto_input(service)
  end

  def api service
    r = request service
    Google::Gapic::Schema::Api.new r.proto_file, r.file_to_generate
  end

  def expected_content filename
    File.read "test/expected_output/#{filename}"
  end
end
