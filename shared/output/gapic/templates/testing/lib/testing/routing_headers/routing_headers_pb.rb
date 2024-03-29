# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: testing/routing_headers/routing_headers.proto

require 'google/protobuf'

require 'google/api/client_pb'
require 'google/api/annotations_pb'
require 'google/api/routing_pb'


descriptor_data = "\n-testing/routing_headers/routing_headers.proto\x12\x16testing.routingheaders\x1a\x17google/api/client.proto\x1a\x1cgoogle/api/annotations.proto\x1a\x18google/api/routing.proto\"p\n\x07Request\x12\x12\n\ntable_name\x18\x01 \x01(\t\x12\x16\n\x0e\x61pp_profile_id\x18\x02 \x01(\t\x12\x39\n\x08resource\x18\x03 \x01(\x0b\x32\'.testing.routingheaders.RequestResource\"^\n\x0fRequestResource\x12\x15\n\rresource_name\x18\x01 \x01(\t\x12\x34\n\x05inner\x18\x02 \x01(\x0b\x32%.testing.routingheaders.InnerResource\"#\n\rInnerResource\x12\x12\n\ninner_name\x18\x01 \x01(\t\"\n\n\x08Response2\x7f\n\x10ServiceNoHeaders\x12L\n\x05Plain\x12\x1f.testing.routingheaders.Request\x1a .testing.routingheaders.Response\"\x00\x1a\x1d\xca\x41\x1aroutingheaders.example.com2\xa5\x04\n\x16ServiceImplicitHeaders\x12\x8a\x01\n\x05Plain\x12\x1f.testing.routingheaders.Request\x1a .testing.routingheaders.Response\">\x82\xd3\xe4\x93\x02\x38\x12\x36/v2/{table_name=projects/*/instances/*/tables/*}:plain\x12\xa8\x01\n\x0eWithSubMessage\x12\x1f.testing.routingheaders.Request\x1a .testing.routingheaders.Response\"S\x82\xd3\xe4\x93\x02M\x12K/v2/{resource.resource_name=projects/*/instances/*/tables/*}:withSubMessage\x12\xb3\x01\n\x12WithMultipleLevels\x12\x1f.testing.routingheaders.Request\x1a .testing.routingheaders.Response\"Z\x82\xd3\xe4\x93\x02T\x12R/v2/{resource.inner.inner_name=projects/*/instances/*/tables/*}:withMultipleLevels\x1a\x1d\xca\x41\x1aroutingheaders.example.com2\xcc\x0b\n\x16ServiceExplicitHeaders\x12\xb0\x01\n\x0fPlainNoTemplate\x12\x1f.testing.routingheaders.Request\x1a .testing.routingheaders.Response\"Z\x82\xd3\xe4\x93\x02@\x12>/v2/{table_name=projects/*/instances/*/tables/*}:sampleRowKeys\x8a\xd3\xe4\x93\x02\x0e\x12\x0c\n\ntable_name\x12\xde\x01\n\x0ePlainFullField\x12\x1f.testing.routingheaders.Request\x1a .testing.routingheaders.Response\"\x88\x01\x82\xd3\xe4\x93\x02@\x12>/v2/{table_name=projects/*/instances/*/tables/*}:sampleRowKeys\x8a\xd3\xe4\x93\x02<\x12:\n\ntable_name\x12,{table_name=projects/*/instances/*/tables/*}\x12\xdc\x01\n\x0cPlainExtract\x12\x1f.testing.routingheaders.Request\x1a .testing.routingheaders.Response\"\x88\x01\x82\xd3\xe4\x93\x02@\x12>/v2/{table_name=projects/*/instances/*/tables/*}:sampleRowKeys\x8a\xd3\xe4\x93\x02<\x12:\n\ntable_name\x12,projects/*/instances/*/{table_name=tables/*}\x12\x93\x04\n\x07\x43omplex\x12\x1f.testing.routingheaders.Request\x1a .testing.routingheaders.Response\"\xc4\x03\x82\xd3\xe4\x93\x02@\x12>/v2/{table_name=projects/*/instances/*/tables/*}:sampleRowKeys\x8a\xd3\xe4\x93\x02\xf7\x02\x12:\n\ntable_name\x12,{project_id=projects/*}/instances/*/tables/*\x12;\n\ntable_name\x12-projects/*/{instance_id=instances/*}/tables/*\x12\x38\n\ntable_name\x12*projects/*/instances/*/{table_id=tables/*}\x12:\n\ntable_name\x12,{table_name=projects/*/instances/*/tables/*}\x12\x45\n\ntable_name\x12\x37{table_name=projects/*/instances/*/tables/*/aliases/**}\x12\x10\n\x0e\x61pp_profile_id\x12-\n\x0e\x61pp_profile_id\x12\x1b{app_profile_id_renamed=**}\x12\x89\x02\n\x0eWithSubMessage\x12\x1f.testing.routingheaders.Request\x1a .testing.routingheaders.Response\"\xb3\x01\x82\xd3\xe4\x93\x02M\x12K/v2/{resource.resource_name=projects/*/instances/*/tables/*}:withSubMessage\x8a\xd3\xe4\x93\x02Z\x12\x46\n\x16resource.resource_name\x12,{table_name=projects/*/instances/*/tables/*}\x12\x10\n\x0e\x61pp_profile_id\x1a\x1d\xca\x41\x1aroutingheaders.example.comB\x1a\xea\x02\x17Testing::RoutingHeadersb\x06proto3"

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

module Testing
  module RoutingHeaders
    Request = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("testing.routingheaders.Request").msgclass
    RequestResource = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("testing.routingheaders.RequestResource").msgclass
    InnerResource = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("testing.routingheaders.InnerResource").msgclass
    Response = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("testing.routingheaders.Response").msgclass
  end
end
