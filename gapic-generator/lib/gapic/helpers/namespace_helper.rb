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

module Gapic
  module Helpers
    ##
    # Helpers related to generating ruby namespaces
    #
    module NamespaceHelper
      ##
      # Looks up the ruby_package for a dot-separated address string to a new string
      # and creates the corrected Ruby namespace
      def ruby_namespace api, address
        file = api.file_for address
        address = address.dup
        address[file.package] = file.ruby_package if file.ruby_package.present?
        namespace = ruby_namespace_for_address address
        fix_namespace api, namespace
      end

      ##
      # Converts an array or dot-separated address string to a new string with
      # Ruby double-semicolon separators.
      def ruby_namespace_for_address address
        address = address.split "." if address.is_a? String
        ensure_absolute_namespace address.reject(&:empty?).map(&:camelize).join("::")
      end

      ##
      # Returns the given namespace, ensuring double colons are prepended
      #
      def ensure_absolute_namespace namespace
        namespace.start_with?("::") ? namespace : "::#{namespace}"
      end

      ##
      # Corrects a namespace by replacing known bad values with good values.
      def fix_namespace api, namespace
        namespace.split("::").map { |node| api.fix_namespace node }.join("::")
      end
    end
  end
end
