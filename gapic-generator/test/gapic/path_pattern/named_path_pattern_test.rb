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
      Gapic::PathPattern::CollectionIdSegment.new("foo"),
      Gapic::PathPattern::ResourceIdSegment.create_simple("bar"),
      Gapic::PathPattern::CollectionIdSegment.new("baz"),
      Gapic::PathPattern::ResourceIdSegment.create_simple("bif"),
    ).segments

    refute segments[1].positional?
    assert segments[1].provides_arguments?
    refute segments[1].has_resource_pattern?
  end

  def test_pattern_path_pattern
    segments = assert_path_pattern(
      "hello/{name=foo*bar}/world/{trailer=**}",
      Gapic::PathPattern::CollectionIdSegment.new("hello"),
      Gapic::PathPattern::ResourceIdSegment.new(:simple_resource_id, "{name=foo*bar}", ["name"], ["foo*bar"]),
      Gapic::PathPattern::CollectionIdSegment.new("world"),
      Gapic::PathPattern::ResourceIdSegment.new(:simple_resource_id, "{trailer=**}", ["trailer"], ["**"])
    ).segments

    
    refute segments[1].positional?
    assert segments[1].has_resource_pattern?
    assert segments[1].has_nontrivial_resource_pattern?
    
    refute segments[3].positional?
    assert segments[3].has_resource_pattern?
    refute segments[3].has_nontrivial_resource_pattern?
  end

  def test_prefix_path_pattern
    assert_path_pattern(
      "{foo}/bar/{baz}/bif/{qux}",
      Gapic::PathPattern::ResourceIdSegment.create_simple("foo"),
      Gapic::PathPattern::CollectionIdSegment.new("bar"),
      Gapic::PathPattern::ResourceIdSegment.create_simple("baz"),
      Gapic::PathPattern::CollectionIdSegment.new("bif"),
      Gapic::PathPattern::ResourceIdSegment.create_simple("qux")
    )
  end

  def test_trailing_path_pattern
    assert_path_pattern(
      "foo/{bar}/baz/{bif}/qux",
      Gapic::PathPattern::CollectionIdSegment.new("foo"),
      Gapic::PathPattern::ResourceIdSegment.create_simple("bar"),
      Gapic::PathPattern::CollectionIdSegment.new("baz"),
      Gapic::PathPattern::ResourceIdSegment.create_simple("bif"),
      Gapic::PathPattern::CollectionIdSegment.new("qux")
    )
  end

  def test_correct_multivariate_path_pattern
    assert_path_pattern(
      "hello/{foo}~{bar}/world",
      Gapic::PathPattern::CollectionIdSegment.new("hello"),
      Gapic::PathPattern::ResourceIdSegment.new(:complex_resource_id, "{foo}~{bar}", ["foo", "bar"]),
      Gapic::PathPattern::CollectionIdSegment.new("world")
    )
  end
end
