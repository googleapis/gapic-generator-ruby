# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: grafeas/v1/package.proto

require 'google/protobuf'

require 'google/api/field_behavior_pb'
require 'grafeas/v1/common_pb'


descriptor_data = "\n\x18grafeas/v1/package.proto\x12\ngrafeas.v1\x1a\x1fgoogle/api/field_behavior.proto\x1a\x17grafeas/v1/common.proto\"\xb7\x01\n\x0c\x44istribution\x12\x14\n\x07\x63pe_uri\x18\x01 \x01(\tB\x03\xe0\x41\x02\x12.\n\x0c\x61rchitecture\x18\x02 \x01(\x0e\x32\x18.grafeas.v1.Architecture\x12+\n\x0elatest_version\x18\x03 \x01(\x0b\x32\x13.grafeas.v1.Version\x12\x12\n\nmaintainer\x18\x04 \x01(\t\x12\x0b\n\x03url\x18\x05 \x01(\t\x12\x13\n\x0b\x64\x65scription\x18\x06 \x01(\t\"O\n\x08Location\x12\x0f\n\x07\x63pe_uri\x18\x01 \x01(\t\x12$\n\x07version\x18\x02 \x01(\x0b\x32\x13.grafeas.v1.Version\x12\x0c\n\x04path\x18\x03 \x01(\t\"\xd0\x02\n\x0bPackageNote\x12\x14\n\x04name\x18\x01 \x01(\tB\x06\xe0\x41\x02\xe0\x41\x05\x12.\n\x0c\x64istribution\x18\n \x03(\x0b\x32\x18.grafeas.v1.Distribution\x12\x14\n\x0cpackage_type\x18\x0b \x01(\t\x12\x0f\n\x07\x63pe_uri\x18\x0c \x01(\t\x12.\n\x0c\x61rchitecture\x18\r \x01(\x0e\x32\x18.grafeas.v1.Architecture\x12$\n\x07version\x18\x0e \x01(\x0b\x32\x13.grafeas.v1.Version\x12\x12\n\nmaintainer\x18\x0f \x01(\t\x12\x0b\n\x03url\x18\x10 \x01(\t\x12\x13\n\x0b\x64\x65scription\x18\x11 \x01(\t\x12$\n\x07license\x18\x12 \x01(\x0b\x32\x13.grafeas.v1.License\x12\"\n\x06\x64igest\x18\x13 \x03(\x0b\x32\x12.grafeas.v1.Digest\"\x88\x02\n\x11PackageOccurrence\x12\x14\n\x04name\x18\x01 \x01(\tB\x06\xe0\x41\x02\xe0\x41\x03\x12&\n\x08location\x18\x02 \x03(\x0b\x32\x14.grafeas.v1.Location\x12\x19\n\x0cpackage_type\x18\x03 \x01(\tB\x03\xe0\x41\x03\x12\x14\n\x07\x63pe_uri\x18\x04 \x01(\tB\x03\xe0\x41\x03\x12\x33\n\x0c\x61rchitecture\x18\x05 \x01(\x0e\x32\x18.grafeas.v1.ArchitectureB\x03\xe0\x41\x03\x12$\n\x07license\x18\x06 \x01(\x0b\x32\x13.grafeas.v1.License\x12)\n\x07version\x18\x07 \x01(\x0b\x32\x13.grafeas.v1.VersionB\x03\xe0\x41\x03\"\xe0\x01\n\x07Version\x12\r\n\x05\x65poch\x18\x01 \x01(\x05\x12\x0c\n\x04name\x18\x02 \x01(\t\x12\x10\n\x08revision\x18\x03 \x01(\t\x12\x11\n\tinclusive\x18\x06 \x01(\x08\x12-\n\x04kind\x18\x04 \x01(\x0e\x32\x1f.grafeas.v1.Version.VersionKind\x12\x11\n\tfull_name\x18\x05 \x01(\t\"Q\n\x0bVersionKind\x12\x1c\n\x18VERSION_KIND_UNSPECIFIED\x10\x00\x12\n\n\x06NORMAL\x10\x01\x12\x0b\n\x07MINIMUM\x10\x02\x12\x0b\n\x07MAXIMUM\x10\x03*>\n\x0c\x41rchitecture\x12\x1c\n\x18\x41RCHITECTURE_UNSPECIFIED\x10\x00\x12\x07\n\x03X86\x10\x01\x12\x07\n\x03X64\x10\x02\x42Q\n\rio.grafeas.v1P\x01Z8google.golang.org/genproto/googleapis/grafeas/v1;grafeas\xa2\x02\x03GRAb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool

begin
  pool.add_serialized_file(descriptor_data)
rescue TypeError => e
  # Compatibility code: will be removed in the next major version.
  require 'google/protobuf/descriptor_pb'
  parsed = Google::Protobuf::FileDescriptorProto.decode(descriptor_data)
  parsed.clear_dependency
  serialized = parsed.class.encode(parsed)
  file = pool.add_serialized_file(serialized)
  warn "Warning: Protobuf detected an import path issue while loading generated file #{__FILE__}"
  imports = [
    ["grafeas.v1.License", "grafeas/v1/common.proto"],
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

module Grafeas
  module V1
    Distribution = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.Distribution").msgclass
    Location = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.Location").msgclass
    PackageNote = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.PackageNote").msgclass
    PackageOccurrence = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.PackageOccurrence").msgclass
    Version = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.Version").msgclass
    Version::VersionKind = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.Version.VersionKind").enummodule
    Architecture = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.Architecture").enummodule
  end
end
