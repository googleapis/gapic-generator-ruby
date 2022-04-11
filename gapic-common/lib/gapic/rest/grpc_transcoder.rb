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

require "gapic/rest/grpc_transcoder/http_binding"

module Gapic
  module Rest
    # @private
    # Transcodes a proto request message into HTTP Rest call components
    # using a configuration of bindings
    class GrpcTranscoder
      def initialize bindings = nil
        @bindings = bindings || []
      end

      def with_bindings uri_method:, uri_template:, matches: [], body: nil
        template = uri_template

        matches.each do |name, _|
          unless uri_template =~ /({#{Regexp.quote name}})/
            err_msg = "Binding configuration is incorrect: missing parameter in the URI template.\n" \
                      "Parameter `#{name}` is specified for matching but there is no corresponding parameter" \
                      " `{#{name}}` in the URI template."
            raise ::Gapic::Common::Error, err_msg
          end

          template = template.gsub "{#{name}}", ""
        end

        if template =~ /{([a-zA-Z_.]+)}/
          err_name = /{([a-zA-Z_.]+)}/.match(template)[1]
          err_msg = "Binding configuration is incorrect: missing match configuration.\n" \
                    "Parameter `{#{err_name}}` is specified in the URI template but there is no" \
                    " corresponding match configuration for `#{err_name}`."
          raise ::Gapic::Common::Error, err_msg
        end

        if body&.include? "."
          raise ::Gapic::Common::Error,
                "Provided body template `#{body}` points to a field in a sub-message. This is not supported."
        end

        field_bindings = matches.map do |match|
          HttpBinding::FieldBinding.new match[0], match[1]
        end

        GrpcTranscoder.new @bindings << HttpBinding.new(uri_method, uri_template, field_bindings, body)
      end

      def transcode request
        # Using bindings in reverse here because of the "last one wins" rule
        @bindings.reverse.each do |http_binding|
          # The main reason we are goind through request.to_json
          # is that the unset proto3_optional fields will not be
          # in that JSON, letting us skip the checks that would look like
          #   `request.respond_to?("has_#{key}?".to_sym) && !request.send("has_#{key}?".to_sym)`
          # The reason we set emit_defaults: true is to avoid
          # having to figure out default values for the required
          # fields at a runtime.
          #
          # Make a new one for each binding because extract_scalar_value! is destructive
          request_hash = JSON.parse request.to_json emit_defaults: true

          uri_values = bind_uri_values http_binding, request_hash
          next if uri_values.any? { |_, value| value.nil? }

          if http_binding.body && http_binding.body != "*"
            # Note that the body template can only point to a top-level field,
            # so there is no need to split the path.
            body_binding_camel = camel_name_for http_binding.body
            next unless request_hash.key? body_binding_camel
          end

          method = http_binding.method
          uri = expand_template http_binding.template, uri_values
          body, query_params = construct_body_query_params http_binding.body, request_hash, request

          return method, uri, query_params, body
        end

        raise ::Gapic::Common::Error,
              "Request object does not match any transcoding template. Cannot form a correct REST call."
      end

      private

      def bind_uri_values http_binding, request_hash
        http_binding.field_bindings.map do |field_binding|
          field_path_camel = field_binding.field_path.split(".").map { |part| camel_name_for part }.join(".")
          field_value = extract_scalar_value! request_hash, field_path_camel, field_binding.regex
          [field_binding.field_path, field_value]
        end.to_h
      end

      def construct_body_query_params body_template, request_hash_without_uri, request
        body = ""
        query_params = []

        if body_template == "*"
          body = request_hash_without_uri.to_json
        elsif body_template && body_template != ""
          # Using a `request` here instead of `request_hash_without_uri`
          # because if `body` is bound to a message field,
          # the fields of the corresponding sub-message,
          # which were used when constructing the URI, should not be deleted
          # (as opposed to the case when `body` is `*`).
          #
          # The `request_hash_without_uri` at this point was mutated to delete these fields.
          #
          # Note that the body template can only point to a top-level field
          request_hash_without_uri.delete camel_name_for body_template
          body = request.send(body_template.to_sym).to_json(emit_defaults: true)
          query_params = build_query_params request_hash_without_uri
        else
          query_params = build_query_params request_hash_without_uri
        end

        [body, query_params]
      end

      def build_query_params request_hash, prefix = ""
        result = []
        request_hash.each do |key, value|
          if value.is_a? ::Array
            value.each do |_val|
              result.push "#{prefix}#{key}=#{value}"
            end
          elsif value.is_a? ::Hash
            result += build_query_params value, "#{key}."
          else
            result.push "#{prefix}#{key}=#{value}" unless value.nil?
          end
        end

        result
      end

      def extract_scalar_value! request_hash, field_path, regex
        parent, name = find_value request_hash, field_path
        value = parent.delete name

        # Covers the case where in `foo.bar.baz`, `baz` is still a submessage or an array.
        return nil if value.is_a?(::Hash) || value.is_a?(::Array)
        return value.to_s if value.to_s =~ regex
      end

      def find_value request_hash, field_path
        path_split = field_path.split "."

        value_parent = nil
        value = request_hash
        last_field_name = nil
        path_split.each do |curr_field|
          # Covers the case when in `foo.bar.baz`, `bar` is not a submessage field
          # or is a submessage field initialized with nil.
          return {}, nil unless value.is_a? ::Hash
          value_parent = value
          last_field_name = curr_field
          value = value[curr_field]
        end

        [value_parent, last_field_name]
      end

      def expand_template template, bindings
        result = template
        bindings.each do |name, value|
          result = result.gsub "{#{name}}", value
        end
        result
      end

      ##
      # Converts a snake_case parameter name into camelCase for query string parameters
      # @param attr_name [String]
      # @return [String] camel-cased parameter name
      def camel_name_for attr_name
        parts = attr_name.split "_"
        first_part = parts[0]
        other_parts = parts[1..-1]
        other_parts_pascal = other_parts.map(&:capitalize).join
        "#{first_part}#{other_parts_pascal}"
      end
    end
  end
end
