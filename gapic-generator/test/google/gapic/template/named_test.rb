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

class NamedTemplateTest < TemplateTest
  def test_simple_template
    assert_template(
      "foo/{bar}/baz/{bif}",
      "foo/",
      Google::Gapic::Template::Segment.new("bar", nil),
      "/baz/",
      Google::Gapic::Template::Segment.new("bif", nil)
    )
  end

  def test_pattern_template
    assert_template(
      "hello/{name=foo/*/bar/**}/world",
      "hello/",
      Google::Gapic::Template::Segment.new("name", "foo/*/bar/**"),
      "/world"
    )
  end

  def test_prefix_path_template
    assert_template(
      "{foo}/bar/{baz}/bif/{qux}",
      Google::Gapic::Template::Segment.new("foo", nil),
      "/bar/",
      Google::Gapic::Template::Segment.new("baz", nil),
      "/bif/",
      Google::Gapic::Template::Segment.new("qux", nil)
    )
  end

  def test_trailing_path_template
    assert_template(
      "foo/{bar}/baz/{bif}/qux",
      "foo/",
      Google::Gapic::Template::Segment.new("bar", nil),
      "/baz/",
      Google::Gapic::Template::Segment.new("bif", nil),
      "/qux"
    )
  end

  def test_more_than_two_names_template
    # This is a bad template, it can be parsed but not matched
    assert_template(
      "hello/{foo}{bar}/world",
      "hello/",
      Google::Gapic::Template::Segment.new("foo", nil),
      Google::Gapic::Template::Segment.new("bar", nil),
      "/world"
    )
  end
end
