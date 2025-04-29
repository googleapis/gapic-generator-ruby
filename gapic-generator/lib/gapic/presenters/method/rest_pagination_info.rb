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
  module Presenters
    module Method
      ##
      # Pagination info determined from the proto method
      #
      class RestPaginationInfo
        include Gapic::Helpers::NamespaceHelper
        ##
        # @param proto_method [Gapic::Schema::Method] the method to derive pagination info from
        # @param api [Gapic::Schema::Api]
        #
        def initialize proto_method, api
          @api = api
          @request = proto_method.input
          @response = proto_method.output
          @server_streaming = proto_method.server_streaming
        end

        ##
        # Whether the method should be generated as paged
        #
        # @return [Boolean]
        def paged?
          !server_streaming? && paged_request? && paged_response?
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

        # Whether the underlying proto rpc is a server streaming rpc
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
        # @return[Gapic::Schema::Field, nil]
        def request_page_token_field
          # Has a String page_token field which specifies the actual (next) page to retrieve.
          @request_page_token_field ||= @request.fields.find do |f|
            f.name == "page_token" && f.type == :TYPE_STRING
          end
        end

        ##
        # The field in the request that holds a page_size
        # For Regapic can have a name of either `page_size` or `max_results`
        #
        # @return[Gapic::Schema::Field, nil]
        def request_page_size_field
          @request_page_size_field ||=
            begin
              page_size_names = ["page_size", "max_results"]

              # Has the int32 page_size or int32 max_results field
              # which defines the maximum number of paginated resources to return in the response.
              page_size_types = [:TYPE_UINT32, :TYPE_INT32]

              field = @request.fields.find do |f|
                page_size_names.include?(f.name) && page_size_types.include?(f.type)
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
          # Has the string next_page_token field to be used in the next request as page_token to retrieve the next page.
          # Has only one repeated or map<string, ?> field containing a list of paginated resources.
          !response_next_page_token_field.nil? && !response_results_field.nil?
        end

        ##
        # The field in the response that holds a next page_token
        #
        # @return[Gapic::Schema::Field, nil]
        def response_next_page_token_field
          # Has the string next_page_token field to be used in the next request as page_token to retrieve the next page.
          @response_next_page_token_field ||= @response.fields.find do |f|
            f.name == "next_page_token" && f.type == :TYPE_STRING
          end
        end

        ##
        # The field in the response that holds the results
        # For Regapic can be either a vanilla repeated field or a map
        #
        # @return [Gapic::Schema::Field, nil]
        def response_results_field
          @response_results_field ||= begin
            map_fields = @response.fields.find_all(&:map?)
            repeated_fields = @response.fields.find_all do |f|
              !f.map? && f.label == :LABEL_REPEATED
            end

            if map_fields.count == 1
              # If the response message has only one map<string, ?> field
              # treat it as the one with paginated resources (i.e. ignore the repeated fields if any).
              map_fields.first
            elsif repeated_fields.count == 1 && map_fields.empty?
              # If the response message contains only one repeated field,
              # treat that field as the one containing the paginated resources.
              repeated_fields.first
            end
            # If the response message contains more than one repeated field or does not have repeated fields at all
            # but has more than one map<string, ?> field, do not generate any paginated methods for such rpc.
          end
        end

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
