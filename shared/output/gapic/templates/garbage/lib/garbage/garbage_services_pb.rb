# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: garbage/garbage.proto for package 'So.Much.Trash'

require 'grpc'
require 'garbage/garbage_pb'

module So
  module Much
    module Trash
      module GarbageService
        # Endless trash
        class Service

          include GRPC::GenericService

          self.marshal_class_method = :encode
          self.unmarshal_class_method = :decode
          self.service_name = 'endless.trash.forever.GarbageService'

          # Retrieves an EmptyGarbage resource
          rpc :GetEmptyGarbage, ::So::Much::Trash::EmptyGarbage, ::So::Much::Trash::EmptyGarbage
          # Retrieves a SimpleGarbage resource.
          rpc :GetSimpleGarbage, ::So::Much::Trash::SimpleGarbage, ::So::Much::Trash::SimpleGarbage
          # Retrieves a SpecificGarbage resource.
          rpc :GetSpecificGarbage, ::So::Much::Trash::SpecificGarbage, ::So::Much::Trash::SpecificGarbage
          # Retrieves a SpecificGarbage resource with fancy routing headers.
          rpc :GetSpecificGarbageFancy, ::So::Much::Trash::SpecificGarbage, ::So::Much::Trash::SpecificGarbage
          # Retrieves a NestedGarbage resource.
          rpc :GetNestedGarbage, ::So::Much::Trash::SpecificGarbage::NestedGarbage, ::So::Much::Trash::SpecificGarbage::NestedGarbage
          # Retrieves a RepeatedGarbage resource.
          rpc :GetRepeatedGarbage, ::So::Much::Trash::RepeatedGarbage, ::So::Much::Trash::RepeatedGarbage
          # Retrieves a TypicalGarbage resource.
          rpc :GetTypicalGarbage, ::So::Much::Trash::TypicalGarbage, ::So::Much::Trash::TypicalGarbage
          # Retrieves a TypicalGarbage resource by a request.
          rpc :GetTypicalGarbageByRequest, ::So::Much::Trash::GetTypicalGarbageRequest, ::So::Much::Trash::TypicalGarbage
          # Retrieves a ComplexGarbage resource.
          rpc :GetComplexGarbage, ::So::Much::Trash::ComplexGarbage, ::So::Much::Trash::ComplexGarbage
          # Retrieves a GarbageNode resource.
          rpc :GetGarbageNode, ::So::Much::Trash::GarbageNode, ::So::Much::Trash::GarbageNode
          # Performs paged garbage listing.
          rpc :GetPagedGarbage, ::So::Much::Trash::PagedGarbageRequest, ::So::Much::Trash::PagedGarbageResponse
          # Performs asynchronous garbage listing. Garbage items are available via the
          # google.longrunning.Operations interface.
          rpc :LongRunningGarbage, ::So::Much::Trash::LongRunningGarbageRequest, ::Google::Longrunning::Operation
          # Performs client streaming garbage listing.
          rpc :ClientGarbage, stream(::So::Much::Trash::ListGarbageRequest), ::So::Much::Trash::ListGarbageResponse
          # Performs server streaming garbage listing.
          rpc :ServerGarbage, ::So::Much::Trash::ListGarbageRequest, stream(::So::Much::Trash::GarbageItem)
          # Performs bidirectional streaming garbage listing.
          rpc :BidiGarbage, stream(::So::Much::Trash::ListGarbageRequest), stream(::So::Much::Trash::GarbageItem)
          # Performs bidirectional streaming with all typical garbage.
          rpc :BidiTypicalGarbage, stream(::So::Much::Trash::TypicalGarbage), stream(::So::Much::Trash::TypicalGarbage)
          # A method that collides with a Ruby method
          rpc :Send, ::So::Much::Trash::EmptyGarbage, ::So::Much::Trash::EmptyGarbage
        end

        Stub = Service.rpc_stub_class
      end
      module RenamedService
        class Service

          include GRPC::GenericService

          self.marshal_class_method = :encode
          self.unmarshal_class_method = :decode
          self.service_name = 'endless.trash.forever.RenamedService'

          # Retrieves an EmptyGarbage resource
          rpc :GetEmptyGarbage, ::So::Much::Trash::EmptyGarbage, ::So::Much::Trash::EmptyGarbage
        end

        Stub = Service.rpc_stub_class
      end
      module DeprecatedService
        class Service

          include GRPC::GenericService

          self.marshal_class_method = :encode
          self.unmarshal_class_method = :decode
          self.service_name = 'endless.trash.forever.DeprecatedService'

          rpc :DeprecatedGet, ::So::Much::Trash::EmptyGarbage, ::So::Much::Trash::EmptyGarbage
        end

        Stub = Service.rpc_stub_class
      end
    end
  end
end
