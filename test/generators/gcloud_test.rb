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
require "google/gapic/generators/gcloud_generator"

class GcloudGeneratorTest < GeneratorTest
  def test_speech_generate
    generator = Google::Gapic::Generators::GcloudGenerator.new api(:speech)
    test_time = Time.new 2018, 8, 1, 9, 30, 0, "-07:00"
    Time.stub :now, test_time do
      generator.generate.each do |file|
        # File.write "test/expected_output/gcloud/#{file.name}", file.content
        assert_equal expected_content("gcloud/#{file.name}"), file.content
      end
    end
  end
end
