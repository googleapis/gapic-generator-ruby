# Copyright 2018 Google LLC
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

require 'protobuf/descriptors'

module Google
  module Gapic
    module Schema
      # Base class for all generic proto types including: enums, messages, methods
      # and services.
      #
      # @!attribute [r] descriptor
      #   @ return [Object] the descriptor of the proto
      # @!attribute [r] address
      #   @ return [Enumerable<String>] The address of the proto.
      class Proto
        extend Forwardable
        attr_reader :descriptor, :address, :docs

        # Initializes a Proto object.
        # @param descriptor [Object] the protobuf
        #   representation of this service.
        def initialize(descriptor, address, docs)
          @descriptor = descriptor
          @address = address
          @docs = docs
        end

        def_delegators(
          :docs,
          *Google::Protobuf::SourceCodeInfo::Location.all_fields.map{ |f| f.name.to_sym })
      end

      # Wrapper for aprotobuf service.
      #
      # @!attribute [r] methods
      #   @ return [Enumerable<Method>] the methods of this service.
      class Service < Proto
        extend Forwardable
        attr_reader :methods

        # Initializes a Service object.
        # @param descriptor [Google::Protobuf::ServiceDescriptorProto] the protobuf
        #   representation of this service.
        def initialize(descriptor, address, docs, methods)
          super(descriptor, address, docs)
          @methods = methods || {}
        end

        # Delegate the getters for the descriptor fields to the descriptor.
        def_delegators(
          :descriptor,
          *Google::Protobuf::ServiceDescriptorProto.all_fields.map{ |f| f.name.to_sym })
      end

      # Wrapper for aprotobuf method.
      #
      # @!attribute [r] input
      #   @ return [Message] the input message of this method.
      # @!attribute [r] output
      #   @ return [Message] the output message of this method.
      class Method < Proto
        extend Forwardable
        attr_reader :input, :output

        # Initializes a method object.
        # @param descriptor [Google::Protobuf::MethodDescriptorProto] the protobuf
        #   representation of this service.
        def initialize(descriptor, address, docs, input, output)
          super(descriptor, address, docs)
          @input = input
          @output = output
        end

        # Delegate the getters for the descriptor fields to the descriptor.
        def_delegators(
          :descriptor,
          *Google::Protobuf::MethodDescriptorProto.all_fields.map{ |f| f.name.to_sym })
      end

      # Wrapper for aprotobuf method.
      #
      # @!attribute [r] messages
      #   @ return [Message] the messages contained in this file.
      # @!attribute [r] enums
      #   @ return [Message] the enums contained in this file.
      # @!attribute [r] services
      #   @ return [Message] the services contained in this file.
      class File < Proto
        extend Forwardable
        attr_reader :messages, :enums, :services

        # Initializes a message object.
        # @param descriptor [Google::Protobuf::DescriptorProto] the protobuf
        #   representation of this service.
        def initialize(descriptor, address, docs, messages, enums, services, generate)
          super(descriptor, address, docs)
          @messages = messages || {}
          @enums = enums || {}
          @services = services || {}
          @generate = generate
        end

        def generate?
          @generate
        end

        # Delegate the getters for the descriptor fields to the descriptor.
        def_delegators(
          :descriptor,
          *Google::Protobuf::FileDescriptorProto.all_fields.map{ |f| f.name.to_sym })
      end

      # Wrapper for a protobuf enum.
      #
      # @!attribute [r] values
      #   @ return [EnumValue] the EnumValues contained in this file.
      class Enum < Proto
        extend Forwardable
        attr_reader :values

        # Initializes a message object.
        # @param descriptor [Google::Protobuf::DescriptorProto] the protobuf
        #   representation of this service.
        def initialize(descriptor, address, docs, values)
          super(descriptor, address, docs)
          @values = values || {}
        end

        # Delegate the getters for the descriptor fields to the descriptor.
        def_delegators(
          :descriptor,
          *Google::Protobuf::EnumDescriptorProto.all_fields.map{ |f| f.name.to_sym })
      end

      # Wrapper for a protobuf Enum Value.
      class EnumValue < Proto
        extend Forwardable

        # Initializes a message object.
        # @param descriptor [Google::Protobuf::DescriptorProto] the protobuf
        #   representation of this service.
        def initialize(descriptor, address, docs)
          super(descriptor, address, docs)
        end

        # Delegate the getters for the descriptor fields to the descriptor.
        def_delegators(
          :descriptor,
          *Google::Protobuf::EnumValueDescriptorProto.all_fields.map{ |f| f.name.to_sym })
      end

      # Wrapper for a protobuf Message.
      #
      # @!attribute [r] fields
      #   @ return [Enumerable<Field>] the fields of a message.
      # @!attribute [r] extensions
      #   @ return [Enumerable<Field>] the extensions of a message.
      # @!attribute [r] nested_messages
      #   @ return [Enumerable<Message>] the nested message declarations of a
      #      message.
      # @!attribute [r] nested_enums
      #   @ return [Enumerable<Enum>] the nested enum declarations of a message.
      class Message < Proto
        extend Forwardable
        attr_reader :fields, :extensions, :nested_messages, :nested_enums

        # Initializes a message object.
        # @param descriptor [Google::Protobuf::DescriptorProto] the protobuf
        #   representation of this service.
        def initialize(descriptor, address, docs, fields, extensions, nested_messages, nested_enums)
          super(descriptor, address, docs)
          @fields = fields || {}
          @extensions = extensions || {}
          @nested_messages = nested_messages || {}
          @nested_enums = nested_enums || {}
        end

        # Delegate the getters for the descriptor fields to the descriptor.
        def_delegators(
          :descriptor,
          *Google::Protobuf::DescriptorProto.all_fields.map{|f| f.name.to_sym })
      end

      # Wrapper for a protobuf Field.
      #
      # @!attribute [r] message
      #   @ return [Message | nil] the message if the field is a message, nil
      #      otherwise.
      # @!attribute [r] enum
      #   @ return [Enum | nil] the enum if the field is an enum, nil
      #      otherwise.
      class Field < Proto
        extend Forwardable
        attr_reader :message, :enum
        attr_writer :message, :enum

        # Initializes a message object.
        # @param descriptor [Google::Protobuf::FieldDescriptorProto] the protobuf
        #   representation of this service.
        def initialize(descriptor, address, docs, message, enum)
          super(descriptor, address, docs)
          @message = message
          @enum = enum
        end

        # Delegate the getters for the descriptor fields to the descriptor.
        def_delegators(
          :descriptor,
          *Google::Protobuf::FieldDescriptorProto.all_fields.map{ |f| f.name.to_sym })
      end
    end
  end
end
