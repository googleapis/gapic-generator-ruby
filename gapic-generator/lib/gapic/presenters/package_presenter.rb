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

require "active_support/inflector"
require "gapic/helpers/filepath_helper"
require "gapic/helpers/namespace_helper"

module Gapic
  module Presenters
    ##
    # A presenter for proto packages.
    #
    class PackagePresenter
      include Gapic::Helpers::FilepathHelper
      include Gapic::Helpers::NamespaceHelper

      def initialize api, package
        @api = api
        @package = package
      end

      def gem
        GemPresenter.new @api
      end

      def name
        @package
      end

      def namespace
        return services.first&.namespace if services.first&.namespace
        ruby_namespace_for_address address
      end

      def parent_namespace
        namespace.split("::")[0...-1].join("::")
      end

      def module_name
        namespace.split("::").last
      end

      # Services whose clients should be generated in this package namespace.
      def services
        @services ||= begin
          files = @api.generate_files.select { |f| f.package == @package }
          services = files.map(&:services).flatten
          # Omit common services in this package. Common service clients do not
          # go into their own package.
          normal_services = services.select { |s| @api.delegate_service_for(s).nil? }
          # But include common services that delegate to normal services in this package.
          common_services = normal_services.flat_map { |s| @api.common_services_for s }
          (normal_services + common_services).map { |s| ServicePresenter.new @api, s }
        end
      end

      def address
        @package.split "."
      end

      def package_require
        ruby_file_path @api, namespace
      end

      def package_file_path
        package_require + ".rb"
      end

      def empty?
        services.empty?
      end
    end
  end
end
