# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: testing/grpc_service_config/grpc_service_config.proto for package 'Testing.GrpcServiceConfig'

require 'grpc'
require 'testing/grpc_service_config/grpc_service_config_pb'

module Testing
  module GrpcServiceConfig
    module ServiceNoRetry
      class Service

        include GRPC::GenericService

        self.marshal_class_method = :encode
        self.unmarshal_class_method = :decode
        self.service_name = 'testing.grpcserviceconfig.ServiceNoRetry'

        rpc :NoRetryMethod, Testing::GrpcServiceConfig::Request, Testing::GrpcServiceConfig::Response
      end

      Stub = Service.rpc_stub_class
    end
    module ServiceWithRetries
      class Service

        include GRPC::GenericService

        self.marshal_class_method = :encode
        self.unmarshal_class_method = :decode
        self.service_name = 'testing.grpcserviceconfig.ServiceWithRetries'

        rpc :ServiceLevelRetryMethod, Testing::GrpcServiceConfig::Request, Testing::GrpcServiceConfig::Response
        rpc :MethodLevelRetryMethod, Testing::GrpcServiceConfig::Request, Testing::GrpcServiceConfig::Response
      end

      Stub = Service.rpc_stub_class
    end
  end
end
