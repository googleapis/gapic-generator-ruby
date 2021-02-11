# frozen_string_literal: true

# Copyright 2020 Google LLC
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
  module GrpcServiceConfig
    ##
    # Representation of a GRPC service config split into the configurations
    # applied on the service level (to all the methods) and the configurations
    # applied to the specific methods
    #
    class ServiceConfig
      attr_reader :service_level_configs
      attr_reader :service_method_level_configs

      ##
      # Create new ServiceConfig.
      #
      # @param service_level_configs [Hash<String, Gapic::GrpcServiceConfig::MethodConfig>] service-level configs
      #   in a lookup hash by the service full grpc name
      #
      # @param service_method_level_configs [Hash<String, Hash<String, Gapic::GrpcServiceConfig::MethodConfig>>]
      #   method-level configs in a double lookup hash, first by the service full grpc name then by the method name
      #
      def initialize service_level_configs, service_method_level_configs
        @service_level_configs = service_level_configs
        @service_method_level_configs = service_method_level_configs
      end
    end
  end
end
