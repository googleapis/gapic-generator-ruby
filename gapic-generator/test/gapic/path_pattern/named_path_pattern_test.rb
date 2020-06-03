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

class NamedPathPatternTest < PathPatternTest
  def test_simple_path_pattern
    segments = assert_path_pattern(
      "foo/{bar}/baz/{bif}",
      "foo/",
      Gapic::PathPattern::Segment.new("bar", nil),
      "/baz/",
      Gapic::PathPattern::Segment.new("bif", nil)
    )
    assert segments[1].named?
    refute segments[1].positional?
    refute segments[1].pattern?
    refute segments[1].nontrivial_pattern?
  end

  def test_pattern_path_pattern
    segments = assert_path_pattern(
      "hello/{name=foo*bar}/world/{trailer=**}",
      "hello/",
      Gapic::PathPattern::Segment.new("name", "foo*bar"),
      "/world/",
      Gapic::PathPattern::Segment.new("trailer", "**")
    )
    assert segments[1].named?
    refute segments[1].positional?
    assert segments[1].pattern?
    assert segments[1].nontrivial_pattern?
    assert segments[3].named?
    refute segments[3].positional?
    assert segments[3].pattern?
    refute segments[3].nontrivial_pattern?
  end

  def test_prefix_path_pattern
    assert_path_pattern(
      "{foo}/bar/{baz}/bif/{qux}",
      Gapic::PathPattern::Segment.new("foo", nil),
      "/bar/",
      Gapic::PathPattern::Segment.new("baz", nil),
      "/bif/",
      Gapic::PathPattern::Segment.new("qux", nil)
    )
  end

  def test_trailing_path_pattern
    assert_path_pattern(
      "foo/{bar}/baz/{bif}/qux",
      "foo/",
      Gapic::PathPattern::Segment.new("bar", nil),
      "/baz/",
      Gapic::PathPattern::Segment.new("bif", nil),
      "/qux"
    )
  end

  def test_more_than_two_names_path_pattern
    # This is a bad URI path template, it can be parsed but not matched
    assert_path_pattern(
      "hello/{foo}{bar}/world",
      "hello/",
      Gapic::PathPattern::Segment.new("foo", nil),
      Gapic::PathPattern::Segment.new("bar", nil),
      "/world"
    )
  end

  # def test_correct_multivariate_path_pattern
  #   # This is a bad URI path template, it can be parsed but not matched
  #   assert_path_pattern(
  #     "hello/{foo}~{bar}/world",
  #     "hello/",
  #     Gapic::PathPattern::Segment.new("foo", nil),
  #     Gapic::PathPattern::Segment.new("bar", nil),
  #     "/world"
  #   )
  # end
end
