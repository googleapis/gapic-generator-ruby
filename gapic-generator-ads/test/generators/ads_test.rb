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


require "test_helper"
require "gapic/generators/ads_generator"

class AdsGeneratorTest < GeneratorTest
  def test_speech_generate
    generator = Gapic::Generators::AdsGenerator.new api(:googleads)
    generator.generate.each do |file|
      assert_equal expected_content(:googleads, file.name), file.content
    end
  end
end
