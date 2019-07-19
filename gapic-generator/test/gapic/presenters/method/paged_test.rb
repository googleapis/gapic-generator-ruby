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

class MethodPresenterPagedTest < PresenterTest
  def test_showcase_Expand
    presenter = method_presenter :showcase, "Echo", "Expand"

    assert_equal "Google::Showcase::V1alpha3::ExpandRequest", presenter.request_type
    assert_equal "Google::Showcase::V1alpha3::EchoResponse", presenter.return_type

    refute presenter.paged?
    assert_nil presenter.paged_response_type
  end

  def test_showcase_PagedExpand
    presenter = method_presenter :showcase, "Echo", "PagedExpand"

    assert_equal "Google::Showcase::V1alpha3::PagedExpandRequest", presenter.request_type
    assert_equal "Google::Showcase::V1alpha3::PagedExpandResponse", presenter.return_type

    assert presenter.paged?
    assert_equal "Google::Showcase::V1alpha3::EchoResponse", presenter.paged_response_type
  end
end
