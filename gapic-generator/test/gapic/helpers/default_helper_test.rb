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

class DefaultHelperTest < Minitest::Test
  class HelperInstance
    include DefaultHelper
  end

  def helper
    @helper ||= HelperInstance.new
  end

  def test_format_number_small_integer
    str = helper.format_number 1
    assert_equal "1", str
  end

  def test_format_number_4digit_integer
    str = helper.format_number 1234
    assert_equal "1234", str
  end

  def test_format_number_5digit_integer
    str = helper.format_number 12_345
    assert_equal "12_345", str
  end

  def test_format_number_7digit_integer
    str = helper.format_number 1_234_567
    assert_equal "1_234_567", str
  end

  def test_format_number_negative_4digit_integer
    str = helper.format_number(-1234)
    assert_equal "-1234", str
  end

  def test_format_number_negative_5digit_integer
    str = helper.format_number(-12_345)
    assert_equal "-12_345", str
  end

  def test_format_number_negative_7digit_integer
    str = helper.format_number(-1_234_567)
    assert_equal "-1_234_567", str
  end

  def test_format_number_small_float
    str = helper.format_number 1.2345
    assert_equal "1.2345", str
  end

  def test_format_number_negative_small_float
    str = helper.format_number(-1.2345)
    assert_equal "-1.2345", str
  end

  def test_format_number_tiny_float
    str = helper.format_number 0.000123
    assert_equal "0.000123", str
  end

  def test_format_number_large_float
    str = helper.format_number 1_234_567.89
    assert_equal "1_234_567.89", str
  end

  def test_format_number_negative_large_float
    str = helper.format_number(-1_234_567.89)
    assert_equal "-1_234_567.89", str
  end
end
