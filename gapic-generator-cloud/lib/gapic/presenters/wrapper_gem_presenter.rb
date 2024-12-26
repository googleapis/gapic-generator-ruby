# frozen_string_literal: true

# Copyright 2019 Google LLC
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

require "gapic/model/mixins"
require "gapic/presenters"
require "gapic/presenters/wrapper_service_presenter"

module Gapic
  module Presenters
    ##
    # A presenter for wrapper gems.
    #
    class WrapperGemPresenter < CloudGemPresenter
      def entrypoint_require
        namespace_require
      end

      def services
        @services ||= begin
          @api.generate_files
              .map(&:services)
              .flatten
              .map { |s| WrapperServicePresenter.new self, @api, s }
              .find_all { |s| !s.is_hosted_mixin? }
        end
      end

      def namespace_require
        ruby_file_path @api, namespace
      end

      def main_directory_name
        namespace_require.split("/").last
      end

      def helpers_require
        "#{namespace_require}/helpers"
      end

      def namespace_file_path
        "#{namespace_require}.rb"
      end

      def needs_entrypoint?
        name != namespace_require
      end

      def needs_default_config_block?
        needs_entrypoint? && !google_cloud_short_name.nil?
      end

      def migration_version
        gem_config :migration_version
      end

      ##
      # Generates a description text for README files, accounting for markdown
      # rendering, properly escaping variables and disabling xrefs in the wrapper.
      #
      # @return [Array<String>] The description text as an array of lines.
      #
      def readme_description
        has_markdown = description.strip.start_with? "#"
        desc = has_markdown ? description.split("\n") : [description.gsub(/\s+/, " ").strip]
        Gapic::FormattingUtils.format_doc_lines @api, desc, disable_xrefs: true
      end

      # A description of the versions prior to the migration version.
      # Could be "a.x" if the migration version is 1.0 or later, otherwise
      # falls back to "pre-a.b".
      def pre_migration_version
        match = /^(\d)+\.0/.match migration_version.to_s
        if match
          major = match[1].to_i
          return "#{major - 1}.x" if major.positive?
        end
        "pre-#{migration_version}"
      end

      def migration?
        migration_version ? true : false
      end

      def extra_files
        files = ["README.md", "LICENSE.md", ".yardopts"]
        files.insert 1, "AUTHENTICATION.md" unless generic_endpoint?
        files.append "MIGRATING.md" if migration?
        files
      end

      def factory_method_suffix
        gem_config(:factory_method_suffix).to_s
      end

      def version_dependencies
        gem_config(:version_dependencies).to_s.split(";").map { |str| str.split ":" }
      end

      def versioned_gems
        version_dependencies.map { |version, _requirement| "#{name}-#{version}" }.sort
      end

      def default_version
        version_dependencies.first&.first
      end

      def default_versioned_gem
        versioned_gems.first
      end

      def dependencies
        @dependencies ||= begin
          deps = { "google-cloud-core" => "~> 1.6" }
          version_dependencies.each do |version, requirement|
            # For pre-release dependencies on versioned clients, support both
            # 0.x and 1.x versions to ease the transition to 1.0 (GA) releases
            # for those dependencies. (Note the 0.x->1.0 transition is
            # generally not breaking.)
            deps["#{name}-#{version}"] =
              if requirement.start_with? "0."
                [">= #{requirement}", "< 2.a"]
              else
                "~> #{requirement}"
              end
          end
          extra_deps = gem_config_dependencies
          deps.merge! extra_deps if extra_deps
          deps
        end
      end

      def google_cloud_short_name
        m = /^google-cloud-(.*)$/.match name
        return nil unless m
        m[1].tr "-", "_"
      end

      def docs_link version: nil, class_name: nil, text: nil, gem_name: nil
        gem_name ||= version ? "#{name}-#{version}" : name
        base_url =
          if cloud_product?
            "https://cloud.google.com/ruby/docs/reference/#{gem_name}/latest"
          else
            "https://rubydoc.info/gems/#{gem_name}"
          end
        if class_name
          separator = cloud_product? ? "-" : "/"
          path = namespace.gsub "::", separator
          path = "#{path}#{separator}#{version.capitalize}" if version
          class_path = class_name.gsub "::", separator
          text ||= namespaced_class class_name, version: version
          return "[#{text}](#{base_url}/#{path}#{separator}#{class_path})"
        end
        "[#{text || name}](#{base_url})"
      end

      def namespaced_class name, version: nil
        base = version ? "#{namespace}::#{version.capitalize}" : namespace
        "#{base}::#{name}"
      end
    end

    def self.wrapper_gem_presenter api
      WrapperGemPresenter.new api
    end
  end
end
