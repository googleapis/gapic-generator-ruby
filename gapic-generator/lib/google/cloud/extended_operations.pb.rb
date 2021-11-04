# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require 'google/protobuf/descriptor.pb'

module Google
  module Cloud
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Enum Classes
    #
    class OperationResponseMapping < ::Protobuf::Enum
      define :UNDEFINED, 0
      define :NAME, 1
      define :STATUS, 2
      define :ERROR_CODE, 3
      define :ERROR_MESSAGE, 4
    end


    ##
    # File Options
    #
    set_option :java_package, "com.google.cloud"
    set_option :java_outer_classname, "ExtendedOperationsProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/cloud/extendedops;extendedops"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Extended Message Fields
    #
    class ::Google::Protobuf::FieldOptions < ::Protobuf::Message
      optional ::Google::Cloud::OperationResponseMapping, :".google.cloud.operation_field", 1149, :extension => true
      optional :string, :".google.cloud.operation_request_field", 1150, :extension => true
      optional :string, :".google.cloud.operation_response_field", 1151, :extension => true
    end

    class ::Google::Protobuf::MethodOptions < ::Protobuf::Message
      optional :string, :".google.cloud.operation_service", 1249, :extension => true
      optional :bool, :".google.cloud.operation_polling_method", 1250, :extension => true
    end

  end

end

