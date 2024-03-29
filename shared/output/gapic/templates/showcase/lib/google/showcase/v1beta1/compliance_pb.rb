# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/showcase/v1beta1/compliance.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'


descriptor_data = "\n(google/showcase/v1beta1/compliance.proto\x12\x17google.showcase.v1beta1\x1a\x1cgoogle/api/annotations.proto\x1a\x17google/api/client.proto\"\xc3\x02\n\rRepeatRequest\x12\x0c\n\x04name\x18\x01 \x01(\t\x12\x35\n\x04info\x18\x02 \x01(\x0b\x32\'.google.showcase.v1beta1.ComplianceData\x12\x15\n\rserver_verify\x18\x03 \x01(\x08\x12!\n\x14intended_binding_uri\x18\n \x01(\tH\x00\x88\x01\x01\x12\x0f\n\x07\x66_int32\x18\x04 \x01(\x05\x12\x0f\n\x07\x66_int64\x18\x05 \x01(\x03\x12\x10\n\x08\x66_double\x18\x06 \x01(\x01\x12\x14\n\x07p_int32\x18\x07 \x01(\x05H\x01\x88\x01\x01\x12\x14\n\x07p_int64\x18\x08 \x01(\x03H\x02\x88\x01\x01\x12\x15\n\x08p_double\x18\t \x01(\x01H\x03\x88\x01\x01\x42\x17\n\x15_intended_binding_uriB\n\n\x08_p_int32B\n\n\x08_p_int64B\x0b\n\t_p_double\"^\n\x0eRepeatResponse\x12\x37\n\x07request\x18\x01 \x01(\x0b\x32&.google.showcase.v1beta1.RepeatRequest\x12\x13\n\x0b\x62inding_uri\x18\x02 \x01(\t\"J\n\x0f\x43omplianceSuite\x12\x37\n\x05group\x18\x01 \x03(\x0b\x32(.google.showcase.v1beta1.ComplianceGroup\"g\n\x0f\x43omplianceGroup\x12\x0c\n\x04name\x18\x01 \x01(\t\x12\x0c\n\x04rpcs\x18\x02 \x03(\t\x12\x38\n\x08requests\x18\x03 \x03(\x0b\x32&.google.showcase.v1beta1.RepeatRequest\"\xe0\x06\n\x0e\x43omplianceData\x12\x10\n\x08\x66_string\x18\x01 \x01(\t\x12\x0f\n\x07\x66_int32\x18\x02 \x01(\x05\x12\x10\n\x08\x66_sint32\x18\x03 \x01(\x11\x12\x12\n\nf_sfixed32\x18\x04 \x01(\x0f\x12\x10\n\x08\x66_uint32\x18\x05 \x01(\r\x12\x11\n\tf_fixed32\x18\x06 \x01(\x07\x12\x0f\n\x07\x66_int64\x18\x07 \x01(\x03\x12\x10\n\x08\x66_sint64\x18\x08 \x01(\x12\x12\x12\n\nf_sfixed64\x18\t \x01(\x10\x12\x10\n\x08\x66_uint64\x18\n \x01(\x04\x12\x11\n\tf_fixed64\x18\x0b \x01(\x06\x12\x10\n\x08\x66_double\x18\x0c \x01(\x01\x12\x0f\n\x07\x66_float\x18\r \x01(\x02\x12\x0e\n\x06\x66_bool\x18\x0e \x01(\x08\x12\x0f\n\x07\x66_bytes\x18\x0f \x01(\x0c\x12\x46\n\tf_kingdom\x18\x16 \x01(\x0e\x32\x33.google.showcase.v1beta1.ComplianceData.LifeKingdom\x12=\n\x07\x66_child\x18\x10 \x01(\x0b\x32,.google.showcase.v1beta1.ComplianceDataChild\x12\x15\n\x08p_string\x18\x11 \x01(\tH\x00\x88\x01\x01\x12\x14\n\x07p_int32\x18\x12 \x01(\x05H\x01\x88\x01\x01\x12\x15\n\x08p_double\x18\x13 \x01(\x01H\x02\x88\x01\x01\x12\x13\n\x06p_bool\x18\x14 \x01(\x08H\x03\x88\x01\x01\x12K\n\tp_kingdom\x18\x17 \x01(\x0e\x32\x33.google.showcase.v1beta1.ComplianceData.LifeKingdomH\x04\x88\x01\x01\x12\x42\n\x07p_child\x18\x15 \x01(\x0b\x32,.google.showcase.v1beta1.ComplianceDataChildH\x05\x88\x01\x01\"\x83\x01\n\x0bLifeKingdom\x12\x1c\n\x18LIFE_KINGDOM_UNSPECIFIED\x10\x00\x12\x12\n\x0e\x41RCHAEBACTERIA\x10\x01\x12\x0e\n\nEUBACTERIA\x10\x02\x12\x0c\n\x08PROTISTA\x10\x03\x12\t\n\x05\x46UNGI\x10\x04\x12\x0b\n\x07PLANTAE\x10\x05\x12\x0c\n\x08\x41NIMALIA\x10\x06\x42\x0b\n\t_p_stringB\n\n\x08_p_int32B\x0b\n\t_p_doubleB\t\n\x07_p_boolB\x0c\n\n_p_kingdomB\n\n\x08_p_child\"\xef\x03\n\x13\x43omplianceDataChild\x12\x10\n\x08\x66_string\x18\x01 \x01(\t\x12\x0f\n\x07\x66_float\x18\x02 \x01(\x02\x12\x10\n\x08\x66_double\x18\x03 \x01(\x01\x12\x0e\n\x06\x66_bool\x18\x04 \x01(\x08\x12\x37\n\x0b\x66_continent\x18\x0b \x01(\x0e\x32\".google.showcase.v1beta1.Continent\x12\x42\n\x07\x66_child\x18\x05 \x01(\x0b\x32\x31.google.showcase.v1beta1.ComplianceDataGrandchild\x12\x15\n\x08p_string\x18\x06 \x01(\tH\x00\x88\x01\x01\x12\x14\n\x07p_float\x18\x07 \x01(\x02H\x01\x88\x01\x01\x12\x15\n\x08p_double\x18\x08 \x01(\x01H\x02\x88\x01\x01\x12\x13\n\x06p_bool\x18\t \x01(\x08H\x03\x88\x01\x01\x12\x37\n\x0bp_continent\x18\x0c \x01(\x0e\x32\".google.showcase.v1beta1.Continent\x12G\n\x07p_child\x18\n \x01(\x0b\x32\x31.google.showcase.v1beta1.ComplianceDataGrandchildH\x04\x88\x01\x01\x42\x0b\n\t_p_stringB\n\n\x08_p_floatB\x0b\n\t_p_doubleB\t\n\x07_p_boolB\n\n\x08_p_child\"N\n\x18\x43omplianceDataGrandchild\x12\x10\n\x08\x66_string\x18\x01 \x01(\t\x12\x10\n\x08\x66_double\x18\x02 \x01(\x01\x12\x0e\n\x06\x66_bool\x18\x03 \x01(\x08\"#\n\x0b\x45numRequest\x12\x14\n\x0cunknown_enum\x18\x01 \x01(\x08\"|\n\x0c\x45numResponse\x12\x35\n\x07request\x18\x01 \x01(\x0b\x32$.google.showcase.v1beta1.EnumRequest\x12\x35\n\tcontinent\x18\x02 \x01(\x0e\x32\".google.showcase.v1beta1.Continent*i\n\tContinent\x12\x19\n\x15\x43ONTINENT_UNSPECIFIED\x10\x00\x12\n\n\x06\x41\x46RICA\x10\x01\x12\x0b\n\x07\x41MERICA\x10\x02\x12\r\n\tANTARTICA\x10\x03\x12\r\n\tAUSTRALIA\x10\x04\x12\n\n\x06\x45UROPE\x10\x05\x32\xd8\r\n\nCompliance\x12\x82\x01\n\x0eRepeatDataBody\x12&.google.showcase.v1beta1.RepeatRequest\x1a\'.google.showcase.v1beta1.RepeatResponse\"\x1f\x82\xd3\xe4\x93\x02\x19\"\x14/v1beta1/repeat:body:\x01*\x12\x8d\x01\n\x12RepeatDataBodyInfo\x12&.google.showcase.v1beta1.RepeatRequest\x1a\'.google.showcase.v1beta1.RepeatResponse\"&\x82\xd3\xe4\x93\x02 \"\x18/v1beta1/repeat:bodyinfo:\x04info\x12\x81\x01\n\x0fRepeatDataQuery\x12&.google.showcase.v1beta1.RepeatRequest\x1a\'.google.showcase.v1beta1.RepeatResponse\"\x1d\x82\xd3\xe4\x93\x02\x17\x12\x15/v1beta1/repeat:query\x12\xd9\x01\n\x14RepeatDataSimplePath\x12&.google.showcase.v1beta1.RepeatRequest\x1a\'.google.showcase.v1beta1.RepeatResponse\"p\x82\xd3\xe4\x93\x02j\x12h/v1beta1/repeat/{info.f_string}/{info.f_int32}/{info.f_double}/{info.f_bool}/{info.f_kingdom}:simplepath\x12\xd3\x02\n\x16RepeatDataPathResource\x12&.google.showcase.v1beta1.RepeatRequest\x1a\'.google.showcase.v1beta1.RepeatResponse\"\xe7\x01\x82\xd3\xe4\x93\x02\xe0\x01\x12h/v1beta1/repeat/{info.f_string=first/*}/{info.f_child.f_string=second/*}/bool/{info.f_bool}:pathresourceZt\x12r/v1beta1/repeat/{info.f_child.f_string=first/*}/{info.f_string=second/*}/bool/{info.f_bool}:childfirstpathresource\x12\xd9\x01\n\x1eRepeatDataPathTrailingResource\x12&.google.showcase.v1beta1.RepeatRequest\x1a\'.google.showcase.v1beta1.RepeatResponse\"f\x82\xd3\xe4\x93\x02`\x12^/v1beta1/repeat/{info.f_string=first/*}/{info.f_child.f_string=second/**}:pathtrailingresource\x12\x88\x01\n\x11RepeatDataBodyPut\x12&.google.showcase.v1beta1.RepeatRequest\x1a\'.google.showcase.v1beta1.RepeatResponse\"\"\x82\xd3\xe4\x93\x02\x1c\x1a\x17/v1beta1/repeat:bodyput:\x01*\x12\x8c\x01\n\x13RepeatDataBodyPatch\x12&.google.showcase.v1beta1.RepeatRequest\x1a\'.google.showcase.v1beta1.RepeatResponse\"$\x82\xd3\xe4\x93\x02\x1e\x32\x19/v1beta1/repeat:bodypatch:\x01*\x12x\n\x07GetEnum\x12$.google.showcase.v1beta1.EnumRequest\x1a%.google.showcase.v1beta1.EnumResponse\" \x82\xd3\xe4\x93\x02\x1a\x12\x18/v1beta1/compliance/enum\x12|\n\nVerifyEnum\x12%.google.showcase.v1beta1.EnumResponse\x1a%.google.showcase.v1beta1.EnumResponse\" \x82\xd3\xe4\x93\x02\x1a\"\x18/v1beta1/compliance/enum\x1a\x11\xca\x41\x0elocalhost:7469Bq\n\x1b\x63om.google.showcase.v1beta1P\x01Z4github.com/googleapis/gapic-showcase/server/genproto\xea\x02\x19Google::Showcase::V1beta1b\x06proto3"

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

module Google
  module Showcase
    module V1beta1
      RepeatRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.RepeatRequest").msgclass
      RepeatResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.RepeatResponse").msgclass
      ComplianceSuite = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ComplianceSuite").msgclass
      ComplianceGroup = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ComplianceGroup").msgclass
      ComplianceData = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ComplianceData").msgclass
      ComplianceData::LifeKingdom = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ComplianceData.LifeKingdom").enummodule
      ComplianceDataChild = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ComplianceDataChild").msgclass
      ComplianceDataGrandchild = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ComplianceDataGrandchild").msgclass
      EnumRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.EnumRequest").msgclass
      EnumResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.EnumResponse").msgclass
      Continent = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.Continent").enummodule
    end
  end
end
