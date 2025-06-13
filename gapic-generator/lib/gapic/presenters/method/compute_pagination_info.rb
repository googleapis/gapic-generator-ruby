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

require "gapic/model/model_error"

module Gapic
  module Presenters
    module Method
      ##
      # Compute-specific pagination info determined from the proto method
      #
      # This implements the Compute-specific pagination heuristic
      #
      # The following steps are followed for this heuristic:
      # 1. The method should not be server-streamed
      # 2. The request should have a page token and page size fields
      # 3. The response should have a next page token and contain a valid results field
      #
      # Now determining the valid results field is its own complicated sub-heuristic that should be run last.
      # This sub-heuristic cannot end in "not paginated". It should either determine the results field or throw an error
      #
      # The following steps are followed for this sub-heuristic:
      # 0. Check the exception dictionary. If the method is there as a key, use the value as the results field.
      # 1. If there is exactly one map field, that field is the results field.
      #
      # NB: at this point the response contains either 0 or 2 map fields
      #
      # 2. If there are no repeated fields there is no results field and we shall throw an error
      # 3. If there is exactly one repeated field, that field is the results field.
      # 4. If there are exactly 2 repeated fields, one is of message type, and the other is of type
      #    "String", the field of message type is the results field.
      #
      # At this point there are either 2 repeated fields in wrong configuration, or 3 or more repeated
      # fields. The method should have been in the exception dictionary (see step 0).
      # Since the method is NOT in the exception dictionary we should throw an error to prevent
      # accidentally releasing a Compute library with incorrect pagination.
      #
      class ComputePaginationInfo
        include Gapic::Helpers::NamespaceHelper

        # @private Field name for Pagination Request page token
        PAGE_TOKEN_NAME = "page_token"
        private_constant :PAGE_TOKEN_NAME
        # @private Field type for Pagination Request page token
        PAGE_TOKEN_TYPE = :TYPE_STRING
        private_constant :PAGE_TOKEN_TYPE

        # @private Field names for Pagination Request page size
        PAGE_SIZE_NAMES = ["page_size", "max_results"].freeze
        private_constant :PAGE_SIZE_NAMES
        # @private Field types for Pagination Request page size
        PAGE_SIZE_TYPES = [:TYPE_UINT32, :TYPE_INT32].freeze
        private_constant :PAGE_SIZE_TYPES

        # @private Field name for Pagination Response next page token
        NEXT_PAGE_TOKEN_NAME = "next_page_token"
        private_constant :NEXT_PAGE_TOKEN_NAME
        # @private Field type for Pagination Response next page token
        NEXT_PAGE_TOKEN_TYPE = :TYPE_STRING
        private_constant :NEXT_PAGE_TOKEN_TYPE

        # @private A dictionary of special response messages of paginated methods and their repeated fields
        # Curently contains only UsableSubnetworksAggregatedList which is a paginated field with 3 repeated fields,
        #   2 of which are message-typed fields
        REPEATED_FIELD_SPECIAL_DICTIONARY = {
          "google.cloud.compute.v1.UsableSubnetworksAggregatedList" => "items",
          "google.cloud.compute.v1beta.UsableSubnetworksAggregatedList" => "items"
        }.freeze
        private_constant :REPEATED_FIELD_SPECIAL_DICTIONARY

        ##
        # @param proto_method [Gapic::Schema::Method] the method to derive pagination info from
        # @param api [Gapic::Schema::Api]
        #
        def initialize proto_method, api
          @api = api
          @method_full_name = proto_method.full_name
          @request = proto_method.input
          @response = proto_method.output
          @server_streaming = proto_method.server_streaming
        end

        ##
        # Whether the method should be generated as paged
        #
        # @return [Boolean]
        def paged?
          paged_candidate = !server_streaming? && paged_request? && paged_response_candidate?

          # `paged_response?` can raise and should be evaluated last
          paged_candidate && paged_response?
        end

        ##
        # Name of the request's field used for page size
        # For Regapic can be either `page_size` or `max_results`
        #
        # @return [String, nil]
        def request_page_size_name
          request_page_size_field&.name
        end

        ##
        # Name of the repeated field in the response message
        # For REST gapics can be either a vanilla repeated field or a map
        #
        # @return [String, nil]
        def response_repeated_field_name
          response_results_field&.name
        end

        ##
        # Whether the repeated field in the response message is a map
        #
        # @return [Boolean, nil]
        def repeated_field_is_a_map?
          response_results_field&.map?
        end

        ##
        # Proto type of the repeated field in the response message
        #
        # @return [String, nil]
        def paged_element_doc_type
          return nil if response_results_field.nil?
          field_paginated_elem_doc_type response_results_field
        end

        private

        ##
        # Whether the underlying proto rpc is a server streaming rpc
        #
        # @return [Boolean]
        attr_accessor :server_streaming

        ##
        # Whether the underlying proto rpc is a server streaming rpc
        #
        # @return [Boolean]
        def server_streaming?
          @server_streaming
        end

        ##
        # Whether the request message for the REGAPIC rpc satisfies the criteria
        # for the rpc to be classified and implemented as paged
        #
        # @return [Boolean]
        def paged_request?
          # Has a String page_token field which specifies the actual (next) page to retrieve.
          # Has an int32 page_size or int32 max_results field
          # which defines the maximum number of paginated resources to return in the response.
          !request_page_token_field.nil? && !request_page_size_field.nil?
        end

        ##
        # The field in the request that holds a page_token
        #
        # @return [Gapic::Schema::Field, nil]
        def request_page_token_field
          # Has a String page_token field which specifies the actual (next) page to retrieve.
          @request_page_token_field ||= @request.fields.find do |f|
            f.name == PAGE_TOKEN_NAME && f.type == PAGE_TOKEN_TYPE
          end
        end

        ##
        # The field in the request that holds a page_size
        # For Regapic can have a name of either `page_size` or `max_results`
        #
        # @return [Gapic::Schema::Field, nil]
        def request_page_size_field
          @request_page_size_field ||=
            begin
              field = @request.fields.find do |f|
                PAGE_SIZE_NAMES.include?(f.name) && PAGE_SIZE_TYPES.include?(f.type)
              end

              field
            end
        end

        ##
        # Whether the response message for the REGAPIC rpc satisfies the criteria
        # for the rpc to be classified and implemented as paged
        #
        # @return [Boolean]
        def paged_response?
          # Has the string next_page_token field to be used in the next request as
          # page_token to retrieve the next page.
          # Passes the heuristic for paginated response
          # Order is important here, since paginated response heuristic can raise and should be evaluated last
          paged_response_candidate? && !response_results_field.nil?
        end

        ##
        # Whether the response message for the REGAPIC rpc satisfies the criteria
        # to be a candidate for pagination. This is intentinally split from evaluating
        # the paged response heuristic since that heuristic can raise.
        #
        # @return [Boolean]
        def paged_response_candidate?
          # Has the string next_page_token field to be used in the next request as
          # page_token to retrieve the next page.
          !response_next_page_token_field.nil?
        end

        ##
        # The field in the response that holds a next page_token
        #
        # @return [Gapic::Schema::Field, nil]
        def response_next_page_token_field
          # Has the string next_page_token field to be used in the next request as
          # page_token to retrieve the next page.
          @response_next_page_token_field ||= @response.fields.find do |f|
            f.name == NEXT_PAGE_TOKEN_NAME && f.type == NEXT_PAGE_TOKEN_TYPE
          end
        end


        # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
        # The heuristic in `response_results_field` would be more confusing if spread across several methods

        ##
        # The field in the response that holds the results
        # For Compute Regapic can be either a vanilla repeated field or a map
        #
        # @return [Gapic::Schema::Field, nil]
        def response_results_field
          # This sub-heuristic cannot end in "not paginated".
          # It should either determine the results field or throw an error.
          @response_results_field ||= begin
            map_fields = @response.fields.find_all(&:map?)
            repeated_fields = @response.fields.find_all do |f|
              !f.map? && f.label == :LABEL_REPEATED
            end

            # The following steps are followed for this sub-heuristic:
            # 0. Check the exception dictionary. If the method is there as key, use the value as the results field.
            if REPEATED_FIELD_SPECIAL_DICTIONARY.key? @response.full_name
              field_name = REPEATED_FIELD_SPECIAL_DICTIONARY[@response.full_name]
              field = map_fields.find do |f|
                f.name == field_name
              end || repeated_fields.find do |f|
                f.name == field_name
              end

              unless field
                error_text = "A field of name \"#{field_name}\" is included in the special dictionary for " \
                             "the response type \"#{@response.full_name}\". However this field is not a map " \
                             "or repeated field. Failing, as the generator cannot continue."

                raise ::Gapic::Model::ModelError, error_text
              end

              field
            elsif map_fields.count == 1
              # 1. If there is exactly one map field, that field is the results field.
              map_fields.first
            # NB: at this point the response contains either 0 or 2 map fields.
            elsif repeated_fields.count.zero?
              # 2. If there are no repeated fields there is no results field and we shall throw an error
              error_text = "A response message \"#{@response.full_name}\" has a next page token field and " \
                           "is being evaluated as a candidate for pagination. However it has " \
                           "#{map_fields.count} (!= 1) map fields and no repeated fields.  " \
                           "Failing, as the generator should not continue."

              raise ::Gapic::Model::ModelError, error_text
            elsif repeated_fields.count == 1
              # 3. If there is exactly one repeated field, that field is the results field.
              repeated_fields.first
            elsif repeated_fields.count == 2
              # 4. If there are exactly 2 repeated fields, one is of message type, and the other is of type
              #    "String", the field of message type is the results field.
              pagination_field = repeated_fields.find(&:message?)
              string_field = repeated_fields.find { |f| f.type == :TYPE_STRING }

              unless pagination_field && string_field
                # At this point if there are 2 repeated fields of different configuration, or 3 or more repeated
                # fields the method should have been in the exception dictionary (see step 0).
                error_text = "A response message \"#{@response.full_name}\" has a next page token " \
                             "field and is being evaluated as a candidate for pagination. However it should have " \
                             "a configuration of exactly 2 repeated fields, one is of message type, and the other " \
                             "of type \"String\". Failing, as the generator cannot continue. \n" \
                             "As a developer, please evaluate the message that fails this heuristic and either " \
                             "change the heuristic or add the message to the special dictionary."

                raise ::Gapic::Model::ModelError, error_text
              end

              pagination_field
            else
              # At this point there are 3 or more repeated fields, and the method should have been in the
              # exception dictionary (see step 0).
              error_text = "A response message \"#{@response.full_name}\" has a next page token " \
                           "field and is being evaluated as a candidate for pagination. However it has  " \
                           "#{repeated_fields.count} (>= 3) repeated fields, and not in the special dictionary " \
                           "for exceptions. Failing, as the generator cannot continue. \n" \
                           "As a developer, please evaluate the message that fails this heuristic and either " \
                           "change the heuristic or add the message to the special dictionary."

              raise ::Gapic::Model::ModelError, error_text
            end
          end
        end

        # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

        # @private
        FIELD_TYPE_MAPPING = {
          TYPE_DOUBLE: "::Float",
          TYPE_FLOAT: "::Float",
          TYPE_INT64: "::Integer",
          TYPE_UINT64: "::Integer",
          TYPE_INT32: "::Integer",
          TYPE_FIXED64: "::Integer",
          TYPE_FIXED32: "::Integer",
          TYPE_BOOL: "::Boolean",
          TYPE_STRING: "::String",
          TYPE_BYTES: "::String",
          TYPE_UINT32: "::Integer",
          TYPE_SFIXED32: "::Integer",
          TYPE_SFIXED64: "::Integer",
          TYPE_SINT32: "::Integer",
          TYPE_SINT64: "::Integer"
        }.freeze
        private_constant :FIELD_TYPE_MAPPING

        ##
        # A helper to get a Ruby doc-type for a paginated element.
        #
        # @param field [Gapic::Schema::Field]
        #
        # @return [String]
        def field_paginated_elem_doc_type field
          return field_paginated_elem_map_type field if field.map?
          if field.message?
            message_ruby_type field.message
          elsif field.enum?
            # TODO: handle when arg message is nil and enum is the type
            message_ruby_type field.enum
          else
            FIELD_TYPE_MAPPING[field.type] || "::Object"
          end
        end

        ##
        # A helper to get a Ruby doc-type for a proto map's paginated element.
        #
        # @param field [Gapic::Schema::Field]
        #
        # @return [String]
        def field_paginated_elem_map_type field
          key_field = field.map_key_field
          value_field = field.map_val_field

          if key_field && value_field
            key_type = field_paginated_elem_doc_type key_field
            value_type = field_paginated_elem_doc_type value_field
            "#{key_type}, #{value_type}"
          else
            class_name
          end
        end

        ##
        # A helper to get a Ruby type for a proto message.
        #
        # @param message [Gapic::Schema::Message]
        #
        # @return [String]
        def message_ruby_type message
          ruby_namespace @api, message.address.join(".")
        end
      end
    end
  end
end
