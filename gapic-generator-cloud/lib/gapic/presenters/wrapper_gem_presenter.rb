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
          files = @api.generate_files
          files.map(&:services).flatten.map { |s| WrapperServicePresenter.new self, @api, s }
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
        deps = { "google-cloud-core" => "~> 1.5" }
        version_dependencies.each do |version, requirement|
          deps["#{name}-#{version}"] = "~> #{requirement}"
        end
        extra_deps = gem_config :extra_dependencies
        deps.merge! extra_deps if extra_deps
        deps
      end

      def google_cloud_short_name
        m = /^google-cloud-(.*)$/.match name
        return nil unless m
        m[1].tr "-", "_"
      end

      def docs_link version: nil, class_name: nil, text: nil
        gem_name = version ? "#{name}-#{version}" : name
        base_url = "https://googleapis.dev/ruby/#{gem_name}/latest"
        if class_name
          path = namespace.gsub "::", "/"
          path = "#{path}/#{version.capitalize}" if version
          class_path = class_name.gsub "::", "/"
          text ||= namespaced_class class_name, version: version
          return "[#{text}](#{base_url}/#{path}/#{class_path}.html)"
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
