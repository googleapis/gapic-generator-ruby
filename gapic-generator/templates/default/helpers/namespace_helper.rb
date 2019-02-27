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

module NamespaceHelper
  def namespace_for api
    api.address.each do |namespace|
      puts "module #{namespace}"
    end

    yield

    api.address.each do |_namespace|
      puts "end"
    end
  end

  ##
  # Converts an array or dot-separated namespace string to a new string with
  # forward-slash separators.
  def ruby_path namespaces
    namespaces = namespaces.split "." if namespaces.is_a? String
    namespaces.reject(&:empty?).map(&:underscore).join "/"
  end

  ##
  # Converts an array or dot-separated namespace string to a new string with
  # Ruby double-semicolon separators.
  def ruby_namespace namespaces
    namespaces = namespaces.split "." if namespaces.is_a? String
    namespaces.reject(&:empty?).map(&:upcase_first).join "::"
  end
end
