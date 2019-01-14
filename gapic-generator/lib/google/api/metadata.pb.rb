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
    class Metadata < ::Protobuf::Message; end
    class OAuth < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.api"
    set_option :java_outer_classname, "MetadataProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/api/annotations;annotations"


    ##
    # Message Fields
    #
    class Metadata
      optional :string, :product_name, 1
      optional :string, :product_uri, 2
      optional :string, :package_name, 3
      repeated :string, :package_namespace, 4
    end

    class OAuth
      repeated :string, :scopes, 1
    end

  end

end

