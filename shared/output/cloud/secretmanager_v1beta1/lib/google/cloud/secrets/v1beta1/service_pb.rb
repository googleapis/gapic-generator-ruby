# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/secrets/v1beta1/service.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/cloud/secrets/v1beta1/resources_pb'
require 'google/iam/v1/iam_policy_pb'
require 'google/iam/v1/policy_pb'
require 'google/protobuf/empty_pb'
require 'google/protobuf/field_mask_pb'


descriptor_data = "\n*google/cloud/secrets/v1beta1/service.proto\x12\x1cgoogle.cloud.secrets.v1beta1\x1a\x1cgoogle/api/annotations.proto\x1a\x17google/api/client.proto\x1a\x1fgoogle/api/field_behavior.proto\x1a\x19google/api/resource.proto\x1a,google/cloud/secrets/v1beta1/resources.proto\x1a\x1egoogle/iam/v1/iam_policy.proto\x1a\x1agoogle/iam/v1/policy.proto\x1a\x1bgoogle/protobuf/empty.proto\x1a google/protobuf/field_mask.proto\"\x8a\x01\n\x12ListSecretsRequest\x12\x43\n\x06parent\x18\x01 \x01(\tB3\xe0\x41\x02\xfa\x41-\n+cloudresourcemanager.googleapis.com/Project\x12\x16\n\tpage_size\x18\x02 \x01(\x05\x42\x03\xe0\x41\x01\x12\x17\n\npage_token\x18\x03 \x01(\tB\x03\xe0\x41\x01\"y\n\x13ListSecretsResponse\x12\x35\n\x07secrets\x18\x01 \x03(\x0b\x32$.google.cloud.secrets.v1beta1.Secret\x12\x17\n\x0fnext_page_token\x18\x02 \x01(\t\x12\x12\n\ntotal_size\x18\x03 \x01(\x05\"\xad\x01\n\x13\x43reateSecretRequest\x12\x43\n\x06parent\x18\x01 \x01(\tB3\xe0\x41\x02\xfa\x41-\n+cloudresourcemanager.googleapis.com/Project\x12\x16\n\tsecret_id\x18\x02 \x01(\tB\x03\xe0\x41\x02\x12\x39\n\x06secret\x18\x03 \x01(\x0b\x32$.google.cloud.secrets.v1beta1.SecretB\x03\xe0\x41\x02\"\x99\x01\n\x17\x41\x64\x64SecretVersionRequest\x12;\n\x06parent\x18\x01 \x01(\tB+\xe0\x41\x02\xfa\x41%\n#secretmanager.googleapis.com/Secret\x12\x41\n\x07payload\x18\x02 \x01(\x0b\x32+.google.cloud.secrets.v1beta1.SecretPayloadB\x03\xe0\x41\x02\"M\n\x10GetSecretRequest\x12\x39\n\x04name\x18\x01 \x01(\tB+\xe0\x41\x02\xfa\x41%\n#secretmanager.googleapis.com/Secret\"\x89\x01\n\x19ListSecretVersionsRequest\x12;\n\x06parent\x18\x01 \x01(\tB+\xe0\x41\x02\xfa\x41%\n#secretmanager.googleapis.com/Secret\x12\x16\n\tpage_size\x18\x02 \x01(\x05\x42\x03\xe0\x41\x01\x12\x17\n\npage_token\x18\x03 \x01(\tB\x03\xe0\x41\x01\"\x88\x01\n\x1aListSecretVersionsResponse\x12=\n\x08versions\x18\x01 \x03(\x0b\x32+.google.cloud.secrets.v1beta1.SecretVersion\x12\x17\n\x0fnext_page_token\x18\x02 \x01(\t\x12\x12\n\ntotal_size\x18\x03 \x01(\x05\"[\n\x17GetSecretVersionRequest\x12@\n\x04name\x18\x01 \x01(\tB2\xe0\x41\x02\xfa\x41,\n*secretmanager.googleapis.com/SecretVersion\"\x86\x01\n\x13UpdateSecretRequest\x12\x39\n\x06secret\x18\x01 \x01(\x0b\x32$.google.cloud.secrets.v1beta1.SecretB\x03\xe0\x41\x02\x12\x34\n\x0bupdate_mask\x18\x02 \x01(\x0b\x32\x1a.google.protobuf.FieldMaskB\x03\xe0\x41\x02\"^\n\x1a\x41\x63\x63\x65ssSecretVersionRequest\x12@\n\x04name\x18\x01 \x01(\tB2\xe0\x41\x02\xfa\x41,\n*secretmanager.googleapis.com/SecretVersion\"\x9a\x01\n\x1b\x41\x63\x63\x65ssSecretVersionResponse\x12=\n\x04name\x18\x01 \x01(\tB/\xfa\x41,\n*secretmanager.googleapis.com/SecretVersion\x12<\n\x07payload\x18\x02 \x01(\x0b\x32+.google.cloud.secrets.v1beta1.SecretPayload\"P\n\x13\x44\x65leteSecretRequest\x12\x39\n\x04name\x18\x01 \x01(\tB+\xe0\x41\x02\xfa\x41%\n#secretmanager.googleapis.com/Secret\"_\n\x1b\x44isableSecretVersionRequest\x12@\n\x04name\x18\x01 \x01(\tB2\xe0\x41\x02\xfa\x41,\n*secretmanager.googleapis.com/SecretVersion\"^\n\x1a\x45nableSecretVersionRequest\x12@\n\x04name\x18\x01 \x01(\tB2\xe0\x41\x02\xfa\x41,\n*secretmanager.googleapis.com/SecretVersion\"_\n\x1b\x44\x65stroySecretVersionRequest\x12@\n\x04name\x18\x01 \x01(\tB2\xe0\x41\x02\xfa\x41,\n*secretmanager.googleapis.com/SecretVersion2\x83\x16\n\x14SecretManagerService\x12\xa9\x01\n\x0bListSecrets\x12\x30.google.cloud.secrets.v1beta1.ListSecretsRequest\x1a\x31.google.cloud.secrets.v1beta1.ListSecretsResponse\"5\xda\x41\x06parent\x82\xd3\xe4\x93\x02&\x12$/v1beta1/{parent=projects/*}/secrets\x12\xb7\x01\n\x0c\x43reateSecret\x12\x31.google.cloud.secrets.v1beta1.CreateSecretRequest\x1a$.google.cloud.secrets.v1beta1.Secret\"N\xda\x41\x17parent,secret_id,secret\x82\xd3\xe4\x93\x02.\"$/v1beta1/{parent=projects/*}/secrets:\x06secret\x12\xc5\x01\n\x10\x41\x64\x64SecretVersion\x12\x35.google.cloud.secrets.v1beta1.AddSecretVersionRequest\x1a+.google.cloud.secrets.v1beta1.SecretVersion\"M\xda\x41\x0eparent,payload\x82\xd3\xe4\x93\x02\x36\"1/v1beta1/{parent=projects/*/secrets/*}:addVersion:\x01*\x12\x96\x01\n\tGetSecret\x12..google.cloud.secrets.v1beta1.GetSecretRequest\x1a$.google.cloud.secrets.v1beta1.Secret\"3\xda\x41\x04name\x82\xd3\xe4\x93\x02&\x12$/v1beta1/{name=projects/*/secrets/*}\x12\xb9\x01\n\x0cUpdateSecret\x12\x31.google.cloud.secrets.v1beta1.UpdateSecretRequest\x1a$.google.cloud.secrets.v1beta1.Secret\"P\xda\x41\x12secret,update_mask\x82\xd3\xe4\x93\x02\x35\x32+/v1beta1/{secret.name=projects/*/secrets/*}:\x06secret\x12\x8e\x01\n\x0c\x44\x65leteSecret\x12\x31.google.cloud.secrets.v1beta1.DeleteSecretRequest\x1a\x16.google.protobuf.Empty\"3\xda\x41\x04name\x82\xd3\xe4\x93\x02&*$/v1beta1/{name=projects/*/secrets/*}\x12\xc9\x01\n\x12ListSecretVersions\x12\x37.google.cloud.secrets.v1beta1.ListSecretVersionsRequest\x1a\x38.google.cloud.secrets.v1beta1.ListSecretVersionsResponse\"@\xda\x41\x06parent\x82\xd3\xe4\x93\x02\x31\x12//v1beta1/{parent=projects/*/secrets/*}/versions\x12\xb6\x01\n\x10GetSecretVersion\x12\x35.google.cloud.secrets.v1beta1.GetSecretVersionRequest\x1a+.google.cloud.secrets.v1beta1.SecretVersion\">\xda\x41\x04name\x82\xd3\xe4\x93\x02\x31\x12//v1beta1/{name=projects/*/secrets/*/versions/*}\x12\xd1\x01\n\x13\x41\x63\x63\x65ssSecretVersion\x12\x38.google.cloud.secrets.v1beta1.AccessSecretVersionRequest\x1a\x39.google.cloud.secrets.v1beta1.AccessSecretVersionResponse\"E\xda\x41\x04name\x82\xd3\xe4\x93\x02\x38\x12\x36/v1beta1/{name=projects/*/secrets/*/versions/*}:access\x12\xc9\x01\n\x14\x44isableSecretVersion\x12\x39.google.cloud.secrets.v1beta1.DisableSecretVersionRequest\x1a+.google.cloud.secrets.v1beta1.SecretVersion\"I\xda\x41\x04name\x82\xd3\xe4\x93\x02<\"7/v1beta1/{name=projects/*/secrets/*/versions/*}:disable:\x01*\x12\xc6\x01\n\x13\x45nableSecretVersion\x12\x38.google.cloud.secrets.v1beta1.EnableSecretVersionRequest\x1a+.google.cloud.secrets.v1beta1.SecretVersion\"H\xda\x41\x04name\x82\xd3\xe4\x93\x02;\"6/v1beta1/{name=projects/*/secrets/*/versions/*}:enable:\x01*\x12\xc9\x01\n\x14\x44\x65stroySecretVersion\x12\x39.google.cloud.secrets.v1beta1.DestroySecretVersionRequest\x1a+.google.cloud.secrets.v1beta1.SecretVersion\"I\xda\x41\x04name\x82\xd3\xe4\x93\x02<\"7/v1beta1/{name=projects/*/secrets/*/versions/*}:destroy:\x01*\x12\x8b\x01\n\x0cSetIamPolicy\x12\".google.iam.v1.SetIamPolicyRequest\x1a\x15.google.iam.v1.Policy\"@\x82\xd3\xe4\x93\x02:\"5/v1beta1/{resource=projects/*/secrets/*}:setIamPolicy:\x01*\x12\x88\x01\n\x0cGetIamPolicy\x12\".google.iam.v1.GetIamPolicyRequest\x1a\x15.google.iam.v1.Policy\"=\x82\xd3\xe4\x93\x02\x37\x12\x35/v1beta1/{resource=projects/*/secrets/*}:getIamPolicy\x12\xb1\x01\n\x12TestIamPermissions\x12(.google.iam.v1.TestIamPermissionsRequest\x1a).google.iam.v1.TestIamPermissionsResponse\"F\x82\xd3\xe4\x93\x02@\";/v1beta1/{resource=projects/*/secrets/*}:testIamPermissions:\x01*\x1aP\xca\x41\x1csecretmanager.googleapis.com\xd2\x41.https://www.googleapis.com/auth/cloud-platformB\xef\x01\n&com.google.cloud.secretmanager.v1beta1B\x0cServiceProtoP\x01Z:cloud.google.com/go/secrets/apiv1beta1/secretspb;secretspb\xf8\x01\x01\xa2\x02\x03GSM\xaa\x02\"Google.Cloud.SecretManager.V1Beta1\xca\x02\"Google\\Cloud\\SecretManager\\V1beta1\xea\x02%Google::Cloud::SecretManager::V1beta1b\x06proto3"

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
    ["google.cloud.secrets.v1beta1.Secret", "google/cloud/secrets/v1beta1/resources.proto"],
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
  module Cloud
    module SecretManager
      module V1beta1
        ListSecretsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.ListSecretsRequest").msgclass
        ListSecretsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.ListSecretsResponse").msgclass
        CreateSecretRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.CreateSecretRequest").msgclass
        AddSecretVersionRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.AddSecretVersionRequest").msgclass
        GetSecretRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.GetSecretRequest").msgclass
        ListSecretVersionsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.ListSecretVersionsRequest").msgclass
        ListSecretVersionsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.ListSecretVersionsResponse").msgclass
        GetSecretVersionRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.GetSecretVersionRequest").msgclass
        UpdateSecretRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.UpdateSecretRequest").msgclass
        AccessSecretVersionRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.AccessSecretVersionRequest").msgclass
        AccessSecretVersionResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.AccessSecretVersionResponse").msgclass
        DeleteSecretRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.DeleteSecretRequest").msgclass
        DisableSecretVersionRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.DisableSecretVersionRequest").msgclass
        EnableSecretVersionRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.EnableSecretVersionRequest").msgclass
        DestroySecretVersionRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.secrets.v1beta1.DestroySecretVersionRequest").msgclass
      end
    end
  end
end
