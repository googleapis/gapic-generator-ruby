# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: transcoding_example.proto

require 'google/protobuf'


descriptor_data = "\n\x19transcoding_example.proto\x12\x1agapic.examples.transcoding\"\xed\x01\n\x07Request\x12\n\n\x02id\x18\x01 \x01(\x05\x12\x0c\n\x04name\x18\x02 \x01(\t\x12\x16\n\tmaybe_num\x18\x03 \x01(\x05H\x00\x88\x01\x01\x12\x38\n\x0bsub_request\x18\x04 \x01(\x0b\x32#.gapic.examples.transcoding.Request\x12\x0c\n\x04nums\x18\x05 \x03(\x05\x12\x0c\n\x04strs\x18\x06 \x03(\t\x12=\n\nIPProtocol\x18\x07 \x01(\x0e\x32$.gapic.examples.transcoding.ProtocolH\x01\x88\x01\x01\x42\x0c\n\n_maybe_numB\r\n\x0b_IPProtocol*)\n\x08Protocol\x12\x0b\n\x07Unknown\x10\x00\x12\x07\n\x03TCP\x10\x01\x12\x07\n\x03UDP\x10\x02\x62\x06proto3"

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

module Gapic
  module Examples
    module Transcoding
      Request = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("gapic.examples.transcoding.Request").msgclass
      Protocol = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("gapic.examples.transcoding.Protocol").enummodule
    end
  end
end
