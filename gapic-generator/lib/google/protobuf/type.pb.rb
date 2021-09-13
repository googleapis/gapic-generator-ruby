# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require 'google/protobuf/any.pb'
require 'google/protobuf/source_context.pb'

module Google
  module Protobuf
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Enum Classes
    #
    class Syntax < ::Protobuf::Enum
      define :SYNTAX_PROTO2, 0
      define :SYNTAX_PROTO3, 1
    end


    ##
    # Message Classes
    #
    class Type < ::Protobuf::Message; end
    class Field < ::Protobuf::Message
      class Kind < ::Protobuf::Enum
        define :TYPE_UNKNOWN, 0
        define :TYPE_DOUBLE, 1
        define :TYPE_FLOAT, 2
        define :TYPE_INT64, 3
        define :TYPE_UINT64, 4
        define :TYPE_INT32, 5
        define :TYPE_FIXED64, 6
        define :TYPE_FIXED32, 7
        define :TYPE_BOOL, 8
        define :TYPE_STRING, 9
        define :TYPE_GROUP, 10
        define :TYPE_MESSAGE, 11
        define :TYPE_BYTES, 12
        define :TYPE_UINT32, 13
        define :TYPE_ENUM, 14
        define :TYPE_SFIXED32, 15
        define :TYPE_SFIXED64, 16
        define :TYPE_SINT32, 17
        define :TYPE_SINT64, 18
      end

      class Cardinality < ::Protobuf::Enum
        define :CARDINALITY_UNKNOWN, 0
        define :CARDINALITY_OPTIONAL, 1
        define :CARDINALITY_REQUIRED, 2
        define :CARDINALITY_REPEATED, 3
      end

    end

    class Enum < ::Protobuf::Message; end
    class EnumValue < ::Protobuf::Message; end
    class Option < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.protobuf"
    set_option :java_outer_classname, "TypeProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/protobuf/ptype;ptype"
    set_option :cc_enable_arenas, true
    set_option :objc_class_prefix, "GPB"
    set_option :csharp_namespace, "Google.Protobuf.WellKnownTypes"


    ##
    # Message Fields
    #
    class Type
      optional :string, :name, 1
      repeated ::Google::Protobuf::Field, :fields, 2
      repeated :string, :oneofs, 3
      repeated ::Google::Protobuf::Option, :options, 4
      optional ::Google::Protobuf::SourceContext, :source_context, 5
      optional ::Google::Protobuf::Syntax, :syntax, 6
    end

    class Field
      optional ::Google::Protobuf::Field::Kind, :kind, 1
      optional ::Google::Protobuf::Field::Cardinality, :cardinality, 2
      optional :int32, :number, 3
      optional :string, :name, 4
      optional :string, :type_url, 6
      optional :int32, :oneof_index, 7
      optional :bool, :packed, 8
      repeated ::Google::Protobuf::Option, :options, 9
      optional :string, :json_name, 10
      optional :string, :default_value, 11
    end

    class Enum
      optional :string, :name, 1
      repeated ::Google::Protobuf::EnumValue, :enumvalue, 2
      repeated ::Google::Protobuf::Option, :options, 3
      optional ::Google::Protobuf::SourceContext, :source_context, 4
      optional ::Google::Protobuf::Syntax, :syntax, 5
    end

    class EnumValue
      optional :string, :name, 1
      optional :int32, :number, 2
      repeated ::Google::Protobuf::Option, :options, 3
    end

    class Option
      optional :string, :name, 1
      optional ::Google::Protobuf::Any, :value, 2
    end

  end

end

