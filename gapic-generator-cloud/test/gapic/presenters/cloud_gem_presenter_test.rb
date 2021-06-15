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

class CloudGemPresenterTest < PresenterTest
  ##
  # Tests that cloud gem presenter
  #   - is overriding the wrapper name when given a non-empty value via config
  #   - is detecting that wrapper is not present when given an empty value via config
  def test_empty_wrapper_override
    api_no_param = api :language_v1beta1
    presenter_no_param = Gapic::Presenters::CloudGemPresenter.new api_no_param
    assert presenter_no_param.has_wrapper? # language has a wrapper by default

    empty_wrapper_name_params = { ":overrides.:wrapper_gem_name" => "" }
    api_empty_param = api :language_v1beta1, params_override: empty_wrapper_name_params
    presenter_empty_param = Gapic::Presenters::CloudGemPresenter.new api_empty_param
    refute presenter_empty_param.has_wrapper?

    wrapper_name_params = { ":overrides.:wrapper_gem_name" => "foo" }
    api_param = api :language_v1beta1, params_override: wrapper_name_params
    presenter_param = Gapic::Presenters::CloudGemPresenter.new api_param
    assert presenter_param.has_wrapper?
    assert_equal "foo", presenter_param.wrapper_name
  end
end
