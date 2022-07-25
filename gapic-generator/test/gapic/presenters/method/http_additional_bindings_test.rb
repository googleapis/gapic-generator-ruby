# frozen_string_literal: true

# Copyright 2021 Google LLC
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

class HttpAdditionalBindingsTest < PresenterTest
  def test_showcase_compliance
    presenter = method_presenter :showcase, "Compliance", "RepeatDataPathResource"
    assert_equal 2, presenter.http_bindings.count
    first_binding = presenter.http_bindings.first

    assert first_binding.verb?
    assert_equal first_binding.verb, :get
    assert first_binding.path.include? "v1beta1"
  end
end
