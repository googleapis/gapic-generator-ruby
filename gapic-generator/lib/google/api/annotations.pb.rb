# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require 'google/api/http.pb'
require 'google/protobuf/descriptor.pb'

module Google
  module Api
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "AnnotationsProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/annotations;annotations"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Extended Message Fields
    #
    class ::Google::Protobuf::MethodOptions < ::Protobuf::Message
      optional ::Google::Api::HttpRule, :".google.api.http", 72295728, :extension => true
    end

  end

end

