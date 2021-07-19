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

class MethodPresenterRestTest < PresenterTest
  def test_showcase_GetUser
    presenter = method_presenter :compute_small, "Addresses", "List"

    assert presenter.routing_params?
    assert presenter.rest.verb?
    assert_equal "/compute/v1/projects/\#{request_pb.project}/regions/\#{request_pb.region}/addresses", presenter.rest.uri_interpolated
    assert presenter.rest.verb?
  end
end
