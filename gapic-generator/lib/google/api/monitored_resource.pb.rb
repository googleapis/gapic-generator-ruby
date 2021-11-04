# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require 'google/api/label.pb'
require 'google/api/launch_stage.pb'
require 'google/protobuf/struct.pb'

module Google
  module Api
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Message Classes
    #
    class MonitoredResourceDescriptor < ::Protobuf::Message; end
    class MonitoredResource < ::Protobuf::Message
    end

    class MonitoredResourceMetadata < ::Protobuf::Message
    end



    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "MonitoredResourceProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/monitoredres;monitoredres"
    set_option :cc_enable_arenas, true
    set_option :objc_class_prefix, "GAPI"


    ##
    # Message Fields
    #
    class MonitoredResourceDescriptor
      optional :string, :name, 5
      optional :string, :type, 1
      optional :string, :display_name, 2
      optional :string, :description, 3
      repeated ::Google::Api::LabelDescriptor, :labels, 4
      optional ::Google::Api::LaunchStage, :launch_stage, 7
    end

    class MonitoredResource
      optional :string, :type, 1
      map :string, :string, :labels, 2
    end

    class MonitoredResourceMetadata
      optional ::Google::Protobuf::Struct, :system_labels, 1
      map :string, :string, :user_labels, 2
    end

  end

end

