# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require 'google/protobuf/descriptor.pb'

module Google
  module Api
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Message Classes
    #
    class RoutingRule < ::Protobuf::Message; end
    class RoutingParameter < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "RoutingProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/annotations;annotations"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class RoutingRule
      repeated ::Google::Api::RoutingParameter, :routing_parameters, 2
    end

    class RoutingParameter
      optional :string, :field, 1
      optional :string, :path_template, 2
    end


    ##
    # Extended Message Fields
    #
    class ::Google::Protobuf::MethodOptions < ::Protobuf::Message
      optional ::Google::Api::RoutingRule, :".google.api.routing", 72295729, :extension => true
    end

  end

end

