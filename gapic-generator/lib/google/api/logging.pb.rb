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
    class Logging < ::Protobuf::Message
      class LoggingDestination < ::Protobuf::Message; end

    end



    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "LoggingProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/serviceconfig;serviceconfig"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class Logging
      class LoggingDestination
        optional :string, :monitored_resource, 3
        repeated :string, :logs, 1
      end

      repeated ::Google::Api::Logging::LoggingDestination, :producer_destinations, 1
      repeated ::Google::Api::Logging::LoggingDestination, :consumer_destinations, 2
    end

  end

end

