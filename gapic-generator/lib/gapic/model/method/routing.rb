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
    module Method
      ##
      # Routing headers info determined from the proto method
      #
      # @!attribute [r] routing
      #   @return [::Google::Api::RoutingRule] Explicit routing annotation for the Api
      class Routing
        attr_reader :routing

        ##
        # @param routing [::Google::Api::RoutingRule] Explict routing annotation for the Api
        # @param http [Gapic::Model::Method::HttpAnnotation] Model for the Http annotation
        #
        def initialize routing, http
          @routing = routing
          @http = http
        end

        ##
        # Whether routing parameters are specified
        #
        # @return [Boolean]
        def routing_params?
          explicit_params? || implicit_params?
        end

        ##
        # Whether an explicit routing annotation (`google.api.routing`) is present
        #
        # @return [Boolean]
        def explicit_annotation?
          !@routing.nil?
        end

        ##
        # Whether an annotation that might contain implicit routing (`google.api.http`) is present
        #
        # @return [Boolean]
        def implicit_annotation?
          !@http.nil?
        end

        ##
        # Whether explicit routing parameters are present
        #
        # @return [Boolean]
        def explicit_params?
          return false unless explicit_annotation?

          explicit_params.any?
        end

        ##
        # Explicit routing parameters, if present.
        # Grouped by the routing key, in order, with the extraction and matching information.
        #
        # @return [Hash<String, Array>]
        def explicit_params
          all_explicit_params.group_by(&:key).transform_values do |params|
            params.sort_by(&:order).to_a
          end
        end

        ##
        # Whether implict routing parameters from `google.api.http` annotation are present
        #
        # @return [Boolean]
        def implicit_params?
          @http.routing_params?
        end

        ##
        # Implicit routing parameters.
        # These strings are both field and routing header key names.
        #
        # @return [Array<String>]
        def implicit_params
          return {} unless implicit_params?
          @http.routing_params
        end

        ##
        # Full routing parameter information, including parsing order
        # and matching/extraction patterns and regexes.
        #
        # @!attribute [r] order
        #   @return [Integer] Order of the parameter in the annotation
        #
        # @!attribute [r] field
        #   @return [String] Field to extract the routing header from
        #
        # @!attribute [r] raw_template
        #   @return [String, nil] Raw template as given in the annotation
        #
        # @!attribute [r] path_template
        #   @return [String] 'Processed' template, handling such cases as
        #      empty or nameless template
        #
        # @!attribute [r] key
        #   @return [String] Name of the key to add to the routing header
        #
        # @!attribute [r] value_pattern
        #   @return [String] The pattern of the value to be extracted
        #
        # @!attribute [r] field_pattern
        #   @return [String] The pattern of the full field (simplified)
        #      The field as a whole should match this pattern
        #      This pattern is simplified, stipped of the names of the
        #      resource id segments.
        #      (e.g. `collections/{resource_id=foo/*}` => `collections/foo/*`)
        #
        # @!attribute [r] field_regex_str
        #   @return [String] The regex matching the `field_pattern`
        #      (the regex form of the simplified pattern)
        #
        # @!attribute [r] field_full_regex_str
        #   @return [String] The regex matching the full unsimplified field pattern
        #      (it will contain the named capture corresponding to the
        #       resource id segment name)
        #
        class RoutingParameter
          attr_reader :order
          attr_reader :field
          attr_reader :raw_template
          attr_reader :path_template
          attr_reader :key
          attr_reader :value_pattern
          attr_reader :field_pattern
          attr_reader :field_regex_str
          attr_reader :field_full_regex_str

          ##
          # @param routing_parameter [::Google::Api::RoutingParameter]
          #   Routing parameter annotation
          #
          # @param order [Integer]
          #   Order of this annotation among its peers
          def initialize routing_parameter, order
            @order = order
            @field = routing_parameter.field
            @raw_template = routing_parameter.path_template
            @path_template = infer_template @raw_template, @field
            @path_pattern = Gapic::PathPattern.parse @path_template

            resource_segment = @path_pattern.segments.find(&:resource_id_segment?)

            # Only one segment providing an argument and only one argument in the segment
            # (no `{foo}~{bar}` segments)
            valid = @path_pattern.segments.count(&:resource_id_segment?) == 1 &&
                    resource_segment.arguments.count == 1

            unless valid
              error_text = create_invalid_error_text @path_pattern, @raw_template
              raise ModelError, error_text
            end

            @field_pattern = @path_pattern.simplified_pattern
            @field_full_regex_str =  to_field_pattern @path_pattern
            @field_regex_str = to_field_pattern Gapic::PathPattern.parse(@field_pattern)

            @key = resource_segment.arguments[0]
            @value_pattern = resource_segment.resource_patterns[0]
          end

          ##
          # Whether pattern matching is not needed
          # since the patterns allow all strings
          # @return [Boolean]
          def pattern_matching_not_needed?
            field_pattern == "**" && value_pattern == "**"
          end

          ##
          # Whether the value to be added to the routing header
          # is the value of the whole field
          # @return [Boolean]
          def value_is_full_field?
            @path_pattern.segments.count == 1
          end

          private

          # Makes a regex pattern match a field
          # - adds markers for the beginning and end of the string
          # - adds handling of an optional tail `/` if needed
          # @param pattern [String]
          # @return [String]
          def to_field_pattern pattern
            tail_slash_accept = if pattern.segments.last.simplified_pattern == "**"
                                  ""
                                else
                                  "/?"
                                end
            "^#{pattern.to_regex_str}#{tail_slash_accept}$"
          end

          # Converts path template simplified forms into canonical
          # ResourceId representations by adding a field as a Resource Id
          # @param template [String]
          # @param field [String]
          # @return [String]
          def infer_template template, field
            if template.nil? || template.empty?
              return "{#{field}=**}"
            end

            if template.strip == "**"
              return "{#{field}=**}"
            end

            if template.strip == "*"
              return "{#{field}=*}"
            end

            template
          end

          def create_invalid_error_text path_pattern, raw_template
            reason = if path_pattern.segments.count(&:resource_id_segment?).zero?
                       "it contains no ResourceId (e.g. `{foo=*}`) segments"
                     elsif path_pattern.segments.count(&:resource_id_segment?) > 1
                       "it contains more than one ResourceId (e.g. `{foo=*}`) segments "
                     else
                       "it contains a multivariate ResourceId segment (e.g. `{foo}~{bar}`)"
                     end

            "A routing header parameter with the path_template #{raw_template}\n is invalid: #{reason}"
          end
        end

        private

        # All explicit routing parameters in an array.
        # @return [Array<RoutingParameter>]
        def all_explicit_params
          return [] unless explicit_annotation?
          @routing.routing_parameters.each_with_index.map { |param, index| RoutingParameter.new param, index }.to_a
        end
      end
    end
  end
end
