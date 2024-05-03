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

require "gapic/formatting_utils"
require "gapic/path_pattern"
require "gapic/schema/proto_tools"

require "google/cloud/tools/snippetgen/configlanguage/v1/snippet_config_language_pb"

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

      attr_reader :descriptor
      attr_reader :address
      attr_reader :docs

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
        @options_extensions = nil
      end

      # Returns the "root" of this schema.
      # @return [Gapic::Schema::Api]
      def containing_api
        parent&.containing_api
      end

      # Returns the file containing this proto entity
      # @return [Gapic::Schema::File]
      def containing_file
        parent&.containing_file
      end

      ##
      # Gets the cleaned up leading comments documentation
      #
      # @param disable_xrefs [Boolean] (default is `false`) Disable linking to
      #   cross-references, and render them simply as text. This can be used if
      #   it is known that the targets are not present in the current library.
      # @param transport [:rest,:grpc] The transport for client classes.
      #   Optional; falls back to the default transport if not given.
      # @return [String]
      #
      def docs_leading_comments disable_xrefs: false, transport: nil
        return nil if @docs.nil?
        return nil if @docs.leading_comments.empty?

        transport ||= containing_api.default_transport
        lines = @docs.leading_comments.each_line.to_a
        lines.map! { |line| line.start_with?(" ") ? line[1..] : line }
        lines = FormattingUtils.format_doc_lines containing_api, lines,
                                                 disable_xrefs: disable_xrefs,
                                                 transport: transport
        lines.join
      end

      ##
      # Return the options. This method must be overridden by a subclass.
      #
      def options
        raise UnimplementedError
      end

      ##
      # Return a configuration of supported option extensions.
      # This method should be overridden by a subclass.
      #
      def option_extension_names
        {}
      end

      ##
      # Return the value of the named option, or nil if not found.
      #
      def option_named name
        return nil unless options
        result = options[name]
        return result unless result.nil?
        name = option_extension_names.keys.find { |key| key.end_with? ".#{name}" } unless name.include? "."
        return nil unless name
        @options_extensions ||= ProtoTools.parse_options_extensions options, option_extension_names
        @options_extensions[name]
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

      OPTION_EXTENSION_NAMES = {
        "google.api.default_host" => [1049, :string],
        "google.api.oauth_scopes" => [1050, :string],
        "google.api.api_version" => [525_000_001, :string]
      }.freeze

      ##
      # Return a configuration of supported option extensions.
      #
      def option_extension_names
        OPTION_EXTENSION_NAMES
      end

      # @return [String] The hostname for this service
      #   (e.g. "foo.googleapis.com"). This should be specified with no
      #   prefix.
      def host
        option_named "google.api.default_host"
      end

      # @return [Array<String>] The OAuth scopes information for the client.
      def scopes
        String(option_named("google.api.oauth_scopes")).split ","
      end

      # @return [String] The API version for this service.
      def api_version
        option_named "google.api.api_version"
      end

      # @return [String] Ruby Package
      def ruby_package
        return nil if parent.nil?

        parent.ruby_package
      end

      # @return [Boolean] True if this service is marked as deprecated, false
      #   otherwise.
      def is_deprecated?
        option_named "deprecated"
      end

      # @return [Array<Google::Api::ResourceDescriptor>] A representation of the resource.
      #   This is generally intended to be attached to the "name" field.
      #   See `google/api/resource.proto`.
      def resources
        require "gapic/resource_lookup"

        @resources ||= Gapic::ResourceLookup.for_service self
      end

      # @return [String] The full name for this service
      #   (e.g. `google.example.Service`).
      #   Useful when matching against other pieces of information
      #   which also reference full proto name, e.g. Service Config
      #   or Grpc Service Config
      def full_name
        @address.join "."
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

      attr_reader :input
      attr_reader :output

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

      OPTION_EXTENSION_NAMES = {
        "google.api.method_signature" => [1050, :string, :repeated],
        "google.api.http" => [72_295_728, ::Google::Api::HttpRule],
        "google.api.routing" => [72_295_729, ::Google::Api::RoutingRule],
        "google.cloud.operation_polling_method" => [1250, :bool],
        "google.cloud.operation_service" => [1249, :string],
        "google.longrunning.operation_info" => [1049, ::Google::Longrunning::OperationInfo]
      }.freeze

      ##
      # Return a configuration of supported option extensions.
      #
      def option_extension_names
        OPTION_EXTENSION_NAMES
      end

      # @return [Array<Array<String>>] The parameter lists
      #   defined for this method. See `google/api/client.proto`.
      def signatures
        return [] if options.nil?

        Array(option_named("google.api.method_signature")).map do |sig|
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
        option_named "google.longrunning.operation_info"
      end

      # @return [Boolean] True if this method is marked as deprecated, false
      #   otherwise.
      def is_deprecated?
        option_named("deprecated") == true
      end

      # @return [Google::Api::HttpRule] The HTTP bindings for this method. See
      #   `google/api/http.proto`.
      def http
        option_named "google.api.http"
      end

      # @return [Google::Api::RoutingRule] The Routing bindings for this method. See
      #   `google/api/routing.proto`.
      def routing
        option_named "google.api.routing"
      end

      # @return [String] The full name for this method
      #   (e.g. `google.example.Service.Rpc`).
      #   Useful when matching against other pieces of information
      #   which also reference full proto name.
      def full_name
        @address.join "."
      end

      # Nonstandard LRO annotation.
      # @return [String] Name of the nonstandard LRO service
      #   that should be used for polling the operation object
      #   that this method returns
      def operation_service
        option_named "google.cloud.operation_service"
      end

      # Nonstandard LRO annotation.
      # @return [Boolean] Whether this method is a polling method
      #   for a nonstandard LRO service
      def polling_method
        option_named "google.cloud.operation_polling_method"
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
    #   @return [Enumerable<Message>] The top level messages contained in
    #     this file.
    # @!attribute [r] enums
    #   @return [Enumerable<Enum>] The top level enums contained in this
    #     file.
    # @!attribute [r] services
    #   @return [Enumerable<Service>] The services contained in this file.
    # @!attribute [r] resources
    #   @return [Enumerable<Resource>] The top level resources contained in
    #     this file.
    class File < Proto
      extend Forwardable

      attr_reader :messages
      attr_reader :enums
      attr_reader :services
      attr_reader :resources
      attr_reader :registry

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
      # @param resources [Enumerable<Resource>] The resources from this file.
      # @param generate [Boolean] Whether this file should be generated.
      def initialize descriptor, address, docs, messages, enums, services,
                     resources, generate, registry
        super descriptor, address, docs
        @messages = messages || []
        @enums = enums || []
        @services = services || []
        @resources = resources || []
        @generate = generate
        @registry = registry

        # Apply parent
        @messages.each { |m| m.parent = self }
        @enums.each { |m| m.parent = self }
        @services.each { |m| m.parent = self }
        @resources.each { |m| m.parent = self }
      end

      def containing_file
        self
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
        option_named "ruby_package"
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

      # @return [Boolean] True if this enum is marked as deprecated, false
      #   otherwise.
      def is_deprecated?
        option_named "deprecated"
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
    # @!attribute [r] resource
    #   @ return [Resource,nil] A representation of the resource.
    # @!attribute [r] nested_messages
    #   @ return [Enumerable<Message>] The nested message declarations of a
    #      message.
    # @!attribute [r] nested_enums
    #   @ return [Enumerable<Enum>] The nested enum declarations of a message.
    class Message < Proto
      extend Forwardable

      attr_reader :fields
      attr_reader :extensions
      attr_reader :resource
      attr_reader :nested_messages
      attr_reader :nested_enums

      # Initializes a message object.
      # @param descriptor [Google::Protobuf::DescriptorProto] the protobuf
      #   representation of this service.
      # @param address [Enumerable<String>] The address of the proto. See
      #   #address for more info.
      # @param docs [Google::Protobuf::SourceCodeInfo::Location] The docs
      #   of the proto. See #docs for more info.
      # @param fields [Enumerable<Field>] The fields of this message.
      # @param extensions [Enumerable<Field>] The extensions of this message.
      # @param resource [Resource,nil] The resource of this message, or nil if none.
      # @param nested_messages [Enumerable<Message>] The nested message
      #   declarations of this message.
      # @param nested_enums [Enumerable<Enum>] The nested enum declarations
      #   of this message.
      def initialize descriptor, address, docs, fields, extensions, resource,
                     nested_messages, nested_enums
        super descriptor, address, docs
        @fields = fields || []
        @extensions = extensions || []
        @resource = resource
        @nested_messages = nested_messages || []
        @nested_enums = nested_enums || []

        @fields.each          { |f| f.parent = self }
        @extensions.each      { |x| x.parent = self }
        @nested_messages.each { |m| m.parent = self }
        @nested_enums.each    { |e| e.parent = self }
        @resource.parent = self if @resource
      end

      OPTION_EXTENSION_NAMES = {
        "google.api.resource" => [1053, ::Google::Api::ResourceDescriptor]
      }.freeze

      ##
      # Return a configuration of supported option extensions.
      #
      def option_extension_names
        OPTION_EXTENSION_NAMES
      end

      # @return [Boolean] whether this type is a map entry
      def map_entry?
        descriptor.options&.map_entry
      end

      # @return [String] The full name for this message
      #   (e.g. `google.example.Message`).
      #   Useful when matching against other pieces of information
      #   which also reference full proto name.
      def full_name
        @address.join "."
      end

      # @return [Boolean] True if this message is marked as deprecated, false
      #   otherwise.
      def is_deprecated?
        option_named "deprecated"
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

      attr_accessor :message
      attr_accessor :enum

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

      OPTION_EXTENSION_NAMES = {
        "google.api.field_behavior" => [1052, :enum, :repeated],
        "google.api.resource_reference" => [1055, ::Google::Api::ResourceReference],
        "google.cloud.operation_field" => [1149, :enum],
        "google.cloud.operation_request_field" => [1150, :string],
        "google.cloud.operation_response_field" => [1151, :string]
      }.freeze

      ##
      # Return a configuration of supported option extensions.
      #
      def option_extension_names
        OPTION_EXTENSION_NAMES
      end

      # Whether this field is a message.
      # @return [Boolean]
      def message?
        return true if @message

        false
      end

      # Whether this field is a repeated field.
      # @return [Boolean]
      def repeated?
        label == :LABEL_REPEATED
      end

      # Whether this field is an enum.
      # @return [Boolean]
      def enum?
        return true if @enum

        false
      end

      # Whether this field is a map
      # @return [Boolean]
      def map?
        return true if repeated? && @message&.map_entry?

        false
      end

      # @return [Field, nil] a key field for this map
      #   or nil if this field is not a map
      def map_key_field
        return nil? unless map?
        @message.fields.find { |f| f.name == "key" }
      end

      # @return [Field, nil] a value field for this map
      #   or nil if this field is not a map
      def map_val_field
        return nil? unless map?
        @message.fields.find { |f| f.name == "value" }
      end

      # @return [String] A reference to another resource message or resource
      #   definition. See `google/api/resource.proto`.
      def resource_reference
        option_named "google.api.resource_reference"
      end

      # @return [Array<Google::Api::FieldBehavior>] A designation of a
      #   specific field behavior (required, output only, etc.) in protobuf
      #   messages.
      def field_behavior
        option_named("google.api.field_behavior") || []
      end

      # @return [String] The full name for this field
      #   (e.g. `google.example.Message.field`).
      #   Useful when matching against other pieces of information
      #   which also reference full proto name.
      def full_name
        @address.join "."
      end

      # Nonstandard LRO annotation.
      # This annotation goes on the field of the request message of the method
      # that intiates a non-standard LRO.
      #
      # This annotation contains a field name of the request message
      # of the LRO polling method. (e.g. `GetRegionOperationRequest`)
      # (let's call it a 'referenced field')
      #
      # When the this method is called, this value should be saved.
      # Later, when when polling for a nonstandard LRO, this saved value should
      # be copied to the referenced field.
      #
      # This typically would be used for something that a caller method knows,
      # but an Operation object might not have, e.g. a 'region_id'.
      #
      # So if this field is `region_id` and the annotation is
      # `(google.cloud.operation_request_field) = "region"`, then:
      #
      #     `get_region_operation_request.region = this_message.region_id`
      #
      # In contrast to the `operation_response_field`, this field
      # - goes onto the fields of the input message of the method that
      #   initiates the LRO
      # - semantically annotates a 'push': the value of this field gets
      #   'pushed' into every LRO poll request.
      #
      # @return [String]
      def operation_request_field
        option_named "google.cloud.operation_request_field"
      end

      # Nonstandard LRO annotation.
      # This annotation goes on the field of the request message of the method
      # that polls for a non-standard LRO.
      #
      # This annotation contains a field name of the LRO object (typically 'Operation')
      # (let's call it a 'referenced field')
      #
      # When polling for a nonstandard LRO, the value of the field
      # that this annotation is on should be copied from the referenced field.
      #
      # This typically would get used for something that is named differently in the
      # operation polling request message vs in the Operation object, e.g. operation's name
      #
      # So if this field is `operation` and the annotation is
      # `(google.cloud.operation_response_field) = "name"`, then:
      #
      #     `get_region_operation_request.operation = operation.name`
      #
      # In contrast to the `operation_request_field`, this field
      # - goes onto the fields of the LRO polling method's input message
      # - semantically annotates a 'pull', the value of the referenced field gets
      #   'pulled' into this one.
      #
      # @return [String]
      def operation_response_field
        option_named "google.cloud.operation_response_field"
      end

      # Nonstandard LRO annotation.
      # This annotation goes on the fields of the nonstandard Operation message
      # Is value can be either `NAME`, `STATUS`, `ERROR_MESSAGE`, or `ERROR_CODE`
      # and the field encodes a corresponding aspect of the LRO behaviour.
      #
      # @return [Integer]
      def operation_field
        option_named "google.cloud.operation_field"
      end

      # Specifically denotes a field as optional. While all fields in protocol
      # buffers are optional, this may be specified for emphasis if
      # appropriate.
      def optional?
        field_behavior&.include? Google::Api::FieldBehavior::OPTIONAL
      end

      # Denotes a field as a part of oneof.
      # oneof_index is an int field so it'll be 0 by default for every field
      # and an index in the message's oneof table for the oneof fields
      # but since the indexes in the message's oneof table start with 0 as well
      # we need this to determine whether the field is a part of the oneof
      def oneof?
        @descriptor.has_oneof_index?
      end

      # Denotes a field as required. This indicates that the field **must** be
      # provided as part of the request, and failure to do so will cause an
      # error (usually `INVALID_ARGUMENT`).
      def required?
        field_behavior&.include? Google::Api::FieldBehavior::REQUIRED
      end

      # Denotes a field as output only. This indicates that the field is
      # provided in responses, but including the field in a request does
      # nothing (the server *must* ignore it and *must not* throw an error as
      # a result of the field's presence).
      def output_only?
        field_behavior&.include? Google::Api::FieldBehavior::OUTPUT_ONLY
      end

      # Denotes a field as input only. This indicates that the field is
      # provided in requests, and the corresponding field is not included in
      # output.
      def input_only?
        field_behavior&.include? Google::Api::FieldBehavior::INPUT_ONLY
      end

      # Denotes a field as immutable. This indicates that the field may be set
      # once in a request to create a resource, but may not be changed
      # thereafter.
      def immutable?
        field_behavior&.include? Google::Api::FieldBehavior::IMMUTABLE
      end

      # Denotes a field as proto3 optional
      def proto3_optional?
        @descriptor.proto3_optional
      end

      # @return [Boolean] True if this field is marked as deprecated, false
      #   otherwise.
      def is_deprecated?
        option_named "deprecated"
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

    # Wrapper for a protobuf Resource.
    #
    # Unlike most wrappers, this does not subclass the {Proto} wrapper because
    # it does not use the fields exposed by that wrapper (`address`, `docs`,
    # etc.) This is here principally to augment the resource definition with
    # information about resource parent-child relationships.
    #
    # Resource parentage is defined implicitly by path patterns. The algorithm
    # is as follows:
    # * If the final segment of a pattern is an ID segment (i.e. `*` or some
    #   `{name}`) then remove it and the previous segment (which we assume to
    #   be the corresponding collection identifier, as described in AIP-122.)
    #   The resulting pattern is what we expect a parent to have.
    # * If the final segment is static, then assume the pattern represents a
    #   singleton resource (AIP-156) and remove only that one segment. The
    #   resulting pattern is what we expect a parent to have.
    #
    # The {Resource#parsed_parent_patterns} method returns the set of patterns
    # we expect of parents. It is then possible to search for resources with
    # those patterns to determine what the parents are.
    #
    # @!attribute [rw] parent
    #   @return [Gapic::Schema::File,Gapic::Schema::Message] The parent object.
    # @!attribute [r] descriptor
    #   @return [Array<Gapic::Schema::ResourceDescriptor>] The resource
    #     descriptor.
    # @!attribute [r] parsed_patterns
    #   @return [Array<String>] The template form of the
    #     patterns. Template means all ID segments are replaced by asterisks
    #     to remove non-structural differences due to different names being
    #     used.
    #     For example, if a pattern is `"projects/{project}""`, the
    #     corresponding parsed pattern would be `"projects/*"]`.
    # @!attribure [r] parsed_parent_patterns
    #   return [Array<String>] Parsed patterns for the expected parents.
    # @!attribute [r] parent_resources
    #   @return [Array<Gapic::Schema::Resource>] Parent resources
    class Resource
      extend Forwardable

      attr_reader :descriptor
      attr_reader :parsed_patterns
      attr_reader :parsed_parent_patterns
      attr_reader :parent_resources

      attr_accessor :parent

      # Initializes a resource object.
      # @param descriptor [Google::Api::ResourceDescriptor] the protobuf
      #   representation of this resource.
      def initialize descriptor
        @parent = nil
        @descriptor = descriptor
        patterns = descriptor.pattern.map do |pattern|
          Gapic::PathPattern.parse pattern
        end.freeze
        @parsed_patterns = patterns.map(&:template).compact.uniq.freeze
        @parsed_parent_patterns = patterns.map(&:parent_template).compact.uniq.freeze
        @parent_resources = []
      end

      # Returns the "root" of this schema.
      # @return [Gapic::Schema::Api]
      def containing_api
        parent&.containing_api
      end

      # Returns the file containing this proto entity
      # @return [Gapic::Schema::File]
      def containing_file
        parent&.containing_file
      end

      # @!method type
      #   @return [String] the resource type string.
      # @!method pattern
      #   @return [Array<String>] the set of patterns.
      # @!method name_field
      #   @return [String] the field on the resource that designates the
      #     resource name field. If omitted, this is assumed to be "name".
      def_delegators(
        :descriptor,
        :type,
        :pattern,
        :name_field
      )
    end
  end
end

module Google
  module Cloud
    module Tools
      module SnippetGen
        module ConfigLanguage
          module V1
            ##
            # Additions to the SnippetConfig message
            #
            class SnippetConfig
              attr_accessor :json_representation
            end
          end
        end
      end
    end
  end
end
