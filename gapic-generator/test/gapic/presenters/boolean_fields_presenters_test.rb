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

##
# This is an integration test that checks that
# the boolean parameters are correctly represented
# in the api and presenters after being parsed
class BooleanFieldsPresenterTest < PresenterTest
  def test_no_set_booleans
    api_v1 = api :grpc_service_config,
                 params_purge: Gapic::Generators::DefaultGeneratorParameters::BOOL_PARAMETERS.clone

    refute api_v1.generate_metadata #false by default in the gapic-generator-vanilla

    presenter_v1 = Gapic::Presenters::GemPresenter.new api_v1
    assert presenter_v1.yard_strict? #true by default
    refute presenter_v1.generic_endpoint?  #false by default
    refute presenter_v1.free_tier? #false by default
  end

  def test_set_to_false_booleans
    all_false_booleans = Gapic::Generators::DefaultGeneratorParameters::BOOL_PARAMETERS.map do |param_name|
      [param_name, "false"]
    end.to_h

    api_v1 = api :grpc_service_config,
                 params_override: all_false_booleans

    refute api_v1.generate_metadata

    presenter_v1 = Gapic::Presenters::GemPresenter.new api_v1
    refute presenter_v1.yard_strict?
    refute presenter_v1.generic_endpoint?
    refute presenter_v1.free_tier?
  end

  def test_set_to_true_booleans
    all_true_booleans = Gapic::Generators::DefaultGeneratorParameters::BOOL_PARAMETERS.map do |param_name|
      [param_name, "true"]
    end.to_h

    api_v1 = api :grpc_service_config,
                 params_override: all_true_booleans

    assert api_v1.generate_metadata

    presenter_v1 = Gapic::Presenters::GemPresenter.new api_v1
    assert presenter_v1.yard_strict?
    assert presenter_v1.generic_endpoint?
    assert presenter_v1.free_tier?
  end
end
