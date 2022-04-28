# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'

module Google
  module Cloud
    module Tools
      module Snippetgen
        module Snippetindex
          module V1
            ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

            ##
            # Enum Classes
            #
            class Language < ::Protobuf::Enum
              define :LANGUAGE_UNSPECIFIED, 0
              define :C_PLUS_PLUS, 1
              define :C_SHARP, 2
              define :DART, 3
              define :ELIXIR, 4
              define :ERLANG, 5
              define :F_SHARP, 6
              define :GO, 7
              define :JAVA, 8
              define :JAVASCRIPT, 9
              define :KOTLIN, 10
              define :PHP, 11
              define :PYTHON, 12
              define :RUBY, 13
              define :RUST, 14
              define :SWIFT, 15
              define :TYPESCRIPT, 16
              define :VB_NET, 17
            end


            ##
            # Message Classes
            #
            class Index < ::Protobuf::Message; end
            class Snippet < ::Protobuf::Message
              class Origin < ::Protobuf::Enum
                define :ORIGIN_UNSPECIFIED, 0
                define :API_DEFINITION, 1
                define :CONFIG, 2
                define :HANDWRITTEN, 3
              end

              class Segment < ::Protobuf::Message
                class SegmentType < ::Protobuf::Enum
                  define :SEGMENT_TYPE_UNSPECIFIED, 0
                  define :FULL, 1
                  define :SHORT, 2
                  define :CLIENT_INITIALIZATION, 3
                  define :REQUEST_INITIALIZATION, 4
                  define :REQUEST_EXECUTION, 5
                  define :RESPONSE_HANDLING, 6
                end

              end


            end

            class ClientMethod < ::Protobuf::Message
              class Parameter < ::Protobuf::Message; end

            end

            class ServiceClient < ::Protobuf::Message; end
            class ClientLibrary < ::Protobuf::Message; end
            class Method < ::Protobuf::Message; end
            class Service < ::Protobuf::Message; end
            class Api < ::Protobuf::Message; end


            ##
            # File Options
            #
            set_option :csharp_namespace, "Google.Cloud.Tools.SnippetGen.SnippetIndex.V1"
            set_option :php_namespace, "Google\\Cloud\\Tools\\SnippetGen\\SnippetIndex\\V1"
            set_option :ruby_package, "Google::Cloud::Tools::SnippetGen::SnippetIndex::V1"


            ##
            # Message Fields
            #
            class Index
              optional ::Google::Cloud::Tools::Snippetgen::Snippetindex::V1::ClientLibrary, :client_library, 1
              repeated ::Google::Cloud::Tools::Snippetgen::Snippetindex::V1::Snippet, :snippets, 2
            end

            class Snippet
              class Segment
                optional :int32, :start, 1
                optional :int32, :end, 2
                optional ::Google::Cloud::Tools::Snippetgen::Snippetindex::V1::Snippet::Segment::SegmentType, :type, 3
              end

              optional :string, :region_tag, 1
              optional :string, :title, 2
              optional :string, :description, 3
              optional :string, :file, 4
              optional ::Google::Cloud::Tools::Snippetgen::Snippetindex::V1::Language, :language, 5
              optional ::Google::Cloud::Tools::Snippetgen::Snippetindex::V1::ClientMethod, :client_method, 6
              optional :bool, :canonical, 7
              optional ::Google::Cloud::Tools::Snippetgen::Snippetindex::V1::Snippet::Origin, :origin, 8
              repeated ::Google::Cloud::Tools::Snippetgen::Snippetindex::V1::Snippet::Segment, :segments, 9
            end

            class ClientMethod
              class Parameter
                optional :string, :type, 1
                optional :string, :name, 2
              end

              optional :string, :short_name, 1
              optional :string, :full_name, 2
              optional :bool, :async, 3
              repeated ::Google::Cloud::Tools::Snippetgen::Snippetindex::V1::ClientMethod::Parameter, :parameters, 4
              optional :string, :result_type, 5
              optional ::Google::Cloud::Tools::Snippetgen::Snippetindex::V1::ServiceClient, :client, 6
              optional ::Google::Cloud::Tools::Snippetgen::Snippetindex::V1::Method, :method, 7
            end

            class ServiceClient
              optional :string, :short_name, 1
              optional :string, :full_name, 2
            end

            class ClientLibrary
              optional :string, :name, 1
              optional :string, :version, 2
              optional ::Google::Cloud::Tools::Snippetgen::Snippetindex::V1::Language, :language, 3
              repeated ::Google::Cloud::Tools::Snippetgen::Snippetindex::V1::Api, :apis, 4
            end

            class Method
              optional :string, :short_name, 1
              optional :string, :full_name, 2
              optional ::Google::Cloud::Tools::Snippetgen::Snippetindex::V1::Service, :service, 3
            end

            class Service
              optional :string, :short_name, 1
              optional :string, :full_name, 2
            end

            class Api
              optional :string, :id, 1
              optional :string, :version, 2
            end

          end

        end

      end

    end

  end

end

