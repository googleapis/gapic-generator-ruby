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

require "google/protobuf/compiler/plugin_pb"
require "google/cloud/tools/snippetgen/snippetindex/v1/snippet_index_pb"
require "json"

module Gapic
  # An object that collects snippets for a package and generates the metadata
  # content.
  class PackageSnippets
    # @private
    SnippetIndex = ::Google::Cloud::Tools::SnippetGen::SnippetIndex::V1

    ##
    # Start collecting snippets for a package
    #
    # @param proto_package [String] Fully qualified proto package name including
    #     API version, e.g. `google.cloud.translate.v3`. Required.
    # @param gem_name [String] Name of the gem being generated, e.g.
    #     `google-cloud-translate-v3`. Required.
    # @param snippet_dir [String] Directory where snippets are generated.
    #     Optional. Defaults to `snippets`.
    #
    def initialize proto_package:, gem_name:, snippet_dir: "snippets"
      api = SnippetIndex::Api.new(
        id: proto_package,
        version: proto_package.split(".").last
      )
      client_library_object = SnippetIndex::ClientLibrary.new(
        name: gem_name,
        version: "",
        language: "RUBY",
        apis: [api]
      )
      @index_object = SnippetIndex::Index.new(
        client_library: client_library_object
      )
      @metadata_filename = "#{snippet_dir}/snippet_metadata_#{proto_package}.json"
      @snippet_files = []
    end

    ##
    # Add a snippet to the collection
    #
    # @param method_presenter [Gapic::Presenters::MethodPresenter]
    # @param snippet_presenter [Gapic::Presenters::SnippetPresenter]
    # @param snippet_file [Google::Protobuf::Compiler::CodeGeneratorResponse::File]
    # @return [self]
    #
    def add method_presenter:, snippet_presenter:, snippet_file:
      service_presenter = method_presenter.service
      snippet_lines = [""] + snippet_file.content.split("\n")
      @index_object.snippets <<
        build_snippet_object(snippet_presenter, method_presenter, service_presenter, snippet_lines)
      @snippet_files << snippet_file
      self
    end

    ##
    # Return a list of files to render for this package. This includes all the
    # snippet files themselves, and the metadata file.
    #
    # @return [Array<Google::Protobuf::Compiler::CodeGeneratorResponse::File>]
    #
    def files
      metadata_content = JSON.pretty_generate json_value_for @index_object
      metadata_file = Google::Protobuf::Compiler::CodeGeneratorResponse::File.new(
        name: @metadata_filename,
        content: metadata_content
      )
      @snippet_files + [metadata_file]
    end

    private

    def build_snippet_object snippet_presenter, method_presenter, service_presenter, snippet_lines
      service_presenter = service_presenter.rest if snippet_presenter.transport == :rest
      SnippetIndex::Snippet.new(
        region_tag: snippet_presenter.region_tag,
        title: snippet_presenter.snippet_name,
        description: snippet_presenter.description,
        file: snippet_presenter.snippet_file_path,
        language: "RUBY",
        client_method: build_client_method_object(method_presenter, service_presenter),
        canonical: true,
        origin: "API_DEFINITION",
        segments: build_segments_array(snippet_lines, snippet_presenter.region_tag)
      )
    end

    def build_client_method_object method_presenter, service_presenter
      parameter = SnippetIndex::ClientMethod::Parameter.new(
        type: method_presenter.request_type,
        name: "request"
      )
      client = SnippetIndex::ServiceClient.new(
        short_name: service_presenter.client_suffix_for_default_transport,
        full_name: service_presenter.client_name_full
      )
      SnippetIndex::ClientMethod.new(
        short_name: method_presenter.name,
        full_name: "#{service_presenter.client_name_full}##{method_presenter.name}",
        async: false,
        parameters: [parameter],
        result_type: method_presenter.return_type,
        client: client,
        method: build_method_object(method_presenter, service_presenter)
      )
    end

    def build_method_object method_presenter, service_presenter
      service = SnippetIndex::Service.new(
        short_name: service_presenter.name,
        full_name: service_presenter.grpc_full_name
      )
      SnippetIndex::Method.new(
        short_name: method_presenter.grpc_name,
        full_name: method_presenter.grpc_full_name,
        service: service
      )
    end

    # Currently this builds only the FULL segment. We can fill out additional
    # segment types once requirements have been clarified.
    def build_segments_array snippet_lines, region_tag
      start_tag_line = snippet_lines.index { |line| line.include? "[START #{region_tag}]" }
      end_tag_line = snippet_lines.index { |line| line.include? "[END #{region_tag}]" }
      result = []
      if start_tag_line && end_tag_line
        result << SnippetIndex::Snippet::Segment.new(
          start: start_tag_line + 1,
          end: end_tag_line - 1,
          type: "FULL"
        )
      end
      result
    end

    def json_value_for value
      json = value.class.encode_json value, preserve_proto_fieldnames: true,
                                            emit_defaults: true
      JSON.parse json
    end
  end
end
