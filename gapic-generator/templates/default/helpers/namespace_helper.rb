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

module NamespaceHelper
  ##
  # Converts an array or dot-separated address string to a new string with
  # forward-slash separators.
  def ruby_path_for_address address
    address = address.split "." if address.is_a? String
    address.reject(&:empty?).map(&:underscore).join "/"
  end

  ##
  # Converts an array or dot-separated address string to a new string with
  # Ruby double-semicolon separators.
  def ruby_namespace_for_address address
    address = address.split "." if address.is_a? String
    address.reject(&:empty?).map(&:camelize).join "::"
  end
end
