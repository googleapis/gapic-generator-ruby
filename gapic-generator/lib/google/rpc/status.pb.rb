# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require 'google/protobuf/any.pb'

module Google
  module Rpc
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Message Classes
    #
    class Status < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.rpc"
    set_option :java_outer_classname, "StatusProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/rpc/status;status"
    set_option :objc_class_prefix, "RPC"


    ##
    # Message Fields
    #
    class Status
      optional :int32, :code, 1
      optional :string, :message, 2
      repeated ::Google::Protobuf::Any, :details, 3
    end

  end

end

