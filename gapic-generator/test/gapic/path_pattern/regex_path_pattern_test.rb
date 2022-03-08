# frozen_string_literal: true

# Copyright 2021 Google LLC
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

class RegexPathPatternTest < PathPatternTest
  def test_simple_path_patterns
    path_pattern_to_regex_str = {
      "*" => "[^/]+",
      "**" => ".*",
      "foo" => "foo",
      "hello/world" => "hello/world",
      "hello/*" => "hello/[^/]+",
      "*/world" => "[^/]+/world",
      "hello/*/world" => "hello/[^/]+/world",
      "hello/*/**" => "hello/[^/]+(?:/.*)?",
      "hello/**" => "hello(?:/.*)?"
    }

    path_pattern_to_regex_str.each do |key, value|
      assert_equal value, Gapic::PathPattern.parse(key).to_regex_str, "Pattern: #{key}\n"
    end
  end

  def test_named_segment_path_patterns
    path_pattern_to_regex_str = {
      "{foo}" => "(?<foo>[^/]+)",
      "{foo.bar}" => "(?<foo.bar>[^/]+)",
      "{foo=*}" => "(?<foo>[^/]+)",
      "{foo=**}" => "(?<foo>.*)"
    }

    path_pattern_to_regex_str.each do |key, value|
      assert_equal value, Gapic::PathPattern.parse(key).to_regex_str, "Pattern: #{key}\n"
    end
  end
end
