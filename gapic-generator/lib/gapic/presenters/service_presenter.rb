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
    # A presenter for proto services.
    #
    class ServicePresenter
      include Gapic::Helpers::FilepathHelper
      include Gapic::Helpers::NamespaceHelper

      # @return [Gapic::Presenters::ServiceRestPresenter]
      attr_reader :rest

      def initialize gem_presenter, api, service, parent_service: nil
        @gem_presenter = gem_presenter
        @api = api
        @service = service
        @parent_service = parent_service
        @rest = ServiceRestPresenter.new self, api
      end

      def gem
        @gem_presenter
      end

      def file
        FilePresenter.new @api, @service.parent
      end

      def package
        PackagePresenter.new @gem_presenter, @api, @service.parent.package
      end

      def is_deprecated?
        @service.is_deprecated?
      end

      ##
      # @return [Enumerable<Gapic::Presenters::MethodPresenter>]
      #
      def methods
        @methods ||= @service.methods.map { |m| MethodPresenter.new self, @api, m }
      end

      def address
        @service.address
      end

      # Returns a presenter for this service's delegate (if it is a common service)
      # otherwise returns `nil`.
      def common_service_delegate
        unless defined? @common_service_delegate
          delegate = @api.delegate_service_for @service
          @common_service_delegate = delegate ? ServicePresenter.new(@gem_presenter, @api, delegate) : nil
        end
        @common_service_delegate
      end

      # The namespace of the client. Normally this is the version module. This
      # may be different from the proto namespace for a common service.
      def namespace
        # If this service is a common service, its client should go into its
        # delegate's namespace rather than its own. For example, KMS includes
        # the common IAMPolicy service, but that service's client should go
        # into the KMS namespace.
        return common_service_delegate.namespace if common_service_delegate

        return ensure_absolute_namespace @service.ruby_package if @service.ruby_package.present?

        namespace = ruby_namespace_for_address @service.address[0...-1]
        fix_namespace @api, namespace
      end

      def version
        ActiveSupport::Inflector.camelize @service.address[-2]
      end

      def doc_description disable_xrefs: false
        @service.docs_leading_comments disable_xrefs: disable_xrefs
      end

      def name
        @api.fix_service_name @service.name
      end

      # The namespace of the protos. This may be different from the client
      # namespace for a common service.
      def proto_namespace
        return ensure_absolute_namespace @service.ruby_package if @service.ruby_package.present?

        namespace = ruby_namespace_for_address @service.address[0...-1]
        @api.override_proto_namespaces? ? fix_namespace(@api, namespace) : namespace
      end

      def proto_service_name_full
        name_full = "#{proto_namespace}::#{@service.name}"
        @api.override_proto_namespaces? ? fix_namespace(@api, name_full) : name_full
      end

      def module_name
        service_name_full.split("::").last
      end

      def proto_service_file_path
        @service.parent.name.sub ".proto", "_pb.rb"
      end

      def proto_service_file_name
        proto_service_file_path.split("/").last
      end

      def proto_service_require
        proto_service_file_path.sub ".rb", ""
      end

      def proto_services_file_path
        @service.parent.name.sub ".proto", "_services_pb.rb"
      end

      def proto_services_file_name
        proto_services_file_path.split("/").last
      end

      def proto_services_require
        proto_services_file_path.sub ".rb", ""
      end

      def proto_service_stub_name_full
        "#{proto_service_name_full}::Stub"
      end

      def service_name_full
        fix_namespace @api, "#{namespace}::#{name}"
      end

      def service_file_path
        "#{service_require}.rb"
      end

      def service_file_name
        service_file_path.split("/").last
      end

      def service_directory_name
        service_require.split("/").last
      end

      def service_require
        ruby_file_path @api, service_name_full
      end

      def client_name
        "Client"
      end

      def client_name_full
        fix_namespace @api, "#{service_name_full}::#{client_name}"
      end

      def create_client_call
        "#{client_name_full}.new"
      end

      def configure_client_call
        "#{client_name_full}.configure"
      end

      def client_require
        ruby_file_path @api, client_name_full
      end

      def client_file_path
        "#{client_require}.rb"
      end

      def client_file_name
        client_file_path.split("/").last
      end

      def client_endpoint
        return nil if generic_endpoint?
        @parent_service&.client_endpoint ||
          common_service_delegate&.client_endpoint ||
          @service.host ||
          default_config(:default_host) ||
          "localhost"
      end

      def generic_endpoint?
        gem.generic_endpoint?
      end

      def client_scopes
        common_service_delegate&.client_scopes ||
          @service.scopes ||
          default_config(:oauth_scopes) ||
          []
      end

      def credentials_name
        "Credentials"
      end

      def credentials_name_full
        fix_namespace @api, "#{service_name_full}::#{credentials_name}"
      end

      def credentials_class_xref
        "{#{credentials_name_full}}"
      end

      def credentials_file_path
        "#{credentials_require}.rb"
      end

      def credentials_file_name
        credentials_file_path.split("/").last
      end

      def credentials_require
        ruby_file_path @api, credentials_name_full
      end

      def helpers_file_path
        "#{helpers_require}.rb"
      end

      def helpers_file_name
        "helpers.rb"
      end

      def helpers_require
        ruby_file_path @api, "#{service_name_full}::Helpers"
      end

      def references
        @references ||= @service.resources.map { |resource| ResourcePresenter.new resource }.sort_by(&:name)
      end

      def paths?
        references.any?
      end

      def paths_name
        "Paths"
      end

      def paths_name_full
        fix_namespace @api, "#{service_name_full}::#{paths_name}"
      end

      def paths_file_path
        "#{paths_require}.rb"
      end

      def paths_file_name
        paths_file_path.split("/").last
      end

      def paths_require
        ruby_file_path @api, "#{service_name_full}::#{paths_name}"
      end

      def generate_rest_clients?
        @api.generate_rest_clients?
      end

      def generate_grpc_clients?
        @api.generate_grpc_clients?
      end

      ##
      # @return [Boolean] whether this service contains any methods with REST bindings
      #
      def methods_rest_bindings?
        methods_rest_bindings.any?
      end

      ##
      # @return [Enumerable<Gapic::Presenters::MethodPresenter>]
      #   List of mods for which REST bindings are present and REST methods can be generated
      #
      def methods_rest_bindings
        methods.select { |method| method.rest.path? && method.rest.verb? }
      end

      def test_client_file_path
        service_file_path.sub ".rb", "_test.rb"
      end

      def test_paths_file_path
        service_file_path.sub ".rb", "_paths_test.rb"
      end

      def test_client_operations_file_path
        service_file_path.sub ".rb", "_operations_test.rb"
      end

      def stub_name
        "#{ActiveSupport::Inflector.underscore name}_stub"
      end

      def lro?
        methods.find(&:lro?)
      end

      def lro_client_var
        "operations_client"
      end

      def lro_client_ivar
        "@#{lro_client_var}"
      end

      def operations_name
        "Operations"
      end

      def operations_name_full
        fix_namespace @api, "#{service_name_full}::#{operations_name}"
      end

      def operations_file_path
        "#{operations_require}.rb"
      end

      def operations_file_name
        operations_file_path.split("/").last
      end

      def operations_require
        ruby_file_path @api, "#{service_name_full}::#{operations_name}"
      end

      def lro_service
        lro = @service.parent.parent.files.find { |file| file.name == "google/longrunning/operations.proto" }
        return ServicePresenter.new @gem_presenter, @api, lro.services.first, parent_service: self unless lro.nil?
      end

      def config_channel_args
        { "grpc.service_config_disable_resolution" => 1 }
      end

      def grpc_service_config
        return unless @api.grpc_service_config&.service_level_configs&.key? grpc_full_name
        @api.grpc_service_config.service_level_configs[grpc_full_name]
      end

      ##
      # The short proto name for this service
      #
      # @return [String]
      def grpc_service_name
        @service.name
      end

      def grpc_full_name
        @service.address.join "."
      end

      ##
      # Returns a hash with a drift_manifest of this service,
      # describing correspondence between the proto description
      # of the service with the generated code for the service.
      # See https://github.com/googleapis/googleapis/blob/master/gapic/metadata/gapic_metadata.proto
      #
      # @return [Hash]
      def drift_manifest
        {
          clients: {
            grpc: {
              libraryClient: client_name_full,
              # The methods should grouped by grpc_method_name and then
              # their names are returned together in an array.
              # For Ruby currently we have 1:1 proto to code
              # correspondence for methods, so our generation is easier
              rpcs:       methods.map { |m| [m.grpc_method_name, m.drift_manifest] }.to_h
            }
          }
        }
      end

      ##
      # How comments in the generated libraries refer to the GRPC client
      # if no REST code is generated, this should just be "client",
      # if REST code is generated, this should be disambiguated into the "GRPC client"
      #
      # @return [String]
      def grpc_client_designation
        generate_rest_clients? ? "GRPC client" : "client"
      end

      private

      def default_config key
        return unless @service.parent.parent.configuration[:defaults]
        return unless @service.parent.parent.configuration[:defaults][:service]

        @service.parent.parent.configuration[:defaults][:service][key]
      end
    end
  end
end
