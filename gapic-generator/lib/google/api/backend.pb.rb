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
    class Backend < ::Protobuf::Message; end
    class BackendRule < ::Protobuf::Message
      class PathTranslation < ::Protobuf::Enum
        define :PATH_TRANSLATION_UNSPECIFIED, 0
        define :CONSTANT_ADDRESS, 1
        define :APPEND_PATH_TO_ADDRESS, 2
      end

    end



    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "BackendProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/serviceconfig;serviceconfig"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class Backend
      repeated ::Google::Api::BackendRule, :rules, 1
    end

    class BackendRule
      optional :string, :selector, 1
      optional :string, :address, 2
      optional :double, :deadline, 3
      optional :double, :min_deadline, 4
      optional :double, :operation_deadline, 5
      optional ::Google::Api::BackendRule::PathTranslation, :path_translation, 6
      optional :string, :jwt_audience, 7
      optional :bool, :disable_auth, 8
      optional :string, :protocol, 9
    end

  end

end

