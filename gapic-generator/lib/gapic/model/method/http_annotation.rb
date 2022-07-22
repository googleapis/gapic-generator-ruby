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

require "gapic/uri_template"

module Gapic
  module Model
    module Method
      ##
      # The information used in the generation process that
      # can be gathered from the `google.api.http` annotation.
      # `google.api.http` is used in two distinct ways:
      #   - REST libs use it as part of the transcoding to set up the REST call
      #   - gRPC libs use it as a source of implicit routing headers
      #
      class HttpAnnotation
        ##
        # @param proto_method [::Gapic::Schema::Method]
        #   The proto method this annotation model applies to
        # @param service_config [::Google::Api::Service]
        #   The service config that might contain an override for the proto method's
        #   http annotation.
        #
        def initialize proto_method, service_config
          proto_http = proto_method.http
          http_override = begin
            unless service_config&.http.nil?
              service_config.http.rules.find { |http_rule| http_rule.selector == proto_method.full_name }
            end
          end

          @http = http_override || proto_http
        end

        def bindings
          @bindings ||= parse_bindings
        end

        ##
        # Whether a http verb is present for this method
        #
        # @return [Boolean]
        def verb?
          !verb.nil?
        end

        ##
        # The http verb for this method
        #
        # @return [Symbol, nil]
        def verb
          bindings.first&.verb
        end

        ##
        # Whether a method path is present and non-empty
        #
        # @return [Boolean]
        def path?
          !path.empty?
        end

        ##
        # A method path or an empty string if not present
        #
        # @return [String]
        def path
          bindings.first&.path || ""
        end

        ##
        # Whether any routing params are present
        #
        # @return [Boolean]
        def routing_params?
          routing_params.any?
        end

        ##
        # The segment key names.
        #
        # @return [Array<String>]
        def routing_params
          routing_params_with_patterns.map { |param, _| param }
        end

        ##
        # The segment key names and their corresponding paterns,
        # including the `*` pattern implied for the named segments
        # without pattern explicitly specified.
        #
        # @return [Array<Array<String>>]
        def routing_params_with_patterns
          bindings.first&.routing_params_with_patterns || []
        end

        ##
        # Whether method has body specified in proto
        #
        # @return [Boolean]
        def body?
          !body.empty?
        end

        ##
        # The body specified for the given method in proto
        # or an empty string if not specified
        #
        # @return [String]
        def body
          bindings.first&.body || ""
        end

        ##
        # @private
        #
        class HttpBinding
          def initialize binding
            @binding = binding
          end

          ##
          # Whether a http verb is present for this method
          #
          # @return [Boolean]
          def verb?
            !verb.nil?
          end

          ##
          # The http verb for this method
          #
          # @return [Symbol, nil]
          def verb
            verb_path[0] if verb_path
          end

          ##
          # Whether a method path is present and non-empty
          #
          # @return [Boolean]
          def path?
            !path.empty?
          end

          ##
          # A method path or an empty string if not present
          #
          # @return [String]
          def path
            return "" unless verb_path
            verb_path[1]
          end

          ##
          # Whether any routing params are present
          #
          # @return [Boolean]
          def routing_params?
            routing_params.any?
          end

          ##
          # The segment key names and their corresponding paterns,
          # including the `*` pattern implied for the named segments
          # without pattern explicitly specified.
          #
          # @return [Array<Array<String>>]
          def routing_params_with_patterns
            @routing_params_with_patterns ||= begin
              Gapic::UriTemplate.parse_arguments(path).map do |name, pattern|
                [name, pattern.empty? ? "*" : pattern]
              end
            end
          end

          ##
          # The segment key names.
          #
          # @return [Array<String>]
          def routing_params
            routing_params_with_patterns.map { |param, _| param }
          end

          ##
          # Whether method has body specified in proto
          #
          # @return [Boolean]
          def body?
            !body.empty?
          end

          ##
          # The body specified for the given method in proto
          # or an empty string if not specified
          #
          # @return [String]
          def body
            @binding&.body || ""
          end


          private
          ##
          # The combination of verb and path found in the http annotation
          # (or Nil if the annotation is Nil).
          #
          # @return [Array<Symbol, String>, Nil]
          def verb_path
            return nil if @binding.nil?

            method = {
              get:    @binding.get,
              post:   @binding.post,
              put:    @binding.put,
              patch:  @binding.patch,
              delete: @binding.delete
            }.find { |_, value| !value.empty? }

            method unless method.nil?
          end
        end

        private

        def parse_bindings 
          binds = []
          return binds if @http.nil?
          raw_binds = [@http]
          if @http.additional_bindings && @http.additional_bindings.any?
            for additional_bind in @http.additional_bindings
              raw_binds << additional_bind
            end
          end

          while raw_bind = raw_binds.shift
            binds << HttpBinding.new(raw_bind)
          end
          binds
        end
      end
    end
  end
end
