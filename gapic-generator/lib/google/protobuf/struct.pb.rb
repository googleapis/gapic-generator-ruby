# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'

module Google
  module Protobuf
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Enum Classes
    #
    class NullValue < ::Protobuf::Enum
      define :NULL_VALUE, 0
    end


    ##
    # Message Classes
    #
    class Struct < ::Protobuf::Message
    end

    class Value < ::Protobuf::Message; end
    class ListValue < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.protobuf"
    set_option :java_outer_classname, "StructProto"
    set_option :java_multiple_files, true
    set_option :go_package, "github.com/golang/protobuf/ptypes/struct;structpb"
    set_option :cc_enable_arenas, true
    set_option :objc_class_prefix, "GPB"
    set_option :csharp_namespace, "Google.Protobuf.WellKnownTypes"


    ##
    # Message Fields
    #
    class Struct
      map :string, ::Google::Protobuf::Value, :fields, 1
    end

    class Value
      optional ::Google::Protobuf::NullValue, :null_value, 1
      optional :double, :number_value, 2
      optional :string, :string_value, 3
      optional :bool, :bool_value, 4
      optional ::Google::Protobuf::Struct, :struct_value, 5
      optional ::Google::Protobuf::ListValue, :list_value, 6
    end

    class ListValue
      repeated ::Google::Protobuf::Value, :values, 1
    end

  end

end

