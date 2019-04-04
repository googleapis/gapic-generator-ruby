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
  module Protobuf
    # The protocol compiler can output a FileDescriptorSet containing the .proto
    #  files it parses.
    # @!attribute [rw] file
    #   @return [Google::Protobuf::FileDescriptorProto]
    class FileDescriptorSet
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Describes a complete .proto file.
    # @!attribute [rw] name
    #   @return [String]
    # @!attribute [rw] package
    #   @return [String]
    # @!attribute [rw] dependency
    #   @return [String]
    #     Names of files imported by this file.
    # @!attribute [rw] public_dependency
    #   @return [Integer]
    #     Indexes of the public imported files in the dependency list above.
    # @!attribute [rw] weak_dependency
    #   @return [Integer]
    #     Indexes of the weak imported files in the dependency list.
    #      For Google-internal migration only. Do not use.
    # @!attribute [rw] message_type
    #   @return [Google::Protobuf::DescriptorProto]
    #     All top-level definitions in this file.
    # @!attribute [rw] enum_type
    #   @return [Google::Protobuf::EnumDescriptorProto]
    # @!attribute [rw] service
    #   @return [Google::Protobuf::ServiceDescriptorProto]
    # @!attribute [rw] extension
    #   @return [Google::Protobuf::FieldDescriptorProto]
    # @!attribute [rw] options
    #   @return [Google::Protobuf::FileOption]
    # @!attribute [rw] source_code_info
    #   @return [Google::Protobuf::SourceCodeInfo]
    #     This field contains optional information about the original source code.
    #      You may safely remove this entire field without harming runtime
    #      functionality of the descriptors -- the information is needed only by
    #      development tools.
    # @!attribute [rw] syntax
    #   @return [String]
    #     The syntax of the proto file.
    #      The supported values are "proto2" and "proto3".
    class FileDescriptorProto
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Describes a message type.
    # @!attribute [rw] name
    #   @return [String]
    # @!attribute [rw] field
    #   @return [Google::Protobuf::FieldDescriptorProto]
    # @!attribute [rw] extension
    #   @return [Google::Protobuf::FieldDescriptorProto]
    # @!attribute [rw] nested_type
    #   @return [Google::Protobuf::DescriptorProto]
    # @!attribute [rw] enum_type
    #   @return [Google::Protobuf::EnumDescriptorProto]
    # @!attribute [rw] extension_range
    #   @return [Google::Protobuf::DescriptorProto::ExtensionRange]
    # @!attribute [rw] oneof_decl
    #   @return [Google::Protobuf::OneofDescriptorProto]
    # @!attribute [rw] options
    #   @return [Google::Protobuf::MessageOption]
    # @!attribute [rw] reserved_range
    #   @return [Google::Protobuf::DescriptorProto::ReservedRange]
    # @!attribute [rw] reserved_name
    #   @return [String]
    #     Reserved field names, which may not be used by fields in the same message.
    #      A given name may only be reserved once.
    class DescriptorProto
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods

      # @!attribute [rw] start
      #   @return [Integer]
      # @!attribute [rw] end
      #   @return [Integer]
      # @!attribute [rw] options
      #   @return [Google::Protobuf::ExtensionRangeOption]
      class ExtensionRange
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # Range of reserved tag numbers. Reserved tag numbers may not be used by
      #  fields or extension ranges in the same message. Reserved ranges may
      #  not overlap.
      # @!attribute [rw] start
      #   @return [Integer]
      # @!attribute [rw] end
      #   @return [Integer]
      class ReservedRange
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end
    end

    # @!attribute [rw] uninterpreted_option
    #   @return [Google::Protobuf::UninterpretedOption]
    #     The parser stores options it doesn't recognize here. See above.
    class ExtensionRangeOptions
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Describes a field within a message.
    # @!attribute [rw] name
    #   @return [String]
    # @!attribute [rw] number
    #   @return [Integer]
    # @!attribute [rw] label
    #   @return [ENUM(Label)]
    # @!attribute [rw] type
    #   @return [ENUM(Type)]
    #     If type_name is set, this need not be set.  If both this and type_name
    #      are set, this must be one of TYPE_ENUM, TYPE_MESSAGE or TYPE_GROUP.
    # @!attribute [rw] type_name
    #   @return [String]
    #     For message and enum types, this is the name of the type.  If the name
    #      starts with a '.', it is fully-qualified.  Otherwise, C++-like scoping
    #      rules are used to find the type (i.e. first the nested types within this
    #      message are searched, then within the parent, on up to the root
    #      namespace).
    # @!attribute [rw] extendee
    #   @return [String]
    #     For extensions, this is the name of the type being extended.  It is
    #      resolved in the same manner as type_name.
    # @!attribute [rw] default_value
    #   @return [String]
    #     For numeric types, contains the original text representation of the value.
    #      For booleans, "true" or "false".
    #      For strings, contains the default text contents (not escaped in any way).
    #      For bytes, contains the C escaped value.  All bytes >= 128 are escaped.
    #      TODO(kenton):  Base-64 encode?
    # @!attribute [rw] oneof_index
    #   @return [Integer]
    #     If set, gives the index of a oneof in the containing type's oneof_decl
    #      list.  This field is a member of that oneof.
    # @!attribute [rw] json_name
    #   @return [String]
    #     JSON name of this field. The value is set by protocol compiler. If the
    #      user has set a "json_name" option on this field, that option's value
    #      will be used. Otherwise, it's deduced from the field's name by converting
    #      it to camelCase.
    # @!attribute [rw] options
    #   @return [Google::Protobuf::FieldOption]
    class FieldDescriptorProto
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods

      module Type
        # 0 is reserved for errors.
        #  Order is weird for historical reasons.
        TYPE_DOUBLE = 1

        TYPE_FLOAT = 2

        # Not ZigZag encoded.  Negative numbers take 10 bytes.  Use TYPE_SINT64 if
        #  negative values are likely.
        TYPE_INT64 = 3

        TYPE_UINT64 = 4

        # Not ZigZag encoded.  Negative numbers take 10 bytes.  Use TYPE_SINT32 if
        #  negative values are likely.
        TYPE_INT32 = 5

        TYPE_FIXED64 = 6

        TYPE_FIXED32 = 7

        TYPE_BOOL = 8

        TYPE_STRING = 9

        # Tag-delimited aggregate.
        #  Group type is deprecated and not supported in proto3. However, Proto3
        #  implementations should still be able to parse the group wire format and
        #  treat group fields as unknown fields.
        TYPE_GROUP = 10

        TYPE_MESSAGE = 11

        # New in version 2.
        TYPE_BYTES = 12

        TYPE_UINT32 = 13

        TYPE_ENUM = 14

        TYPE_SFIXED32 = 15

        TYPE_SFIXED64 = 16

        TYPE_SINT32 = 17

        TYPE_SINT64 = 18
      end

      module Label
        # 0 is reserved for errors
        LABEL_OPTIONAL = 1

        LABEL_REQUIRED = 2

        LABEL_REPEATED = 3
      end
    end

    # Describes a oneof.
    # @!attribute [rw] name
    #   @return [String]
    # @!attribute [rw] options
    #   @return [Google::Protobuf::OneofOption]
    class OneofDescriptorProto
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Describes an enum type.
    # @!attribute [rw] name
    #   @return [String]
    # @!attribute [rw] value
    #   @return [Google::Protobuf::EnumValueDescriptorProto]
    # @!attribute [rw] options
    #   @return [Google::Protobuf::EnumOption]
    # @!attribute [rw] reserved_range
    #   @return [Google::Protobuf::EnumDescriptorProto::EnumReservedRange]
    #     Range of reserved numeric values. Reserved numeric values may not be used
    #      by enum values in the same enum declaration. Reserved ranges may not
    #      overlap.
    # @!attribute [rw] reserved_name
    #   @return [String]
    #     Reserved enum value names, which may not be reused. A given name may only
    #      be reserved once.
    class EnumDescriptorProto
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods

      # Range of reserved numeric values. Reserved values may not be used by
      #  entries in the same enum. Reserved ranges may not overlap.
      #
      #  Note that this is distinct from DescriptorProto.ReservedRange in that it
      #  is inclusive such that it can appropriately represent the entire int32
      #  domain.
      # @!attribute [rw] start
      #   @return [Integer]
      # @!attribute [rw] end
      #   @return [Integer]
      class EnumReservedRange
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end
    end

    # Describes a value within an enum.
    # @!attribute [rw] name
    #   @return [String]
    # @!attribute [rw] number
    #   @return [Integer]
    # @!attribute [rw] options
    #   @return [Google::Protobuf::EnumValueOption]
    class EnumValueDescriptorProto
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Describes a service.
    # @!attribute [rw] name
    #   @return [String]
    # @!attribute [rw] method
    #   @return [Google::Protobuf::MethodDescriptorProto]
    # @!attribute [rw] options
    #   @return [Google::Protobuf::ServiceOption]
    class ServiceDescriptorProto
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # Describes a method of a service.
    # @!attribute [rw] name
    #   @return [String]
    # @!attribute [rw] input_type
    #   @return [String]
    #     Input and output type names.  These are resolved in the same way as
    #      FieldDescriptorProto.type_name, but must refer to a message type.
    # @!attribute [rw] output_type
    #   @return [String]
    # @!attribute [rw] options
    #   @return [Google::Protobuf::MethodOption]
    # @!attribute [rw] client_streaming
    #   @return [Boolean]
    #     Identifies if client streams multiple client messages
    # @!attribute [rw] server_streaming
    #   @return [Boolean]
    #     Identifies if server streams multiple server messages
    class MethodDescriptorProto
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # @!attribute [rw] java_package
    #   @return [String]
    #     Sets the Java package where classes generated from this .proto will be
    #      placed.  By default, the proto package is used, but this is often
    #      inappropriate because proto packages do not normally start with backwards
    #      domain names.
    # @!attribute [rw] java_outer_classname
    #   @return [String]
    #     If set, all the classes from the .proto file are wrapped in a single
    #      outer class with the given name.  This applies to both Proto1
    #      (equivalent to the old "--one_java_file" option) and Proto2 (where
    #      a .proto always translates to a single class, but you may want to
    #      explicitly choose the class name).
    # @!attribute [rw] java_multiple_files
    #   @return [Boolean]
    #     If set true, then the Java code generator will generate a separate .java
    #      file for each top-level message, enum, and service defined in the .proto
    #      file.  Thus, these types will *not* be nested inside the outer class
    #      named by java_outer_classname.  However, the outer class will still be
    #      generated to contain the file's getDescriptor() method as well as any
    #      top-level extensions defined in the file.
    # @!attribute [rw] java_generate_equals_and_hash
    #   @return [Boolean]
    #     This option does nothing.
    # @!attribute [rw] java_string_check_utf8
    #   @return [Boolean]
    #     If set true, then the Java2 code generator will generate code that
    #      throws an exception whenever an attempt is made to assign a non-UTF-8
    #      byte sequence to a string field.
    #      Message reflection will do the same.
    #      However, an extension field still accepts non-UTF-8 byte sequences.
    #      This option has no effect on when used with the lite runtime.
    # @!attribute [rw] optimize_for
    #   @return [ENUM(OptimizeMode)]
    # @!attribute [rw] go_package
    #   @return [String]
    #     Sets the Go package where structs generated from this .proto will be
    #      placed. If omitted, the Go package will be derived from the following:
    #        - The basename of the package import path, if provided.
    #        - Otherwise, the package statement in the .proto file, if present.
    #        - Otherwise, the basename of the .proto file, without extension.
    # @!attribute [rw] cc_generic_services
    #   @return [Boolean]
    #     Should generic services be generated in each language?  "Generic" services
    #      are not specific to any particular RPC system.  They are generated by the
    #      main code generators in each language (without additional plugins).
    #      Generic services were the only kind of service generation supported by
    #      early versions of google.protobuf.
    #
    #      Generic services are now considered deprecated in favor of using plugins
    #      that generate code specific to your particular RPC system.  Therefore,
    #      these default to false.  Old code which depends on generic services should
    #      explicitly set them to true.
    # @!attribute [rw] java_generic_services
    #   @return [Boolean]
    # @!attribute [rw] py_generic_services
    #   @return [Boolean]
    # @!attribute [rw] php_generic_services
    #   @return [Boolean]
    # @!attribute [rw] deprecated
    #   @return [Boolean]
    #     Is this file deprecated?
    #      Depending on the target platform, this can emit Deprecated annotations
    #      for everything in the file, or it will be completely ignored; in the very
    #      least, this is a formalization for deprecating files.
    # @!attribute [rw] cc_enable_arenas
    #   @return [Boolean]
    #     Enables the use of arenas for the proto messages in this file. This applies
    #      only to generated classes for C++.
    # @!attribute [rw] objc_class_prefix
    #   @return [String]
    #     Sets the objective c class prefix which is prepended to all objective c
    #      generated classes from this .proto. There is no default.
    # @!attribute [rw] csharp_namespace
    #   @return [String]
    #     Namespace for generated classes; defaults to the package.
    # @!attribute [rw] swift_prefix
    #   @return [String]
    #     By default Swift generators will take the proto package and CamelCase it
    #      replacing '.' with underscore and use that to prefix the types/symbols
    #      defined. When this options is provided, they will use this value instead
    #      to prefix the types/symbols defined.
    # @!attribute [rw] php_class_prefix
    #   @return [String]
    #     Sets the php class prefix which is prepended to all php generated classes
    #      from this .proto. Default is empty.
    # @!attribute [rw] php_namespace
    #   @return [String]
    #     Use this option to change the namespace of php generated classes. Default
    #      is empty. When this option is empty, the package name will be used for
    #      determining the namespace.
    # @!attribute [rw] php_metadata_namespace
    #   @return [String]
    #     Use this option to change the namespace of php generated metadata classes.
    #      Default is empty. When this option is empty, the proto file name will be used
    #      for determining the namespace.
    # @!attribute [rw] ruby_package
    #   @return [String]
    #     Use this option to change the package of ruby generated classes. Default
    #      is empty. When this option is not set, the package name will be used for
    #      determining the ruby package.
    # @!attribute [rw] uninterpreted_option
    #   @return [Google::Protobuf::UninterpretedOption]
    #     The parser stores options it doesn't recognize here.
    #      See the documentation for the "Options" section above.
    class FileOptions
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods

      # Generated classes can be optimized for speed or code size.
      module OptimizeMode
        SPEED = 1

        # etc.
        CODE_SIZE = 2

        LITE_RUNTIME = 3
      end
    end

    # @!attribute [rw] message_set_wire_format
    #   @return [Boolean]
    #     Set true to use the old proto1 MessageSet wire format for extensions.
    #      This is provided for backwards-compatibility with the MessageSet wire
    #      format.  You should not use this for any other reason:  It's less
    #      efficient, has fewer features, and is more complicated.
    #
    #      The message must be defined exactly as follows:
    #        message Foo {
    #          option message_set_wire_format = true;
    #          extensions 4 to max;
    #        }
    #      Note that the message cannot have any defined fields; MessageSets only
    #      have extensions.
    #
    #      All extensions of your type must be singular messages; e.g. they cannot
    #      be int32s, enums, or repeated messages.
    #
    #      Because this is an option, the above two restrictions are not enforced by
    #      the protocol compiler.
    # @!attribute [rw] no_standard_descriptor_accessor
    #   @return [Boolean]
    #     Disables the generation of the standard "descriptor()" accessor, which can
    #      conflict with a field of the same name.  This is meant to make migration
    #      from proto1 easier; new code should avoid fields named "descriptor".
    # @!attribute [rw] deprecated
    #   @return [Boolean]
    #     Is this message deprecated?
    #      Depending on the target platform, this can emit Deprecated annotations
    #      for the message, or it will be completely ignored; in the very least,
    #      this is a formalization for deprecating messages.
    # @!attribute [rw] map_entry
    #   @return [Boolean]
    #     Whether the message is an automatically generated map entry type for the
    #      maps field.
    #
    #      For maps fields:
    #          map<KeyType, ValueType> map_field = 1;
    #      The parsed descriptor looks like:
    #          message MapFieldEntry {
    #              option map_entry = true;
    #              optional KeyType key = 1;
    #              optional ValueType value = 2;
    #          }
    #          repeated MapFieldEntry map_field = 1;
    #
    #      Implementations may choose not to generate the map_entry=true message, but
    #      use a native map in the target language to hold the keys and values.
    #      The reflection APIs in such implementions still need to work as
    #      if the field is a repeated message field.
    #
    #      NOTE: Do not set the option in .proto files. Always use the maps syntax
    #      instead. The option should only be implicitly set by the proto compiler
    #      parser.
    # @!attribute [rw] uninterpreted_option
    #   @return [Google::Protobuf::UninterpretedOption]
    #     The parser stores options it doesn't recognize here. See above.
    class MessageOptions
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # @!attribute [rw] ctype
    #   @return [ENUM(CType)]
    #     The ctype option instructs the C++ code generator to use a different
    #      representation of the field than it normally would.  See the specific
    #      options below.  This option is not yet implemented in the open source
    #      release -- sorry, we'll try to include it in a future version!
    # @!attribute [rw] packed
    #   @return [Boolean]
    #     The packed option can be enabled for repeated primitive fields to enable
    #      a more efficient representation on the wire. Rather than repeatedly
    #      writing the tag and type for each element, the entire array is encoded as
    #      a single length-delimited blob. In proto3, only explicit setting it to
    #      false will avoid using packed encoding.
    # @!attribute [rw] jstype
    #   @return [ENUM(JSType)]
    #     The jstype option determines the JavaScript type used for values of the
    #      field.  The option is permitted only for 64 bit integral and fixed types
    #      (int64, uint64, sint64, fixed64, sfixed64).  A field with jstype JS_STRING
    #      is represented as JavaScript string, which avoids loss of precision that
    #      can happen when a large value is converted to a floating point JavaScript.
    #      Specifying JS_NUMBER for the jstype causes the generated JavaScript code to
    #      use the JavaScript "number" type.  The behavior of the default option
    #      JS_NORMAL is implementation dependent.
    #
    #      This option is an enum to permit additional types to be added, e.g.
    #      goog.math.Integer.
    # @!attribute [rw] lazy
    #   @return [Boolean]
    #     Should this field be parsed lazily?  Lazy applies only to message-type
    #      fields.  It means that when the outer message is initially parsed, the
    #      inner message's contents will not be parsed but instead stored in encoded
    #      form.  The inner message will actually be parsed when it is first accessed.
    #
    #      This is only a hint.  Implementations are free to choose whether to use
    #      eager or lazy parsing regardless of the value of this option.  However,
    #      setting this option true suggests that the protocol author believes that
    #      using lazy parsing on this field is worth the additional bookkeeping
    #      overhead typically needed to implement it.
    #
    #      This option does not affect the public interface of any generated code;
    #      all method signatures remain the same.  Furthermore, thread-safety of the
    #      interface is not affected by this option; const methods remain safe to
    #      call from multiple threads concurrently, while non-const methods continue
    #      to require exclusive access.
    #
    #
    #      Note that implementations may choose not to check required fields within
    #      a lazy sub-message.  That is, calling IsInitialized() on the outer message
    #      may return true even if the inner message has missing required fields.
    #      This is necessary because otherwise the inner message would have to be
    #      parsed in order to perform the check, defeating the purpose of lazy
    #      parsing.  An implementation which chooses not to check required fields
    #      must be consistent about it.  That is, for any particular sub-message, the
    #      implementation must either *always* check its required fields, or *never*
    #      check its required fields, regardless of whether or not the message has
    #      been parsed.
    # @!attribute [rw] deprecated
    #   @return [Boolean]
    #     Is this field deprecated?
    #      Depending on the target platform, this can emit Deprecated annotations
    #      for accessors, or it will be completely ignored; in the very least, this
    #      is a formalization for deprecating fields.
    # @!attribute [rw] weak
    #   @return [Boolean]
    #     For Google-internal migration only. Do not use.
    # @!attribute [rw] uninterpreted_option
    #   @return [Google::Protobuf::UninterpretedOption]
    #     The parser stores options it doesn't recognize here. See above.
    class FieldOptions
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods

      module CType
        # Default mode.
        STRING = 0

        CORD = 1

        STRING_PIECE = 2
      end

      module JSType
        # Use the default type.
        JS_NORMAL = 0

        # Use JavaScript strings.
        JS_STRING = 1

        # Use JavaScript numbers.
        JS_NUMBER = 2
      end
    end

    # @!attribute [rw] uninterpreted_option
    #   @return [Google::Protobuf::UninterpretedOption]
    #     The parser stores options it doesn't recognize here. See above.
    class OneofOptions
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # @!attribute [rw] allow_alias
    #   @return [Boolean]
    #     Set this option to true to allow mapping different tag names to the same
    #      value.
    # @!attribute [rw] deprecated
    #   @return [Boolean]
    #     Is this enum deprecated?
    #      Depending on the target platform, this can emit Deprecated annotations
    #      for the enum, or it will be completely ignored; in the very least, this
    #      is a formalization for deprecating enums.
    # @!attribute [rw] uninterpreted_option
    #   @return [Google::Protobuf::UninterpretedOption]
    #     The parser stores options it doesn't recognize here. See above.
    class EnumOptions
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # @!attribute [rw] deprecated
    #   @return [Boolean]
    #     Is this enum value deprecated?
    #      Depending on the target platform, this can emit Deprecated annotations
    #      for the enum value, or it will be completely ignored; in the very least,
    #      this is a formalization for deprecating enum values.
    # @!attribute [rw] uninterpreted_option
    #   @return [Google::Protobuf::UninterpretedOption]
    #     The parser stores options it doesn't recognize here. See above.
    class EnumValueOptions
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # @!attribute [rw] deprecated
    #   @return [Boolean]
    #     Is this service deprecated?
    #      Depending on the target platform, this can emit Deprecated annotations
    #      for the service, or it will be completely ignored; in the very least,
    #      this is a formalization for deprecating services.
    # @!attribute [rw] uninterpreted_option
    #   @return [Google::Protobuf::UninterpretedOption]
    #     The parser stores options it doesn't recognize here. See above.
    class ServiceOptions
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods
    end

    # @!attribute [rw] deprecated
    #   @return [Boolean]
    #     Is this method deprecated?
    #      Depending on the target platform, this can emit Deprecated annotations
    #      for the method, or it will be completely ignored; in the very least,
    #      this is a formalization for deprecating methods.
    # @!attribute [rw] idempotency_level
    #   @return [ENUM(IdempotencyLevel)]
    # @!attribute [rw] uninterpreted_option
    #   @return [Google::Protobuf::UninterpretedOption]
    #     The parser stores options it doesn't recognize here. See above.
    class MethodOptions
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods

      # Is this method side-effect-free (or safe in HTTP parlance), or idempotent,
      #  or neither? HTTP based RPC implementation may choose GET verb for safe
      #  methods, and PUT verb for idempotent methods instead of the default POST.
      module IdempotencyLevel
        IDEMPOTENCY_UNKNOWN = 0

        NO_SIDE_EFFECTS = 1

        IDEMPOTENT = 2
      end
    end

    # A message representing a option the parser does not recognize. This only
    #  appears in options protos created by the compiler::Parser class.
    #  DescriptorPool resolves these when building Descriptor objects. Therefore,
    #  options protos in descriptor objects (e.g. returned by Descriptor::options(),
    #  or produced by Descriptor::CopyTo()) will never have UninterpretedOptions
    #  in them.
    # @!attribute [rw] name
    #   @return [Google::Protobuf::UninterpretedOption::NamePart]
    # @!attribute [rw] identifier_value
    #   @return [String]
    #     The value of the uninterpreted option, in whatever type the tokenizer
    #      identified it as during parsing. Exactly one of these should be set.
    # @!attribute [rw] positive_int_value
    #   @return [Integer]
    # @!attribute [rw] negative_int_value
    #   @return [Integer]
    # @!attribute [rw] double_value
    #   @return [Float]
    # @!attribute [rw] string_value
    #   @return [String]
    # @!attribute [rw] aggregate_value
    #   @return [String]
    class UninterpretedOption
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods

      # The name of the uninterpreted option.  Each string represents a segment in
      #  a dot-separated name.  is_extension is true iff a segment represents an
      #  extension (denoted with parentheses in options specs in .proto files).
      #  E.g.,{ ["foo", false], ["bar.baz", true], ["qux", false] } represents
      #  "foo.(bar.baz).qux".
      # @!attribute [rw] name_part
      #   @return [String]
      # @!attribute [rw] is_extension
      #   @return [Boolean]
      class NamePart
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end
    end

    # Encapsulates information about the original source file from which a
    #  FileDescriptorProto was generated.
    # @!attribute [rw] location
    #   @return [Google::Protobuf::SourceCodeInfo::Location]
    #     A Location identifies a piece of source code in a .proto file which
    #      corresponds to a particular definition.  This information is intended
    #      to be useful to IDEs, code indexers, documentation generators, and similar
    #      tools.
    #
    #      For example, say we have a file like:
    #        message Foo {
    #          optional string foo = 1;
    #        }
    #      Let's look at just the field definition:
    #        optional string foo = 1;
    #        ^       ^^     ^^  ^  ^^^
    #        a       bc     de  f  ghi
    #      We have the following locations:
    #        span   path               represents
    #        [a,i)  [ 4, 0, 2, 0 ]     The whole field definition.
    #        [a,b)  [ 4, 0, 2, 0, 4 ]  The label (optional).
    #        [c,d)  [ 4, 0, 2, 0, 5 ]  The type (string).
    #        [e,f)  [ 4, 0, 2, 0, 1 ]  The name (foo).
    #        [g,h)  [ 4, 0, 2, 0, 3 ]  The number (1).
    #
    #      Notes:
    #      - A location may refer to a repeated field itself (i.e. not to any
    #        particular index within it).  This is used whenever a set of elements are
    #        logically enclosed in a single code segment.  For example, an entire
    #        extend block (possibly containing multiple extension definitions) will
    #        have an outer location whose path refers to the "extensions" repeated
    #        field without an index.
    #      - Multiple locations may have the same path.  This happens when a single
    #        logical declaration is spread out across multiple places.  The most
    #        obvious example is the "extend" block again -- there may be multiple
    #        extend blocks in the same scope, each of which will have the same path.
    #      - A location's span is not always a subset of its parent's span.  For
    #        example, the "extendee" of an extension declaration appears at the
    #        beginning of the "extend" block and is shared by all extensions within
    #        the block.
    #      - Just because a location's span is a subset of some other location's span
    #        does not mean that it is a descendent.  For example, a "group" defines
    #        both a type and a field in a single declaration.  Thus, the locations
    #        corresponding to the type and field and their components will overlap.
    #      - Code which tries to interpret locations should probably be designed to
    #        ignore those that it doesn't understand, as more types of locations could
    #        be recorded in the future.
    class SourceCodeInfo
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods

      # @!attribute [rw] path
      #   @return [Integer]
      #     Identifies which part of the FileDescriptorProto was defined at this
      #      location.
      #
      #      Each element is a field number or an index.  They form a path from
      #      the root FileDescriptorProto to the place where the definition.  For
      #      example, this path:
      #        [ 4, 3, 2, 7, 1 ]
      #      refers to:
      #        file.message_type(3)  // 4, 3
      #            .field(7)         // 2, 7
      #            .name()           // 1
      #      This is because FileDescriptorProto.message_type has field number 4:
      #        repeated DescriptorProto message_type = 4;
      #      and DescriptorProto.field has field number 2:
      #        repeated FieldDescriptorProto field = 2;
      #      and FieldDescriptorProto.name has field number 1:
      #        optional string name = 1;
      #
      #      Thus, the above path gives the location of a field name.  If we removed
      #      the last element:
      #        [ 4, 3, 2, 7 ]
      #      this path refers to the whole field declaration (from the beginning
      #      of the label to the terminating semicolon).
      # @!attribute [rw] span
      #   @return [Integer]
      #     Always has exactly three or four elements: start line, start column,
      #      end line (optional, otherwise assumed same as start line), end column.
      #      These are packed into a single field for efficiency.  Note that line
      #      and column numbers are zero-based -- typically you will want to add
      #      1 to each before displaying to a user.
      # @!attribute [rw] leading_comments
      #   @return [String]
      #     If this SourceCodeInfo represents a complete declaration, these are any
      #      comments appearing before and after the declaration which appear to be
      #      attached to the declaration.
      #
      #      A series of line comments appearing on consecutive lines, with no other
      #      tokens appearing on those lines, will be treated as a single comment.
      #
      #      leading_detached_comments will keep paragraphs of comments that appear
      #      before (but not connected to) the current element. Each paragraph,
      #      separated by empty lines, will be one comment element in the repeated
      #      field.
      #
      #      Only the comment content is provided; comment markers (e.g. //) are
      #      stripped out.  For block comments, leading whitespace and an asterisk
      #      will be stripped from the beginning of each line other than the first.
      #      Newlines are included in the output.
      #
      #      Examples:
      #
      #        optional int32 foo = 1;  // Comment attached to foo.
      #        // Comment attached to bar.
      #        optional int32 bar = 2;
      #
      #        optional string baz = 3;
      #        // Comment attached to baz.
      #        // Another line attached to baz.
      #
      #        // Comment attached to qux.
      #        //
      #        // Another line attached to qux.
      #        optional double qux = 4;
      #
      #        // Detached comment for corge. This is not leading or trailing comments
      #        // to qux or corge because there are blank lines separating it from
      #        // both.
      #
      #        // Detached comment for corge paragraph 2.
      #
      #        optional string corge = 5;
      #        /* Block comment attached
      #         * to corge.  Leading asterisks
      #         * will be removed. */
      #        /* Block comment attached to
      #         * grault. */
      #        optional int32 grault = 6;
      #
      #        // ignored detached comments.
      # @!attribute [rw] trailing_comments
      #   @return [String]
      # @!attribute [rw] leading_detached_comments
      #   @return [String]
      class Location
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end
    end

    # Describes the relationship between generated code and its original source
    #  file. A GeneratedCodeInfo message is associated with only one generated
    #  source file, but may contain references to different source .proto files.
    # @!attribute [rw] annotation
    #   @return [Google::Protobuf::GeneratedCodeInfo::Annotation]
    #     An Annotation connects some span of text in generated code to an element
    #      of its generating .proto file.
    class GeneratedCodeInfo
      include Google::Protobuf::MessageExts
      extend Google::Protobuf::MessageExts::ClassMethods

      # @!attribute [rw] path
      #   @return [Integer]
      #     Identifies the element in the original source .proto file. This field
      #      is formatted the same as SourceCodeInfo.Location.path.
      # @!attribute [rw] source_file
      #   @return [String]
      #     Identifies the filesystem path to the original source .proto.
      # @!attribute [rw] begin
      #   @return [Integer]
      #     Identifies the starting offset in bytes in the generated code
      #      that relates to the identified object.
      # @!attribute [rw] end
      #   @return [Integer]
      #     Identifies the ending offset in bytes in the generated code that
      #      relates to the identified offset. The end offset should be one past
      #      the last relevant byte (so the length of the text = end - begin).
      class Annotation
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end
    end
  end
end
