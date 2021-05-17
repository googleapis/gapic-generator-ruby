# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require 'google/api/http.pb'
require 'google/protobuf/api.pb'
require 'google/protobuf/wrappers.pb'

module Google
  module Api
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Message Classes
    #
    class Service < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "ServiceProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/serviceconfig;serviceconfig"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class Service
      optional ::Google::Protobuf::UInt32Value, :config_version, 20
      optional :string, :name, 1
      optional :string, :id, 33
      optional :string, :title, 2
      repeated ::Google::Protobuf::Api, :apis, 3
      optional ::Google::Api::Http, :http, 9
    end

  end

end

