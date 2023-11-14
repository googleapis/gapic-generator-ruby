# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/showcase/v1beta1/echo.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/routing_pb'
require 'google/longrunning/operations_pb'
require 'google/protobuf/any_pb'
require 'google/protobuf/duration_pb'
require 'google/protobuf/timestamp_pb'
require 'google/rpc/status_pb'


descriptor_data = "\n\"google/showcase/v1beta1/echo.proto\x12\x17google.showcase.v1beta1\x1a\x1cgoogle/api/annotations.proto\x1a\x17google/api/client.proto\x1a\x1fgoogle/api/field_behavior.proto\x1a\x18google/api/routing.proto\x1a#google/longrunning/operations.proto\x1a\x19google/protobuf/any.proto\x1a\x1egoogle/protobuf/duration.proto\x1a\x1fgoogle/protobuf/timestamp.proto\x1a\x17google/rpc/status.proto\"\xac\x01\n\x0b\x45\x63hoRequest\x12\x11\n\x07\x63ontent\x18\x01 \x01(\tH\x00\x12#\n\x05\x65rror\x18\x02 \x01(\x0b\x32\x12.google.rpc.StatusH\x00\x12\x33\n\x08severity\x18\x03 \x01(\x0e\x32!.google.showcase.v1beta1.Severity\x12\x0e\n\x06header\x18\x04 \x01(\t\x12\x14\n\x0cother_header\x18\x05 \x01(\tB\n\n\x08response\"T\n\x0c\x45\x63hoResponse\x12\x0f\n\x07\x63ontent\x18\x01 \x01(\t\x12\x33\n\x08severity\x18\x02 \x01(\x0e\x32!.google.showcase.v1beta1.Severity\"P\n\x17\x45\x63hoErrorDetailsRequest\x12\x1a\n\x12single_detail_text\x18\x01 \x01(\t\x12\x19\n\x11multi_detail_text\x18\x02 \x03(\t\"\xf2\x02\n\x18\x45\x63hoErrorDetailsResponse\x12U\n\rsingle_detail\x18\x01 \x01(\x0b\x32>.google.showcase.v1beta1.EchoErrorDetailsResponse.SingleDetail\x12[\n\x10multiple_details\x18\x02 \x01(\x0b\x32\x41.google.showcase.v1beta1.EchoErrorDetailsResponse.MultipleDetails\x1aM\n\x0cSingleDetail\x12=\n\x05\x65rror\x18\x01 \x01(\x0b\x32..google.showcase.v1beta1.ErrorWithSingleDetail\x1aS\n\x0fMultipleDetails\x12@\n\x05\x65rror\x18\x01 \x01(\x0b\x32\x31.google.showcase.v1beta1.ErrorWithMultipleDetails\">\n\x15\x45rrorWithSingleDetail\x12%\n\x07\x64\x65tails\x18\x01 \x01(\x0b\x32\x14.google.protobuf.Any\"A\n\x18\x45rrorWithMultipleDetails\x12%\n\x07\x64\x65tails\x18\x01 \x03(\x0b\x32\x14.google.protobuf.Any\"x\n\rExpandRequest\x12\x0f\n\x07\x63ontent\x18\x01 \x01(\t\x12!\n\x05\x65rror\x18\x02 \x01(\x0b\x32\x12.google.rpc.Status\x12\x33\n\x10stream_wait_time\x18\x03 \x01(\x0b\x32\x19.google.protobuf.Duration\"R\n\x12PagedExpandRequest\x12\x15\n\x07\x63ontent\x18\x01 \x01(\tB\x04\xe2\x41\x01\x02\x12\x11\n\tpage_size\x18\x02 \x01(\x05\x12\x12\n\npage_token\x18\x03 \x01(\t\"Z\n\x18PagedExpandLegacyRequest\x12\x15\n\x07\x63ontent\x18\x01 \x01(\tB\x04\xe2\x41\x01\x02\x12\x13\n\x0bmax_results\x18\x02 \x01(\x05\x12\x12\n\npage_token\x18\x03 \x01(\t\"h\n\x13PagedExpandResponse\x12\x38\n\tresponses\x18\x01 \x03(\x0b\x32%.google.showcase.v1beta1.EchoResponse\x12\x17\n\x0fnext_page_token\x18\x02 \x01(\t\"(\n\x17PagedExpandResponseList\x12\r\n\x05words\x18\x01 \x03(\t\"\x83\x02\n\x1fPagedExpandLegacyMappedResponse\x12`\n\x0c\x61lphabetized\x18\x01 \x03(\x0b\x32J.google.showcase.v1beta1.PagedExpandLegacyMappedResponse.AlphabetizedEntry\x12\x17\n\x0fnext_page_token\x18\x02 \x01(\t\x1a\x65\n\x11\x41lphabetizedEntry\x12\x0b\n\x03key\x18\x01 \x01(\t\x12?\n\x05value\x18\x02 \x01(\x0b\x32\x30.google.showcase.v1beta1.PagedExpandResponseList:\x02\x38\x01\"\xd9\x01\n\x0bWaitRequest\x12.\n\x08\x65nd_time\x18\x01 \x01(\x0b\x32\x1a.google.protobuf.TimestampH\x00\x12(\n\x03ttl\x18\x04 \x01(\x0b\x32\x19.google.protobuf.DurationH\x00\x12#\n\x05\x65rror\x18\x02 \x01(\x0b\x32\x12.google.rpc.StatusH\x01\x12\x38\n\x07success\x18\x03 \x01(\x0b\x32%.google.showcase.v1beta1.WaitResponseH\x01\x42\x05\n\x03\x65ndB\n\n\x08response\"\x1f\n\x0cWaitResponse\x12\x0f\n\x07\x63ontent\x18\x01 \x01(\t\"<\n\x0cWaitMetadata\x12,\n\x08\x65nd_time\x18\x01 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\"\xad\x01\n\x0c\x42lockRequest\x12\x31\n\x0eresponse_delay\x18\x01 \x01(\x0b\x32\x19.google.protobuf.Duration\x12#\n\x05\x65rror\x18\x02 \x01(\x0b\x32\x12.google.rpc.StatusH\x00\x12\x39\n\x07success\x18\x03 \x01(\x0b\x32&.google.showcase.v1beta1.BlockResponseH\x00\x42\n\n\x08response\" \n\rBlockResponse\x12\x0f\n\x07\x63ontent\x18\x01 \x01(\t*D\n\x08Severity\x12\x0f\n\x0bUNNECESSARY\x10\x00\x12\r\n\tNECESSARY\x10\x01\x12\n\n\x06URGENT\x10\x02\x12\x0c\n\x08\x43RITICAL\x10\x03\x32\xa1\r\n\x04\x45\x63ho\x12\x94\x03\n\x04\x45\x63ho\x12$.google.showcase.v1beta1.EchoRequest\x1a%.google.showcase.v1beta1.EchoResponse\"\xbe\x02\x82\xd3\xe4\x93\x02\x17\"\x12/v1beta1/echo:echo:\x01*\x8a\xd3\xe4\x93\x02\x9a\x02\x12\x08\n\x06header\x12\x19\n\x06header\x12\x0f{routing_id=**}\x12+\n\x06header\x12!{table_name=regions/*/zones/*/**}\x12\"\n\x06header\x12\x18{super_id=projects/*}/**\x12\x30\n\x06header\x12&{table_name=projects/*/instances/*/**}\x12\x31\n\x06header\x12\'projects/*/{instance_id=instances/*}/**\x12\x18\n\x0cother_header\x12\x08{baz=**}\x12#\n\x0cother_header\x12\x13{qux=projects/*}/**\x12\x9f\x01\n\x10\x45\x63hoErrorDetails\x12\x30.google.showcase.v1beta1.EchoErrorDetailsRequest\x1a\x31.google.showcase.v1beta1.EchoErrorDetailsResponse\"&\x82\xd3\xe4\x93\x02 \"\x1b/v1beta1/echo:error-details:\x01*\x12\x8a\x01\n\x06\x45xpand\x12&.google.showcase.v1beta1.ExpandRequest\x1a%.google.showcase.v1beta1.EchoResponse\"/\xda\x41\rcontent,error\x82\xd3\xe4\x93\x02\x19\"\x14/v1beta1/echo:expand:\x01*0\x01\x12z\n\x07\x43ollect\x12$.google.showcase.v1beta1.EchoRequest\x1a%.google.showcase.v1beta1.EchoResponse\" \x82\xd3\xe4\x93\x02\x1a\"\x15/v1beta1/echo:collect:\x01*(\x01\x12W\n\x04\x43hat\x12$.google.showcase.v1beta1.EchoRequest\x1a%.google.showcase.v1beta1.EchoResponse(\x01\x30\x01\x12\x8e\x01\n\x0bPagedExpand\x12+.google.showcase.v1beta1.PagedExpandRequest\x1a,.google.showcase.v1beta1.PagedExpandResponse\"$\x82\xd3\xe4\x93\x02\x1e\"\x19/v1beta1/echo:pagedExpand:\x01*\x12\xa0\x01\n\x11PagedExpandLegacy\x12\x31.google.showcase.v1beta1.PagedExpandLegacyRequest\x1a,.google.showcase.v1beta1.PagedExpandResponse\"*\x82\xd3\xe4\x93\x02$\"\x1f/v1beta1/echo:pagedExpandLegacy:\x01*\x12\xb2\x01\n\x17PagedExpandLegacyMapped\x12+.google.showcase.v1beta1.PagedExpandRequest\x1a\x38.google.showcase.v1beta1.PagedExpandLegacyMappedResponse\"0\x82\xd3\xe4\x93\x02*\"%/v1beta1/echo:pagedExpandLegacyMapped:\x01*\x12\x89\x01\n\x04Wait\x12$.google.showcase.v1beta1.WaitRequest\x1a\x1d.google.longrunning.Operation\"<\xca\x41\x1c\n\x0cWaitResponse\x12\x0cWaitMetadata\x82\xd3\xe4\x93\x02\x17\"\x12/v1beta1/echo:wait:\x01*\x12v\n\x05\x42lock\x12%.google.showcase.v1beta1.BlockRequest\x1a&.google.showcase.v1beta1.BlockResponse\"\x1e\x82\xd3\xe4\x93\x02\x18\"\x13/v1beta1/echo:block:\x01*\x1a\x11\xca\x41\x0elocalhost:7469Bq\n\x1b\x63om.google.showcase.v1beta1P\x01Z4github.com/googleapis/gapic-showcase/server/genproto\xea\x02\x19Google::Showcase::V1beta1b\x06proto3"

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
    ["google.rpc.Status", "google/rpc/status.proto"],
    ["google.protobuf.Any", "google/protobuf/any.proto"],
    ["google.protobuf.Duration", "google/protobuf/duration.proto"],
    ["google.protobuf.Timestamp", "google/protobuf/timestamp.proto"],
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
      EchoRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.EchoRequest").msgclass
      EchoResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.EchoResponse").msgclass
      EchoErrorDetailsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.EchoErrorDetailsRequest").msgclass
      EchoErrorDetailsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.EchoErrorDetailsResponse").msgclass
      EchoErrorDetailsResponse::SingleDetail = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.EchoErrorDetailsResponse.SingleDetail").msgclass
      EchoErrorDetailsResponse::MultipleDetails = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.EchoErrorDetailsResponse.MultipleDetails").msgclass
      ErrorWithSingleDetail = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ErrorWithSingleDetail").msgclass
      ErrorWithMultipleDetails = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ErrorWithMultipleDetails").msgclass
      ExpandRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ExpandRequest").msgclass
      PagedExpandRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.PagedExpandRequest").msgclass
      PagedExpandLegacyRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.PagedExpandLegacyRequest").msgclass
      PagedExpandResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.PagedExpandResponse").msgclass
      PagedExpandResponseList = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.PagedExpandResponseList").msgclass
      PagedExpandLegacyMappedResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.PagedExpandLegacyMappedResponse").msgclass
      WaitRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.WaitRequest").msgclass
      WaitResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.WaitResponse").msgclass
      WaitMetadata = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.WaitMetadata").msgclass
      BlockRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.BlockRequest").msgclass
      BlockResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.BlockResponse").msgclass
      Severity = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.Severity").enummodule
    end
  end
end
