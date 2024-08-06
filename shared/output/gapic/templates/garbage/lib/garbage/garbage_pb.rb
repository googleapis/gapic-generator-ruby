# frozen_string_literal: true
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


descriptor_data = "\n\x15garbage/garbage.proto\x12\x15\x65ndless.trash.forever\x1a\x1cgoogle/api/annotations.proto\x1a\x17google/api/client.proto\x1a\x1fgoogle/api/field_behavior.proto\x1a\x19google/api/resource.proto\x1a#google/longrunning/operations.proto\x1a\x1fgoogle/protobuf/timestamp.proto\x1a\x1egoogle/protobuf/duration.proto\"V\n\x18GetTypicalGarbageRequest\x12:\n\x04name\x18\x01 \x01(\tB,\xfa\x41)\n\'endlesstrash.example.net/TypicalGarbage\",\n\x19LongRunningGarbageRequest\x12\x0f\n\x07garbage\x18\x01 \x01(\t\"`\n\x1aLongRunningGarbageResponse\x12\x0f\n\x07garbage\x18\x01 \x01(\t\x12\x31\n\x05items\x18\x02 \x03(\x0b\x32\".endless.trash.forever.GarbageItem\"\x9c\x01\n\x1aLongRunningGarbageMetadata\x12\x18\n\x10progress_percent\x18\x01 \x01(\x05\x12.\n\nstart_time\x18\x02 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\x12\x34\n\x10last_update_time\x18\x03 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\"L\n\x12ListGarbageRequest\x12\x36\n\x07garbage\x18\x01 \x01(\tB%\xfa\x41\"\x12 endlesstrash.example.net/Garbage\"Y\n\x13ListGarbageResponse\x12\x0f\n\x07garbage\x18\x01 \x01(\t\x12\x31\n\x05items\x18\x02 \x03(\x0b\x32\".endless.trash.forever.GarbageItem\"g\n\x0bGarbageItem\x12\x36\n\x07garbage\x18\x01 \x01(\tB%\xfa\x41\"\n endlesstrash.example.net/Garbage\x12\x0b\n\x01\x61\x18\x02 \x01(\tH\x00\x12\x0b\n\x01\x62\x18\x03 \x01(\x05H\x00\x42\x06\n\x04item\"\x0e\n\x0c\x45mptyGarbage\"|\n\rSimpleGarbage\x12\x0c\n\x04name\x18\x01 \x01(\t:]\xea\x41Z\n&endlesstrash.example.net/SimpleGarbage\x12\x30projects/{project}/simpleGarbage/{simpleGarbage}\"s\n\x11SimpleGarbageItem\x12<\n\x07garbage\x18\x01 \x01(\tB+\xfa\x41(\n&endlesstrash.example.net/SimpleGarbage\x12\x0b\n\x01\x61\x18\x02 \x01(\tH\x00\x12\x0b\n\x01\x62\x18\x03 \x01(\x05H\x00\x42\x06\n\x04item\"\x8e\x08\n\x0eTypicalGarbage\x12\x11\n\x04name\x18\x01 \x01(\tB\x03\xe0\x41\x02\x12\x12\n\x05int32\x18\x02 \x01(\x05\x42\x03\xe0\x41\x02\x12\r\n\x05int64\x18\x03 \x01(\x03\x12\x0e\n\x06uint32\x18\x04 \x01(\r\x12\x0e\n\x06uint64\x18\x05 \x01(\x04\x12\x11\n\x04\x62ool\x18\x06 \x01(\x08\x42\x03\xe0\x41\x02\x12\r\n\x05\x66loat\x18\x07 \x01(\x02\x12\x0e\n\x06\x64ouble\x18\x08 \x01(\x01\x12\r\n\x05\x62ytes\x18\t \x01(\x0c\x12+\n\x07timeout\x18\n \x01(\x0b\x32\x1a.google.protobuf.Timestamp\x12+\n\x08\x64uration\x18\x0b \x01(\x0b\x32\x19.google.protobuf.Duration\x12\x33\n\x03msg\x18\x0c \x01(\x0b\x32!.endless.trash.forever.GarbageMapB\x03\xe0\x41\x03\x12\x30\n\x04\x65num\x18\r \x01(\x0e\x32\".endless.trash.forever.GarbageEnum\x12=\n\x04\x61map\x18\x0e \x03(\x0b\x32/.endless.trash.forever.TypicalGarbage.AmapEntry\x12\x1c\n\x12oneof_singular_str\x18\x0f \x01(\tH\x00\x12\x1a\n\x10oneof_pair_int32\x18\x10 \x01(\x05H\x01\x12\x1a\n\x10oneof_pair_float\x18\x11 \x01(\x02H\x01\x12J\n\x16oneof_multiple_message\x18\x12 \x01(\x0b\x32(.endless.trash.forever.SimpleGarbageItemH\x02\x12\x1e\n\x14oneof_multiple_bytes\x18\x13 \x01(\x0cH\x02\x12\x41\n\x13oneof_multiple_enum\x18\x14 \x01(\x0e\x32\".endless.trash.forever.GarbageEnumH\x02\x12\x1f\n\x15oneof_multiple_double\x18\x15 \x01(\x01H\x02\x12\x1b\n\x0eoptional_int32\x18\x16 \x01(\x05H\x03\x88\x01\x01\x12\x0c\n\x04\x63\x61se\x18\x17 \x01(\t\x1a+\n\tAmapEntry\x12\x0b\n\x03key\x18\x01 \x01(\t\x12\r\n\x05value\x18\x02 \x01(\t:\x02\x38\x01:\xa1\x01\xea\x41\x9d\x01\n\'endlesstrash.example.net/TypicalGarbage\x12\x38projects/{project}/typical_garbage_1/{typical_garbage_1}\x12\x38projects/{project}/typical_garbage_2/{typical_garbage_2}B\x10\n\x0eoneof_singularB\x0c\n\noneof_pairB\x10\n\x0eoneof_multipleB\x11\n\x0f_optional_int32\"\xb8\x05\n\x0fSpecificGarbage\x12\x11\n\x04name\x18\x01 \x01(\tB\x03\xe0\x41\x02\x12\r\n\x05int32\x18\x02 \x01(\x05\x12\r\n\x05int64\x18\x03 \x01(\x03\x12\x0e\n\x06uint32\x18\x04 \x01(\r\x12\x0e\n\x06uint64\x18\x05 \x01(\x04\x12\x0c\n\x04\x62ool\x18\x06 \x01(\x08\x12\r\n\x05\x66loat\x18\x07 \x01(\x02\x12\x0e\n\x06\x64ouble\x18\x08 \x01(\x01\x12\r\n\x05\x62ytes\x18\t \x01(\x0c\x12\x33\n\x03msg\x18\n \x01(\x0b\x32!.endless.trash.forever.GarbageMapB\x03\xe0\x41\x03\x12\x30\n\x04\x65num\x18\x0b \x01(\x0e\x32\".endless.trash.forever.GarbageEnum\x12\x44\n\x06nested\x18\x0c \x01(\x0b\x32\x34.endless.trash.forever.SpecificGarbage.NestedGarbage\x1a\x83\x02\n\rNestedGarbage\x12\x11\n\x04name\x18\x01 \x01(\tB\x03\xe0\x41\x02\x12\r\n\x05int32\x18\x02 \x01(\x05\x12\r\n\x05int64\x18\x03 \x01(\x03\x12\x0e\n\x06uint32\x18\x04 \x01(\r\x12\x0e\n\x06uint64\x18\x05 \x01(\x04\x12\x0c\n\x04\x62ool\x18\x06 \x01(\x08\x12\r\n\x05\x66loat\x18\x07 \x01(\x02\x12\x0e\n\x06\x64ouble\x18\x08 \x01(\x01\x12\r\n\x05\x62ytes\x18\t \x01(\x0c\x12\x33\n\x03msg\x18\n \x01(\x0b\x32!.endless.trash.forever.GarbageMapB\x03\xe0\x41\x03\x12\x30\n\x04\x65num\x18\x0b \x01(\x0e\x32\".endless.trash.forever.GarbageEnum:e\xea\x41\x62\n(endlesstrash.example.net/SpecificGarbage\x12\x36projects/{project}/specific_garbage/{specific_garbage}\"\xe8\x02\n\x0fRepeatedGarbage\x12\x1a\n\rrepeated_name\x18\x01 \x03(\tB\x03\xe0\x41\x02\x12\x16\n\x0erepeated_int32\x18\x02 \x03(\x05\x12\x16\n\x0erepeated_int64\x18\x03 \x03(\x03\x12\x17\n\x0frepeated_uint32\x18\x04 \x03(\r\x12\x17\n\x0frepeated_uint64\x18\x05 \x03(\x04\x12\x15\n\rrepeated_bool\x18\x06 \x03(\x08\x12\x16\n\x0erepeated_float\x18\x07 \x03(\x02\x12\x17\n\x0frepeated_double\x18\x08 \x03(\x01\x12\x16\n\x0erepeated_bytes\x18\t \x03(\x0c\x12<\n\x0crepeated_msg\x18\n \x03(\x0b\x32!.endless.trash.forever.GarbageMapB\x03\xe0\x41\x03\x12\x39\n\rrepeated_enum\x18\x0b \x03(\x0e\x32\".endless.trash.forever.GarbageEnum\"}\n\x13PagedGarbageRequest\x12?\n\x07garbage\x18\x01 \x01(\tB.\xe0\x41\x02\xfa\x41(\n&endlesstrash.example.net/SimpleGarbage\x12\x11\n\tpage_size\x18\x02 \x01(\x05\x12\x12\n\npage_token\x18\x03 \x01(\t\"b\n\x14PagedGarbageResponse\x12\x31\n\x05items\x18\x01 \x03(\x0b\x32\".endless.trash.forever.GarbageItem\x12\x17\n\x0fnext_page_token\x18\x02 \x01(\t\"\xdd\x02\n\x0e\x43omplexGarbage\x12H\n\x06layer1\x18\x01 \x01(\x0b\x32\x33.endless.trash.forever.ComplexGarbage.Layer1GarbageB\x03\xe0\x41\x02\x1aY\n\rLayer1Garbage\x12H\n\x06layer2\x18\x01 \x01(\x0b\x32\x33.endless.trash.forever.ComplexGarbage.Layer2GarbageB\x03\xe0\x41\x02\x1aY\n\rLayer2Garbage\x12H\n\x06layer3\x18\x01 \x01(\x0b\x32\x33.endless.trash.forever.ComplexGarbage.Layer3GarbageB\x03\xe0\x41\x02\x1aK\n\rLayer3Garbage\x12:\n\x07garbage\x18\x01 \x01(\x0b\x32$.endless.trash.forever.SimpleGarbageB\x03\xe0\x41\x02\"\xbc\x02\n\nGarbageMap\x12O\n\x10map_string_int32\x18\x01 \x03(\x0b\x32\x35.endless.trash.forever.GarbageMap.MapStringInt32Entry\x12K\n\x0emap_string_msg\x18\x02 \x03(\x0b\x32\x33.endless.trash.forever.GarbageMap.MapStringMsgEntry\x1a\x35\n\x13MapStringInt32Entry\x12\x0b\n\x03key\x18\x01 \x01(\t\x12\r\n\x05value\x18\x02 \x01(\x05:\x02\x38\x01\x1aY\n\x11MapStringMsgEntry\x12\x0b\n\x03key\x18\x01 \x01(\t\x12\x33\n\x05value\x18\x02 \x01(\x0b\x32$.endless.trash.forever.SimpleGarbage:\x02\x38\x01\"O\n\x0bGarbageNode\x12\x0c\n\x04\x64\x61ta\x18\x01 \x01(\t\x12\x32\n\x06parent\x18\x02 \x01(\x0b\x32\".endless.trash.forever.GarbageNode*\\\n\x0bGarbageEnum\x12\x13\n\x0f\x44\x45\x46\x41ULT_GARBAGE\x10\x00\x12\x0f\n\x0bGARBAGE_BAG\x10\x01\x12\x10\n\x0cGARBAGE_HEAP\x10\x02\x12\x0c\n\x08\x44UMPSTER\x10\x03\x12\x07\n\x03\x45ND\x10\x04\x32\xe2\x12\n\x0eGarbageService\x12}\n\x0fGetEmptyGarbage\x12#.endless.trash.forever.EmptyGarbage\x1a#.endless.trash.forever.EmptyGarbage\" \x82\xd3\xe4\x93\x02\x1a\"\x15/v1/empty_garbage:get:\x01*\x12\x81\x01\n\x10GetSimpleGarbage\x12$.endless.trash.forever.SimpleGarbage\x1a$.endless.trash.forever.SimpleGarbage\"!\x82\xd3\xe4\x93\x02\x1b\"\x16/v1/simple_garbage:get:\x01*\x12\x89\x01\n\x12GetSpecificGarbage\x12&.endless.trash.forever.SpecificGarbage\x1a&.endless.trash.forever.SpecificGarbage\"#\x82\xd3\xe4\x93\x02\x1d\"\x18/v1/specific_garbage:get:\x01*\x12\xa1\x01\n\x10GetNestedGarbage\x12\x34.endless.trash.forever.SpecificGarbage.NestedGarbage\x1a\x34.endless.trash.forever.SpecificGarbage.NestedGarbage\"!\x82\xd3\xe4\x93\x02\x1b\"\x16/v1/nested_garbage:get:\x01*\x12\x89\x01\n\x12GetRepeatedGarbage\x12&.endless.trash.forever.RepeatedGarbage\x1a&.endless.trash.forever.RepeatedGarbage\"#\x82\xd3\xe4\x93\x02\x1d\"\x18/v1/repeated_garbage:get:\x01*\x12\x85\x01\n\x11GetTypicalGarbage\x12%.endless.trash.forever.TypicalGarbage\x1a%.endless.trash.forever.TypicalGarbage\"\"\x82\xd3\xe4\x93\x02\x1c\"\x17/v1/typical_garbage:get:\x01*\x12\xa6\x01\n\x1aGetTypicalGarbageByRequest\x12/.endless.trash.forever.GetTypicalGarbageRequest\x1a%.endless.trash.forever.TypicalGarbage\"0\x88\x02\x01\x82\xd3\xe4\x93\x02\'\"\"/v1/typical_garbage_by_request:get:\x01*\x12\x85\x01\n\x11GetComplexGarbage\x12%.endless.trash.forever.ComplexGarbage\x1a%.endless.trash.forever.ComplexGarbage\"\"\x82\xd3\xe4\x93\x02\x1c\"\x17/v1/complex_garbage:get:\x01*\x12y\n\x0eGetGarbageNode\x12\".endless.trash.forever.GarbageNode\x1a\".endless.trash.forever.GarbageNode\"\x1f\x82\xd3\xe4\x93\x02\x19\"\x14/v1/garbage_node:get:\x01*\x12\x8c\x01\n\x0fGetPagedGarbage\x12*.endless.trash.forever.PagedGarbageRequest\x1a+.endless.trash.forever.PagedGarbageResponse\" \x82\xd3\xe4\x93\x02\x1a\"\x15/v1/paged_garbage:get:\x01*\x12\xe0\x01\n\x12LongRunningGarbage\x12\x30.endless.trash.forever.LongRunningGarbageRequest\x1a\x1d.google.longrunning.Operation\"y\xca\x41\\\n,google.garbage.v1.LongRunningGarbageResponse\x12,google.garbage.v1.LongRunningGarbageMetadata\x82\xd3\xe4\x93\x02\x14\"\x0f/v1/garbage:lro:\x01*\x12\x87\x01\n\rClientGarbage\x12).endless.trash.forever.ListGarbageRequest\x1a*.endless.trash.forever.ListGarbageResponse\"\x1d\x82\xd3\xe4\x93\x02\x17\"\x12/v1/garbage:client:\x01*(\x01\x12\x7f\n\rServerGarbage\x12).endless.trash.forever.ListGarbageRequest\x1a\".endless.trash.forever.GarbageItem\"\x1d\x82\xd3\xe4\x93\x02\x17\"\x12/v1/garbage:server:\x01*0\x01\x12`\n\x0b\x42idiGarbage\x12).endless.trash.forever.ListGarbageRequest\x1a\".endless.trash.forever.GarbageItem(\x01\x30\x01\x12\x66\n\x12\x42idiTypicalGarbage\x12%.endless.trash.forever.TypicalGarbage\x1a%.endless.trash.forever.TypicalGarbage(\x01\x30\x01\x12i\n\x04Send\x12#.endless.trash.forever.EmptyGarbage\x1a#.endless.trash.forever.EmptyGarbage\"\x17\x82\xd3\xe4\x93\x02\x11\"\x0c/v1/send:get:\x01*\x1a\xaa\x01\xca\x41\x18\x65ndlesstrash.example.net\xd2\x41\x8b\x01https://endlesstrash.example.net/garbage-admin,https://endlesstrash.example.net/garbage-read,https://endlesstrash.example.net/garbage-write2\xbc\x02\n\x0eRenamedService\x12}\n\x0fGetEmptyGarbage\x12#.endless.trash.forever.EmptyGarbage\x1a#.endless.trash.forever.EmptyGarbage\" \x82\xd3\xe4\x93\x02\x1a\"\x15/v1/empty_garbage:get:\x01*\x1a\xaa\x01\xca\x41\x18\x65ndlesstrash.example.net\xd2\x41\x8b\x01https://endlesstrash.example.net/garbage-admin,https://endlesstrash.example.net/garbage-read,https://endlesstrash.example.net/garbage-write2\xbf\x02\n\x11\x44\x65precatedService\x12|\n\rDeprecatedGet\x12#.endless.trash.forever.EmptyGarbage\x1a#.endless.trash.forever.EmptyGarbage\"!\x82\xd3\xe4\x93\x02\x1b\"\x16/v1/deprecated_get:get:\x01*\x1a\xab\x01\x88\x02\x01\xca\x41\x16\x64\x65precated.example.com\xd2\x41\x8b\x01https://endlesstrash.example.net/garbage-admin,https://endlesstrash.example.net/garbage-read,https://endlesstrash.example.net/garbage-writeB\x84\x03\xea\x02\x0fSo::Much::Trash\xea\x41\xee\x02\n endlesstrash.example.net/Garbage\x12\x32projects/{project}/simple_garbage/{simple_garbage}\x12\x38projects/{project}/typical_garbage_1/{typical_garbage_1}\x12\x38projects/{project}/typical_garbage_2/{typical_garbage_2}\x12\x36projects/{project}/specific_garbage/{specific_garbage}\x12\x32projects/{project}/nested_garbage/{nested_garbage}\x12\x36projects/{project}/repeated_garbage/{repeated_garbage}b\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool

begin
  pool.add_serialized_file(descriptor_data)
rescue TypeError
  # Compatibility code: will be removed in the next major version.
  require 'google/protobuf/descriptor_pb'
  parsed = Google::Protobuf::FileDescriptorProto.decode(descriptor_data)
  parsed.clear_dependency
  serialized = parsed.class.encode(parsed)
  file = pool.add_serialized_file(serialized)
  warn "Warning: Protobuf detected an import path issue while loading generated file #{__FILE__}"
  imports = [
    ["google.protobuf.Timestamp", "google/protobuf/timestamp.proto"],
    ["google.protobuf.Duration", "google/protobuf/duration.proto"],
  ]
  imports.each do |type_name, expected_filename|
    import_file = pool.lookup(type_name).file_descriptor
    if import_file.name != expected_filename
      warn "- #{file.name} imports #{expected_filename}, but that import was loaded as #{import_file.name}"
    end
  end
  warn "Each proto file must use a consistent fully-qualified name."
  warn "This will become an error in the next major version."
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
