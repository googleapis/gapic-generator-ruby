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

class PositionalTemplateTest < TemplateTest
  def test_simple_template
    assert_template(
      "hello/*/world/**",
      "hello/",
      Google::Gapic::Template::Segment.new(0, "*"),
      "/world/",
      Google::Gapic::Template::Segment.new(1, "**")
    )
  end

  def test_prefix_path_template
    assert_template(
      "*/bar/*/bif/*",
      Google::Gapic::Template::Segment.new(0, "*"),
      "/bar/",
      Google::Gapic::Template::Segment.new(1, "*"),
      "/bif/",
      Google::Gapic::Template::Segment.new(2, "*")
    )
  end

  def test_trailing_path_template
    assert_template(
      "foo/*/baz/*/qux",
      "foo/",
      Google::Gapic::Template::Segment.new(0, "*"),
      "/baz/",
      Google::Gapic::Template::Segment.new(1, "*"),
      "/qux"
    )
  end

  def test_more_than_two_stars_template
    # This is a bad template, it can be parsed but not matched
    assert_template(
      "hello/***/world",
      "hello/",
      Google::Gapic::Template::Segment.new(0, "**"),
      Google::Gapic::Template::Segment.new(1, "*"),
      "/world"
    )
  end
end
