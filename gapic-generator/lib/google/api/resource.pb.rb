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
    class Resource < ::Protobuf::Message; end
    class ResourceSet < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "ResourceProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/annotations;annotations"
    set_option :objc_class_prefix, "GAPI"
    set_option :".google.api.resource_definition", [{ :pattern => "projects/{project}", :symbol => "Project" }, { :pattern => "organizations/{organization}", :symbol => "Organization" }]


    ##
    # Message Fields
    #
    class Resource
      optional :string, :pattern, 1
      optional :string, :symbol, 2
    end

    class ResourceSet
      optional :string, :symbol, 1
      repeated ::Google::Api::Resource, :resources, 2
      repeated :string, :resource_references, 3
    end


    ##
    # Extended Message Fields
    #
    class ::Google::Protobuf::FieldOptions < ::Protobuf::Message
      optional ::Google::Api::Resource, :".google.api.resource", 1053, :extension => true
      optional ::Google::Api::ResourceSet, :".google.api.resource_set", 1054, :extension => true
      optional :string, :".google.api.resource_reference", 1055, :extension => true
    end

    class ::Google::Protobuf::FileOptions < ::Protobuf::Message
      repeated ::Google::Api::Resource, :".google.api.resource_definition", 1053, :extension => true
    end

  end

end

