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
    class Mixins
      # LRO might be specified in the mixins but it is handled differently
      LRO_SERVICE = "google.longrunning.Operations"

      attr_accessor :api_services

      def initialize api_services, service_config
        @api_services = api_services
        @service_config = service_config
      end

      def mixins?
        mixin_services.any?
      end

      def mixin_services
        @mixin_services ||= begin
          services_in_config.select do |service|
            service != LRO_SERVICE && !@api_services.include?(service)
          end
        end
      end

      def mixins
        @mixins ||= mixin_services.map { |service| create_mixin(service) }
      end

      def dependencies
        @dependencies ||= begin
          mixins.reduce({}) { |deps, mixin| deps.merge mixin.dependency }
        end
      end

      class Mixin
        attr_accessor :service, :dependency, :require_str
        attr_accessor :client_class_name, :client_var_name

        def initialize service, dependency, require_str, client_class_name, client_var_name
          @service = service
          @dependency = dependency
          @require_str = require_str
          @client_class_name = client_class_name
          @client_var_name = client_var_name
        end
      end

      private

      def services_in_config
        return [] unless @service_config && @service_config.apis 
        @service_config.apis.map(&:name)
      end

      # Since mixins are scope-limited to a couple of services, it is easier to
      # have these in lookup tables than to construct a ServicePresenter

      SERVICE_TO_DEPENDENCY = {
        "google.cloud.location.Locations" => {"google-cloud-location" => "~> 1.0"},
        "google.iam.v1.IAMPolicy" => {"google-iam-v1" => "~> 1.0"},
      }

      SERVICE_TO_REQUIRE_STR = {
        "google.cloud.location.Locations" => "google/cloud/location",
        "google.iam.v1.IAMPolicy" => "google/cloud/v1/iam_policy",
      }

      SERVICE_TO_CLIENT_CLASS_NAME = {
        "google.cloud.location.Locations" => "Google::Cloud::Locations::Client",
        "google.iam.v1.IAMPolicy" => "Google::Cloud::V1::IAMPolicy::Client",
      }

      SERVICE_TO_CLIENT_ATTR_NAME = {
        "google.cloud.location.Locations" => "locations_client",
        "google.iam.v1.IAMPolicy" => "iam_policy_client",
      }

      def create_mixin service
        unless SERVICE_TO_DEPENDENCY.key?(service) &&
               SERVICE_TO_REQUIRE_STR.key?(service) &&
               SERVICE_TO_CLIENT_CLASS_NAME.key?(service)
               SERVICE_TO_CLIENT_ATTR_NAME.key?(service)

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