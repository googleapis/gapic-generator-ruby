# frozen_string_literal: true

# Copyright 2020 Google LLC
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

require "test_helper"
require "gapic/generators/default_generator"

class DefaultGeneratorTestingTest < GeneratorTest
  def test_testing_generate
    api_request = api :testing
    generator = Gapic::Generators::DefaultGenerator.new api_request
    generator.generate.each do |file|
      assert_equal expected_content(:testing, file.name), file.content
    end
  end
end
