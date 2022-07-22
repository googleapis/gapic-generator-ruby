# frozen_string_literal: true

# Copyright 2022 Google LLC
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
      # A presenter for the Http Binding, used to generate code setting up gRPC transcoding
      #
      class HttpBindingPresenter
        extend Forwardable

        def initialize binding
          @binding = binding
        end

        ##
        # Performs a limited URI transcoding to create a string that will interpolate
        # the values from the request object to create a request URI at runtime.
        # Currently only supports "value" into "request_object.value"
        # @param [String] request_obj_name the name of the request object for the interpolation
        #   defaults to "request_pb"
        # @return [String] A string to interpolate values from the request object into URI
        #
        def uri_for_transcoding
          return path unless routing_params?

          @binding.routing_params.reduce path do |uri, param|
            param_esc = Regexp.escape param
            uri.gsub(/{#{param_esc}[^}]*}/, "{#{param}}")
          end
        end

        ##
        # The strings to initialize the `matches` parameter when initializing a
        # grpc transcoder binding. The `matches` parameter is an array of arrays,
        # so every string here is in a ruby array syntax. All strings except for the
        # last one have a comma at the end.
        #
        # @return [Array<String>]
        #
        def routing_params_transcoder_matches_strings
          return [] if routing_params_with_regexes.empty?
          match_init_strings = routing_params_with_regexes.map do |name, regex, preserve_slashes|
            "[\"#{name}\", %r{#{regex}}, #{preserve_slashes}],"
          end
          match_init_strings << match_init_strings.pop.chop # remove the trailing comma for the last element
          match_init_strings
        end

        # @!method verb?
        #   @return [Boolean]
        #     Whether a http verb is present for this binding.
        # @!method verb
        #   @return [String]
        #     The http verb for this binding.
        # @!method path?
        #   @return [Boolean]
        #     Whether a binding path is present and non-empty.
        # @!method path
        #   @return [String]
        #     A binding path or an empty string if not present.
        # @!method routing_params?
        #   @return [Boolean]
        #     Whether any routing params are present for this bindings.
        # @!method body?
        #   @return [Boolean]
        #     Whether the binding has a `body` specified.
        # @!method body
        #   @return [String]
        #     The `body` specified for this binding
        #     or an empty string if not specified.
        def_delegators :@binding, :verb?, :verb, :path?, :path, :routing_params?, :body?, :body

        private

        ##
        # The segment key names, the regexes for their patterns (including
        # the regexes for `*` patterns implied for the named segments without
        # pattern explicitly specified), and whether the slash `/` symbols in
        # the segment variable should be preserved (as opposed to percent-escaped).
        #
        # These are used to initialize the grpc transcoder `matches` binding parameter.
        #
        # @return [Array<Array<String|Boolean>>]
        #
        def routing_params_with_regexes
          @routing_params_with_regexes ||= begin
            @binding.routing_params_with_patterns.map do |name, pattern|
              path_pattern = PathPattern.parse pattern
              [name, path_pattern.to_regex_str, path_pattern.ends_with_double_star_pattern?]
            end
          end
        end
      end
    end
  end
end
