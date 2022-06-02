# frozen_string_literal: true

# Copyright 2020 Google LLC
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
require "gapic/uri_template"

class UriTemplateTest < PathPatternTest
  def test_trivial_uri_template
    uri_template = "/hello/world"
    assert_equal [], Gapic::UriTemplate.parse_arguments(uri_template)
  end

  def test_named_uri_template
    uri_template = "/hellos/{hello}/worlds/{world}"
    assert_equal [["hello", ""], ["world", ""]], Gapic::UriTemplate.parse_arguments(uri_template)
  end

  def test_positional_uri_template
    uri_template = "/foo/*/bar/**"
    assert_equal [], Gapic::UriTemplate.parse_arguments(uri_template)
  end

  def test_named_positional_uri_template
    uri_template = "/hellos/{hello}/foo/*/worlds/{world}/bar/**"
    assert_equal [["hello", ""], ["world", ""]], Gapic::UriTemplate.parse_arguments(uri_template)
  end

  def test_named_simple_pattern_uri_template
    uri_template = "/hellos/{hello=*}/worlds/{world=**}"
    assert_equal [["hello", "*"], ["world", "**"]], Gapic::UriTemplate.parse_arguments(uri_template)
  end

  def test_named_mediumcomplex_pattern_uri_template
    uri_template = "hellos/{hello=foo/*/bar}/worlds/{world=**}"
    assert_equal [["hello", "foo/*/bar"], ["world", "**"]], Gapic::UriTemplate.parse_arguments(uri_template)
  end

  def test_named_mostcomplex_pattern_uri_template
    uri_template = "hellos/{hello=sessions/*}/worlds/{world=sessions/*/tests/*}:check"
    assert_equal [["hello", "sessions/*"], ["world", "sessions/*/tests/*"]],
                 Gapic::UriTemplate.parse_arguments(uri_template)
  end
end
