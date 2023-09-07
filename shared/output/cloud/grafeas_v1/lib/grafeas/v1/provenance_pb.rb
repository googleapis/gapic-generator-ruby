# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: grafeas/v1/provenance.proto

require 'google/protobuf'

require 'google/protobuf/timestamp_pb'


descriptor_data = "\n\x1bgrafeas/v1/provenance.proto\x12\ngrafeas.v1\x1a\x1fgoogle/protobuf/timestamp.proto\"\x90\x04\n\x0f\x42uildProvenance\x12\n\n\x02id\x18\x01 \x01(\t\x12\x12\n\nproject_id\x18\x02 \x01(\t\x12%\n\x08\x63ommands\x18\x03 \x03(\x0b\x32\x13.grafeas.v1.Command\x12-\n\x0f\x62uilt_artifacts\x18\x04 \x03(\x0b\x32\x14.grafeas.v1.Artifact\x12/\n\x0b\x63reate_time\x18\x05 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\x12.\n\nstart_time\x18\x06 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\x12,\n\x08\x65nd_time\x18\x07 \x01(\x0b\x32\x1a.google.protobuf.Timestamp\x12\x0f\n\x07\x63reator\x18\x08 \x01(\t\x12\x10\n\x08logs_uri\x18\t \x01(\t\x12-\n\x11source_provenance\x18\n \x01(\x0b\x32\x12.grafeas.v1.Source\x12\x12\n\ntrigger_id\x18\x0b \x01(\t\x12\x44\n\rbuild_options\x18\x0c \x03(\x0b\x32-.grafeas.v1.BuildProvenance.BuildOptionsEntry\x12\x17\n\x0f\x62uilder_version\x18\r \x01(\t\x1a\x33\n\x11\x42uildOptionsEntry\x12\x0b\n\x03key\x18\x01 \x01(\t\x12\r\n\x05value\x18\x02 \x01(\t:\x02\x38\x01\"\x95\x02\n\x06Source\x12#\n\x1b\x61rtifact_storage_source_uri\x18\x01 \x01(\t\x12\x37\n\x0b\x66ile_hashes\x18\x02 \x03(\x0b\x32\".grafeas.v1.Source.FileHashesEntry\x12*\n\x07\x63ontext\x18\x03 \x01(\x0b\x32\x19.grafeas.v1.SourceContext\x12\x36\n\x13\x61\x64\x64itional_contexts\x18\x04 \x03(\x0b\x32\x19.grafeas.v1.SourceContext\x1aI\n\x0f\x46ileHashesEntry\x12\x0b\n\x03key\x18\x01 \x01(\t\x12%\n\x05value\x18\x02 \x01(\x0b\x32\x16.grafeas.v1.FileHashes:\x02\x38\x01\"1\n\nFileHashes\x12#\n\tfile_hash\x18\x01 \x03(\x0b\x32\x10.grafeas.v1.Hash\"#\n\x04Hash\x12\x0c\n\x04type\x18\x01 \x01(\t\x12\r\n\x05value\x18\x02 \x01(\x0c\"]\n\x07\x43ommand\x12\x0c\n\x04name\x18\x01 \x01(\t\x12\x0b\n\x03\x65nv\x18\x02 \x03(\t\x12\x0c\n\x04\x61rgs\x18\x03 \x03(\t\x12\x0b\n\x03\x64ir\x18\x04 \x01(\t\x12\n\n\x02id\x18\x05 \x01(\t\x12\x10\n\x08wait_for\x18\x06 \x03(\t\"7\n\x08\x41rtifact\x12\x10\n\x08\x63hecksum\x18\x01 \x01(\t\x12\n\n\x02id\x18\x02 \x01(\t\x12\r\n\x05names\x18\x03 \x03(\t\"\x9a\x02\n\rSourceContext\x12\x38\n\ncloud_repo\x18\x01 \x01(\x0b\x32\".grafeas.v1.CloudRepoSourceContextH\x00\x12\x31\n\x06gerrit\x18\x02 \x01(\x0b\x32\x1f.grafeas.v1.GerritSourceContextH\x00\x12+\n\x03git\x18\x03 \x01(\x0b\x32\x1c.grafeas.v1.GitSourceContextH\x00\x12\x35\n\x06labels\x18\x04 \x03(\x0b\x32%.grafeas.v1.SourceContext.LabelsEntry\x1a-\n\x0bLabelsEntry\x12\x0b\n\x03key\x18\x01 \x01(\t\x12\r\n\x05value\x18\x02 \x01(\t:\x02\x38\x01\x42\t\n\x07\x63ontext\"\x8a\x01\n\x0c\x41liasContext\x12+\n\x04kind\x18\x01 \x01(\x0e\x32\x1d.grafeas.v1.AliasContext.Kind\x12\x0c\n\x04name\x18\x02 \x01(\t\"?\n\x04Kind\x12\x14\n\x10KIND_UNSPECIFIED\x10\x00\x12\t\n\x05\x46IXED\x10\x01\x12\x0b\n\x07MOVABLE\x10\x02\x12\t\n\x05OTHER\x10\x04\"\x93\x01\n\x16\x43loudRepoSourceContext\x12#\n\x07repo_id\x18\x01 \x01(\x0b\x32\x12.grafeas.v1.RepoId\x12\x15\n\x0brevision_id\x18\x02 \x01(\tH\x00\x12\x31\n\ralias_context\x18\x03 \x01(\x0b\x32\x18.grafeas.v1.AliasContextH\x00\x42\n\n\x08revision\"\x95\x01\n\x13GerritSourceContext\x12\x10\n\x08host_uri\x18\x01 \x01(\t\x12\x16\n\x0egerrit_project\x18\x02 \x01(\t\x12\x15\n\x0brevision_id\x18\x03 \x01(\tH\x00\x12\x31\n\ralias_context\x18\x04 \x01(\x0b\x32\x18.grafeas.v1.AliasContextH\x00\x42\n\n\x08revision\"4\n\x10GitSourceContext\x12\x0b\n\x03url\x18\x01 \x01(\t\x12\x13\n\x0brevision_id\x18\x02 \x01(\t\"S\n\x06RepoId\x12\x34\n\x0fproject_repo_id\x18\x01 \x01(\x0b\x32\x19.grafeas.v1.ProjectRepoIdH\x00\x12\r\n\x03uid\x18\x02 \x01(\tH\x00\x42\x04\n\x02id\"6\n\rProjectRepoId\x12\x12\n\nproject_id\x18\x01 \x01(\t\x12\x11\n\trepo_name\x18\x02 \x01(\tBQ\n\rio.grafeas.v1P\x01Z8google.golang.org/genproto/googleapis/grafeas/v1;grafeas\xa2\x02\x03GRAb\x06proto3"

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
    BuildProvenance = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.BuildProvenance").msgclass
    Source = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.Source").msgclass
    FileHashes = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.FileHashes").msgclass
    Hash = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.Hash").msgclass
    Command = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.Command").msgclass
    Artifact = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.Artifact").msgclass
    SourceContext = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.SourceContext").msgclass
    AliasContext = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.AliasContext").msgclass
    AliasContext::Kind = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.AliasContext.Kind").enummodule
    CloudRepoSourceContext = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.CloudRepoSourceContext").msgclass
    GerritSourceContext = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.GerritSourceContext").msgclass
    GitSourceContext = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.GitSourceContext").msgclass
    RepoId = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.RepoId").msgclass
    ProjectRepoId = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("grafeas.v1.ProjectRepoId").msgclass
  end
end
