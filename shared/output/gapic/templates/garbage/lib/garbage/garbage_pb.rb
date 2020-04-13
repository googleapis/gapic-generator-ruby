# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: garbage/garbage.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/longrunning/operations_pb'
require 'google/protobuf/timestamp_pb'
require 'google/protobuf/duration_pb'
require 'google/iam/v1/iam_policy_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("garbage/garbage.proto", :syntax => :proto3) do
    add_message "endless.trash.forever.GetTypicalGarbageRequest" do
      optional :name, :string, 1
    end
    add_message "endless.trash.forever.LongRunningGarbageRequest" do
      optional :garbage, :string, 1
    end
    add_message "endless.trash.forever.LongRunningGarbageResponse" do
      optional :garbage, :string, 1
      repeated :items, :message, 2, "endless.trash.forever.GarbageItem"
    end
    add_message "endless.trash.forever.LongRunningGarbageMetadata" do
      optional :progress_percent, :int32, 1
      optional :start_time, :message, 2, "google.protobuf.Timestamp"
      optional :last_update_time, :message, 3, "google.protobuf.Timestamp"
    end
    add_message "endless.trash.forever.ListGarbageRequest" do
      optional :garbage, :string, 1
    end
    add_message "endless.trash.forever.ListGarbageResponse" do
      optional :garbage, :string, 1
      repeated :items, :message, 2, "endless.trash.forever.GarbageItem"
    end
    add_message "endless.trash.forever.GarbageItem" do
      optional :garbage, :string, 1
      oneof :item do
        optional :a, :string, 2
        optional :b, :int32, 3
      end
    end
    add_message "endless.trash.forever.EmptyGarbage" do
    end
    add_message "endless.trash.forever.SimpleGarbage" do
      optional :name, :string, 1
    end
    add_message "endless.trash.forever.SimpleGarbageItem" do
      optional :garbage, :string, 1
      oneof :item do
        optional :a, :string, 2
        optional :b, :int32, 3
      end
    end
    add_message "endless.trash.forever.TypicalGarbage" do
      optional :name, :string, 1
      optional :int32, :int32, 2
      optional :int64, :int64, 3
      optional :uint32, :uint32, 4
      optional :uint64, :uint64, 5
      optional :bool, :bool, 6
      optional :float, :float, 7
      optional :double, :double, 8
      optional :bytes, :bytes, 9
      optional :timeout, :message, 10, "google.protobuf.Timestamp"
      optional :duration, :message, 11, "google.protobuf.Duration"
      optional :msg, :message, 12, "endless.trash.forever.GarbageMap"
      optional :enum, :enum, 13, "endless.trash.forever.GarbageEnum"
      map :amap, :string, :string, 14
    end
    add_message "endless.trash.forever.SpecificGarbage" do
      optional :name, :string, 1
      optional :int32, :int32, 2
      optional :int64, :int64, 3
      optional :uint32, :uint32, 4
      optional :uint64, :uint64, 5
      optional :bool, :bool, 6
      optional :float, :float, 7
      optional :double, :double, 8
      optional :bytes, :bytes, 9
      optional :msg, :message, 10, "endless.trash.forever.GarbageMap"
      optional :enum, :enum, 11, "endless.trash.forever.GarbageEnum"
      optional :nested, :message, 12, "endless.trash.forever.SpecificGarbage.NestedGarbage"
    end
    add_message "endless.trash.forever.SpecificGarbage.NestedGarbage" do
      optional :name, :string, 1
      optional :int32, :int32, 2
      optional :int64, :int64, 3
      optional :uint32, :uint32, 4
      optional :uint64, :uint64, 5
      optional :bool, :bool, 6
      optional :float, :float, 7
      optional :double, :double, 8
      optional :bytes, :bytes, 9
      optional :msg, :message, 10, "endless.trash.forever.GarbageMap"
      optional :enum, :enum, 11, "endless.trash.forever.GarbageEnum"
    end
    add_message "endless.trash.forever.RepeatedGarbage" do
      repeated :repeated_name, :string, 1
      repeated :repeated_int32, :int32, 2
      repeated :repeated_int64, :int64, 3
      repeated :repeated_uint32, :uint32, 4
      repeated :repeated_uint64, :uint64, 5
      repeated :repeated_bool, :bool, 6
      repeated :repeated_float, :float, 7
      repeated :repeated_double, :double, 8
      repeated :repeated_bytes, :bytes, 9
      repeated :repeated_msg, :message, 10, "endless.trash.forever.GarbageMap"
      repeated :repeated_enum, :enum, 11, "endless.trash.forever.GarbageEnum"
    end
    add_message "endless.trash.forever.PagedGarbageRequest" do
      optional :garbage, :string, 1
      optional :page_size, :int32, 2
      optional :page_token, :string, 3
    end
    add_message "endless.trash.forever.PagedGarbageResponse" do
      repeated :items, :message, 1, "endless.trash.forever.GarbageItem"
      optional :next_page_token, :string, 2
    end
    add_message "endless.trash.forever.ComplexGarbage" do
      optional :layer1, :message, 1, "endless.trash.forever.ComplexGarbage.Layer1Garbage"
    end
    add_message "endless.trash.forever.ComplexGarbage.Layer1Garbage" do
      optional :layer2, :message, 1, "endless.trash.forever.ComplexGarbage.Layer2Garbage"
    end
    add_message "endless.trash.forever.ComplexGarbage.Layer2Garbage" do
      optional :layer3, :message, 1, "endless.trash.forever.ComplexGarbage.Layer3Garbage"
    end
    add_message "endless.trash.forever.ComplexGarbage.Layer3Garbage" do
      optional :garbage, :message, 1, "endless.trash.forever.SimpleGarbage"
    end
    add_message "endless.trash.forever.GarbageMap" do
      map :map_string_int32, :string, :int32, 1
      map :map_string_msg, :string, :message, 2, "endless.trash.forever.SimpleGarbage"
    end
    add_message "endless.trash.forever.GarbageNode" do
      optional :data, :string, 1
      optional :parent, :message, 2, "endless.trash.forever.GarbageNode"
    end
    add_enum "endless.trash.forever.GarbageEnum" do
      value :DEFAULT_GARBAGE, 0
      value :GARBAGE_BAG, 1
      value :GARBAGE_HEAP, 2
      value :DUMPSTER, 3
    end
  end
end

module So
  module Much
    module Trash
      GetTypicalGarbageRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.GetTypicalGarbageRequest").msgclass
      LongRunningGarbageRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.LongRunningGarbageRequest").msgclass
      LongRunningGarbageResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.LongRunningGarbageResponse").msgclass
      LongRunningGarbageMetadata = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.LongRunningGarbageMetadata").msgclass
      ListGarbageRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.ListGarbageRequest").msgclass
      ListGarbageResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.ListGarbageResponse").msgclass
      GarbageItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.GarbageItem").msgclass
      EmptyGarbage = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.EmptyGarbage").msgclass
      SimpleGarbage = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.SimpleGarbage").msgclass
      SimpleGarbageItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.SimpleGarbageItem").msgclass
      TypicalGarbage = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.TypicalGarbage").msgclass
      SpecificGarbage = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.SpecificGarbage").msgclass
      SpecificGarbage::NestedGarbage = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.SpecificGarbage.NestedGarbage").msgclass
      RepeatedGarbage = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.RepeatedGarbage").msgclass
      PagedGarbageRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.PagedGarbageRequest").msgclass
      PagedGarbageResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.PagedGarbageResponse").msgclass
      ComplexGarbage = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.ComplexGarbage").msgclass
      ComplexGarbage::Layer1Garbage = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.ComplexGarbage.Layer1Garbage").msgclass
      ComplexGarbage::Layer2Garbage = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.ComplexGarbage.Layer2Garbage").msgclass
      ComplexGarbage::Layer3Garbage = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.ComplexGarbage.Layer3Garbage").msgclass
      GarbageMap = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.GarbageMap").msgclass
      GarbageNode = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.GarbageNode").msgclass
      GarbageEnum = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("endless.trash.forever.GarbageEnum").enummodule
    end
  end
end
