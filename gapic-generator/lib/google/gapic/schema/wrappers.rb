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

module Google
  module Gapic
    module Schema
      # Base class for all generic proto types including: enums, messages,
      # methods and services.
      #
      # @!attribute [r] descriptor
      #   @return [Object] the descriptor of the proto
      # @!attribute [r] address
      #   @return [Enumerable<String>] A sequence of names which determines
      #     the address of the proto. For example, a message named "Foo" in
      #     package "google.example.v1" will have the address:
      #     ["google", "example", "v1", "Foo"].
      #     and a nested message within "Foo" named "Bar" will have the address:
      #     ["google", "example", "v1", "Foo", "Bar"]
      # @!attribute [r] docs
      #   @return [Google::Protobuf::SourceCodeInfo::Location]
      #     A Location identifies a piece of source code in a .proto file which
      #     corresponds to a particular definition.  This information is
      #     intended to be useful to IDEs, code indexers, documentation
      #     generators, and similar tools.
      #
      #     For example, say we have a file like:
      #       message Foo {
      #         optional string foo = 1;
      #       }
      #     Let's look at just the field definition:
      #       optional string foo = 1;
      #       ^       ^^     ^^  ^  ^^^
      #       a       bc     de  f  ghi
      #     We have the following locations:
      #       span   path               represents
      #       [a,i)  [ 4, 0, 2, 0 ]     The whole field definition.
      #       [a,b)  [ 4, 0, 2, 0, 4 ]  The label (optional).
      #       [c,d)  [ 4, 0, 2, 0, 5 ]  The type (string).
      #       [e,f)  [ 4, 0, 2, 0, 1 ]  The name (foo).
      #       [g,h)  [ 4, 0, 2, 0, 3 ]  The number (1).
      #
      #     Notes:
      #     - A location may refer to a repeated field itself (i.e. not to any
      #       particular index within it).  This is used whenever a set of
      #       elements are logically enclosed in a single code segment.  For
      #       example, an entire extend block (possibly containing multiple
      #       extension definitions) will have an outer location whose path
      #       refers to the "extensions" repeated field without an index.
      #     - Multiple locations may have the same path.  This happens when a
      #       single logical declaration is spread out across multiple places.
      #       The most obvious example is the "extend" block again -- there may
      #       be multiple extend blocks in the same scope, each of which will
      #       have the same path.
      #     - A location's span is not always a subset of its parent's span.
      #       For example, the "extendee" of an extension declaration appears at
      #       the beginning of the "extend" block and is shared by all
      #       extensions within the block.
      #     - Just because a location's span is a subset of some other
      #       location's span does not mean that it is a descendent. For
      #       example, a "group" defines both a type and a field in a single
      #       declaration. Thus, the locations corresponding to the type and
      #       field and their components will overlap.
      #     - Code which tries to interpret locations should probably be
      #       designed to ignore those that it doesn't understand, as more types
      #       of locations could be recorded in the future.
      class Proto
        extend Forwardable
        attr_reader :descriptor, :address, :docs
        attr_accessor :parent

        # Initializes a Proto object.
        # @param descriptor [Object] the protobuf
        #   representation of this service.
        # @param address [Enumerable<String>] The address of the proto. See
        #   #address for more info.
        # @param docs [Google::Protobuf::SourceCodeInfo::Location] The docs
        #   of the proto. See #docs for more info.
        def initialize descriptor, address, docs
          @descriptor = descriptor
          @address = address
          @docs = docs
        end

        # @!method path
        #   @return [Array<Integer>]
        #     Identifies which part of the FileDescriptorProto was defined at
        #     this location.
        #
        #     Each element is a field number or an index.  They form a path from
        #     the root FileDescriptorProto to the place where the definition.
        #     For example, this path:
        #       [ 4, 3, 2, 7, 1 ]
        #     refers to:
        #       file.message_type(3)  // 4, 3
        #           .field(7)         // 2, 7
        #           .name()           // 1
        #     This is because FileDescriptorProto.message_type has field number
        #     4:
        #       repeated DescriptorProto message_type = 4;
        #     and DescriptorProto.field has field number 2:
        #       repeated FieldDescriptorProto field = 2;
        #     and FieldDescriptorProto.name has field number 1:
        #       optional string name = 1;
        #
        #     Thus, the above path gives the location of a field name.  If we
        #     removed the last element:
        #       [ 4, 3, 2, 7 ]
        #     this path refers to the whole field declaration (from the
        #     beginning of the label to the terminating semicolon).
        # @!method span
        #   @return [Array<Integer
        #     Always has exactly three or four elements: start line, start
        #     column, end line (optional, otherwise assumed same as start line),
        #     end column. These are packed into a single field for efficiency.
        #     Note that line and column numbers are zero-based -- typically you
        #     will want to add 1 to each before displaying to a user.
        # @!method leading_comments
        #   @return [String]
        #     If this SourceCodeInfo represents a complete declaration, these
        #     are any comments appearing before and after the declaration which
        #     appear to be attached to the declaration.
        #
        #     A series of line comments appearing on consecutive lines, with no
        #     other tokens appearing on those lines, will be treated as a single
        #     comment.
        #
        #     leading_detached_comments will keep paragraphs of comments that
        #     appear before (but not connected to) the current element. Each
        #     paragraph, separated by empty lines, will be one comment element
        #     in the repeated field.
        #
        #     Only the comment content is provided; comment markers (e.g. //)
        #     are stripped out.  For block comments, leading whitespace and an
        #     asterisk will be stripped from the beginning of each line other
        #     than the first. Newlines are included in the output.
        #
        #     Examples:
        #
        #       optional int32 foo = 1;  // Comment attached to foo.
        #       // Comment attached to bar.
        #       optional int32 bar = 2;
        #
        #       optional string baz = 3;
        #       // Comment attached to baz.
        #       // Another line attached to baz.
        #
        #       // Comment attached to qux.
        #       //
        #       // Another line attached to qux.
        #       optional double qux = 4;
        #
        #       // Detached comment for corge. This is not leading or trailing
        #       // comments to qux or corge because there are blank lines
        #       // separating it from both.
        #
        #       // Detached comment for corge paragraph 2.
        #
        #       optional string corge = 5;
        #       /* Block comment attached
        #        * to corge.  Leading asterisks
        #        * will be removed. */
        #       /* Block comment attached to
        #        * grault. */
        #       optional int32 grault = 6;
        #
        #       // ignored detached comments.
        # @!method trailing_comments
        #   @return [String] (see #leading_comments)
        # @!method leading_detached_comments
        #   @return [Array<String>] (see #leading_comments)
        def_delegators(
          :docs,
          :path,
          :leading_comments,
          :trailing_comments,
          :leading_detached_comments
        )
      end

      # Wrapper for a protobuf service.
      #
      # @!attribute [r] methods
      #   @ return [Enumerable<Method>] The methods of this service.
      class Service < Proto
        extend Forwardable
        attr_reader :methods

        # Initializes a Service object.
        # @param descriptor [Google::Protobuf::ServiceDescriptorProto] the
        #   protobuf representation of this service.
        # @param address [Enumerable<String>] The address of the proto. See
        #   #address for more info.
        # @param docs [Google::Protobuf::SourceCodeInfo::Location] The docs
        #   of the proto. See #docs for more info.
        # @param methods [Enumerable<Method>] The methods of this service.
        def initialize descriptor, address, docs, methods
          super descriptor, address, docs
          @methods = methods || []
          @methods.each { |m| m.parent = self }
        end

        # @return [String] The hostname for this service
        #   (e.g. "foo.googleapis.com"). This should be specified with no
        #   prefix.
        def host
          options[:".google.api.default_host"] if options
        end

        # @return [Array<String>] The OAuth scopes information for the client.
        def scopes
          String(options[:".google.api.oauth_scopes"]).split "," if options
        end

        # @return [String] Ruby Package
        def ruby_package
          return nil if parent.nil?

          parent.ruby_package
        end

        # @return [Google::Api::Package] Packaging information.
        #   See `google/api/client.proto`.
        def client_package
          return nil if parent.nil?

          parent.client_package
        end

        # @!method name
        #   @return [String] the unqualified name of the service.
        # @!method options
        #   @return [Google::Protobuf::ServiceOptions] the options of this
        #     service.
        def_delegators(
          :descriptor,
          :name,
          :options
        )
      end

      # Wrapper for a protobuf method.
      #
      # @!attribute [r] input
      #   @ return [Message] The input message of this method.
      # @!attribute [r] output
      #   @ return [Message] The output message of this method.
      class Method < Proto
        extend Forwardable
        attr_reader :input, :output

        # Initializes a method object.
        # @param descriptor [Google::Protobuf::MethodDescriptorProto] the
        #   protobuf representation of this service.
        # @param address [Enumerable<String>] The address of the proto. See
        #   #address for more info.
        # @param docs [Google::Protobuf::SourceCodeInfo::Location] The docs
        #   of the proto. See #docs for more info.
        # @param input [Message] The input message of this method.
        # @param output [Message] The output message of this method.
        def initialize descriptor, address, docs, input, output
          super descriptor, address, docs
          @input = input
          @output = output
        end

        # @return [Array<Array<String>>] The parameter lists
        #   defined for this method. See `google/api/client.proto`.
        def signatures
          return [] if options.nil?

          Array(options[:".google.api.method_signature"]).map do |sig|
            String(sig).split ","
          end
        end

        # @return [Google::Longrunning::OperationInfo] Additional information
        #   regarding long-running operations.
        #   In particular, this specifies the types that are returned from
        #   long-running operations.
        #   Required for methods that return `google.longrunning.Operation`;
        #   invalid otherwise.
        def operation_info
          options[:".google.longrunning.operation_info"] if options
        end

        # @return [Google::Api::HttpRule] The HTTP bindings for this method. See
        #   `google/api/http.proto`.
        def http
          options[:".google.api.http"] if options
        end

        # @!method name
        #   @return [String] the unqualified name of the method.
        # @!method options
        #   @return [Google::Protobuf::MethodOptions] the options of this
        #     method.
        # @!method client_streaming
        #   @return [Boolean]
        #     Identifies if client streams multiple client messages.
        # @!method server_streaming
        #   @return [Boolean]
        #     Identifies if server streams multiple server messages.
        def_delegators(
          :descriptor,
          :name,
          :options,
          :client_streaming,
          :server_streaming
        )
      end

      # Wrapper for a protobuf file.
      #
      # @!attribute [r] messages
      #   @ return [Enumerable<Message>] The top level messages contained in
      #     this file.
      # @!attribute [r] enums
      #   @ return [Enumerable<Enum>] The top level enums contained in this
      #     file.
      # @!attribute [r] services
      #   @ return [Enumerable<Service>] The services contained in this file.
      class File < Proto
        extend Forwardable
        attr_reader :messages, :enums, :services, :registry

        # Initializes a message object.
        # @param descriptor [Google::Protobuf::DescriptorProto] the protobuf
        #   representation of this service.
        # @param address [Enumerable<String>] The address of the proto. See
        #   #address for more info.
        # @param docs [Google::Protobuf::SourceCodeInfo::Location] The docs
        #   of the proto. See #docs for more info.
        # @param messages [Enumerable<Message>] The top level messages of this
        #   file.
        # @param enums [Enumerable<Enum>] The top level enums of this file.
        # @param services [Enumerable<Service>] The services of this file.
        # @param generate [Boolean] Whether this file should be generated.
        def initialize descriptor, address, docs, messages, enums, services,
                       generate, registry
          super descriptor, address, docs
          @messages = messages || []
          @enums = enums || []
          @services = services || []
          @generate = generate
          @registry = registry

          # Apply parent
          @messages.each { |m| m.parent = self }
          @enums.each    { |m| m.parent = self }
          @services.each { |m| m.parent = self }
        end

        def lookup address
          address = address.split(".").reject(&:empty?).join(".")
          @registry[address]
        end

        def generate?
          @generate
        end

        # @return [String] Ruby Package
        def ruby_package
          options[:ruby_package] if options
        end

        # @return [Google::Api::Package] Packaging information.
        #   See `google/api/client.proto`.
        def client_package
          options[:".google.api.client_package"] if options
        end

        # @!method name
        #   @return [String] file name, relative to root of source tree.
        # @!method package
        #   @return [String] package of the file. e.g. "foo", "foo.bar", etc.
        # @!method dependency
        #   @return [Array<String>] Names of files imported by this file.
        # @!method public_dependency
        #   @return [Array<Integer>] Indexes of the public imported files in the
        #     dependency list returned by #dependency.
        # @!method options
        #   @return [Google::Protobuf::FileOptions] the options of this file.
        def_delegators(
          :descriptor,
          :name,
          :package,
          :dependency,
          :public_dependency,
          :options
        )
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
        # @param address [Enumerable<String>] The address of the proto. See
        #   #address for more info.
        # @param docs [Google::Protobuf::SourceCodeInfo::Location] The docs
        #   of the proto. See #docs for more info.
        # @param values [Enumerable<EnumValue>] The EnumValues of this enum.
        def initialize descriptor, address, docs, values
          super descriptor, address, docs
          @values = values || []
          @values.each { |v| v.parent = self }
        end

        # @!method name
        #   @return [String] the unqualified name of the Enum.
        # @!method options
        #   @return [Array<Google::Protobuf::EnumOptions>] the options of the
        #     enum.
        def_delegators(
          :descriptor,
          :name,
          :options
        )
      end

      # Wrapper for a protobuf Enum Value.
      class EnumValue < Proto
        extend Forwardable

        # Initializes a message object.
        # @param descriptor [Google::Protobuf::DescriptorProto] the protobuf
        #   representation of this service.
        # @param address [Enumerable<String>] The address of the proto. See
        #   #address for more info.
        # @param docs [Google::Protobuf::SourceCodeInfo::Location] The docs
        #   of the proto. See #docs for more info.
        def initialize descriptor, address, docs
          super descriptor, address, docs
        end

        # @!method name
        #   @return [String] the unqualified name of the EnumValue
        # @!method number
        #   @return [Integer] The number value.
        # @!method options
        #   @return [Array<Google::Protobuf::EnumValueOptions>]
        #     The options of the enum value.
        def_delegators(
          :descriptor,
          :name,
          :number,
          :options
        )
      end

      # Wrapper for a protobuf Message.
      #
      # @!attribute [r] fields
      #   @ return [Enumerable<Field>] The fields of a message.
      # @!attribute [r] extensions
      #   @ return [Enumerable<Field>] The extensions of a message.
      # @!attribute [r] nested_messages
      #   @ return [Enumerable<Message>] The nested message declarations of a
      #      message.
      # @!attribute [r] nested_enums
      #   @ return [Enumerable<Enum>] The nested enum declarations of a message.
      class Message < Proto
        extend Forwardable
        attr_reader :fields, :extensions, :nested_messages, :nested_enums

        # Initializes a message object.
        # @param descriptor [Google::Protobuf::DescriptorProto] the protobuf
        #   representation of this service.
        # @param address [Enumerable<String>] The address of the proto. See
        #   #address for more info.
        # @param docs [Google::Protobuf::SourceCodeInfo::Location] The docs
        #   of the proto. See #docs for more info.
        # @param fields [Enumerable<Field>] The fields of this message.
        # @param extensions [Enumerable<Field>] The extensions of this message.
        # @param nested_messages [Enumerable<Message>] The nested message
        #   declarations of this message.
        # @param nested_enums [Enumerable<Enum>] The nested enum declarations
        #   of this message.
        def initialize descriptor, address, docs, fields, extensions,
                       nested_messages, nested_enums
          super descriptor, address, docs
          @fields = fields || []
          @extensions = extensions || []
          @nested_messages = nested_messages || []
          @nested_enums = nested_enums || []

          @fields.each          { |f| f.parent = self }
          @extensions.each      { |x| x.parent = self }
          @nested_messages.each { |m| m.parent = self }
          @nested_enums.each    { |e| e.parent = self }
        end

        # @!method name
        #   @return [String] the unqualified name of the message.
        # @!method oneof_decl
        #   @return [Array<Google::Protobuf::OneofDescriptorProto>]
        #     The oneofs declared in this message.
        # @!method options
        #   @return [Array<Google::Protobuf::MessageOptions>]
        #     The options of this meessage.
        def_delegators(
          :descriptor,
          :name,
          :oneof_decl,
          :options
        )
      end

      # Wrapper for a protobuf Field.
      #
      # @!attribute [r] message
      #   @ return [Message | nil] The message if the field is a message, nil
      #      otherwise.
      # @!attribute [r] enum
      #   @ return [Enum | nil] The enum if the field is an enum, nil
      #      otherwise.
      class Field < Proto
        extend Forwardable
        attr_reader :message, :enum
        attr_writer :message, :enum

        # Initializes a message object.
        # @param descriptor [Google::Protobuf::FieldDescriptorProto] the
        #   protobuf representation of this service.
        # @param address [Enumerable<String>] The address of the proto. See
        #   #address for more info.
        # @param docs [Google::Protobuf::SourceCodeInfo::Location] The docs
        #   of the proto. See #docs for more info.
        # @param message [Message | nil] The message if the field is a message,
        #   nil otherwise.
        # @param enum [Enum | nil] The enum if the field is an enum, nil
        #   otherwise.
        def initialize descriptor, address, docs, message, enum
          super descriptor, address, docs
          @message = message
          @enum = enum
        end

        # Whether this field is a message.
        # @return [Boolean]
        def message?
          return true if @message

          false
        end

        # Whether this field is an enum.
        # @return [Boolean]
        def enum?
          return true if @enum

          false
        end

        # @return [Google::Api::Resource] A representation of the resource.
        #   This is generally intended to be attached to the "name" field.
        #   See `google/api/resource.proto`.
        def resource
          options[:".google.api.resource"] if options
        end

        # @return [String] A reference to another resource message or resource
        #   definition. See `google/api/resource.proto`.
        def resource_reference
          options[:".google.api.resource_reference"] if options
        end

        # @return [Array<Google::Api::FieldBehavior>] A designation of a
        #   specific field behavior (required, output only, etc.) in protobuf
        #   messages.
        def field_behavior
          return options[:".google.api.field_behavior"] if options

          []
        end

        # Specifically denotes a field as optional. While all fields in protocol
        # buffers are optional, this may be specified for emphasis if
        # appropriate.
        def optional?
          field_behavior.include? Google::Api::FieldBehavior::OPTIONAL
        end

        # Denotes a field as required. This indicates that the field **must** be
        # provided as part of the request, and failure to do so will cause an
        # error (usually `INVALID_ARGUMENT`).
        def required?
          field_behavior.include? Google::Api::FieldBehavior::REQUIRED
        end

        # Denotes a field as output only. This indicates that the field is
        # provided in responses, but including the field in a request does
        # nothing (the server *must* ignore it and *must not* throw an error as
        # a result of the field's presence).
        def output_only?
          field_behavior.include? Google::Api::FieldBehavior::OUTPUT_ONLY
        end

        # Denotes a field as input only. This indicates that the field is
        # provided in requests, and the corresponding field is not included in
        # output.
        def input_only?
          field_behavior.include? Google::Api::FieldBehavior::INPUT_ONLY
        end

        # Denotes a field as immutable. This indicates that the field may be set
        # once in a request to create a resource, but may not be changed
        # thereafter.
        def immutable?
          field_behavior.include? Google::Api::FieldBehavior::IMMUTABLE
        end

        # @!method name
        #   @return [String] the unqualified name of the field.
        # @!method number
        #   @return [Integer] the number of the field.
        # @!method label
        #   @return [Google::Protobuf::FieldDescriptorProto::Label]
        #     The label of the field.
        # @!method type
        #   @return [Google::Protobuf::FieldDescriptorProto::Type]
        #     If type_name is set, this need not be set.  If both this and
        #     type_name are set, this must be one of TYPE_ENUM, TYPE_MESSAGE or
        #     TYPE_GROUP.
        # @!method type_name
        #   @return [String]
        #     For message and enum types, this is the name of the type.  If the
        #     name starts with a '.', it is fully-qualified.  Otherwise,
        #     C++-like scoping rules are used to find the type (i.e. first the
        #     nested types within this message are searched, then within the
        #     parent, on up to the root namespace).
        # @!method default_value
        #   @return [String]
        #     For numeric types, contains the original text representation of
        #     the value. For booleans, "true" or "false". For strings, contains
        #     the default text contents (not escaped in any way). For bytes,
        #     contains the C escaped value.  All bytes >= 128 are escaped.
        # @!method oneof_index
        #   @return [Integer]
        #     If set, gives the index of a oneof in the containing type's
        #     oneof_decl list.  This field is a member of that oneof.
        # @!method json_name
        #   @return [String]
        #     JSON name of this field. The value is set by protocol compiler. If
        #     the user has set a "json_name" option on this field, that option's
        #     value will be used. Otherwise, it's deduced from the field's name
        #     by converting it to camelCase.
        # @!method options
        #   @return [Google::Protobuf::FieldOptions] the options of this field.
        def_delegators(
          :descriptor,
          :name,
          :number,
          :label,
          :type,
          :type_name,
          :default_value,
          :oneof_index,
          :json_name,
          :options
        )
      end
    end
  end
end
