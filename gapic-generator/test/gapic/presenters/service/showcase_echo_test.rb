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

class ShowcaseEchoServiceTest < PresenterTest
  def presenter
    service_presenter :showcase, "Echo"
  end

  def test_name
    assert_equal "Echo", presenter.name
  end

  def test_methods
    refute_empty presenter.methods
    presenter.methods.each { |ref| assert_kind_of Gapic::Presenters::MethodPresenter, ref }
    exp_method_names = ["echo", "echo_error_details", "expand", "collect", "chat", "paged_expand", "paged_expand_legacy", "paged_expand_legacy_mapped", "wait", "block"]
    assert_equal exp_method_names, presenter.methods.map(&:name)
  end

  def test_references
    assert_empty presenter.references
  end

  def test_proto_service_name_full
    assert_equal "::Google::Showcase::V1beta1::Echo", presenter.proto_service_name_full
  end

  def test_proto_service_file_path
    assert_equal "google/showcase/v1beta1/echo_pb.rb", presenter.proto_service_file_path
  end

  def test_proto_service_file_name
    assert_equal "echo_pb.rb", presenter.proto_service_file_name
  end

  def test_proto_service_require
    assert_equal "google/showcase/v1beta1/echo_pb", presenter.proto_service_require
  end

  def test_proto_services_file_path
    assert_equal "google/showcase/v1beta1/echo_services_pb.rb", presenter.proto_services_file_path
  end

  def test_proto_services_file_name
    assert_equal "echo_services_pb.rb", presenter.proto_services_file_name
  end

  def test_proto_services_require
    assert_equal "google/showcase/v1beta1/echo_services_pb", presenter.proto_services_require
  end

  def test_proto_service_stub_name_full
    assert_equal "::Google::Showcase::V1beta1::Echo::Stub", presenter.proto_service_stub_name_full
  end

  def test_credentials_name
    assert_equal "Credentials", presenter.credentials_name
  end

  def test_credentials_name_full
    assert_equal "::Google::Showcase::V1beta1::Echo::Credentials", presenter.credentials_name_full
  end

  def test_credentials_file_path
    assert_equal "google/showcase/v1beta1/echo/credentials.rb", presenter.credentials_file_path
  end

  def test_credentials_file_name
    assert_equal "credentials.rb", presenter.credentials_file_name
  end

  def test_credentials_require
    assert_equal "google/showcase/v1beta1/echo/credentials", presenter.credentials_require
  end

  def test_operations_name
    assert_equal "Operations", presenter.operations_name
  end

  def test_operations_name_full
    assert_equal "::Google::Showcase::V1beta1::Echo::Operations", presenter.operations_name_full
  end

  def test_operations_file_path
    assert_equal "google/showcase/v1beta1/echo/operations.rb", presenter.operations_file_path
  end

  def test_operations_file_name
    assert_equal "operations.rb", presenter.operations_file_name
  end

  def test_operations_require
    assert_equal "google/showcase/v1beta1/echo/operations", presenter.operations_require
  end

  def test_helpers_file_path
    assert_equal "google/showcase/v1beta1/echo/helpers.rb", presenter.helpers_file_path
  end

  def test_helpers_file_name
    assert_equal "helpers.rb", presenter.helpers_file_name
  end

  def test_helpers_require
    assert_equal "google/showcase/v1beta1/echo/helpers", presenter.helpers_require
  end

  def test_test_client_file_path
    assert_equal "google/showcase/v1beta1/echo_test.rb", presenter.test_client_file_path
  end

  def test_test_client_operations_file_path
    assert_equal "google/showcase/v1beta1/echo_operations_test.rb", presenter.test_client_operations_file_path
  end

  def test_stub_name
    assert_equal "echo_stub", presenter.stub_name
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

  def test_lro_client_var
    assert_equal "operations_client", presenter.lro_client_var
  end

  def test_lro_client_ivar
    assert_equal "@operations_client", presenter.lro_client_ivar
  end

  def test_paths?
    refute presenter.paths?
  end

  def test_paths_name
    assert_equal "Paths", presenter.paths_name
  end

  def test_paths_name_full
    assert_equal "::Google::Showcase::V1beta1::Echo::Paths", presenter.paths_name_full
  end

  def test_paths_file_path
    assert_equal "google/showcase/v1beta1/echo/paths.rb", presenter.paths_file_path
  end

  def test_paths_file_name
    assert_equal "paths.rb", presenter.paths_file_name
  end

  def test_paths_require
    assert_equal "google/showcase/v1beta1/echo/paths", presenter.paths_require
  end
end
