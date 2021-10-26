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
      #   - the rest libs use it as part of the transcoding to set up the REST call
      #   - both rest and grpc libs use it as a source of implicit routing headers
      #
      class HttpAnnotation
        ##
        # @param proto_method [Gapic::Schema::Method]
        #
        def initialize proto_method
          @proto_method = proto_method
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
        # @return [Symbol, Nil]
        def verb
          return nil if @proto_method.http.nil?

          method = {
            get:    @proto_method.http.get,
            post:   @proto_method.http.post,
            put:    @proto_method.http.put,
            patch:  @proto_method.http.patch,
            delete: @proto_method.http.delete
          }.find { |_, value| !value.empty? }

          method[0] unless method.nil?
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
          return "" if @proto_method.http.nil?

          verb_path = [
            @proto_method.http.get, @proto_method.http.post, @proto_method.http.put,
            @proto_method.http.patch, @proto_method.http.delete
          ].find { |x| !x.empty? }

          verb_path || @proto_method.http.custom&.path || ""
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
          Gapic::UriTemplate.parse_arguments path
        end

        ##
        # Whether method has body specified in proto
        #
        # @return [Boolean]
        def body?
          return false if @proto_method.http.nil?

          !@proto_method.http.body.empty?
        end

        ##
        # The body specified for the given method in proto
        # or an empty string if not specified
        #
        # @return [String]
        def body
          @proto_method.http&.body || ""
        end
      end
    end
  end
end
