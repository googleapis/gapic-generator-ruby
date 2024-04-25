# frozen_string_literal: true

# Copyright 2024 Google LLC
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

class EnumValuePresenterTest < PresenterTest
  def typical_garbage_enum_value enum_value
    enum_value_presenter :garbage, "garbage/garbage.proto", "GarbageEnum", enum_value
  end

  def test_enum_value_name_no_keyword_collision
    evp = typical_garbage_enum_value 3
    assert_equal "DUMPSTER", evp.name
  end

  focus
  def test_enum_value_name_with_keyword_collision
    evp = typical_garbage_enum_value 4
    assert_equal "GarbageEnum::END", evp.name
  end
end
