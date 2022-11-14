# frozen_string_literal: true

# Copyright 2022 Google LLC
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

class ShowcaseEchoRestServiceTest < PresenterTest
  def presenter
    service_presenter(:showcase, "Echo").rest
  end

  def test_name
    assert_equal "Echo", presenter.name
  end

  def test_methods
    refute_empty presenter.methods
    presenter.methods.each { |ref| assert_kind_of Gapic::Presenters::MethodPresenter, ref }
    # showcase does not have REST bindings for the `chat` method
    # `expand` and `collect` are streaming methods and are currently not supported
    exp_method_names = ["echo", "paged_expand", "wait", "block"]
    assert_equal exp_method_names, presenter.methods.map(&:name)
  end

  def test_service_name_full
    assert_equal "::Google::Showcase::V1beta1::Echo::Rest", presenter.service_name_full
  end

  def test_service_stub_name_full
    assert_equal "::Google::Showcase::V1beta1::Echo::Rest::ServiceStub", presenter.service_stub_name_full
  end

  def test_operations_name
    assert_equal "Operations", presenter.operations_name
  end

  def test_operations_name_full
    assert_equal "::Google::Showcase::V1beta1::Echo::Rest::Operations", presenter.operations_name_full
  end

  def test_operations_file_path
    assert_equal "google/showcase/v1beta1/echo/rest/operations.rb", presenter.operations_file_path
  end

  def test_operations_require
    assert_equal "google/showcase/v1beta1/echo/rest/operations", presenter.operations_require
  end

  def test_test_client_file_path
    assert_equal "google/showcase/v1beta1/echo_rest_test.rb", presenter.test_client_file_path
  end

  def test_lro?
    assert presenter.lro?
  end

  def test_lro_service
    lro_presenter = presenter.lro_service
    assert_kind_of Gapic::Presenters::ServicePresenter, lro_presenter
    assert lro_presenter.is_hosted_mixin?
    refute lro_presenter.is_main_mixin_service?
  end
end
