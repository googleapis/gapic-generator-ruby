# frozen_string_literal: true

# Copyright 2021 Google LLC
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
    # A presenter for proto service (REST submethods)
    #
    class ServiceRestPresenter
      include Gapic::Helpers::FilepathHelper
      include Gapic::Helpers::NamespaceHelper

      ##
      # @param main_service [Gapic::Presenters::ServicePresenter]
      # @param api [Gapic::Schema::Api]
      #
      def initialize main_service, api
        @main_service = main_service
        @api = api
      end

      ##
      # Ruby name of this service
      #
      # @return [String]
      #
      def name
        main_service.name
      end

      ##
      # Full Ruby name of this service
      #
      # @return [String]
      #
      def service_name_full
        fix_namespace api, "#{main_service.service_name_full}::Rest"
      end

      ##
      # Require path for this service
      #
      # @return [String]
      #
      def service_require
        ruby_file_path @api, service_name_full
      end

      ##
      # Folder name for this service
      #
      # @return [String]
      #
      def service_directory_name
        service_require.split("/")[-2]
      end

      ##
      # @return [String]
      #
      def service_stub_name
        "ServiceStub"
      end

      ##
      # @return [String]
      #
      def service_stub_name_full
        fix_namespace api, "#{service_name_full}::#{service_stub_name}"
      end

      ##
      # @return [String]
      #
      def service_stub_require
        ruby_file_path api, service_stub_name_full
      end

      ##
      # @return [String]
      #
      def service_stub_file_path
        "#{service_stub_require}.rb"
      end

      ##
      # @return [String]
      #
      def client_name
        main_service.client_name
      end

      ##
      # @return [String]
      #
      def client_name_full
        fix_namespace api, "#{service_name_full}::#{client_name}"
      end

      ##
      # @return [String]
      #
      def client_require
        ruby_file_path api, client_name_full
      end

      ##
      # @return [String]
      #
      def client_file_path
        "#{client_require}.rb"
      end

      ##
      # @return [String]
      #
      def create_client_call
        "#{client_name_full}.new"
      end

      ##
      # @return [String]
      #
      def service_rest_require
        ruby_file_path api, service_name_full
      end

      ##
      # @return [String]
      #
      def service_rest_file_path
        "#{service_rest_require}.rb"
      end

      ##
      # @return [String]
      #
      def test_client_file_path
        main_service.service_file_path.sub ".rb", "_rest_test.rb"
      end

      ##
      # @return [String]
      #
      def credentials_class_xref
        main_service.credentials_class_xref
      end

      ##
      # @return [String]
      #
      def configure_client_call
        "#{client_name_full}.configure"
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
      # Whether this service is a provider of the nonstandard LRO functionality
      #
      # @return [Boolean]
      def nonstandard_lro_provider?
        main_service.nonstandard_lro_provider?
      end

      def lro_service
        main_service.lro_service
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

      ##
      # Whether an AIP-151 LRO subclient needs to be generated for this service
      #
      # @return [Boolean]
      def lro?
        methods.find(&:lro?)
      end

      def lro_client_var
        main_service.lro_client_var
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

      def operations_stub_name
        "OperationsServiceStub"
      end

      ##
      # The client presenters of the nonstandard LROs that are used by the methods of this service
      #
      # @return [Enumerable<Gapic::Presenters::Service::LroClientPresenter>]
      def nonstandard_lros
        return [] unless main_service.nonstandard_lro_consumer?
        main_service.nonstandard_lros_models.map do |lro|
          lro_wrapper = @api.lookup lro.service_full_name
          lro_service = ServicePresenter.new(@gem_presenter, @api, lro_wrapper).rest

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
      # The client presenters of the mixin services that are used by the methods of this service
      #
      # @return [Enumerable<Gapic::Presenters::Service::LroClientPresenter>]
      def mixin_presenters
        return [] unless main_service.mixins?
        main_service.mixins.map do |mixin|
          Gapic::Presenters::Service::LroClientPresenter.new service: mixin.service,
                                                             client_class_name: mixin.client_class_name_rest,
                                                             client_class_docname: mixin.client_class_docname_rest,
                                                             client_var_name: mixin.client_var_name,
                                                             require_str: mixin.require_str_rest,
                                                             service_description: mixin.service_description,
                                                             helper_type: ""
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
        ([] << lro_client_presenter << mixin_presenters << nonstandard_lros).flatten.compact
      end

      ##
      # The method to use for quick start samples. Normally this is simply the
      # first non-client-streaming method defined, but it can be overridden via
      # a gem config.
      #
      # @return [Gapic::Presenters::MethodRestPresenter] if there is a method
      #     appropriate for quick start
      # @return [nil] if there is no method appropriate for quick start
      #
      def quick_start_method
        main_service.quick_start_method&.rest
      end

      ##
      # Presenters for methods that can be generated in REST clients.
      #
      # @return [Enumerable<Gapic::Presenters::MethodPresenter>]
      #
      def methods
        main_service.methods.select(&:can_generate_rest?)
      end

      ##
      # Whether this rest service should send the numeric enums signal
      # @return [Boolean]
      #
      def numeric_enums?
        main_service.gem.rest_numeric_enums?
      end

      private

      # @return [Gapic::Presenters::ServicePresenter]
      attr_reader :main_service
      # @return [Gapic::Schema::Api]
      attr_reader :api
    end
  end
end
