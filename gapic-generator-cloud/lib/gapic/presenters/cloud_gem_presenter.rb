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
      # @private
      # A list of gem name patterns for gems that don't look like cloud but are
      PSEUDO_CLOUD_GEMS = [
        /^google-iam-credentials/,
        /^google-identity-access_context_manager/,
        /^grafeas/,
        /^stackdriver/
      ].freeze

      # @private
      # A list of gem name patterns for gems that look like cloud but aren't
      NON_CLOUD_GEMS = [].freeze

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
      # @return [String, nil]
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
          desc += " Note that #{name} is a version-specific client library. " \
                  "For most uses, we recommend installing the main client library " \
                  "#{wrapper_name} instead. See the readme for more details."
        end
        desc
      end

      def cloud_env_prefix
        env_prefix || "GOOGLE_CLOUD"
      end

      ##
      # Returns a hash of extra generator arguments to be rendered into the
      # repo-metadata.json file.
      #
      def generator_args_for_metadata
        result = {}
        result["ruby-cloud-description"] = description
        result["ruby-cloud-env-prefix"] = env_prefix if env_prefix
        result["ruby-cloud-product-url"] = product_documentation_url if product_documentation_url
        path_overrides = @api.overrides_of(:file_path).map { |k, v| "#{k}=#{v}" }.join ";"
        result["ruby-cloud-path-override"] = path_overrides unless path_overrides.empty?
        namespace_overrides = @api.overrides_of(:namespace).map { |k, v| "#{k}=#{v}" }.join ";"
        result["ruby-cloud-namespace-override"] = namespace_overrides unless namespace_overrides.empty?
        service_overrides = @api.overrides_of(:service).map { |k, v| "#{k}=#{v}" }.join ";"
        result["ruby-cloud-service-override"] = service_overrides unless service_overrides.empty?
        result
      end

      ##
      # Overrides the reference doc URL to point to either the cloud-rad page
      # or the googleapis.dev page depending on whether it is a cloud product.
      #
      # @return [String]
      #
      def library_documentation_url
        gem_config(:library_documentation_url) || begin
          if cloud_product?
            "https://cloud.google.com/ruby/docs/reference/#{name}/latest"
          else
            "https://googleapis.dev/ruby/#{name}/latest"
          end
        end
      end

      ##
      # Whether this gem is for a cloud platform product. This controls, for
      # example, whether the reference documentation appears under the
      # cloud.google.com website.
      #
      # This first uses the `is_cloud_product` config. If that isn't set, it
      # tries the overrides in the `PSEUDO_CLOUD_GEMS` and `NON_CLOUD_GEMS`
      # constants. Finally, it looks for whether any services populate the
      # `Google::Cloud` namespace.
      #
      # @return [boolean]
      #
      def cloud_product?
        configured = gem_config :is_cloud_product
        return configured unless configured.nil?
        return @api.api_metadata.organization == "CLOUD" if @api.api_metadata.organization
        return true if PSEUDO_CLOUD_GEMS.any? { |pattern| pattern === name }
        return false if NON_CLOUD_GEMS.any? { |pattern| pattern === name }
        services.any? do |service|
          service.namespace =~ /^(::)?Google::Cloud::/
        end
      end
    end

    def self.cloud_gem_presenter api
      CloudGemPresenter.new api
    end
  end
end
