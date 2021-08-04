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

class GemPresenterTest < PresenterTest
  NEW_GEM_NAME = "gapic-test-foo"
  GAPIC_COMMON_NAME = "gapic-common"

  def test_first_non_common_service
    request = FakeRequest.new
    request.add_file! "google.common.iam" do
      request.add_service! "IamGroot"
    end
    request.add_file! "google.cloud.example" do
      request.add_service! "Hello"
    end
    configuration = {
      common_services: {
        "google.common.iam.IamGroot" => "google.cloud.example.Hello"
      }
    }
    api = Gapic::Schema::Api.new request, configuration: configuration

    presenter = Gapic::Presenters::GemPresenter.new api
    assert_equal "IamGroot", presenter.services.first.address.last
    assert_equal "Hello", presenter.first_non_common_service.address.last
  end

  def test_common_service_sanity_check
    request = FakeRequest.new
    request.add_file! "google.common.iam" do
      request.add_service! "IamGroot"
    end
    request.add_file! "google.cloud.example" do
      request.add_service! "Hello"
    end
    configuration = {
      common_services: {
        "google.common.iam.IamGroot" => "google.cloud.example.Hello",
        "google.common.iam.IamGroot2" => "google.cloud.example.Hello2"
      }
    }
    out, err = capture_subprocess_io do
      Gapic::Schema::Api.new request, configuration: configuration
    end
    assert_equal "", out
    err = err.split("\n")
    assert_equal "WARNING: configured common service google.common.iam.IamGroot2 is not present", err[0]
    assert_equal "WARNING: configured common service delegate google.cloud.example.Hello2 is not present", err[1]
    assert_equal 2, err.size
  end

  ##
  # Testing that we can add a new dependency with a one-part gem pattern
  # and have it reflected correctly in the gem presenter
  def test_gem_dependencies_simple_new
    complex_version_param = {
      ":gem.:extra_dependencies" => "#{NEW_GEM_NAME}=>= 0.4.1"
    }

    api_param = api :grpc_service_config, params_override: complex_version_param
    presenter_param = Gapic::Presenters::GemPresenter.new api_param

    assert presenter_param.dependencies.key? NEW_GEM_NAME
    assert_kind_of String, presenter_param.dependencies[NEW_GEM_NAME]
    assert_equal ">= 0.4.1", presenter_param.dependencies[NEW_GEM_NAME]
  end

  ##
  # Testing that we can add a new dependency with a multi-part gem pattern
  # and have it reflected correctly in the gem presenter
  def test_gem_dependencies_complex_new
    complex_version_param = {
      ":gem.:extra_dependencies" => "#{NEW_GEM_NAME}=>= 0.4.1|< 2.a|foobar"
    }

    api_param = api :grpc_service_config, params_override: complex_version_param
    presenter_param = Gapic::Presenters::GemPresenter.new api_param

    assert presenter_param.dependencies.key? NEW_GEM_NAME
    assert_kind_of Array, presenter_param.dependencies[NEW_GEM_NAME]
    assert_equal 3, presenter_param.dependencies[NEW_GEM_NAME].length
    assert_includes presenter_param.dependencies[NEW_GEM_NAME], "< 2.a"
  end

  ##
  # Testing that we can override an existing dependency with a one-part gem pattern
  # and have it reflected correctly in the gem presenter
  def test_gem_dependencies_simple_override
    complex_version_param = {
      ":gem.:extra_dependencies" => "#{GAPIC_COMMON_NAME}=>= 0.4.1"
    }

    api_param = api :grpc_service_config, params_override: complex_version_param
    presenter_param = Gapic::Presenters::GemPresenter.new api_param

    assert presenter_param.dependencies.key? GAPIC_COMMON_NAME
    assert_kind_of String, presenter_param.dependencies[GAPIC_COMMON_NAME]
    assert_equal ">= 0.4.1", presenter_param.dependencies[GAPIC_COMMON_NAME]
  end

  ##
  # Testing that we can override an existing dependency with a multi-part gem pattern
  # and have it reflected correctly in the gem presenter
  def test_gem_dependencies_complex_override
    complex_version_param = {
      ":gem.:extra_dependencies" => "#{GAPIC_COMMON_NAME}=>= 0.4.1|< 2.a|foobar"
    }

    api_param = api :grpc_service_config, params_override: complex_version_param
    presenter_param = Gapic::Presenters::GemPresenter.new api_param

    assert presenter_param.dependencies.key? GAPIC_COMMON_NAME
    assert_kind_of Array, presenter_param.dependencies[GAPIC_COMMON_NAME]
    assert_equal 3, presenter_param.dependencies[GAPIC_COMMON_NAME].length
    assert_includes presenter_param.dependencies[GAPIC_COMMON_NAME], "< 2.a"
  end
end
