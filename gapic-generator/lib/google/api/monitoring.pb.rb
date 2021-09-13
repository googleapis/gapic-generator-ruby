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
    class Monitoring < ::Protobuf::Message
      class MonitoringDestination < ::Protobuf::Message; end

    end



    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "MonitoringProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/serviceconfig;serviceconfig"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class Monitoring
      class MonitoringDestination
        optional :string, :monitored_resource, 1
        repeated :string, :metrics, 2
      end

      repeated ::Google::Api::Monitoring::MonitoringDestination, :producer_destinations, 1
      repeated ::Google::Api::Monitoring::MonitoringDestination, :consumer_destinations, 2
    end

  end

end

