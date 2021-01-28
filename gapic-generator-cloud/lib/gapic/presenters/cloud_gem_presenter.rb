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

require "gapic/presenters"
require "gapic/presenters/wrapper_service_presenter"

module Gapic
  module Presenters
    ##
    # A presenter subclass for cloud gems.
    #
    class CloudGemPresenter < GemPresenter
      def license_name
        "Apache-2.0"
      end

      def extra_files
        return ["README.md", "LICENSE.md", ".yardopts"] if generic_endpoint?
        ["README.md", "LICENSE.md", "AUTHENTICATION.md", ".yardopts"]
      end

      def dependencies
        deps = super
        deps["google-cloud-errors"] = "~> 1.0"
        deps
      end

      def wrapper_name
        minfo = /^(.+)-v\w+$/.match name
        minfo ? minfo[1] : nil
      end

      alias_method :readme_description, :description # rubocop:disable Style/Alias

      def description
        desc = readme_description
        if wrapper_name
          desc += " Note that #{name} is a version-specific client library." \
            " For most uses, we recommend installing the main client library" \
            " #{wrapper_name} instead. See the readme for more details."
        end
        desc
      end
    end

    def self.cloud_gem_presenter api
      CloudGemPresenter.new api
    end
  end
end
