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
require_relative "method_presenter"

module MethodHelper
  def method_presenter api, service, method
    MethodPresenter.new api, service, method
  end

  def method_name method
    ActiveSupport::Inflector.underscore method.name
  end

  def method_ivar method
    "@#{method_name method}"
  end

  def method_desc _method
    "TODO"
  end

  def method_lro? method
    method.descriptor.output_type == ".google.longrunning.Operation"
  end

  def method_streaming_bidi? method
    method.descriptor.client_streaming && method.descriptor.server_streaming
  end
end
