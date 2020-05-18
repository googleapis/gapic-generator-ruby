# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: garbage/resource_names.proto for package 'So.Much.Trash'

require 'grpc'
require 'garbage/resource_names_pb'

module So
  module Much
    module Trash
      module ResourceNames
        # A service that exposes the messages testing various combinations of path patterns
        class Service

          include GRPC::GenericService

          self.marshal_class_method = :encode
          self.unmarshal_class_method = :decode
          self.service_name = 'endless.trash.forever.ResourceNames'

          rpc :SimplePatternMethod, So::Much::Trash::SimplePatternRequest, So::Much::Trash::Response
          rpc :ComplexPatternMethod, So::Much::Trash::ComplexPatternRequest, So::Much::Trash::Response
          rpc :StarPatternMethod, So::Much::Trash::StarPatternRequest, So::Much::Trash::Response
        end

        Stub = Service.rpc_stub_class
      end
    end
  end
end
