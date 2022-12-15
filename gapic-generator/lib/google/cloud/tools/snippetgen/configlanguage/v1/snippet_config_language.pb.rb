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
  module Cloud
    module Tools
      module Snippetgen
        module Configlanguage
          module V1
            ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

            ##
            # Enum Classes
            #
            class GeneratorOutputLanguage < ::Protobuf::Enum
              define :GENERATOR_OUTPUT_LANGUAGE_UNSPECIFIED, 0
              define :C_PLUS_PLUS, 1
              define :C_SHARP, 2
              define :GO, 3
              define :JAVA, 4
              define :JAVASCRIPT, 5
              define :PHP, 6
              define :PYTHON, 7
              define :RUBY, 8
            end


            ##
            # Message Classes
            #
            class SnippetConfig < ::Protobuf::Message; end
            class SnippetConfigMetadata < ::Protobuf::Message; end
            class Rpc < ::Protobuf::Message; end
            class SnippetSignature < ::Protobuf::Message
              class SyncPreference < ::Protobuf::Enum
                define :LANGUAGE_PREFERRED, 0
                define :PREFER_ASYNC, 1
                define :PREFER_SYNC, 2
                define :BOTH, 3
              end

            end

            class Snippet < ::Protobuf::Message
              class ClientInitialization < ::Protobuf::Message
                class ServiceEndpoint < ::Protobuf::Message
                  class ServiceEndpointSchema < ::Protobuf::Enum
                    define :LANGUAGE_DEFAULT, 0
                    define :HTTPS, 1
                    define :HTTP, 2
                  end

                end


              end

              class Standard < ::Protobuf::Message; end
              class Paginated < ::Protobuf::Message; end
              class Lro < ::Protobuf::Message; end
              class ClientStreaming < ::Protobuf::Message; end
              class ServerStreaming < ::Protobuf::Message; end
              class BidiStreaming < ::Protobuf::Message; end
              class ClientCall < ::Protobuf::Message; end
              class SimpleRequestInitialization < ::Protobuf::Message; end
              class StreamingRequestInitialization < ::Protobuf::Message; end
              class SimpleResponseHandling < ::Protobuf::Message; end
              class PaginatedResponseHandling < ::Protobuf::Message
                class ByItem < ::Protobuf::Message; end
                class ByPage < ::Protobuf::Message; end
                class NextPageToken < ::Protobuf::Message; end

              end

              class LroResponseHandling < ::Protobuf::Message
                class PollingType < ::Protobuf::Enum
                  define :UNTIL_COMPLETION, 0
                  define :ONCE, 1
                  define :NONE, 2
                end

              end

              class StreamingResponseHandling < ::Protobuf::Message; end

            end

            class Statement < ::Protobuf::Message
              class Declaration < ::Protobuf::Message; end
              class StandardOutput < ::Protobuf::Message; end
              class Return < ::Protobuf::Message; end
              class Conditional < ::Protobuf::Message; end
              class Iteration < ::Protobuf::Message
                class NumericSequenceIteration < ::Protobuf::Message; end
                class RepeatedIteration < ::Protobuf::Message; end
                class MapIteration < ::Protobuf::Message; end
                class BytesIteration < ::Protobuf::Message; end

              end


            end

            class Type < ::Protobuf::Message
              class ScalarType < ::Protobuf::Enum
                define :SCALAR_TYPE_UNDEFINED, 0
                define :TYPE_DOUBLE, 1
                define :TYPE_FLOAT, 2
                define :TYPE_INT64, 3
                define :TYPE_UINT64, 4
                define :TYPE_INT32, 5
                define :TYPE_FIXED64, 6
                define :TYPE_FIXED32, 7
                define :TYPE_BOOL, 8
                define :TYPE_STRING, 9
                define :TYPE_UINT32, 13
                define :TYPE_SFIXED32, 15
                define :TYPE_SFIXED64, 16
                define :TYPE_SINT32, 17
                define :TYPE_SINT64, 18
              end

              class EnumType < ::Protobuf::Message; end
              class BytesType < ::Protobuf::Message
                class LanguageEquivalent < ::Protobuf::Enum
                  define :PROTOBUF_BYTES, 0
                  define :BASE64, 1
                  define :BYTE_ARRAY, 2
                  define :STREAM, 3
                end

              end

              class MessageType < ::Protobuf::Message; end
              class RepeatedType < ::Protobuf::Message
                class LanguageEquivalent < ::Protobuf::Enum
                  define :PROTOBUF_REPEATED, 0
                  define :ARRAY, 1
                  define :LIST, 2
                end

              end

              class MapType < ::Protobuf::Message
                class LanguageEquivalent < ::Protobuf::Enum
                  define :PROTOBUF_MAP, 0
                  define :DICTIONARY, 1
                end

              end


            end

            class Expression < ::Protobuf::Message
              class NullValue < ::Protobuf::Enum
                define :NULL_VALUE, 0
              end

              class DefaultValue < ::Protobuf::Enum
                define :DEFAULT_VALUE, 0
              end

              class NameValue < ::Protobuf::Message; end
              class BytesValue < ::Protobuf::Message
                class FileStream < ::Protobuf::Message; end

              end

              class ComplexValue < ::Protobuf::Message
              end

              class RepeatedValue < ::Protobuf::Message; end
              class MapValue < ::Protobuf::Message; end
              class ConditionalOperator < ::Protobuf::Message; end

            end



            ##
            # File Options
            #
            set_option :java_package, "com.google.cloud.tools.snippetgen.configlanguage.v1"
            set_option :java_outer_classname, "SnippetConfigLanguageProto"
            set_option :java_multiple_files, true
            set_option :csharp_namespace, "Google.Cloud.Tools.SnippetGen.ConfigLanguage.V1"
            set_option :php_namespace, "Google\\Cloud\\Tools\\SnippetGen\\ConfigLanguage\\V1"
            set_option :ruby_package, "Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1"


            ##
            # Message Fields
            #
            class SnippetConfig
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::SnippetConfigMetadata, :metadata, 1
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Rpc, :rpc, 2
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::SnippetSignature, :signature, 3
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet, :snippet, 4
            end

            class SnippetConfigMetadata
              optional :bool, :skipped, 1
              repeated ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::GeneratorOutputLanguage, :skipped_languages, 2
              optional :string, :config_id, 3
              optional :string, :snippet_name, 4
              optional :string, :snippet_description, 5
            end

            class Rpc
              optional :string, :proto_package, 1
              repeated :string, :api_version, 2
              optional :string, :service_name, 3
              optional :string, :rpc_name, 4
            end

            class SnippetSignature
              optional :string, :snippet_method_name, 1
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type, :return_type, 2
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::SnippetSignature::SyncPreference, :sync_preference, 3
              repeated ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Declaration, :parameters, 4
            end

            class Snippet
              class ClientInitialization
                class ServiceEndpoint
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::ClientInitialization::ServiceEndpoint::ServiceEndpointSchema, :schema, 1
                  optional :string, :host, 2
                  optional :string, :region, 3
                  optional :int32, :port, 4
                end

                repeated ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement, :pre_client_initialization, 1
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::ClientInitialization::ServiceEndpoint, :custom_service_endpoint, 2
              end

              class Standard
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::SimpleRequestInitialization, :request_initialization, 1
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::ClientCall, :call, 2
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::SimpleResponseHandling, :response_handling, 3
              end

              class Paginated
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::SimpleRequestInitialization, :request_initialization, 1
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::ClientCall, :paginated_call, 2
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::PaginatedResponseHandling, :paginated_handling, 3
              end

              class Lro
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::SimpleRequestInitialization, :request_initialization, 1
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::ClientCall, :call, 2
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::LroResponseHandling, :lro_handling, 3
              end

              class ClientStreaming
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::ClientCall, :initialization_call, 1
                optional :string, :client_stream_name, 2
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::StreamingRequestInitialization, :request_initialization, 3
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::SimpleResponseHandling, :response_handling, 4
              end

              class ServerStreaming
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::SimpleRequestInitialization, :request_initialization, 1
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::ClientCall, :initialization_call, 2
                optional :string, :server_stream_name, 3
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::StreamingResponseHandling, :response_handling, 4
              end

              class BidiStreaming
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::ClientCall, :initialization_call, 1
                optional :string, :client_stream_name, 2
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::StreamingRequestInitialization, :request_initialization, 3
                optional :string, :server_stream_name, 4
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::StreamingResponseHandling, :response_handling, 5
              end

              class ClientCall
                repeated ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement, :pre_call, 2
              end

              class SimpleRequestInitialization
                repeated ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement, :pre_request_initialization, 1
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :request_value, 2
                optional :string, :request_name, 3
              end

              class StreamingRequestInitialization
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::SimpleRequestInitialization, :first_streaming_request, 1
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Iteration, :iteration, 3
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::SimpleRequestInitialization, :streaming_request, 4
              end

              class SimpleResponseHandling
                optional :string, :response_name, 1
              end

              class PaginatedResponseHandling
                class ByItem
                  optional :string, :item_name, 1
                  repeated ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement, :per_item_statements, 2
                end

                class ByPage
                  optional :string, :page_name, 1
                  repeated ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement, :per_page_statements, 2
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::PaginatedResponseHandling::ByItem, :by_item, 3
                end

                class NextPageToken
                  optional :string, :next_page_token_name, 1
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :explicit_page_size, 2
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::PaginatedResponseHandling::ByPage, :by_page, 3
                end

                optional :string, :response_name, 1
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::PaginatedResponseHandling::ByItem, :by_item, 2
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::PaginatedResponseHandling::ByPage, :by_page, 3
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::PaginatedResponseHandling::NextPageToken, :next_page_token, 4
              end

              class LroResponseHandling
                optional :string, :response_name, 1
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::LroResponseHandling::PollingType, :polling_type, 2
                optional :string, :polling_response_name, 3
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::ClientCall, :polling_call, 4
              end

              class StreamingResponseHandling
                optional :string, :current_response_name, 1
                repeated ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement, :per_stream_response_statements, 2
              end

              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::ClientInitialization, :service_client_initialization, 1
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::Standard, :standard, 2
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::Paginated, :paginated, 3
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::Lro, :lro, 4
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::ClientStreaming, :client_streaming, 5
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::ServerStreaming, :server_streaming, 6
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::BidiStreaming, :bidi_streaming, 7
              repeated ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement, :final_statements, 8
            end

            class Statement
              class Declaration
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type, :type, 1
                optional :string, :name, 2
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :value, 3
                optional :string, :description, 4
              end

              class StandardOutput
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :value, 2
              end

              class Return
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :result, 1
              end

              class Conditional
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :condition, 1
                repeated ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement, :on_true, 2
                repeated ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement, :on_false, 3
              end

              class Iteration
                class NumericSequenceIteration
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Declaration, :start_at, 1
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :increment, 3
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :multiplier, 4
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :less_than_or_equal, 7
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :less_than, 8
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :greater_than_or_equal, 9
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :greater_than, 10
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :total_steps, 11
                end

                class RepeatedIteration
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Declaration, :repeated_elements, 1
                  optional :string, :current_name, 2
                end

                class MapIteration
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Declaration, :map, 1
                  optional :string, :current_key_name, 2
                  optional :string, :current_value_name, 3
                end

                class BytesIteration
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Declaration, :byte_sequence, 1
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :chunk_size, 2
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :total_chunks, 3
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type::BytesType, :chunk_type, 4
                  optional :string, :current_name, 5
                end

                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Iteration::NumericSequenceIteration, :numeric_sequence_iteration, 1
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Iteration::RepeatedIteration, :repeated_iteration, 2
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Iteration::MapIteration, :map_iteration, 3
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Iteration::BytesIteration, :bytes_iteration, 4
                repeated ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement, :statements, 5
              end

              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Declaration, :declaration, 1
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::StandardOutput, :standard_output, 2
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Return, :return, 3
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Conditional, :conditional, 4
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Statement::Iteration, :iteration, 5
            end

            class Type
              class EnumType
                optional :string, :enum_full_name, 1
              end

              class BytesType
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type::BytesType::LanguageEquivalent, :language_equivalent, 1
              end

              class MessageType
                optional :string, :message_full_name, 1
              end

              class RepeatedType
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type, :element_type, 1
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type::RepeatedType::LanguageEquivalent, :language_equivalent, 2
              end

              class MapType
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type, :key_type, 1
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type, :value_type, 2
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type::MapType::LanguageEquivalent, :language_equivalent, 3
              end

              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type::ScalarType, :scalar_type, 1
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type::EnumType, :enum_type, 2
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type::BytesType, :bytes_type, 3
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type::MessageType, :message_type, 4
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type::RepeatedType, :repeated_type, 5
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type::MapType, :map_type, 6
            end

            class Expression
              class NameValue
                optional :string, :name, 1
                repeated :string, :path, 2
              end

              class BytesValue
                class FileStream
                  optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :file_path, 1
                end

                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :base64_string, 1
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression::BytesValue::FileStream, :file_stream, 2
              end

              class ComplexValue
                map :string, ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :properties, 1
              end

              class RepeatedValue
                repeated ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :values, 1
              end

              class MapValue
                repeated ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :keys, 1
                repeated ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :values, 2
              end

              class ConditionalOperator
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :condition, 1
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :on_true, 2
                optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression, :on_false, 3
              end

              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression::NullValue, :null_value, 1
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression::DefaultValue, :default_value, 2
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression::NameValue, :name_value, 3
              optional :double, :number_value, 4
              optional :bool, :boolean_value, 5
              optional :string, :string_value, 6
              optional :string, :enum_value, 7
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression::BytesValue, :bytes_value, 8
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression::ComplexValue, :complex_value, 9
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression::RepeatedValue, :list_value, 10
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression::MapValue, :map_value, 11
              optional ::Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Expression::ConditionalOperator, :conditional_value, 12
              optional :string, :description, 13
            end

          end

        end

      end

    end

  end

end

