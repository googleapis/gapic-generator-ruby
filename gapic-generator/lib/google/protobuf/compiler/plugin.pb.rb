# encoding: utf-8

##
# This file was auto-generated initially but now is hand-edited to add support 
# for response features and proto3_optional
#
require 'protobuf'


##
# Imports
#
require 'google/protobuf/descriptor.pb'

module Google
  module Protobuf
    module Compiler
      ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

      ##
      # Message Classes
      #
      class Version < ::Protobuf::Message; end
      class CodeGeneratorRequest < ::Protobuf::Message; end
      class CodeGeneratorResponse < ::Protobuf::Message
        class File < ::Protobuf::Message; end

      end



      ##
      # File Options
      #
      set_option :java_package, "com.google.protobuf.compiler"
      set_option :java_outer_classname, "PluginProtos"
      set_option :go_package, "github.com/golang/protobuf/protoc-gen-go/plugin;plugin_go"


      ##
      # Message Fields
      #
      class Version
        optional :int32, :major, 1
        optional :int32, :minor, 2
        optional :int32, :patch, 3
        optional :string, :suffix, 4
      end

      class CodeGeneratorRequest
        repeated :string, :file_to_generate, 1
        optional :string, :parameter, 2
        repeated ::Google::Protobuf::FileDescriptorProto, :proto_file, 15
        optional ::Google::Protobuf::Compiler::Version, :compiler_version, 3
      end

      class CodeGeneratorResponse
        FEATURE_PROTO3_OPTIONAL = 1

        class File
          optional :string, :name, 1
          optional :string, :insertion_point, 2
          optional :string, :content, 15
        end

        optional :string, :error, 1
        optional :int32, :supported_features, 2
        repeated ::Google::Protobuf::Compiler::CodeGeneratorResponse::File, :file, 15
      end

    end

  end

end

