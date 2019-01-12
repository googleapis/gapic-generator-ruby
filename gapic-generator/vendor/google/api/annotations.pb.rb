# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require 'google/api/field_behavior.pb'
require 'google/api/http.pb'
require 'google/api/longrunning.pb'
require 'google/api/metadata.pb'
require 'google/api/resources.pb'
require 'google/api/signature.pb'
require 'google/protobuf/descriptor.pb'

module Google
  module Api
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "AnnotationsProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/annotations;annotations"
    set_option :objc_class_prefix, "GAPI"


    ##
    # Extended Message Fields
    #
    class ::Google::Protobuf::FileOptions < ::Protobuf::Message
      optional ::Google::Api::Metadata, :".google.api.metadata", 1048, :extension => true
      repeated ::Google::Api::Resource, :".google.api.resource_definition", 1053, :extension => true
      repeated ::Google::Api::ResourceSet, :".google.api.resource_set_definition", 1054, :extension => true
    end

    class ::Google::Protobuf::ServiceOptions < ::Protobuf::Message
      optional :string, :".google.api.default_host", 1049, :extension => true
      optional ::Google::Api::OAuth, :".google.api.oauth", 1050, :extension => true
    end

    class ::Google::Protobuf::FieldOptions < ::Protobuf::Message
      optional ::Google::Api::Resource, :".google.api.resource", 1053, :extension => true
      optional ::Google::Api::ResourceSet, :".google.api.resource_set", 1054, :extension => true
      optional :string, :".google.api.resource_reference", 1055, :extension => true
      repeated ::Google::Api::FieldBehavior, :".google.api.field_behavior", 1052, :extension => true
    end

    class ::Google::Protobuf::MethodOptions < ::Protobuf::Message
      repeated ::Google::Api::MethodSignature, :".google.api.method_signature", 1051, :extension => true
      optional ::Google::Api::OperationData, :".google.api.operation", 1049, :extension => true
      optional ::Google::Api::HttpRule, :".google.api.http", 72295728, :extension => true
    end

  end

end

