# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'

module Google
  module Protobuf
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Message Classes
    #
    class SourceContext < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.protobuf"
    set_option :java_outer_classname, "SourceContextProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/protobuf/types/known/sourcecontextpb"
    set_option :objc_class_prefix, "GPB"
    set_option :csharp_namespace, "Google.Protobuf.WellKnownTypes"


    ##
    # Message Fields
    #
    class SourceContext
      optional :string, :file_name, 1
    end

  end

end

