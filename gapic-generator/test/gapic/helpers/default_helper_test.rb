# frozen_string_literal: true

# Copyright 2022 Google LLC
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
require_relative "../../../templates/default/helpers/default_helper"

class DefaultHelperTest < Minitest::Test
  class HelperClass
    include DefaultHelper
  end

  def helper_object
    HelperClass.new
  end

  def test_wrap_empty_string
    result = helper_object.wrap "", 80
    assert_equal "", result
  end

  def test_wrap_one_line_string
    result = helper_object.wrap "hello world", 80
    assert_equal "hello world", result
  end

  def test_wrap_two_line_string
    result = helper_object.wrap "hello world ruby rules", 11
    assert_equal "hello world\nruby rules", result
  end

  def test_wrap_line_threshold
    result = helper_object.wrap "hello world ruby rules", 10
    assert_equal "hello\nworld ruby\nrules", result
  end

  def test_wrap_long_lines
    result = helper_object.wrap "hi ya rubyyyyyyy rules", 8
    assert_equal "hi ya\nrubyyyyyyy\nrules", result
  end

  def test_wrap_with_line_breaks
    result = helper_object.wrap "hello world\nruby rules", 10
    assert_equal "hello\nworld\nruby rules", result
  end

  def test_line_spacer
    helper = helper_object
    helper.start_line_spacer
    assert_equal "", helper.line_spacer
    assert_equal "\n", helper.line_spacer
    assert_equal "\n", helper.line_spacer
    helper.start_line_spacer
    assert_equal "", helper.line_spacer
    assert_equal "\n", helper.line_spacer
  end

  def test_line_spacer_named
    helper = helper_object
    helper.start_line_spacer
    helper.start_line_spacer :second
    assert_equal "", helper.line_spacer
    assert_equal "", helper.line_spacer(:second)
    assert_equal "\n", helper.line_spacer
    assert_equal "\n", helper.line_spacer(:second)
    helper.start_line_spacer :second
    assert_equal "\n", helper.line_spacer
    assert_equal "", helper.line_spacer(:second)
  end
end
