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
    ##
    # Service-level models
    #
    module Service
      ##
      # Nonstandard (AIP-151 nonconforming) long-running operation service-level model
      # for the services that are LRO providers (contain polling methods for long-running operations)
      #
      # @!attribute [r] service_full_name
      #   @return [String] Full grpc name of this service. E.g. `google.example.LroProvider`.
      #
      # @!attribute [r] polling_method_name
      #   @return [String] Name of the method that is used to poll for LROs. E.g. `Poll`
      #
      # @!attribute [r] lro_object_full_name
      #   @return [String] Full grpc name of the object that is returned by the polling method.
      #   E.g. `google.cloud.compute.v1.Operation`
      #
      # @!attribute [r] operation_status_field
      #   @return [String] In the Operation message for this service, the name of the `status` field.
      #   The `status` field signals that the operation has finished. It should either contain symbols, and
      #   be set to `:DONE` when finished or contain a boolean and be set to `true` when finished.
      #
      # @!attribute [r] operation_name_field
      #   @return [String, nil] In the Operation message for this service, the name of the `name` field.
      #
      # @!attribute [r] operation_err_code_field
      #   @return [String, nil] In the Operation message for this service, the name of the `error code` field.
      #
      # @!attribute [r] operation_err_msg_field
      #   @return [String, nil] In the Operation message for this service, the name of the `error message` field.
      #
      # @!attribute [r] operation_response_fields
      #   @return [Hash<String, String>] The map of the fields that need to be copied from the
      #   long-running operation object that the polling method returns to the polling request.
      #   The format is `name of the operation object field` -> `name of the polling request field` (`from -> to`).
      #   E.g. `{"foo" => "bar"}` means that when constructing a polling request,
      #   the following assignment should be carried out:
      #   `lro_polling_request.bar = operation_object.foo`.
      #
      class NonstandardLroProvider
        attr_reader :service_full_name
        attr_reader :polling_method_name
        attr_reader :lro_object_full_name
        attr_reader :operation_status_field
        attr_reader :operation_name_field
        attr_reader :operation_err_code_field
        attr_reader :operation_err_msg_field
        attr_reader :operation_response_fields

        ##
        # @return [Boolean] Whether this is a model for a nonstandard LRO provider service
        #
        def nonstandard_lro?
          true
        end

        ##
        # @param service_full_name [String]
        #   Full grpc name of this service. E.g. `google.example.LroProvider`.
        #
        # @param polling_method_name [String]
        #   Name of the method that is used to poll for LROs. E.g. `Poll`
        #
        # @param lro_object_full_name
        #   Full grpc name of the object that is returned by the polling method.
        #   E.g. `google.cloud.compute.v1.Operation`
        #
        # @param operation_status_field [String]
        #   In the Operation message for this service, the name of the `status` field.
        #   The `status` field signals that the operation has finished. It should either contain symbols, and
        #   be set to `:DONE` when finished or contain a boolean and be set to `true` when finished.
        #
        # @param operation_name_field [String, nil]
        #   In the Operation message for this service, the name of the `name` field.
        #
        # @param operation_err_code_field [String, nil]
        #   In the Operation message for this service, the name of the `error code` field.
        #
        # @param operation_err_msg_field [String, nil]
        #   In the Operation message for this service, the name of the `error message` field.
        #
        # @param operation_response_fields [Hash<String, String>]
        #   The map of the fields that need to be copied from the
        #   long-running operation object that the polling method returns to the polling request.
        #   The format is `name of the operation object field` -> `name of the polling request field` (`from -> to`).
        #   E.g. `{"foo" => "bar"}` means that when constructing a polling request,
        #   the following assignment should be carried out:
        #   `lro_polling_request.bar = operation_object.foo`.
        #
        def initialize service_full_name,
                       polling_method_name,
                       lro_object_full_name,
                       operation_status_field,
                       operation_name_field,
                       operation_err_code_field,
                       operation_err_msg_field,
                       operation_response_fields

          @service_full_name = service_full_name
          @polling_method_name = polling_method_name
          @lro_object_full_name = lro_object_full_name
          @operation_status_field = operation_status_field
          @operation_name_field = operation_name_field
          @operation_err_code_field = operation_err_code_field
          @operation_err_msg_field = operation_err_msg_field
          @operation_response_fields = operation_response_fields
        end
      end

      ##
      # Service does not provide nonstandard LRO polling capabilities
      #
      class NoNonstandardLro
        include Singleton

        ##
        # @return [Boolean] Whether this is a model for a nonstandard LRO provider service
        #
        def nonstandard_lro?
          false
        end
      end

      class << self
        ##
        # Parses the service proto information to determine, whether it is
        # a provider for nonstandard long-running operations polling
        #
        # @param service [Gapic::Schema::Service]
        #
        # @raises [Gapic::Model::ModelError]
        #
        # @return [NonstandardLroProvider, nil]
        def parse_nonstandard_lro service
          polling_method = find_polling_method service
          return unless polling_method

          # There should not be any methods that have the `operation_service` annotation
          # in the LRO provider service.
          # In theory there is nothing wrong with one LRO polling service using another
          # LRO polling service, in practice there is potential for service intialization cycles
          # Until we have a real usecase it's safer to assume an error in proto.
          nonstandard_lro_candidates = service.methods.find_all do |m|
            !m.operation_service.nil? && !m.operation_service.empty?
          end

          if nonstandard_lro_candidates.length.positive?
            ops_service_method = nonstandard_lro_candidates[0]
            error_text = "A service `#{service.name}` has a method annotated " \
                         "with `polling_method` (`#{polling_method.name}`), and also a method annotated " \
                         "with `operation_service` (`#{ops_service_method.name}`). " \
                         "This means a grpc service tries to be a client " \
                         "and a provider of the nonstandard LRO at the same time. " \
                         "This is not supported."
            raise ModelError, error_text
          end

          lro_object_full_name = polling_method.output.full_name

          status_field = find_status_field service, polling_method
          operation_status_field = status_field.name

          operation_name_field = name_of_operation_field polling_method, ::Google::Cloud::OperationResponseMapping::NAME
          operation_err_code_field = name_of_operation_field polling_method,
                                                             ::Google::Cloud::OperationResponseMapping::ERROR_CODE
          operation_err_msg_field = name_of_operation_field polling_method,
                                                            ::Google::Cloud::OperationResponseMapping::ERROR_MESSAGE

          # optionally, there might be fields in the polling method's input object
          # that should be filled with information from the LRO object
          ops_response_fields = polling_method.input.fields.find_all do |f|
            !f.operation_response_field.nil? && !f.operation_response_field.empty?
          end

          operation_response_fields = ops_response_fields.to_h do |field|
            [field.name, field.operation_response_field]
          end

          NonstandardLroProvider.new service.full_name,
                                     polling_method.name,
                                     lro_object_full_name,
                                     operation_status_field,
                                     operation_name_field,
                                     operation_err_code_field,
                                     operation_err_msg_field,
                                     operation_response_fields
        end

        private

        ##
        # Returns a name of the polling method's output object (presumed to be LRO object)'s field
        # that is marked with a given `operation_response_field` annotation,
        # or nil if no such field exists.
        #
        # @param polling_method [Gapic::Schema::Method] the polling method
        # @param ops_response_field [Integer] the value of the `operation_response_field` annotation
        #
        # @return [String]
        #
        def name_of_operation_field polling_method, ops_response_field
          name_candidate = polling_method.output.fields.find do |f|
            f.operation_field == ops_response_field
          end
          return name_candidate.name if name_candidate
        end

        ##
        # If this service is provider for a nonstandard LRO,
        # find the polling method.
        # Otherwise returns nil.
        #
        # @param service [Gapic::Schema::Service]
        #
        # @raises [Gapic::Model::ModelError]
        #
        # @returns [Gapic::Schema::Method, nil]
        #
        def find_polling_method service
          # On a LRO service, one method should be marked as 'polling'
          polling_method_candidates = service.methods.find_all do |m|
            !m.polling_method.nil? && m.polling_method
          end
          if polling_method_candidates.length > 1
            error_text = "A service #{service.name} has more than one method annotated " \
                         "with `operation_polling_method`. This should not happen."
            raise ModelError, error_text
          end

          return unless polling_method_candidates.length == 1

          polling_method_candidates[0]
        end

        ##
        # Find the `status` field in the LRO message that this service provides a
        # polling functionality for
        #
        # @param service [Gapic::Schema::Service]
        # @param polling_method [Gapic::Schema::Method]
        #
        # @raises [Gapic::Model::ModelError]
        #
        # @returns [Gapic::Schema::Field]
        #
        def find_status_field service, polling_method
          # The output of the polling method is an Operation, which should have at least
          # a Status field
          status_candidates = polling_method.output.fields.find_all do |f|
            f.operation_field == ::Google::Cloud::OperationResponseMapping::STATUS
          end

          if status_candidates.length > 1
            error_text = "A nonstandard LRO provider service `#{service.name}`'s " \
                         "polling method `#{polling_method.name}`'s output message " \
                         "`#{polling_method.output.name}` has more than one field annotated " \
                         "with `google.cloud.operation_field = STATUS`. This is not supported."
            raise ModelError, error_text
          end

          if status_candidates.empty?
            error_text = "A nonstandard LRO provider service `#{service.name}`'s " \
                         "polling method `#{polling_method.name}`'s output message " \
                         "`#{polling_method.output.name}` does not have any fields annotated " \
                         "with `google.cloud.operation_field = STATUS`. This is not supported."
            raise ModelError, error_text
          end

          status_candidates[0]
        end
      end
    end
  end
end
