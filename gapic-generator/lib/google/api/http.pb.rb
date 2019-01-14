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
    class Http < ::Protobuf::Message; end
    class HttpRule < ::Protobuf::Message; end
    class CustomHttpPattern < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "HttpProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/annotations;annotations"
    set_option :cc_enable_arenas, true
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class Http
      repeated ::Google::Api::HttpRule, :rules, 1
      optional :bool, :fully_decode_reserved_expansion, 2
    end

    class HttpRule
      optional :string, :selector, 1
      optional :string, :get, 2
      optional :string, :put, 3
      optional :string, :post, 4
      optional :string, :delete, 5
      optional :string, :patch, 6
      optional ::Google::Api::CustomHttpPattern, :custom, 8
      optional :string, :body, 7
      optional :string, :response_body, 12
      repeated ::Google::Api::HttpRule, :additional_bindings, 11
    end

    class CustomHttpPattern
      optional :string, :kind, 1
      optional :string, :path, 2
    end

  end

end

