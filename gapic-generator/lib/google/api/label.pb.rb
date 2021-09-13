# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'

module Google
  module Api
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Message Classes
    #
    class LabelDescriptor < ::Protobuf::Message
      class ValueType < ::Protobuf::Enum
        define :STRING, 0
        define :BOOL, 1
        define :INT64, 2
      end

    end



    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "LabelProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/label;label"
    set_option :cc_enable_arenas, true
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class LabelDescriptor
      optional :string, :key, 1
      optional ::Google::Api::LabelDescriptor::ValueType, :value_type, 2
      optional :string, :description, 3
    end

  end

end

