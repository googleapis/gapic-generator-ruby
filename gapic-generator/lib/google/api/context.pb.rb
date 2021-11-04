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
    class Context < ::Protobuf::Message; end
    class ContextRule < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "ContextProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/serviceconfig;serviceconfig"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class Context
      repeated ::Google::Api::ContextRule, :rules, 1
    end

    class ContextRule
      optional :string, :selector, 1
      repeated :string, :requested, 2
      repeated :string, :provided, 3
      repeated :string, :allowed_request_extensions, 4
      repeated :string, :allowed_response_extensions, 5
    end

  end

end

