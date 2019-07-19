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

class NamedPathTemplateTest < PathTemplateTest
  def test_simple_path_template
    assert_path_template(
      "foo/{bar}/baz/{bif}",
      "foo/",
      Gapic::PathTemplate::Segment.new("bar", nil),
      "/baz/",
      Gapic::PathTemplate::Segment.new("bif", nil)
    )
  end

  def test_pattern_path_template
    assert_path_template(
      "hello/{name=foo/*/bar/**}/world",
      "hello/",
      Gapic::PathTemplate::Segment.new("name", "foo/*/bar/**"),
      "/world"
    )
  end

  def test_prefix_path_template
    assert_path_template(
      "{foo}/bar/{baz}/bif/{qux}",
      Gapic::PathTemplate::Segment.new("foo", nil),
      "/bar/",
      Gapic::PathTemplate::Segment.new("baz", nil),
      "/bif/",
      Gapic::PathTemplate::Segment.new("qux", nil)
    )
  end

  def test_trailing_path_template
    assert_path_template(
      "foo/{bar}/baz/{bif}/qux",
      "foo/",
      Gapic::PathTemplate::Segment.new("bar", nil),
      "/baz/",
      Gapic::PathTemplate::Segment.new("bif", nil),
      "/qux"
    )
  end

  def test_more_than_two_names_path_template
    # This is a bad URI path template, it can be parsed but not matched
    assert_path_template(
      "hello/{foo}{bar}/world",
      "hello/",
      Gapic::PathTemplate::Segment.new("foo", nil),
      Gapic::PathTemplate::Segment.new("bar", nil),
      "/world"
    )
  end
end
