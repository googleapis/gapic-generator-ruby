# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'
require 'protobuf/rpc/service'


##
# Imports
#
require 'google/api/annotations.pb'
require 'google/protobuf/any.pb'
require 'google/protobuf/descriptor.pb'
require 'google/protobuf/empty.pb'
require 'google/rpc/status.pb'

module Google
  module Longrunning
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Message Classes
    #
    class Operation < ::Protobuf::Message; end
    class GetOperationRequest < ::Protobuf::Message; end
    class ListOperationsRequest < ::Protobuf::Message; end
    class ListOperationsResponse < ::Protobuf::Message; end
    class CancelOperationRequest < ::Protobuf::Message; end
    class DeleteOperationRequest < ::Protobuf::Message; end
    class OperationInfo < ::Protobuf::Message; end


    ##
    # File Options
    #
    set_option :java_package, "com.google.longrunning"
    set_option :java_outer_classname, "OperationsProto"
    set_option :java_multiple_files, true
    set_option :go_package, "google.golang.org/genproto/googleapis/longrunning;longrunning"
    set_option :csharp_namespace, "Google.LongRunning"


    ##
    # Message Fields
    #
    class Operation
      optional :string, :name, 1
      optional ::Google::Protobuf::Any, :metadata, 2
      optional :bool, :done, 3
      optional ::Google::Rpc::Status, :error, 4
      optional ::Google::Protobuf::Any, :response, 5
    end

    class GetOperationRequest
      optional :string, :name, 1
    end

    class ListOperationsRequest
      optional :string, :name, 4
      optional :string, :filter, 1
      optional :int32, :page_size, 2
      optional :string, :page_token, 3
    end

    class ListOperationsResponse
      repeated ::Google::Longrunning::Operation, :operations, 1
      optional :string, :next_page_token, 2
    end

    class CancelOperationRequest
      optional :string, :name, 1
    end

    class DeleteOperationRequest
      optional :string, :name, 1
    end

    class OperationInfo
      optional :string, :response_type, 1
      optional :string, :metadata_type, 2
    end


    ##
    # Extended Message Fields
    #
    class ::Google::Protobuf::MethodOptions < ::Protobuf::Message
      optional ::Google::Longrunning::OperationInfo, :".google.longrunning.operation_info", 1049, :extension => true
    end


    ##
    # Service Classes
    #
    class Operations < ::Protobuf::Rpc::Service
      rpc :list_operations, ::Google::Longrunning::ListOperationsRequest, ::Google::Longrunning::ListOperationsResponse do
        set_option :".google.api.http", { :get => "/v1/{name=operations}" }
      end
      rpc :get_operation, ::Google::Longrunning::GetOperationRequest, ::Google::Longrunning::Operation do
        set_option :".google.api.http", { :get => "/v1/{name=operations/**}" }
      end
      rpc :delete_operation, ::Google::Longrunning::DeleteOperationRequest, ::Google::Protobuf::Empty do
        set_option :".google.api.http", { :delete => "/v1/{name=operations/**}" }
      end
      rpc :cancel_operation, ::Google::Longrunning::CancelOperationRequest, ::Google::Protobuf::Empty do
        set_option :".google.api.http", { :post => "/v1/{name=operations/**}:cancel", :body => "*" }
      end
    end

  end

end

