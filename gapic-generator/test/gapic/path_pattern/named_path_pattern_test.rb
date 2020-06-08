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
    pattern = assert_path_pattern(
      "foo/{bar}/baz/{bif}",
      Gapic::PathPattern::CollectionIdSegment.new("foo"),
      Gapic::PathPattern::ResourceIdSegment.create_simple("bar"),
      Gapic::PathPattern::CollectionIdSegment.new("baz"),
      Gapic::PathPattern::ResourceIdSegment.create_simple("bif")
    )
    segments = pattern.segments

    refute segments[1].positional?
    assert segments[1].provides_arguments?
    refute segments[1].resource_pattern?

    refute pattern.positional_segments?
    refute pattern.nontrivial_pattern_segments?
    assert_equal ["bar", "bif"], pattern.arguments
  end

  def test_showcase_pattern_path_pattern
    pattern = assert_path_pattern(
      "v1beta1/{parent=rooms/*}/blurbs",
      Gapic::PathPattern::CollectionIdSegment.new("v1beta1"),
      Gapic::PathPattern::ResourceIdSegment.new(:simple_resource_id, "{parent=rooms/*}", ["parent"], ["rooms/*"]),
      Gapic::PathPattern::CollectionIdSegment.new("blurbs")
    )
    segments = pattern.segments

    refute segments[1].positional?
    assert segments[1].resource_pattern?
    assert segments[1].nontrivial_resource_pattern?
    assert segments[1].provides_arguments?

    refute pattern.positional_segments?
    assert pattern.nontrivial_pattern_segments?
    assert_equal ["parent"], pattern.arguments
  end

  def test_pattern_path_pattern
    pattern = assert_path_pattern(
      "hello/{name=foo*bar}/world/{trailer=**}",
      Gapic::PathPattern::CollectionIdSegment.new("hello"),
      Gapic::PathPattern::ResourceIdSegment.new(:simple_resource_id, "{name=foo*bar}", ["name"], ["foo*bar"]),
      Gapic::PathPattern::CollectionIdSegment.new("world"),
      Gapic::PathPattern::ResourceIdSegment.new(:simple_resource_id, "{trailer=**}", ["trailer"], ["**"])
    )
    segments = pattern.segments

    refute segments[1].positional?
    assert segments[1].nontrivial_resource_pattern?

    refute segments[3].positional?
    refute segments[3].nontrivial_resource_pattern?

    refute pattern.positional_segments?
    assert pattern.nontrivial_pattern_segments?
    assert_equal ["name", "trailer"], pattern.arguments
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

  def test_multivariate_path_pattern
    pattern = assert_path_pattern(
      "hello/{foo}~{bar}/worlds/{world}",
      Gapic::PathPattern::CollectionIdSegment.new("hello"),
      Gapic::PathPattern::ResourceIdSegment.new(:complex_resource_id, "{foo}~{bar}", ["foo", "bar"]),
      Gapic::PathPattern::CollectionIdSegment.new("worlds"),
      Gapic::PathPattern::ResourceIdSegment.create_simple("world")
    )
    segments = pattern.segments

    assert_equal :complex_resource_id, segments[1].type
    refute segments[1].resource_pattern?
    assert segments[1].provides_path_string?
    assert_equal "\#{foo}~\#{bar}", segments[1].path_string

    refute pattern.positional_segments?
    refute pattern.nontrivial_pattern_segments?
    assert_equal ["foo", "bar", "world"], pattern.arguments
  end

  def test_lengty_pattern_all_separators
    pattern = assert_path_pattern(
      "customers/{customer}/item_triads/{item_a}.{item_b}~{items_c}/detail_triads/{detail_a}_{detail_b}-{detail_c}",
      Gapic::PathPattern::CollectionIdSegment.new("customers"),
      Gapic::PathPattern::ResourceIdSegment.create_simple("customer"),
      Gapic::PathPattern::CollectionIdSegment.new("item_triads"),
      Gapic::PathPattern::ResourceIdSegment.new(:complex_resource_id, "{item_a}.{item_b}~{items_c}",
                                                ["item_a", "item_b", "items_c"]),
      Gapic::PathPattern::CollectionIdSegment.new("detail_triads"),
      Gapic::PathPattern::ResourceIdSegment.new(:complex_resource_id, "{detail_a}_{detail_b}-{detail_c}",
                                                ["detail_a", "detail_b", "detail_c"])
    )
    assert_equal ["customer", "item_a", "item_b", "items_c", "detail_a", "detail_b", "detail_c"], pattern.arguments
  end
end
