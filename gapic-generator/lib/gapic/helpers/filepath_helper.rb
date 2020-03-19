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
    # Helpers related to generating paths to ruby files (e.g. for require)
    #
    module FilepathHelper
      ##
      # Converts a ruby namespace string to a file path string.
      def ruby_file_path api, namespace
        file_path = ruby_file_path_for_namespace namespace
        fix_file_path api, file_path
      end

      ##
      # Converts a ruby namespace string to a file path string.
      def ruby_file_path_for_namespace namespace
        ActiveSupport::Inflector.underscore namespace
      end

      ##
      # Corrects a namespace by replacing known bad values with good values.
      def fix_file_path api, file_path
        file_path.split("/").map { |node| api.fix_file_path node }.join("/")
      end
    end
  end
end
