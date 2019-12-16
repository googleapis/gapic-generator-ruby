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
    class ResourceDescriptor < ::Protobuf::Message
      class History < ::Protobuf::Enum
        define :HISTORY_UNSPECIFIED, 0
        define :ORIGINALLY_SINGLE_PATTERN, 1
        define :FUTURE_MULTI_PATTERN, 2
      end

    end

    class ResourceReference < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "ResourceProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/annotations;annotations"
    set_option :cc_enable_arenas, true
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class ResourceDescriptor
      optional :string, :type, 1
      repeated :string, :pattern, 2
      optional :string, :name_field, 3
      optional ::Google::Api::ResourceDescriptor::History, :history, 4
      optional :string, :plural, 5
      optional :string, :singular, 6
    end

    class ResourceReference
      optional :string, :type, 1
      optional :string, :child_type, 2
    end


    ##
    # Extended Message Fields
    #
    class ::Google::Protobuf::FieldOptions < ::Protobuf::Message
      optional ::Google::Api::ResourceReference, :".google.api.resource_reference", 1055, :extension => true
    end

    class ::Google::Protobuf::FileOptions < ::Protobuf::Message
      repeated ::Google::Api::ResourceDescriptor, :".google.api.resource_definition", 1053, :extension => true
    end

    class ::Google::Protobuf::MessageOptions < ::Protobuf::Message
      optional ::Google::Api::ResourceDescriptor, :".google.api.resource", 1053, :extension => true
    end

  end

end

