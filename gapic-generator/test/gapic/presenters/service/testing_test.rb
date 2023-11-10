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

class TestingServiceTest < PresenterTest
  def test_testing_nonstandardlro_consumer
    presenter = service_presenter :testing, "PlainLroConsumer"
    
    refute presenter.nonstandard_lro_provider?
    assert presenter.nonstandard_lro_consumer?
  end

  def test_testing_nonstandardlro_provider
    presenter = service_presenter :testing, "PlainLroProvider"

    assert presenter.nonstandard_lro_provider?
    refute presenter.nonstandard_lro_consumer?

    nonstandard_lro = presenter.nonstandard_lro
    refute_nil nonstandard_lro

    assert_equal presenter.grpc_full_name, nonstandard_lro.service_full_name
    assert_equal "Get", nonstandard_lro.polling_method_name
    assert_equal "get", presenter.nonstandard_lro_polling_method_name

    assert_equal "status", nonstandard_lro.operation_status_field
    assert_equal "name", nonstandard_lro.operation_name_field
    assert_equal "http_error_status_code", nonstandard_lro.operation_err_code_field
    assert_equal "http_error_message", nonstandard_lro.operation_err_msg_field
  end

  def test_testing_all_subclients
    presenter = service_presenter :testing, "AllSubclientsConsumer"

    refute presenter.nonstandard_lro_provider?
    assert presenter.nonstandard_lro_consumer?

    refute presenter.is_hosted_mixin?
    refute presenter.is_main_mixin_service?
    assert presenter.mixins?
    assert presenter.mixin_binding_overrides?

    lro = presenter.lro_service
    refute_nil lro

    assert_equal lro.name, "Operations"
    assert lro.grpc_full_name == "google.longrunning.Operations"
    assert lro.mixin_binding_overrides?
    refute lro.rest.mixin_should_generate_override_config?
  end

  def test_testing_with_loc
    presenter = service_presenter(:testing, "ServiceWithLoc").rest
    loc_presenter = presenter.mixin_presenters.first
    refute_nil loc_presenter.bindings_override
  end
end
