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

require "gapic/path_pattern"

module Gapic
  module Model
    ##
    # Method-level models
    #
    module Method
      ##
      # Nonstandard (AIP-151 nonconforming) long-running operation method-level  model
      #
      # @!attribute [r] service_full_name
      #   @return [String] Full grpc name of the provider service for this method's LRO
      #   e.g. `google.example.LroProvider`
      #
      # @!attribute [r] operation_request_fields
      #   @return [Map<String, String>] Map of the field names of this method's request message
      #   that should be saved and later used when constructing the LRO polling request.
      #   The values are the names of the fields in the polling request.
      #   The semantics are `from -> to`, e.g. `{"foo" => "bar"}` means that
      #   when constructing a polling request, the following assignment should be carried out:
      #   `lro_polling_request.bar = this_method_request.foo`.
      #
      class NonStandardLro
        # @return [String]
        attr_reader :service_full_name
        # @return [Map<String, String>]
        attr_reader :operation_request_fields

        ##
        # @param method [Gapic::Schema::Method]
        # @param service_full_name [String] Full grpc name of the provider service for this method's LRO
        def initialize method, service_full_name
          @service_full_name = service_full_name

          # optionally, there might be things to copy from this method's input object
          # to the LRO service's input object (`operation_request_field` annotation)
          ops_request_fields = method.input.fields.find_all do |f|
            !f.operation_request_field.nil? && !f.operation_request_field.empty?
          end

          @operation_request_fields = ops_request_fields.map do |field|
            [field.name, field.operation_request_field]
          end.to_h
        end

        ##
        # @return [Boolean] Whether this is a model for the nonstandard LRO
        #
        def nonstandard_lro?
          true
        end

        ##
        # @return [Boolean] Whether this is a model for the AIP-151 LRO
        #
        def aip_lro?
          false
        end
      end

      ##
      # AIP-151 LRO Model
      #
      class AipLro
        include Singleton
        ##
        # @return [Boolean] Whether this is a model for the nonstandard LRO
        #
        def nonstandard_lro?
          false
        end

        ##
        # @return [Boolean] Whether this is a model for the AIP-151 LRO
        #
        def aip_lro?
          true
        end
      end

      ##
      # Method does not represent a long-running operation
      #
      class NoLro
        include Singleton
        ##
        # @return [Boolean] Whether this is a model for the nonstandard LRO
        #
        def nonstandard_lro?
          false
        end

        ##
        # @return [Boolean] Whether this is a model for the AIP-151 LRO
        #
        def aip_lro?
          false
        end
      end

      class << self
        ##
        # Inspects the method and returns it's long-running operation model
        #
        # @param method [Gapic::Schema::Method]
        # @param api [Gapic::Schema::Api]
        #
        # @raises [Gapic::Model::ModelError]
        #
        # @returns [Gapic::Model::Method::NonStandardLro, Gapic::Model::Method::AipLro, Gapic::Model::Method::NoLro]
        #
        def parse_lro method, api
          is_aip_lro = method.output.full_name == "google.longrunning.Operation"
          return AipLro.instance if is_aip_lro

          # If a method is annotated with operation_service, this is a nonstandard LRO consumer method
          is_nonstandard_lro = !method.operation_service.nil? && !method.operation_service.empty?
          if is_nonstandard_lro
            # LRO service name is given plain, so it has to be in the same package as this method's service
            service_full_name = (method.address[0..-3] << method.operation_service).join "."
            ops_service_lro = api.nonstandard_lro_model_for service_full_name
            unless ops_service_lro.nonstandard_lro?
              error_text = "A service #{service_full_name} specified as a nonstandard LRO service for " \
              "the method #{method.full_name} was not found."
              raise ModelError, error_text
            end
            
            unless method.output.full_name == ops_service_lro.lro_object_full_name
              error_text = "A service #{service_full_name} specified as a nonstandard LRO service for " \
              "the method #{method.full_name} has a different LRO object (#{ops_service_lro.lro_object_full_name}) from " \
              "the method's return type (#{method.output.full_name})."
              raise ModelError, error_text
            end

            return NonStandardLro.new method, service_full_name
          end

          NoLro.instance
        end
      end
    end
  end
end
