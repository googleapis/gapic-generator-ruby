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

class PositionalPathPatternTest < PathPatternTest
  def test_simple_path_pattern
    assert_path_pattern(
      "hello/*/world/**",
      Gapic::PathPattern::CollectionIdSegment.new("hello"),
      Gapic::PathPattern::PositionalSegment.new(1, "*"),
      Gapic::PathPattern::CollectionIdSegment.new("world"),
      Gapic::PathPattern::PositionalSegment.new(3, "**")
    )
  end

  def test_prefix_path_pattern
    assert_path_pattern(
      "*/bar/*/bif/*",
      Gapic::PathPattern::PositionalSegment.new(0, "*"),
      Gapic::PathPattern::CollectionIdSegment.new("bar"),
      Gapic::PathPattern::PositionalSegment.new(2, "*"),
      Gapic::PathPattern::CollectionIdSegment.new("bif"),
      Gapic::PathPattern::PositionalSegment.new(4, "*")
    )
  end

  def test_trailing_path_pattern
    assert_path_pattern(
      "foo/*/baz/*/qux",
      Gapic::PathPattern::CollectionIdSegment.new("foo"),
      Gapic::PathPattern::PositionalSegment.new(1, "*"),
      Gapic::PathPattern::CollectionIdSegment.new("baz"),
      Gapic::PathPattern::PositionalSegment.new(3, "*"),
      Gapic::PathPattern::CollectionIdSegment.new("qux")
    )
  end
end
