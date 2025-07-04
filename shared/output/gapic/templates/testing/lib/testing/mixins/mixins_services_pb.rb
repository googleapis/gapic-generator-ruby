# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: testing/mixins/mixins.proto for package 'Testing.Mixins'

require 'grpc'
require 'testing/mixins/mixins_pb'

module Testing
  module Mixins
    module ServiceWithLoc
      class Service

        include ::GRPC::GenericService

        self.marshal_class_method = :encode
        self.unmarshal_class_method = :decode
        self.service_name = 'testing.mixins.ServiceWithLoc'

        rpc :Method, ::Testing::Mixins::Request, ::Testing::Mixins::Response
      end

      Stub = Service.rpc_stub_class
    end
    module ServiceWithLocAndNonRestOps
      class Service

        include ::GRPC::GenericService

        self.marshal_class_method = :encode
        self.unmarshal_class_method = :decode
        self.service_name = 'testing.mixins.ServiceWithLocAndNonRestOps'

        rpc :Method, ::Testing::Mixins::Request, ::Testing::Mixins::Response
        # LRO method without `google.api.http` -- this should not generate `rest/operations.rb`
        rpc :LROMethod, ::Testing::Mixins::Request, ::Google::Longrunning::Operation
      end

      Stub = Service.rpc_stub_class
    end
  end
end
