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

require 'google/gapic/schema/wrappers'

module Google
  module Gapic
    module Schema
      class Loader
        EMPTY = Google::Protobuf::SourceCodeInfo::Location.new

        # Initializes the loader
        def initialize package
          @package = package
          @prior_messages = []
          @prior_enums = []
        end

        # Loads a file.
        #
        # @param file_descriptor [Google::Protobuf::FileDescriptorProto] the
        #   descriptor of the proto file.
        # @param prior_messages [Hash<Enumerable<String>, Message>] a hash of
        #   addresses mapped to messages that have already been seen.
        # @param prior_enums [Hash<Enumerable<String>, Enum>] a hash of addresses
        #   mapped to enums that have already been seen before.
        # @return [File] the wrapped protofile.
        def load_file file_descriptor
          # Setup.
          address = file_descriptor.package.split('.')
          path = []

          # Load the docs.
          docs = file_descriptor.source_code_info.location.reduce({}) do |ans, l|
            ans[l.path] = l
            ans
          end

          # Load enums.
          enums = file_descriptor.enum_type.each_with_index.map do |e, i|
            load_enum(e, address, docs, [5, i])
          end

          # Load top-level messages.
          messages = file_descriptor.message_type.each_with_index.map do |m, i|
            load_message(m, address, docs, [4, i])
          end
          messages.each(&method(:update_fields!))

          # Load services for files that should be generated.
          file_to_generate = file_descriptor.package.start_with?(@package)
          services = []
          if file_to_generate
            services = file_descriptor.service.each_with_index.map do |s, i|
              load_service(s, address, docs, [6, i])
            end
          end

          # Construct and return the file.
          File.new(
            file_descriptor,
            address,
            docs[path],
            messages,
            enums,
            services, 
            file_to_generate)
        end

        # Updates the fields of a message and it's nested messages.
        #
        # @param message [Message] the message whose fields and nested messages
        #    to update.
        def update_fields! message
          message.nested_messages.each(&method(:update_fields!))
          message.fields.each do |f|
            f.message = cached_message(f.type_name)
            f.enum = cached_enum(f.type_name)
          end
        end

        # Loads an enum.
        #
        # @param descriptor [Google::Protobuf::EnumDescriptorProto] the descriptor
        #   of this enum.
        # @param address [Enumerable<String>] the address of the parent.
        # @return [Hash<Enumerable<String>, Enum>] A hash containg the enum
        #   address mapped to the enum.
        def load_enum descriptor, address, docs, path
          # Update Address.
          address = address.clone << descriptor.name

          # Load Enum Values
          values = descriptor.value.each_with_index.map do |value, i|
            load_enum_value(value, address, docs, path + [2, i])
          end

          # Construct, cache and return enum.
          enum = Enum.new(descriptor, address, docs[path], values)
          @prior_enums << enum
          enum
        end

        # Loads an enum value.
        #
        # @param descriptor [Google::Protobuf::EnumValueDescriptorProto] the
        #   descriptor of this enum value.
        # @param address [Enumerable<String>] the address of the parent.
        # @return [Hash<Enumerable<String>, Enum>] A hash containg the enum value
        #   address mapped to the enum value.
        def load_enum_value descriptor, address, docs, path
          # Update Address.
          address = address.clone << descriptor.name

          # Construct and return value.
          EnumValue.new(descriptor, address, docs[path])
        end


        # Loads a message. As a side effect, this alters @messages and @enums
        # with the nested messages that are found.
        #
        # @param descriptor [Google::Protobuf::DescriptorProto] the
        #   descriptor of this message.
        # @param address [Enumerable<String>] the address of the parent.
        # @return [Hash<Enumerable<String>, Message>] A hash containg the message
        #   address mapped to the message.
        def load_message descriptor, address, docs, path
          # Update Address.
          address = address.clone << descriptor.name

          # Load Children
          fields = descriptor.field.each_with_index.map do |f, i|
            load_field(f, address, docs, path + [2, i])
          end
          extensions = descriptor.extension.each_with_index.map do |e, i|
            load_field(e, address, docs, path + [6, i])
          end
          nested_messages = descriptor.nested_type.each_with_index.map do |m, i|
            load_message(m, address, docs, path + [3, i])
          end
          nested_enums = descriptor.enum_type.each_with_index.map do |e, i|
            load_enum(e, address, docs, path + [4, i])
          end

          # Construct, cache, and return.
          msg = Message.new(
            descriptor,
            address,
            docs[path],
            fields,
            extensions,
            nested_messages,
            nested_enums)
          @prior_messages << msg
          msg
        end

        # Loads a field.
        #
        # @param descriptor [Google::Protobuf::FieldDescriptorProto] the
        #   descriptor of this field.
        # @param address [Enumerable<String>] the address of the parent.
        # @return [Hash<Enumerable<String>, Field>] A hash containg the field
        #   address mapped to the field.
        def load_field descriptor, address, docs, path
          # Update address.
          address = address.clone << descriptor.name

          # Construct and return the field.
          Field.new(
            descriptor,
            address,
            docs[path],
            cached_message(descriptor.type_name),
            cached_enum(descriptor.type_name))
        end

        # Loads a service.
        #
        # @param descriptor [Google::Protobuf::ServiceDescriptorProto] the
        #   descriptor of this service.
        # @param address [Enumerable<String>] the address of the parent.
        # @return [Hash<Enumerable<String>, Service>] A hash containg the service
        #   address mapped to the service.
        def load_service descriptor, address, docs, path
          # Update the address.
          address = address.clone << descriptor.name

          # Load children
          methods = descriptor.method.each_with_index.map do |m, i|
            load_method(m, address, docs, path + [2, i])
          end

          # Construct and return the service.
          Service.new(
            descriptor,
            address,
            docs[path],
            methods)
        end

        # Loads a method.
        #
        # @param descriptor [Google::Protobuf::MethodDescriptorProto] the
        #   descriptor of this service.
        # @param address [Enumerable<String>] the address of the parent.
        # @return [Hash<Enumerable<String>, Method>] A hash containg the method
        #   address mapped to the method.
        def load_method descriptor, address, docs, path
          # Update the address.
          address = address.clone << descriptor.name

          # Construct and return the method.
          Method.new(
            descriptor,
            address,
            docs[path],
            cached_message(descriptor.input_type),
            cached_message(descriptor.output_type))
        end

        # Retrieves an Enum if it has been seen before.
        #
        # @param type_name [String] the type name of the enum.
        # @return [Enum | nil] The enum if it has already been seen or nil if
        #   no enum can be found.
        def cached_enum type_name
          # Remove leading dot.
          type_name = type_name[1..-1 ] if type_name && type_name[0] == '.'

          # Create an address from the type.
          address = type_name.split('.')

          # Check cache.
          @prior_enums.find { |e| e.address == address }
        end

        # Retrieves a Message if it has been seen before.
        #
        # @param type_name [String] the type name of the message.
        # @return [Enum | nil] The message if it has already been seen or nil if
        #   no message can be found.
        def cached_message type_name
          # Remove leading dot.
          type_name = type_name[1..-1 ] if type_name && type_name[0] == '.'

          # Create an address from the type.
          address = type_name.split('.')

          # Check cache.
          @prior_messages.find { |m| m.address == address }
        end
      end
    end
  end
end
