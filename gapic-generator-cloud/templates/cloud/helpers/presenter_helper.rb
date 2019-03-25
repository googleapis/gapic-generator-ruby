# frozen_string_literal: true

# Copyright 2018 Google LLC
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

require "active_support/inflector"
require_relative "presenters/api_presenter"
require_relative "presenters/package_presenter"
require_relative "presenters/service_presenter"
require_relative "presenters/method_presenter"
require_relative "presenters/field_presenter"

module PresenterHelper
  def api_presenter api
    ApiPresenter.new api
  end

  def package_presenter api, package
    PackagePresenter.new api, package
  end

  def service_presenter service
    ServicePresenter.new service
  end

  def method_presenter method
    MethodPresenter.new method
  end

  def field_presenter message, field
    FieldPresenter.new message, field
  end
end
