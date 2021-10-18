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
    class Usage < ::Protobuf::Message; end
    class UsageRule < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "UsageProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/serviceconfig;serviceconfig"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class Usage
      repeated :string, :requirements, 1
      repeated ::Google::Api::UsageRule, :rules, 6
      optional :string, :producer_notification_channel, 7
    end

    class UsageRule
      optional :string, :selector, 1
      optional :bool, :allow_unregistered_calls, 2
      optional :bool, :skip_service_control, 3
    end

  end

end

