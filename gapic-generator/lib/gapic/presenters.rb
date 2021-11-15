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

require "gapic/model"
require "gapic/presenters/enum_presenter"
require "gapic/presenters/enum_value_presenter"
require "gapic/presenters/field_presenter"
require "gapic/presenters/file_presenter"
require "gapic/presenters/gem_presenter"
require "gapic/presenters/message_presenter"
require "gapic/presenters/method_presenter"
require "gapic/presenters/method_rest_presenter"
require "gapic/presenters/package_presenter"
require "gapic/presenters/resource_presenter"
require "gapic/presenters/sample_presenter"
require "gapic/presenters/service/lro_client_presenter"
require "gapic/presenters/service_presenter"
require "gapic/presenters/grpc_service_config_presenter"
require "gapic/presenters/service_rest_presenter"
require "gapic/presenters/snippet_presenter"

module Gapic
  ##
  # A namespace for presenter classes.
  #
  module Presenters
    ##
    # Return a gem presenter
    #
    # @param api [Gapic::Schema::Api] The api schema object
    # @return [Gapic::Presenters::GemPresenter]
    #
    def self.gem_presenter api
      GemPresenter.new api
    end
  end
end
