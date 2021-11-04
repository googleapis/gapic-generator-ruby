# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require 'google/protobuf/source_context.pb'
require 'google/protobuf/type.pb'

module Google
  module Protobuf
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Message Classes
    #
    class Api < ::Protobuf::Message; end
    class Method < ::Protobuf::Message; end
    class Mixin < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.protobuf"
    set_option :java_outer_classname, "ApiProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/protobuf/api;api"
    set_option :objc_class_prefix, "GPB"
    set_option :csharp_namespace, "Google.Protobuf.WellKnownTypes"


    ##
    # Message Fields
    #
    class Api
      optional :string, :name, 1
      repeated ::Google::Protobuf::Method, :methods, 2
      repeated ::Google::Protobuf::Option, :options, 3
      optional :string, :version, 4
      optional ::Google::Protobuf::SourceContext, :source_context, 5
      repeated ::Google::Protobuf::Mixin, :mixins, 6
      optional ::Google::Protobuf::Syntax, :syntax, 7
    end

    class Method
      optional :string, :name, 1
      optional :string, :request_type_url, 2
      optional :bool, :request_streaming, 3
      optional :string, :response_type_url, 4
      optional :bool, :response_streaming, 5
      repeated ::Google::Protobuf::Option, :options, 6
      optional ::Google::Protobuf::Syntax, :syntax, 7
    end

    class Mixin
      optional :string, :name, 1
      optional :string, :root, 2
    end

  end

end

