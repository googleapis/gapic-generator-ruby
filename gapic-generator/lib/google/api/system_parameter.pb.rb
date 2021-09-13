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
    class SystemParameters < ::Protobuf::Message; end
    class SystemParameterRule < ::Protobuf::Message; end
    class SystemParameter < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "SystemParameterProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/serviceconfig;serviceconfig"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class SystemParameters
      repeated ::Google::Api::SystemParameterRule, :rules, 1
    end

    class SystemParameterRule
      optional :string, :selector, 1
      repeated ::Google::Api::SystemParameter, :parameters, 2
    end

    class SystemParameter
      optional :string, :name, 1
      optional :string, :http_header, 2
      optional :string, :url_query_parameter, 3
    end

  end

end

