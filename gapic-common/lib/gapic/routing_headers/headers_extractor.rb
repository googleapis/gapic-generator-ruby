# Copyright 2023 Google LLC
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

require "gapic/routing_headers/header_binding"

module Gapic
  module RoutingHeaders
    class HeadersExtractor
      attr_accessor :bindings

      def initialize bindings = nil
        @bindings = bindings || []
      end

      def with_bindings(field:, header_name: nil, regex: nil)
        binding = HeaderBinding.create(field: field, header_name: header_name, regex: regex)
        HeadersExtractor.new @bindings + [binding]
      end

      def extract_headers request
        header_params = {}

        unless request
          err_msg = "Incorrect header extraction request: request is nil."
          raise ::Gapic::Common::Error, err_msg
        end

        @bindings.each do |header_binding|
          field_value = get_field_val request, header_binding.field
          next unless field_value

          if header_binding.regex && !field_value.is_a?(::String)
            err_msg = "Header binding configuration is incorrect: regex" \
                      "is given with a non-string field #{field}.\n" \
                      "When the regex is present the field in the regex must be a ::String."
            raise ::Gapic::Common::Error, err_msg
          end

          header_name = header_binding.header_name || header_binding.field

          header_value = if header_binding.regex
            match = header_binding.regex.match field_value
            match[1] if match
          else
            field_value.to_s
          end

          header_params[header_name] = header_value if header_value && !header_value.empty?
        end

        header_params
      end

      private

      def get_field_val request, field
        field_path = field.split "."
    
        curr_submessage = request
        field_path.each do |curr_field|
          return nil unless curr_submessage.respond_to? curr_field
          curr_submessage = curr_submessage.send curr_field
        end
    
        return curr_submessage.to_s if curr_submessage
      end
    end
  end
end
