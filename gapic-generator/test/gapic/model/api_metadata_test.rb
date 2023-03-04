# frozen_string_literal: true

# Copyright 2023 Google LLC
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
require "gapic/model/api_metadata"

class ApiMetadataTest < Minitest::Test
  def api_metadata
    @api_metadata ||= Gapic::Model::ApiMetadata.new
  end

  def test_remove_html_tags_removes_opening_tag
    result = api_metadata.remove_html_tags "hello <html> world"
    assert_equal "hello  world", result
  end

  def test_remove_html_tags_removes_closing_tag
    result = api_metadata.remove_html_tags "hello </html> world"
    assert_equal "hello  world", result
  end

  def test_remove_html_tags_removes_open_and_close_tag
    result = api_metadata.remove_html_tags "hello <br/> world"
    assert_equal "hello  world", result
  end

  def test_remove_html_tags_removes_open_and_close_tag_with_space
    result = api_metadata.remove_html_tags "hello <br /> world"
    assert_equal "hello  world", result
  end

  def test_remove_html_tags_removes_tag_with_attr
    result = api_metadata.remove_html_tags "hello <a href=blah>ruby</a> world"
    assert_equal "hello ruby world", result
  end

  def test_remove_html_tags_removes_tag_with_attr_single_quoted
    result = api_metadata.remove_html_tags "hello <a href='blah'>ruby</a> world"
    assert_equal "hello ruby world", result
  end

  def test_remove_html_tags_removes_tag_with_attr_double_quoted
    result = api_metadata.remove_html_tags 'hello <a href="blah">ruby</a> world'
    assert_equal "hello ruby world", result
  end

  def test_remove_html_tags_removes_markdown_link
    result = api_metadata.remove_html_tags "hello [ruby](http) world"
    assert_equal "hello ruby world", result
  end

  def test_short_name_mapping
    api_metadata.update! name: "iam-meta-api.googleapis.com"
    api_metadata.standardize_names!
    assert_equal "iam", api_metadata.short_name
    assert_equal "iam", api_metadata.doc_tag_prefix
  end
end
