# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'

module Google
  module Api
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Enum Classes
    #
    class LaunchStage < ::Protobuf::Enum
      define :LAUNCH_STAGE_UNSPECIFIED, 0
      define :EARLY_ACCESS, 1
      define :ALPHA, 2
      define :BETA, 3
      define :GA, 4
      define :DEPRECATED, 5
    end


    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "LaunchStageProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api;api"
    set_option :objc_class_prefix, "GAPI"

  end

end

