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

class WrapperGemPresenterTest < PresenterTest
  NEW_GEM_NAME = "gapic-test-foo"
  GAPIC_COMMON_NAME = "google-cloud-core"

  ##
  # Testing that we can add a new dependency with a one-part gem pattern
  # and have it reflected correctly in the wrapper gem presenter
  def test_gem_dependencies_simple_new
    complex_version_param = {
      ":gem.:extra_dependencies" => "#{NEW_GEM_NAME}=>= 0.4.1"
    }

    api_param = api :testing, params_override: complex_version_param
    presenter_param = Gapic::Presenters::WrapperGemPresenter.new api_param

    assert presenter_param.dependencies.key? NEW_GEM_NAME
    assert_kind_of String, presenter_param.dependencies[NEW_GEM_NAME]
    assert_equal ">= 0.4.1", presenter_param.dependencies[NEW_GEM_NAME]
  end

  ##
  # Testing that we can add a new dependency with a multi-part gem pattern
  # and have it reflected correctly in the wrapper gem presenter
  def test_gem_dependencies_complex_new
    complex_version_param = {
      ":gem.:extra_dependencies" => "#{NEW_GEM_NAME}=>= 0.4.1|< 2.a|foobar"
    }

    api_param = api :testing, params_override: complex_version_param
    presenter_param = Gapic::Presenters::WrapperGemPresenter.new api_param

    assert presenter_param.dependencies.key? NEW_GEM_NAME
    assert_kind_of Array, presenter_param.dependencies[NEW_GEM_NAME]
    assert_equal 3, presenter_param.dependencies[NEW_GEM_NAME].length
    assert_includes presenter_param.dependencies[NEW_GEM_NAME], "< 2.a"
  end

  ##
  # Testing that we can override an existing dependency with a one-part gem pattern
  # and have it reflected correctly in the wrapper gem presenter
  def test_gem_dependencies_simple_override
    complex_version_param = {
      ":gem.:extra_dependencies" => "#{GAPIC_COMMON_NAME}=>= 0.4.1"
    }

    api_param = api :testing, params_override: complex_version_param
    presenter_param = Gapic::Presenters::WrapperGemPresenter.new api_param

    assert presenter_param.dependencies.key? GAPIC_COMMON_NAME
    assert_kind_of String, presenter_param.dependencies[GAPIC_COMMON_NAME]
    assert_equal ">= 0.4.1", presenter_param.dependencies[GAPIC_COMMON_NAME]
  end

  ##
  # Testing that we can override an existing dependency with a multi-part gem pattern
  # and have it reflected correctly in the wrapper gem presenter
  def test_gem_dependencies_complex_override
    complex_version_param = {
      ":gem.:extra_dependencies" => "#{GAPIC_COMMON_NAME}=>= 0.4.1|< 2.a|foobar"
    }

    api_param = api :testing, params_override: complex_version_param
    presenter_param = Gapic::Presenters::WrapperGemPresenter.new api_param

    assert presenter_param.dependencies.key? GAPIC_COMMON_NAME
    assert_kind_of Array, presenter_param.dependencies[GAPIC_COMMON_NAME]
    assert_equal 3, presenter_param.dependencies[GAPIC_COMMON_NAME].length
    assert_includes presenter_param.dependencies[GAPIC_COMMON_NAME], "< 2.a"
  end

  def test_services_omit_mixins
    api_param = api :testing
    presenter_param = Gapic::Presenters::WrapperGemPresenter.new api_param
    refute_includes presenter_param.services.map { |s| s.address.join "." }, "google.cloud.location.Locations"
  end
end
