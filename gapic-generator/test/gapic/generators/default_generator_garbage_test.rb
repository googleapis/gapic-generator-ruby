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

class DefaultGeneratorGarbageTest < GeneratorTest
  def test_garbage_generate
    generator = Gapic::Generators::DefaultGenerator.new api(:garbage)

    failed_files = []

    generator.generate.each do |file|
      expected = expected_content :garbage, file.name
      actual = file.content

      next if expected == actual

      warn "Generated file #{file.name} differs from expected"
      failed_files << file

      fname = file.name.gsub "/", "_"

      File.write "/tmp/filecomp/exp_#{fname}", expected
      File.write "tmp/filecomp/act_#{fname}", actual
    end

    assert_empty failed_files, "#{failed_files.length} files are different from expected: \n" + failed_files.join("\n")
  end
end
