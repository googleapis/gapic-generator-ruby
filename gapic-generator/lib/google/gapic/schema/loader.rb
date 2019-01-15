# frozen_string_literal: true

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

require "google/api/annotations.pb"
require "google/gapic/schema/wrappers"
require "google/protobuf/descriptor.pb"

module Google
  module Gapic
    module Schema
      # rubocop:disable Metrics/ClassLength

      # Loader
      class Loader
        # Empty location for things with no comments.
        EMPTY = Google::Protobuf::SourceCodeInfo::Location.new

        # Initializes the loader
        def initialize
          @prior_messages = []
          @prior_enums = []
        end

        # rubocop:disable Metrics/AbcSize
        # rubocop:disable Metrics/MethodLength

        # Loads a file.
        #
        # @param file_descriptor [Google::Protobuf::FileDescriptorProto] the
        #   descriptor of the proto file.
        # @oaram file_to_generate [Boolean] Whether this file is to be
        #   generated.
        def load_file file_descriptor, file_to_generate
          # Setup.
          address = file_descriptor.package.split "."
          path = []

          # Load the docs.
          location = file_descriptor.source_code_info.location
          docs = location.each_with_object({}) do |l, ans|
            ans[l.path] = l
          end

          # Load top-level messages.
          messages = file_descriptor.message_type.each_with_index.map do |m, i|
            load_message m, address, docs, [4, i]
          end
          messages.each(&method(:update_fields!))

          # Load enums.
          enums = file_descriptor.enum_type.each_with_index.map do |e, i|
            load_enum e, address, docs, [5, i]
          end

          # Load services.
          services = file_descriptor.service.each_with_index.map do |s, i|
            load_service s, address, docs, [6, i]
          end

          # Construct and return the file.
          File.new file_descriptor, address, docs[path], messages, enums,
                   services, file_to_generate
        end

        # rubocop:enable Metrics/AbcSize
        # rubocop:enable Metrics/MethodLength

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
        # @param descriptor [Google::Protobuf::EnumDescriptorProto] the
        #   descriptor of this enum.
        # @param address [Enumerable<String>] The address of the parent.
        # @param docs [Hash<Enumerable<Integer>,
        #   Google::Protobuf::SourceCodeInfo::Location>]
        #   A mapping of a path to the docs. See Proto#docs for more info.
        # @param path [Enumerable<Integer>] The current path. This is used to
        #   get the docs for a proto. See Proto#docs for more info.
        # @return [Enum] The loaded enum.
        def load_enum descriptor, address, docs, path
          # Update Address.
          address = address.clone << descriptor.name

          # Load Enum Values
          values = descriptor.value.each_with_index.map do |value, i|
            load_enum_value value, address, docs, path + [2, i]
          end

          # Construct, cache and return enum.
          enum = Enum.new descriptor, address, docs[path], values
          @prior_enums << enum
          enum
        end

        # Loads an enum value.
        #
        # @param descriptor [Google::Protobuf::EnumValueDescriptorProto] the
        #   descriptor of this enum value.
        # @param address [Enumerable<String>] the address of the parent.
        # @param docs [Hash<Enumerable<Integer>,
        #   Google::Protobuf::SourceCodeInfo::Location>]
        #   A mapping of a path to the docs. See Proto#docs for more info.
        # @param path [Enumerable<Integer>] The current path. This is used to
        #   get the docs for a proto. See Proto#docs for more info.
        # @return [EnumValue] The loaded enum value.
        def load_enum_value descriptor, address, docs, path
          # Update Address.
          address = address.clone << descriptor.name

          # Construct and return value.
          EnumValue.new descriptor, address, docs[path]
        end

        # rubocop:disable Metrics/AbcSize
        # rubocop:disable Metrics/MethodLength

        # Loads a message. As a side effect, this alters @messages and @enums
        # with the nested messages that are found.
        #
        # @param descriptor [Google::Protobuf::DescriptorProto] the
        #   descriptor of this message.
        # @param address [Enumerable<String>] the address of the parent.
        # @param docs [Hash<Enumerable<Integer>,
        #   Google::Protobuf::SourceCodeInfo::Location>]
        #   A mapping of a path to the docs. See Proto#docs for more info.
        # @param path [Enumerable<Integer>] The current path. This is used to
        #   get the docs for a proto. See Proto#docs for more info.
        # @return [Message] The loaded message.
        def load_message descriptor, address, docs, path
          # Update Address.
          address = address.clone << descriptor.name

          # Load Children
          fields = descriptor.field.each_with_index.map do |f, i|
            load_field f, address, docs, path + [2, i]
          end
          extensions = descriptor.extension.each_with_index.map do |e, i|
            load_field e, address, docs, path + [6, i]
          end
          nested_messages = descriptor.nested_type.each_with_index.map do |m, i|
            load_message m, address, docs, path + [3, i]
          end
          nested_enums = descriptor.enum_type.each_with_index.map do |e, i|
            load_enum e, address, docs, path + [4, i]
          end

          # Construct, cache, and return.
          msg = Message.new(
            descriptor,
            address,
            docs[path],
            fields,
            extensions,
            nested_messages,
            nested_enums
          )
          @prior_messages << msg
          msg
        end

        # rubocop:enable Metrics/AbcSize
        # rubocop:enable Metrics/MethodLength

        # Loads a field.
        #
        # @param descriptor [Google::Protobuf::FieldDescriptorProto] the
        #   descriptor of this field.
        # @param address [Enumerable<String>] The address of the parent.
        # @param docs [Hash<Enumerable<Integer>,
        #   Google::Protobuf::SourceCodeInfo::Location>]
        #   A mapping of a path to the docs. See Proto#docs for more info.
        # @param path [Enumerable<Integer>] The current path. This is used to
        #   get the docs for a proto. See Proto#docs for more info.
        # @return [Field] The loaded field.
        def load_field descriptor, address, docs, path
          # Update address.
          address = address.clone << descriptor.name

          # Construct and return the field.
          Field.new(
            descriptor,
            address,
            docs[path],
            cached_message(descriptor.type_name),
            cached_enum(descriptor.type_name)
          )
        end

        # Loads a service.
        #
        # @param descriptor [Google::Protobuf::ServiceDescriptorProto] the
        #   descriptor of this service.
        # @param address [Enumerable<String>] The address of the parent.
        # @param docs [Hash<Enumerable<Integer>,
        #   Google::Protobuf::SourceCodeInfo::Location>]
        #   A mapping of a path to the docs. See Proto#docs for more info.
        # @param path [Enumerable<Integer>] The current path. This is used to
        #   get the docs for a proto. See Proto#docs for more info.
        # @return [Service] The loaded service.
        def load_service descriptor, address, docs, path
          # Update the address.
          address = address.clone << descriptor.name

          # Load children
          methods = descriptor.method.each_with_index.map do |m, i|
            load_method m, address, docs, path + [2, i]
          end

          # Construct and return the service.
          Service.new(
            descriptor,
            address,
            docs[path],
            methods
          )
        end

        # Loads a method.
        #
        # @param descriptor [Google::Protobuf::MethodDescriptorProto] the
        #   descriptor of this service.
        # @param address [Enumerable<String>] The address of the parent.
        # @param docs [Hash<Enumerable<Integer>,
        #   Google::Protobuf::SourceCodeInfo::Location>]
        #   A mapping of a path to the docs. See Proto#docs for more info.
        # @param path [Enumerable<Integer>] The current path. This is used to
        #   get the docs for a proto. See Proto#docs for more info.
        # @return [Method] The loaded method.
        def load_method descriptor, address, docs, path
          # Update the address.
          address = address.clone << descriptor.name

          # Construct and return the method.
          Method.new(
            descriptor,
            address,
            docs[path],
            cached_message(descriptor.input_type),
            cached_message(descriptor.output_type)
          )
        end

        # Retrieves an Enum if it has been seen before.
        #
        # @param type_name [String] the type name of the enum.
        # @return [Enum | nil] The enum if it has already been seen or nil if
        #   no enum can be found.
        def cached_enum type_name
          # Remove leading dot.
          type_name = type_name[1..-1] if type_name && type_name[0] == "."

          # Create an address from the type.
          address = type_name.split "."

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
          type_name = type_name[1..-1] if type_name && type_name[0] == "."

          # Create an address from the type.
          address = type_name.split "."

          # Check cache.
          @prior_messages.find { |m| m.address == address }
        end
      end

      # rubocop:enable Metrics/ClassLength
    end
  end
end
