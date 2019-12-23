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
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/showcase/v1beta1/identity.proto", :syntax => :proto3) do
    add_message "google.showcase.v1beta1.User" do
      optional :name, :string, 1
      optional :display_name, :string, 2
      optional :email, :string, 3
      optional :create_time, :message, 4, "google.protobuf.Timestamp"
      optional :update_time, :message, 5, "google.protobuf.Timestamp"
    end
    add_message "google.showcase.v1beta1.CreateUserRequest" do
      optional :user, :message, 1, "google.showcase.v1beta1.User"
    end
    add_message "google.showcase.v1beta1.GetUserRequest" do
      optional :name, :string, 1
    end
    add_message "google.showcase.v1beta1.UpdateUserRequest" do
      optional :user, :message, 1, "google.showcase.v1beta1.User"
      optional :update_mask, :message, 2, "google.protobuf.FieldMask"
    end
    add_message "google.showcase.v1beta1.DeleteUserRequest" do
      optional :name, :string, 1
    end
    add_message "google.showcase.v1beta1.ListUsersRequest" do
      optional :page_size, :int32, 1
      optional :page_token, :string, 2
    end
    add_message "google.showcase.v1beta1.ListUsersResponse" do
      repeated :users, :message, 1, "google.showcase.v1beta1.User"
      optional :next_page_token, :string, 2
    end
  end
end

module Google
  module Showcase
    module V1beta1
      User = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.User").msgclass
      CreateUserRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.CreateUserRequest").msgclass
      GetUserRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.GetUserRequest").msgclass
      UpdateUserRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.UpdateUserRequest").msgclass
      DeleteUserRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.DeleteUserRequest").msgclass
      ListUsersRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ListUsersRequest").msgclass
      ListUsersResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.showcase.v1beta1.ListUsersResponse").msgclass
    end
  end
end
