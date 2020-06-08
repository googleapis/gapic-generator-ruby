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

require "test_helper"
require "gapic/generators/default_generator"

class DefaultGeneratorShowcaseTest < GeneratorTest
  def test_showcase_generate
    generator = Gapic::Generators::DefaultGenerator.new api(:showcase)
    generator.generate.each do |file|
      expected = expected_content :showcase, file.name
      actual = file.content

      assert_equal expected, actual, "Generated content for file '#{file.name}' is different from expected"
    end
  end
end
