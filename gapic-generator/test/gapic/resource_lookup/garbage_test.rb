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

class GarbageResourceLookupTest < ResourceLookupTest
  def garbage_service
    service :garbage, "GarbageService"
  end

  def test_lookup
    resources = Gapic::ResourceLookup.for_service garbage_service
    refute_empty resources
    resources.each do |resource|
      assert_kind_of Gapic::Schema::Resource, resource
    end
    expected_types = [
      "cloudresourcemanager.googleapis.com/Project",
      "endlesstrash.example.net/SimpleGarbage",
      "endlesstrash.example.net/SpecificGarbage",
      "endlesstrash.example.net/TypicalGarbage"
    ]
    assert_equal expected_types, resources.map(&:type).sort
  end
end
