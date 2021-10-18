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
    class Documentation < ::Protobuf::Message; end
    class DocumentationRule < ::Protobuf::Message; end
    class Page < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "DocumentationProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/serviceconfig;serviceconfig"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class Documentation
      optional :string, :summary, 1
      repeated ::Google::Api::Page, :pages, 5
      repeated ::Google::Api::DocumentationRule, :rules, 3
      optional :string, :documentation_root_url, 4
      optional :string, :overview, 2
    end

    class DocumentationRule
      optional :string, :selector, 1
      optional :string, :description, 2
      optional :string, :deprecation_description, 3
    end

    class Page
      optional :string, :name, 1
      optional :string, :content, 2
      repeated ::Google::Api::Page, :subpages, 3
    end

  end

end

