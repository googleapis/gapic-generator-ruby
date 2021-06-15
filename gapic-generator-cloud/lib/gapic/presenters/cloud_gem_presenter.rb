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

      ##
      # Whether this gem has a wrapper
      # @return [Boolean]
      def has_wrapper?
        !wrapper_name.nil?
      end

      ##
      # The name of the wrapper gem corresponding to this versioned gem
      # @return [String, Nil]
      #
      def wrapper_name
        return @api.wrapper_gem_name_override if @api.wrapper_gem_name_override?

        minfo = /^(.+)-v\d\w*$/.match name
        minfo ? minfo[1] : nil
      end

      alias_method :readme_description, :description # rubocop:disable Style/Alias

      ##
      # Overrides the gemspec description including a note that users should
      # consider installing the wrapper instead of this versioned gem.
      #
      # Note: The method `readme_description` was aliased to the superclass
      # method because the description without this note is used in the readme.
      #
      # @return [String]
      #
      def description
        desc = readme_description
        if has_wrapper?
          desc += " Note that #{name} is a version-specific client library." \
            " For most uses, we recommend installing the main client library" \
            " #{wrapper_name} instead. See the readme for more details."
        end
        desc
      end

      ##
      # Returns a hash of extra generator arguments to be rendered into the
      # repo-metadata.json file.
      #
      def generator_args_for_metadata
        result = {}
        result["ruby-cloud-description"] = description
        result["ruby-cloud-env-prefix"] = env_prefix
        result["ruby-cloud-product-url"] = product_documentation_url if product_documentation_url
        path_overrides = @api.overrides_of(:file_path).map { |k, v| "#{k}=#{v}" }.join ";"
        result["ruby-cloud-path-override"] = path_overrides unless path_overrides.empty?
        namespace_overrides = @api.overrides_of(:namespace).map { |k, v| "#{k}=#{v}" }.join ";"
        result["ruby-cloud-namespace-override"] = namespace_overrides unless namespace_overrides.empty?
        result
      end
    end

    def self.cloud_gem_presenter api
      CloudGemPresenter.new api
    end
  end
end
