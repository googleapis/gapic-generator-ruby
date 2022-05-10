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

module Gapic
  module Model
    # Aggregated information about the mixin services
    # that should be referenced from their gems in the
    # generated client libraries
    class Mixins
      # LRO might be specified in the mixins but it is not generated
      # as a mixin
      LRO_SERVICE = "google.longrunning.Operations"

      # Locations and Iam are generated as mixins
      LOCATIONS_SERVICE = "google.cloud.location.Locations"
      IAM_SERVICE = "google.iam.v1.IAMPolicy"

      # @return [Enumerable<String>] List of services from the Api model
      attr_accessor :api_services

      ##
      # @param api_services [Enumerable<String>]
      #   List of services from the  Api model
      # @param service_config [Google::Api::Service]
      #   The service config
      def initialize api_services, service_config
        @api_services = api_services
        @service_config = service_config
      end

      # @return [Boolean] Whether there are any mix-in services
      def mixins?
        mixin_services.any?
      end

      # @return [Enumerable<Mixin>]
      #   List of Mixin objects, providing the information that is needed
      #   to add the mixin service references to the generated library
      def mixins
        @mixins ||= mixin_services.map { |service| create_mixin(service) }
      end

      # @return [Enumerable<String>] Full proto names of the mix-in services
      def mixin_services
        @mixin_services ||= (services_in_config & SERVICE_TO_DEPENDENCY.keys)
      end

      # @return [Hash<String, String>]
      #   Aggregated dependencies for the mix-in services
      def dependencies
        @dependencies ||= mixins.reduce({}) { |deps, mixin| deps.merge mixin.dependency }
      end

      # Model of a single mixin service
      # @!attribute [r] service
      #   Full name of the service
      #   @return [String]
      # @!attribute [r] dependency
      #   Service dependencies, in the
      #   `{ gem_name => version pattern }` format
      #   @return [Hash<String, String>]
      # @!attribute [r] require_str
      #   Path to `require` the client of the service
      #   @return [String]
      # @!attribute [r] client_class_name
      #   Full name of the class of the client of the service
      #   @return [String]
      # @!attribute [r] client_class_docname
      #   Name of the class as it should appear in the documentation
      #   @return [String]
      # @!attribute [r] client_var_name
      #   Name for the variable for the client of the
      #   mixin service to use when generating library's service
      #   @return [String]
      class Mixin
        attr_reader :service
        attr_reader :dependency
        attr_reader :require_str
        attr_reader :client_class_name
        attr_reader :client_class_docname
        attr_reader :client_var_name

        # @param service [String]
        #   Full name of the service
        # @param dependency [Hash<String, String>]
        #   Service dependencies, in the
        #   `{ gem_name => version pattern }` format
        # @param require_str [String]
        #   Path to require the client of the service
        # @param client_class_name [String]
        #   Full name of the class of the client of the service
        # @param client_var_name [String]
        #   Name for the variable for the client of the mixin service
        #   to use when generating library's service
        def initialize service, dependency, require_str, client_class_name, client_var_name
          @service = service
          @dependency = dependency
          @require_str = require_str
          @client_class_name = client_class_name
          @client_class_docname = client_class_name # For mixins, the doc name should be the full class name
          @client_var_name = client_var_name
        end

        # @return [String] The description to place in the comments to the
        #   mixin's attribute in the library services's client class
        def service_description
          "mix-in of the #{client_class_name.split('::')[-2]}"
        end
      end

      private

      # @return [Enumerable<String>] Names of all services that are specified
      #   in the Service Config. These include mixin services, as well as
      #   some, all, or none of the library's own services
      def services_in_config
        return [] unless @service_config&.apis
        @service_config.apis.map(&:name)
      end

      # Since mixins are scope-limited to a couple of services, it is easier to
      # have these in lookup tables than to construct a ServicePresenter

      SERVICE_TO_DEPENDENCY = {
        LOCATIONS_SERVICE => { "google-cloud-location" => [">= 0.0", "< 2.a"] },
        IAM_SERVICE => { "google-iam-v1" => [">= 0.0", "< 2.a"] }
      }.freeze

      SERVICE_TO_REQUIRE_STR = {
        LOCATIONS_SERVICE => "google/cloud/location",
        IAM_SERVICE => "google/iam/v1/iam_policy"
      }.freeze

      SERVICE_TO_CLIENT_CLASS_NAME = {
        LOCATIONS_SERVICE => "Google::Cloud::Location::Locations::Client",
        IAM_SERVICE => "Google::Iam::V1::IAMPolicy::Client"
      }.freeze

      SERVICE_TO_CLIENT_ATTR_NAME = {
        LOCATIONS_SERVICE => "location_client",
        IAM_SERVICE => "iam_policy_client"
      }.freeze

      # @param service [String] full grpc name of the service
      # @raise [ModelError]
      # @return [Mixin]
      def create_mixin service
        unless SERVICE_TO_DEPENDENCY.key?(service) &&
               SERVICE_TO_REQUIRE_STR.key?(service) &&
               SERVICE_TO_CLIENT_CLASS_NAME.key?(service)
          SERVICE_TO_CLIENT_ATTR_NAME.key? service

          error_text = "A mixin service #{service} is specified in service config, but " \
                       "the Generator does not know of it."
          raise ModelError, error_text
        end

        Mixin.new service,
                  SERVICE_TO_DEPENDENCY[service],
                  SERVICE_TO_REQUIRE_STR[service],
                  SERVICE_TO_CLIENT_CLASS_NAME[service],
                  SERVICE_TO_CLIENT_ATTR_NAME[service]
      end
    end
  end
end
