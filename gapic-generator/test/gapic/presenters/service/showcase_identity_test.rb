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

class ShowcaseIdentityServiceTest < PresenterTest
  def presenter
    service_presenter :showcase, "Identity"
  end

  def test_name
    assert_equal "Identity", presenter.name
  end

  def test_methods
    refute_empty presenter.methods
    presenter.methods.each { |ref| assert_kind_of Gapic::Presenters::MethodPresenter, ref }
    exp_method_names = ["create_user", "get_user", "update_user", "delete_user", "list_users"]
    assert_equal exp_method_names, presenter.methods.map(&:name)
  end

  def test_references
    refute_empty presenter.references
    presenter.references.each { |ref| assert_kind_of Gapic::Presenters::ResourcePresenter, ref }
    assert_equal ["User"], presenter.references.map(&:name)
    assert_equal ["users/{user_id}"], presenter.references.map(&:patterns).map(&:first).map(&:pattern)
  end

  def test_proto_service_name_full
    assert_equal "::Google::Showcase::V1beta1::Identity", presenter.proto_service_name_full
  end

  def test_proto_service_file_path
    assert_equal "google/showcase/v1beta1/identity_pb.rb", presenter.proto_service_file_path
  end

  def test_proto_service_file_name
    assert_equal "identity_pb.rb", presenter.proto_service_file_name
  end

  def test_proto_service_require
    assert_equal "google/showcase/v1beta1/identity_pb", presenter.proto_service_require
  end

  def test_proto_services_file_path
    assert_equal "google/showcase/v1beta1/identity_services_pb.rb", presenter.proto_services_file_path
  end

  def test_proto_services_file_name
    assert_equal "identity_services_pb.rb", presenter.proto_services_file_name
  end

  def test_proto_services_require
    assert_equal "google/showcase/v1beta1/identity_services_pb", presenter.proto_services_require
  end

  def test_proto_service_stub_name_full
    assert_equal "::Google::Showcase::V1beta1::Identity::Stub", presenter.proto_service_stub_name_full
  end

  def test_credentials_name
    assert_equal "Credentials", presenter.credentials_name
  end

  def test_credentials_name_full
    assert_equal "::Google::Showcase::V1beta1::Identity::Credentials", presenter.credentials_name_full
  end

  def test_credentials_file_path
    assert_equal "google/showcase/v1beta1/identity/credentials.rb", presenter.credentials_file_path
  end

  def test_credentials_file_name
    assert_equal "credentials.rb", presenter.credentials_file_name
  end

  def test_credentials_require
    assert_equal "google/showcase/v1beta1/identity/credentials", presenter.credentials_require
  end

  def test_operations_name
    assert_equal "Operations", presenter.operations_name
  end

  def test_operations_name_full
    assert_equal "::Google::Showcase::V1beta1::Identity::Operations", presenter.operations_name_full
  end

  def test_operations_file_path
    assert_equal "google/showcase/v1beta1/identity/operations.rb", presenter.operations_file_path
  end

  def test_operations_file_name
    assert_equal "operations.rb", presenter.operations_file_name
  end

  def test_operations_require
    assert_equal "google/showcase/v1beta1/identity/operations", presenter.operations_require
  end

  def test_helpers_file_path
    assert_equal "google/showcase/v1beta1/identity/helpers.rb", presenter.helpers_file_path
  end

  def test_helpers_file_name
    assert_equal "helpers.rb", presenter.helpers_file_name
  end

  def test_helpers_require
    assert_equal "google/showcase/v1beta1/identity/helpers", presenter.helpers_require
  end

  def test_test_client_file_path
    assert_equal "google/showcase/v1beta1/identity_test.rb", presenter.test_client_file_path
  end

  def test_test_client_operations_file_path
    assert_equal "google/showcase/v1beta1/identity_operations_test.rb", presenter.test_client_operations_file_path
  end

  def test_stub_name
    assert_equal "identity_stub", presenter.stub_name
  end

  def test_lro?
    refute presenter.lro?
  end

  def test_lro_client_var
    assert_equal "operations_client", presenter.lro_client_var
  end

  def test_lro_client_ivar
    assert_equal "@operations_client", presenter.lro_client_ivar
  end

  def test_paths?
    assert presenter.paths?
  end

  def test_paths_name
    assert_equal "Paths", presenter.paths_name
  end

  def test_paths_name_full
    assert_equal "::Google::Showcase::V1beta1::Identity::Paths", presenter.paths_name_full
  end

  def test_paths_file_path
    assert_equal "google/showcase/v1beta1/identity/paths.rb", presenter.paths_file_path
  end

  def test_paths_file_name
    assert_equal "paths.rb", presenter.paths_file_name
  end

  def test_paths_require
    assert_equal "google/showcase/v1beta1/identity/paths", presenter.paths_require
  end
end
