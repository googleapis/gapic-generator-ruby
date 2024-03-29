# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/common_resources.proto

require 'google/protobuf'

require 'google/api/resource_pb'


descriptor_data = "\n#google/cloud/common_resources.proto\x12\x0cgoogle.cloud\x1a\x19google/api/resource.protoB\xf9\x02\xea\x41\x41\n+cloudresourcemanager.googleapis.com/Project\x12\x12projects/{project}\xea\x41P\n0cloudresourcemanager.googleapis.com/Organization\x12\x1corganizations/{organization}\xea\x41>\n*cloudresourcemanager.googleapis.com/Folder\x12\x10\x66olders/{folder}\xea\x41O\n*cloudbilling.googleapis.com/BillingAccount\x12!billingAccounts/{billing_account}\xea\x41L\n!locations.googleapis.com/Location\x12\'projects/{project}/locations/{location}b\x06proto3"

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
  module Cloud
  end
end
