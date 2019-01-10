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
require "google/gapic/gem_generator"
require "tmpdir"

class GemGeneratorTest < GemTest
  def test_speech_generate
    Dir.mktmpdir do |tmp_dir|
      generator = Google::Gapic::GemGenerator.new "my_plugin", tmp_dir
      generator.generate

      Dir.glob(File.join(tmp_dir, "**/*")).each do |file|
        next unless File.file? file

        local_file_path = file.gsub "#{tmp_dir}/", ""
        assert_equal expected_content("my_plugin", local_file_path),
                     File.read(file)
      end
    end
  end
end
