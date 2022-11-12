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

      def initialize gem_presenter, api, package
        @gem_presenter = gem_presenter
        @api = api
        @package = package
      end

      def gem
        @gem_presenter
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

      ##
      # Services whose clients should be generated in this package namespace.
      # @return [Enumerable<Gapic::Presenters::ServicePresenter>]
      #
      def services
        @services ||= begin
          files = @api.generate_files.select { |f| f.package == @package }
          service_list = files.map(&:services).flatten
          mixin_service_names = gem.mixins_model.mixin_services
          service_list.delete_if { |s| mixin_service_names.include? s.full_name }
          # Omit common services in this package. Common service clients do not
          # go into their own package.
          normal_services = service_list.select { |s| @api.delegate_service_for(s).nil? }
          # But include common services that delegate to normal services in this package.
          common_services = normal_services.flat_map { |s| @api.common_services_for s }
          (normal_services + common_services).map { |s| ServicePresenter.new @gem_presenter, @api, s }
        end
      end

      ##
      # First service with REST bindings.
      # @return [Gapic::Presenters::ServicePresenter, nil]
      #
      def first_service_with_rest
        services.find { |s| s.methods_rest_bindings? }
      end

      def address
        @package.split "."
      end

      def package_require
        ruby_file_path @api, namespace
      end

      def package_file_path
        "#{package_require}.rb"
      end

      def package_directory_name
        package_require.split("/").last
      end

      def empty?
        services.empty?
      end

      def helpers_file_path
        "#{helpers_require}.rb"
      end

      def helpers_file_name
        "_helpers.rb"
      end

      def helpers_require
        "#{package_require}/_helpers"
      end

      ##
      # Returns a hash with a drift_manifest of this package
      # describing correspondence between the proto description
      # of the package with the generated code for the package.
      # See https://github.com/googleapis/googleapis/blob/master/gapic/metadata/gapic_metadata.proto
      #
      # @return [Hash]
      def drift_manifest
        {
          schema:         "1.0",
          comment:        "This file maps proto services/RPCs to the corresponding library clients/methods",
          language:       "ruby",
          protoPackage:   name,
          libraryPackage: namespace,
          services:       services.to_h { |s| [s.grpc_service_name, s.drift_manifest] }
        }
      end

      ##
      # How comments in the generated libraries refer to the GRPC client
      # if no REST code is generated, this should just be "client",
      # if REST code is generated, this should be disambiguated into the "GRPC client"
      #
      # Since we are using first service for an indication of whether package generates
      # REST code, it's OK to defer this to the first service as well.
      # For packages with no services the value of this does not really matter as
      # no client generation docs will be generated.
      #
      # @return [String]
      def grpc_client_designation
        services.first&.grpc_client_designation || ""
      end
    end
  end
end
