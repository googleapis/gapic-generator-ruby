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

require "active_support/inflector"

module SnippetTestHelper
  def build_proto_fragment klass, json
    return nil if json.nil?
    klass.new underscore_keys json
  end

  def underscore_keys input
    case input
    when Hash
      input.to_h { |key, value| [ActiveSupport::Inflector.underscore(key), underscore_keys(value)] }
    when Array
      input.map { |elem| underscore_keys elem }
    else
      input
    end
  end
end
