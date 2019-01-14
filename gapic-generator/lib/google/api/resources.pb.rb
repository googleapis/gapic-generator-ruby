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
    set_option :java_outer_classname, "ResourcesProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/annotations;annotations"


    ##
    # Message Fields
    #
    class Resource
      optional :string, :path, 1
      optional :string, :name, 2
    end

    class ResourceSet
      optional :string, :name, 1
      repeated ::Google::Api::Resource, :resources, 2
      repeated :string, :resource_references, 3
    end

  end

end

