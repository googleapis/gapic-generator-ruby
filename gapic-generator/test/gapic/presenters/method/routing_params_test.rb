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

class MethodPresenterRoutingParamsTest < PresenterTest
  def test_showcase_UpdateUser
    presenter = method_presenter :showcase, "Identity", "UpdateUser"

    assert presenter.routing_params?
  end

  def test_showcase_CreateRoom
    presenter = method_presenter :showcase, "Messaging", "CreateRoom"

    refute presenter.routing_params?
    assert_equal [], presenter.routing_params
  end

  def test_showcase_GetRoom
    presenter = method_presenter :showcase, "Messaging", "GetRoom"

    assert presenter.routing_params?
    assert_equal ["name"], presenter.routing_params
  end

  def test_showcase_UpdateRoom
    presenter = method_presenter :showcase, "Messaging", "UpdateRoom"

    assert presenter.routing_params?
    assert_equal ["room.name"], presenter.routing_params
  end

  def test_showcase_DeleteRoom
    presenter = method_presenter :showcase, "Messaging", "DeleteRoom"

    assert presenter.routing_params?
    assert_equal ["name"], presenter.routing_params
  end

  def test_showcase_ListRooms
    presenter = method_presenter :showcase, "Messaging", "ListRooms"

    refute presenter.routing_params?
    assert_equal [], presenter.routing_params
  end

  def test_showcase_CreateBlurb
    presenter = method_presenter :showcase, "Messaging", "CreateBlurb"

    assert presenter.routing_params?
    assert_equal ["parent"], presenter.routing_params
  end
end
