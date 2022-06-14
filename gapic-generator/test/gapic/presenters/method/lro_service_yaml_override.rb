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

class LroServiceYamlOverrideTest < PresenterTest
  def test_lro_showcase_operations_list
    service_presenter = service_presenter(:showcase, "Echo").rest
    lro_presenter = service_presenter.lro_service.rest
    presenter = lro_presenter.methods.find { |s| s.grpc_name == "ListOperations" }
    
    refute presenter.routing_params?
    assert presenter.rest.verb?
    assert_equal presenter.rest.verb, :get
    assert presenter.rest.path.include? "v1beta1"
  end

  def test_lro_showcase_operations_get
    service_presenter = service_presenter(:showcase, "Echo").rest
    lro_presenter = service_presenter.lro_service.rest
    presenter = lro_presenter.methods.find { |s| s.grpc_name == "GetOperation" }
    
    assert presenter.routing_params?
    assert_equal ["name"], presenter.routing_params
    assert presenter.rest.verb?
    assert_equal presenter.rest.verb, :get
    assert presenter.rest.path.include? "v1beta1"
  end
end
