# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/showcase/v1beta1/identity.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/protobuf/empty_pb'
require 'google/protobuf/field_mask_pb'
require 'google/protobuf/timestamp_pb'


descriptor_data = "\n&google/showcase/v1beta1/identity.proto\x12\x17google.showcase.v1beta1\x1a\x1cgoogle/api/annotations.proto\x1a\x17google/api/client.proto\x1a\x1fgoogle/api/field_behavior.proto\x1a\x19google/api/resource.proto\x1a\x1bgoogle/protobuf/empty.proto\x1a google/protobuf/field_mask.proto\x1a\x1fgoogle/protobuf/timestamp.proto\"\x88\x03\n\x04User\x12\x0c\n\x04name\x18\x01 \x01(\t\x12\x1a\n\x0c\x64isplay_name\x18\x02 \x01(\tB\x04\xe2\x41\x01\x02\x12\x13\n\x05\x65mail\x18\x03 \x01(\tB\x04\xe2\x41\x01\x02\x12\x35\n\x0b\x63reate_time\x18\x04 \x01(\x0b\x32\x1a.google.protobuf.TimestampB\x04\xe2\x41\x01\x03\x12\x35\n\x0bupdate_time\x18\x05 \x01(\x0b\x32\x1a.google.protobuf.TimestampB\x04\xe2\x41\x01\x03\x12\x10\n\x03\x61ge\x18\x06 \x01(\x05H\x00\x88\x01\x01\x12\x18\n\x0bheight_feet\x18\x07 \x01(\x01H\x01\x88\x01\x01\x12\x15\n\x08nickname\x18\x08 \x01(\tH\x02\x88\x01\x01\x12!\n\x14\x65nable_notifications\x18\t \x01(\x08H\x03\x88\x01\x01:/\xea\x41,\n\x1cshowcase.googleapis.com/User\x12\x0cusers/{user}B\x06\n\x04_ageB\x0e\n\x0c_height_feetB\x0b\n\t_nicknameB\x17\n\x15_enable_notifications\"@\n\x11\x43reateUserRequest\x12+\n\x04user\x18\x01 \x01(\x0b\x32\x1d.google.showcase.v1beta1.User\"E\n\x0eGetUserRequest\x12\x33\n\x04name\x18\x01 \x01(\tB%\xe2\x41\x01\x02\xfa\x41\x1e\n\x1cshowcase.googleapis.com/User\"q\n\x11UpdateUserRequest\x12+\n\x04user\x18\x01 \x01(\x0b\x32\x1d.google.showcase.v1beta1.User\x12/\n\x0bupdate_mask\x18\x02 \x01(\x0b\x32\x1a.google.protobuf.FieldMask\"H\n\x11\x44\x65leteUserRequest\x12\x33\n\x04name\x18\x01 \x01(\tB%\xe2\x41\x01\x02\xfa\x41\x1e\n\x1cshowcase.googleapis.com/User\"9\n\x10ListUsersRequest\x12\x11\n\tpage_size\x18\x01 \x01(\x05\x12\x12\n\npage_token\x18\x02 \x01(\t\"Z\n\x11ListUsersResponse\x12,\n\x05users\x18\x01 \x03(\x0b\x32\x1d.google.showcase.v1beta1.User\x12\x17\n\x0fnext_page_token\x18\x02 \x01(\t2\x8a\x06\n\x08Identity\x12\xf3\x01\n\nCreateUser\x12*.google.showcase.v1beta1.CreateUserRequest\x1a\x1d.google.showcase.v1beta1.User\"\x99\x01\xda\x41\x1cuser.display_name,user.email\xda\x41^user.display_name,user.email,user.age,user.nickname,user.enable_notifications,user.height_feet\x82\xd3\xe4\x93\x02\x13\"\x0e/v1beta1/users:\x01*\x12y\n\x07GetUser\x12\'.google.showcase.v1beta1.GetUserRequest\x1a\x1d.google.showcase.v1beta1.User\"&\xda\x41\x04name\x82\xd3\xe4\x93\x02\x19\x12\x17/v1beta1/{name=users/*}\x12\x83\x01\n\nUpdateUser\x12*.google.showcase.v1beta1.UpdateUserRequest\x1a\x1d.google.showcase.v1beta1.User\"*\x82\xd3\xe4\x93\x02$2\x1c/v1beta1/{user.name=users/*}:\x04user\x12x\n\nDeleteUser\x12*.google.showcase.v1beta1.DeleteUserRequest\x1a\x16.google.protobuf.Empty\"&\xda\x41\x04name\x82\xd3\xe4\x93\x02\x19*\x17/v1beta1/{name=users/*}\x12z\n\tListUsers\x12).google.showcase.v1beta1.ListUsersRequest\x1a*.google.showcase.v1beta1.ListUsersResponse\"\x16\x82\xd3\xe4\x93\x02\x10\x12\x0e/v1beta1/users\x1a\x11\xca\x41\x0elocalhost:7469Bq\n\x1b\x63om.google.showcase.v1beta1P\x01Z4github.com/googleapis/gapic-showcase/server/genproto\xea\x02\x19Google::Showcase::V1beta1b\x06proto3"

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
    ["google.protobuf.Timestamp", "google/protobuf/timestamp.proto"],
    ["google.protobuf.FieldMask", "google/protobuf/field_mask.proto"],
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
      User = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.User").msgclass
      CreateUserRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.CreateUserRequest").msgclass
      GetUserRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.GetUserRequest").msgclass
      UpdateUserRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.UpdateUserRequest").msgclass
      DeleteUserRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.DeleteUserRequest").msgclass
      ListUsersRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ListUsersRequest").msgclass
      ListUsersResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ListUsersResponse").msgclass
    end
  end
end
