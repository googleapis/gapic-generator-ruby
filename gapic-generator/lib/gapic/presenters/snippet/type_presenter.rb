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

require "active_support/inflector"

module Gapic
  module Presenters
    class SnippetPresenter
      ##
      # Presentation information about a type
      #
      class TypePresenter
        ##
        # Create a type presenter.
        #
        # @param proto [Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Type]
        #     The protobuf representation of the type
        # @param json [String]
        #     The JSON representation of the type
        #
        def initialize proto, json
          @render =
            if json&.key? "scalarType"
              SCALAR_TYPE_MAPPING[proto.scalar_type] || "Object"
            elsif json&.key? "bytesType"
              "String"
            elsif json&.key? "messageType"
              proto_to_ruby proto.message_type.message_full_name
            elsif json&.key? "enumType"
              proto_to_ruby proto.enum_type.enum_full_name
            elsif json&.key? "repeatedType"
              repeated_render proto, json
            elsif json&.key? "mapType"
              map_render proto, json
            else
              "Object"
            end
        end

        ##
        # The rendered type string.
        # @return [String]
        #
        attr_reader :render

        private

        def proto_to_ruby name
          name.split(".").map { |str| ActiveSupport::Inflector.upcase_first str }.join "::"
        end

        def repeated_render proto, json
          inner_type = TypePresenter.new proto.repeated_type.element_type, json["repeatedType"]["elementType"]
          "Array<#{inner_type.render}>"
        end

        def map_render proto, json
          proto = proto.map_type
          json = json["mapType"]
          key_type = TypePresenter.new proto.key_type, json["keyType"]
          value_type = TypePresenter.new proto.value_type, json["valueType"]
          "Hash{#{key_type.render}=>#{value_type.render}}"
        end

        SCALAR_TYPE_MAPPING = {
          TYPE_DOUBLE: "Float",
          TYPE_FLOAT: "Float",
          TYPE_INT64: "Integer",
          TYPE_UINT64: "Integer",
          TYPE_INT32: "Integer",
          TYPE_FIXED64: "Integer",
          TYPE_FIXED32: "Integer",
          TYPE_BOOL: "boolean",
          TYPE_STRING: "String",
          TYPE_UINT32: "Integer",
          TYPE_SFIXED32: "Integer",
          TYPE_SFIXED64: "Integer",
          TYPE_SINT32: "Integer",
          TYPE_SINT64: "Integer"
        }.freeze
        private_constant :SCALAR_TYPE_MAPPING
      end
    end
  end
end
