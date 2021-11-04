# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require 'google/api/metric.pb'

module Google
  module Api
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Message Classes
    #
    class Billing < ::Protobuf::Message
      class BillingDestination < ::Protobuf::Message; end

    end



    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "BillingProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/serviceconfig;serviceconfig"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class Billing
      class BillingDestination
        optional :string, :monitored_resource, 1
        repeated :string, :metrics, 2
      end

      repeated ::Google::Api::Billing::BillingDestination, :consumer_destinations, 8
    end

  end

end

