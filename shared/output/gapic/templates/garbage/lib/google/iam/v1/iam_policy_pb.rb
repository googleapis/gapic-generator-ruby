# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/iam/v1/iam_policy.proto

require 'google/protobuf'

require 'google/iam/v1/options_pb'
require 'google/iam/v1/policy_pb'
require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/iam/v1/iam_policy.proto", :syntax => :proto3) do
    add_message "google.iam.v1.SetIamPolicyRequest" do
      optional :resource, :string, 1
      optional :policy, :message, 2, "google.iam.v1.Policy"
    end
    add_message "google.iam.v1.GetIamPolicyRequest" do
      optional :resource, :string, 1
      optional :options, :message, 2, "google.iam.v1.GetPolicyOptions"
    end
    add_message "google.iam.v1.TestIamPermissionsRequest" do
      optional :resource, :string, 1
      repeated :permissions, :string, 2
    end
    add_message "google.iam.v1.TestIamPermissionsResponse" do
      repeated :permissions, :string, 1
    end
  end
end

module Google
  module Iam
    module V1
      SetIamPolicyRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.iam.v1.SetIamPolicyRequest").msgclass
      GetIamPolicyRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.iam.v1.GetIamPolicyRequest").msgclass
      TestIamPermissionsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.iam.v1.TestIamPermissionsRequest").msgclass
      TestIamPermissionsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.iam.v1.TestIamPermissionsResponse").msgclass
    end
  end
end
