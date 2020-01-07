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
require "gapic/generators/cloud_generator"

class CloudGeneratorTest < GeneratorTest
  def test_language_v1_generate
    generator = Gapic::Generators::CloudGenerator.new api(:language_v1)
    generator.generate.each do |file|
      assert_equal expected_content(:language_v1, file.name), file.content
    end
  end

  def test_language_v1beta1_generate
    generator = Gapic::Generators::CloudGenerator.new api(:language_v1beta1)
    generator.generate.each do |file|
      assert_equal expected_content(:language_v1beta1, file.name), file.content
    end
  end

  def test_language_v1beta2_generate
    generator = Gapic::Generators::CloudGenerator.new api(:language_v1beta2)
    generator.generate.each do |file|
      assert_equal expected_content(:language_v1beta2, file.name), file.content
    end
  end

  def test_secretmanager_v1beta1_generate
    generator = Gapic::Generators::CloudGenerator.new api(:secretmanager_v1beta1)
    generator.generate.each do |file|
      assert_equal expected_content(:secretmanager_v1beta1, file.name), file.content
    end
  end

  def test_speech_v1_generate
    generator = Gapic::Generators::CloudGenerator.new api(:speech_v1)
    generator.generate.each do |file|
      assert_equal expected_content(:speech_v1, file.name), file.content
    end
  end

  def test_vision_v1_generate
    generator = Gapic::Generators::CloudGenerator.new api(:vision_v1)
    generator.generate.each do |file|
      assert_equal expected_content(:vision_v1, file.name), file.content
    end
  end
end
