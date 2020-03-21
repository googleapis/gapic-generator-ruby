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
    class WrapperGemPresenter < GemPresenter
      def entrypoint_require
        namespace_require
      end

      def services
        @services ||= begin
          files = @api.generate_files
          files.map(&:services).flatten.map { |s| WrapperServicePresenter.new @api, s }
        end
      end

      def namespace_require
        ruby_file_path @api, namespace
      end

      def namespace_file_path
        "#{namespace_require}.rb"
      end

      def migration_version
        gem_config :migration_version
      end

      def pre_migration_version
        m = /^(\d)+\./.match migration_version.to_s
        return nil unless m
        "#{m[1].to_i - 1}.x"
      end

      def migration?
        migration_version ? true : false
      end

      def extra_files
        files = ["README.md", "AUTHENTICATION.md", "LICENSE.md", ".yardopts"]
        files << "MIGRATING.md" if migration?
        files
      end

      def factory_method_suffix
        gem_config(:factory_method_suffix).to_s
      end

      def version_dependencies
        gem_config(:version_dependencies).to_s.split(";").map { |str| str.split ":" }
      end

      def gem_version_dependencies
        version_dependencies.sort_by { |version, _requirement| version }
                            .map { |version, requirement| ["#{name}-#{version}", requirement] }
      end

      def versioned_gems
        gem_version_dependencies.map { |name, _requirement| name }
      end

      def default_version
        version_dependencies.first&.first
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
