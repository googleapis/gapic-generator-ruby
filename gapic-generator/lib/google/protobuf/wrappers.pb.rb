# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'

module Google
  module Protobuf
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Message Classes
    #
    class DoubleValue < ::Protobuf::Message; end
    class FloatValue < ::Protobuf::Message; end
    class Int64Value < ::Protobuf::Message; end
    class UInt64Value < ::Protobuf::Message; end
    class Int32Value < ::Protobuf::Message; end
    class UInt32Value < ::Protobuf::Message; end
    class BoolValue < ::Protobuf::Message; end
    class StringValue < ::Protobuf::Message; end
    class BytesValue < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.protobuf"
    set_option :java_outer_classname, "WrappersProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/protobuf/types/known/wrapperspb"
    set_option :cc_enable_arenas, true
    set_option :objc_class_prefix, "GPB"
    set_option :csharp_namespace, "Google.Protobuf.WellKnownTypes"


    ##
    # Message Fields
    #
    class DoubleValue
      optional :double, :value, 1
    end

    class FloatValue
      optional :float, :value, 1
    end

    class Int64Value
      optional :int64, :value, 1
    end

    class UInt64Value
      optional :uint64, :value, 1
    end

    class Int32Value
      optional :int32, :value, 1
    end

    class UInt32Value
      optional :uint32, :value, 1
    end

    class BoolValue
      optional :bool, :value, 1
    end

    class StringValue
      optional :string, :value, 1
    end

    class BytesValue
      optional :bytes, :value, 1
    end

  end

end

