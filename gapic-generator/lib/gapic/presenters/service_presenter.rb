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
        @nonstandard_lro = api.nonstandard_lro_model_for service.full_name
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

      ##
      # @return [Boolean]
      #
      def is_deprecated?
        @service.is_deprecated?
      end

      ##
      # @return [Enumerable<Gapic::Presenters::MethodPresenter>]
      #
      def methods
        @methods ||= @service.methods.map { |m| MethodPresenter.new self, @api, m }
      end

      ##
      # The address of this service split into an array
      #
      # @return [Array<String>]
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

      ##
      # Deduplicate resource presenters by combining resources with the same
      # name. If multiple resources have the same name (though possibly
      # different namespaces, e.g. `location.googleapis.com/Location` vs
      # `documentai.googleapis.com/Location`), this combines (and dedups) their
      # patterns into a single resource presenter.
      #
      # Used for generating path helpers while avoiding duplicate method names.
      #
      def deduped_references
        @deduped_references ||= begin
          hash = {}
          references.each do |resource|
            if hash.key? resource.name
              existing = hash[resource.name]
              resource.patterns.each do |pat|
                unless existing.patterns.any? { |epat| epat.pattern_template == pat.pattern_template }
                  existing.patterns << pat
                end
              end
            else
              hash[resource.name] = resource.dup
            end
          end
          hash.values
        end
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

      ##
      # @return [Boolean] Whether the generation of REST clients is requested
      #
      def generate_rest_clients?
        @api.generate_rest_clients?
      end

      ##
      # @return [Boolean] Whether the generation of gRPC clients is requested
      #
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
      #   List of methods for which REST bindings are present and REST methods can be generated
      #
      def methods_rest_bindings
        methods.select(&:can_generate_rest?)
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

      ##
      # Whether an AIP-151 LRO subclient needs to be generated for this service
      #
      # @return [Boolean]
      def lro?
        methods.find(&:lro?)
      end

      ##
      # A variable name used for the AIP-151 LRO subclients
      #
      # @return [String]
      def lro_client_var
        "operations_client"
      end

      ##
      # An instance variable name used for the AIP-151 LRO subclients
      #
      # @return [String]
      def lro_client_ivar
        "@#{lro_client_var}"
      end

      ##
      # A presenter for the LRO subclient if needed
      #
      # @return [Gapic::Presenters::Service::LroClientPresenter, nil]
      def lro_client_presenter
        return nil unless lro?
        Gapic::Presenters::Service::LroClientPresenter.new service: "google.longrunning.operations",
                                                           client_class_name: "Operations",
                                                           client_class_docname: operations_name_full,
                                                           client_var_name: lro_client_var,
                                                           require_str: operations_file_path,
                                                           service_description: "long-running operations"
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

      def grpc_service_config_presenter
        GrpcServiceConfigPresenter.new grpc_service_config
      end

      ##
      # The short proto name for this service
      #
      # @return [String]
      def grpc_service_name
        @service.name
      end

      ##
      # The full proto name for this service
      #
      # @return [String]
      def grpc_full_name
        @service.full_name
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
              rpcs:       methods.to_h { |m| [m.grpc_method_name, m.drift_manifest] }
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

      ##
      # The method to use for quick start samples. Normally this is simply the
      # first non-client-streaming method defined, but it can be overridden via
      # a gem config.
      #
      # @return [Gapic::Presenters::MethodPresenter]
      #
      def quick_start_method
        gem_config = @api.configuration[:gem]
        preferred_method = gem_config[:quick_start_method] if gem_config
        result = methods.find { |meth| meth.name == preferred_method } if preferred_method
        result || methods.find { |meth| !meth.client_streaming? }
      end

      ##
      # Returns this service presenter if there is a grpc client. Otherwise,
      # returns the corresponding rest service presenter if there isn't a grpc
      # client but there is a rest client. Otherwise, returns nil if there is
      # neither client.
      #
      # @return [ServicePresenter,ServiceRestPresenter,nil]
      #
      def usable_service_presenter
        if @api.generate_grpc_clients?
          self
        elsif @api.generate_rest_clients? && methods_rest_bindings?
          rest
        end
      end

      ##
      # Whether there are mixin services that should be referenced
      # in the client for this service
      #
      # @return [Boolean]
      #
      def mixins?
        @gem_presenter.mixins?
      end


      ##
      # Whether this service presenter is a mixin inside a host service's gem
      # (and not in its own gem)
      #
      # @return [Boolean]
      #
      def is_hosted_mixin?
        Gapic::Model::Mixins.mixin_service_address? address, gem_address: @gem_presenter.address
      end

      ##
      # Whether this service presenter is a mixin inside it's own gem
      # (and not in another service's gem)
      #
      # @return [Boolean]
      #
      def is_main_mixin_service?
        Gapic::Model::Mixins.mixin_service_address?(address) && !Gapic::Model::Mixins.mixin_service_address?(address, gem_address: @gem_presenter.address)
      end

      ##
      # The mixin services that should be referenced
      # in the client for this service
      #
      # @return [Enumerable<Gapic::Model::Mixins::Mixin>]
      #
      def mixins
        @gem_presenter.mixins_model.mixins
      end

      ##
      # Name of the nonstandard LRO module
      #
      # @return [String]
      #
      def nonstandard_lro_name
        "NonstandardLro"
      end

      ##
      # Full name of the nonstandard LRO module
      #
      # @return [String]
      #
      def nonstandard_lro_name_full
        fix_namespace @api, "#{service_name_full}::#{nonstandard_lro_name}"
      end

      ##
      # Full file path to the nonstandard LRO module
      #
      # @return [String]
      #
      def nonstandard_lro_file_path
        "#{nonstandard_lro_require}.rb"
      end

      ##
      # File name of the nonstandard LRO module
      #
      # @return [String]
      #
      def nonstandard_lro_file_name
        nonstandard_lro_file_path.split("/").last
      end

      ##
      # The require string for the nonstandard LRO module
      #
      # @return [String]
      #
      def nonstandard_lro_require
        ruby_file_path @api, "#{service_name_full}::#{nonstandard_lro_name}"
      end

      ##
      # Nonstandard lro model for this service
      #
      # @return [Gapic::Model::Service::NonstandardLro, Gapic::Model::Service::NoLro]
      def nonstandard_lro
        @nonstandard_lro
      end

      ##
      # The Ruby name for the polling method of the nonstandard LRO provided by this service
      #
      # @return [String]
      def nonstandard_lro_polling_method_name
        return unless nonstandard_lro_provider?
        methods.find { |m| m.grpc_method_name == nonstandard_lro.polling_method_name }.name
      end

      ##
      # Whether this service is a provider of the nonstandard LRO functionality
      #
      # @return [Boolean]
      def nonstandard_lro_provider?
        @nonstandard_lro.nonstandard_lro?
      end

      ##
      # Whether one or more methods of this service use the nonstandard LRO functionality
      #
      # @return [Boolean]
      def nonstandard_lro_consumer?
        methods.find(&:nonstandard_lro?) || false
      end

      ##
      # The client presenters of the nonstandard LROs that are used by the methods of this service
      #
      # @return [Enumerable<Gapic::Presenters::Service::LroClientPresenter>]
      def nonstandard_lros
        return [] unless nonstandard_lro_consumer?
        nonstandard_lros_models.map do |lro|
          lro_wrapper = @api.lookup lro.service_full_name
          lro_service = ServicePresenter.new(@gem_presenter, @api, lro_wrapper)

          service_description = "long-running operations via #{lro_service.name}"
          Gapic::Presenters::Service::LroClientPresenter.new service: lro.service_full_name,
                                                             client_class_name: lro_service.client_name_full,
                                                             client_class_docname: lro_service.client_name_full,
                                                             client_var_name: lro_service.service_directory_name,
                                                             require_str: lro_service.service_require,
                                                             service_description: service_description,
                                                             helper_type: lro_service.nonstandard_lro_name_full
        end
      end

      ##
      # Whether there are any subclients to generate with this service.
      # Subclients are the clients to other services (e.g. an LRO provider service).
      #
      # @return [Boolean]
      def subclients?
        subclients.any?
      end

      ##
      # Subclients for this service
      # Subclients are the clients to other services (e.g. an LRO provider service).
      #
      # The following is typically generated for a subclient:
      # - a require statement for the subclient's class
      # - a class-level variable in the host service's client
      # - a code to initialize this variable with a subclient's class instance in the host service's constructor
      #
      # @return [Enumerable<Gapic::Presenters::Service::LroClientPresenter, Gapic::Model::Mixins::Mixin>]
      def subclients
        ([] << lro_client_presenter << mixins << nonstandard_lros).flatten.compact
      end

      ##
      # @private
      # The nonstandard LRO models for the nonstandard LROs that are used by the methods of this service
      #
      # @return [Enumerable<Gapic::Model::Method::Lro>]
      def nonstandard_lros_models
        return [] unless nonstandard_lro_consumer?
        methods.select(&:nonstandard_lro?).map(&:lro).uniq(&:service_full_name)
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
