# frozen_string_literal: true

# Copyright 2019 Google LLC
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

class GarbageFilePresenterTest < PresenterTest
  def schema
    api :garbage
  end

  def test_garbage
    file = schema.files.find { |f| f.name == "garbage/garbage.proto" }
    fp = FilePresenter.new schema, file

    assert_equal ["endless", "trash", "forever"], fp.address
    assert_equal "So::Much::Trash", fp.namespace
    assert_equal "garbage/garbage.rb", fp.docs_file_path

    assert_equal ["LongRunningGarbageRequest", "LongRunningGarbageResponse", "LongRunningGarbageMetadata", "ListGarbageRequest", "ListGarbageResponse", "GarbageItem", "SimpleGarbage", "SimpleGarbageItem", "TypicalGarbage", "SpecificGarbage", "RepeatedGarbage", "PagedGarbageRequest", "PagedGarbageResponse", "ComplexGarbage", "GarbageMap"], fp.messages.map(&:name)
    fp.messages.each { |mp| assert_kind_of MessagePresenter, mp }

    assert_equal ["GarbageEnum"], fp.enums.map(&:name)
    fp.enums.each { |ep| assert_kind_of EnumPresenter, ep }
  end
end
