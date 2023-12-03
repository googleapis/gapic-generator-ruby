# frozen_string_literal: true

# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "test_helper"
require "gapic/package_snippets"
require "google/protobuf/compiler/plugin_pb"

describe Gapic::PackageSnippets do
  FakeServicePresenter = Struct.new :client_name, :client_name_full, :grpc_full_name, :module_name, :name,
                                    :client_suffix_for_default_transport
  FakeMethodPresenter = Struct.new :grpc_full_name, :grpc_name, :name, :request_type, :return_type, :service
  FakeSnippetPresenter = Struct.new :description, :region_tag, :service, :snippet_file_path, :snippet_name, :transport

  let(:proto_package) { "google.snippetstest.v1" }
  let(:gem_name) { "google-snippets_test-v1" }
  let(:package_snippets) { Gapic::PackageSnippets.new proto_package: proto_package, gem_name: gem_name }
  let(:method_name1) { "get_foo" }
  let(:method_name2) { "set_foo" }
  let(:request_type1) { "Google::SnippetsTest::V1::GetFooRequest" }
  let(:request_type2) { "Google::SnippetsTest::V1::SetFooRequest" }
  let(:return_type) { "Google::SnippetsTest::V1::FooType" }
  let(:service_protoname) { "SnippetsService" }
  let(:service_protoname_full) { "#{proto_package}.#{service_protoname}" }
  let(:method_protoname1) { "GetFoo" }
  let(:method_protoname2) { "SetFoo" }
  let(:method_protoname_full1) { "#{proto_package}.#{service_protoname}.#{method_protoname1}" }
  let(:method_protoname_full2) { "#{proto_package}.#{service_protoname}.#{method_protoname2}" }
  let(:region_tag1) { "snippettest_v1_generated_SnippetService_GetFoo_sync" }
  let(:region_tag2) { "snippettest_v1_generated_SnippetService_SetFoo_sync" }
  let(:snippet_file_path1) { "snippet_service/get_foo.rb" }
  let(:snippet_file_path2) { "snippet_service/set_foo.rb" }
  let(:description1) { "get_foo description" }
  let(:description2) { "set_foo description" }
  let(:snippet_name1) { "get_foo name" }
  let(:snippet_name2) { "set_foo name" }
  let(:snippet_file_fullpath1) { "snippets/#{snippet_file_path1}" }
  let(:snippet_file_fullpath2) { "snippets/#{snippet_file_path2}" }
  let(:snippet_transport) { :grpc }
  let(:service_client_name) { "Client" }
  let(:service_module_name) { service_protoname }
  let(:service_client_name_full) { "Google::SnippetsTest::#{service_module_name}::#{service_client_name}" }
  let(:service_client_suffix) { "#{service_module_name}::#{service_client_name}" }
  let(:service_presenter) do
    FakeServicePresenter.new service_client_name, service_client_name_full, service_protoname_full, service_module_name,
                             service_protoname, service_client_suffix
  end
  let(:method_presenter1) do
    FakeMethodPresenter.new method_protoname_full1, method_protoname1, method_name1, request_type1, return_type, service_presenter
  end
  let(:method_presenter2) do
    FakeMethodPresenter.new method_protoname_full2, method_protoname2, method_name2, request_type2, return_type, service_presenter
  end
  let(:snippet_presenter1) do
    FakeSnippetPresenter.new description1, region_tag1, service_presenter, snippet_file_path1, snippet_name1, snippet_transport
  end
  let(:snippet_presenter2) do
    FakeSnippetPresenter.new description2, region_tag2, service_presenter, snippet_file_path2, snippet_name2, snippet_transport
  end
  let(:snippet_content1) do
    <<~CONTENT
      # testing
      # [START #{region_tag1}]
      foo = bar
      baz = foo
      # [END #{region_tag1}]
    CONTENT
  end
  let(:snippet_content2) do
    <<~CONTENT
      # testing
      # really
      # [START #{region_tag2}]
      bar = foo
      baz = bar
      # [END #{region_tag2}]
    CONTENT
  end
  let(:snippet_file1) do
    Google::Protobuf::Compiler::CodeGeneratorResponse::File.new \
      name: snippet_file_fullpath1,
      content: snippet_content1
  end
  let(:snippet_file2) do
    Google::Protobuf::Compiler::CodeGeneratorResponse::File.new \
      name: snippet_file_fullpath2,
      content: snippet_content2
  end
  let(:package_snippets) { Gapic::PackageSnippets.new proto_package: proto_package, gem_name: gem_name }
  let(:populated_package_snippets) do
    package_snippets.add method_presenter: method_presenter1,
                         snippet_presenter: snippet_presenter1,
                         snippet_file: snippet_file1
    package_snippets.add method_presenter: method_presenter2,
                         snippet_presenter: snippet_presenter2,
                         snippet_file: snippet_file2
    package_snippets
  end

  it "collects snippet files" do
    files = populated_package_snippets.files[0..-2]
    assert_equal 2, files.size
    assert_equal snippet_file1, files[0]
    assert_equal snippet_file2, files[1]
  end

  it "generates metadata" do
    metadata_file = populated_package_snippets.files.last
    assert_equal "snippets/snippet_metadata_#{proto_package}.json", metadata_file.name
    metadata = JSON.parse metadata_file.content
    expected_metadata = {
      "client_library" => {
        "name" => gem_name,
        "version" => "",
        "language" => "RUBY",
        "apis" => [
          {
            "id" => proto_package,
            "version" => "v1"
          }
        ]
      },
      "snippets" => [
        {
          "region_tag" => region_tag1,
          "title" => snippet_name1,
          "description" => description1,
          "file" => snippet_file_path1,
          "language" => "RUBY",
          "client_method" => {
            "short_name" => method_name1,
            "full_name" => "#{service_client_name_full}##{method_name1}",
            "async" => false,
            "parameters" => [
              {
                "type" => request_type1,
                "name" => "request"
              }
            ],
            "result_type" => return_type,
            "client" => {
              "short_name" => service_client_suffix,
              "full_name" => service_client_name_full
            },
            "method" => {
              "short_name" => method_protoname1,
              "full_name" => method_protoname_full1,
              "service" => {
                "short_name" => service_protoname,
                "full_name" => service_protoname_full
              }
            }
          },
          "canonical" => true,
          "origin" => "API_DEFINITION",
          "segments" => [
            {
              "start" => 3,
              "end" => 4,
              "type" => "FULL"
            }
          ]
        },
        {
          "region_tag" => region_tag2,
          "title" => snippet_name2,
          "description" => description2,
          "file" => snippet_file_path2,
          "language" => "RUBY",
          "client_method" => {
            "short_name" => method_name2,
            "full_name" => "#{service_client_name_full}##{method_name2}",
            "async" => false,
            "parameters" => [
              {
                "type" => request_type2,
                "name" => "request"
              }
            ],
            "result_type" => return_type,
            "client" => {
              "short_name" => service_client_suffix,
              "full_name" => service_client_name_full
            },
            "method" => {
              "short_name" => method_protoname2,
              "full_name" => method_protoname_full2,
              "service" => {
                "short_name" => service_protoname,
                "full_name" => service_protoname_full
              }
            }
          },
          "canonical" => true,
          "origin" => "API_DEFINITION",
          "segments" => [
            {
              "start" => 4,
              "end" => 5,
              "type" => "FULL"
            }
          ]
        }
      ]
    }
    assert_equal expected_metadata, metadata
  end
end
