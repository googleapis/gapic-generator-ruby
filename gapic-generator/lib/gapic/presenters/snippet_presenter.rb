# frozen_string_literal: true

# Copyright 2021 Google LLC
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

require "active_support/inflector"
require "google/cloud/tools/snippetgen/configlanguage/v1/snippet_config_language.pb"
require "gapic/presenters/snippet/client_call_presenter"
require "gapic/presenters/snippet/client_initialization_presenter"
require "gapic/presenters/snippet/expression_presenter"
require "gapic/presenters/snippet/parameter_presenter"
require "gapic/presenters/snippet/request_initialization_presenters"
require "gapic/presenters/snippet/response_handling_presenters"
require "gapic/presenters/snippet/statement_presenter"
require "gapic/presenters/snippet/type_presenter"

module Gapic
  module Presenters
    ##
    # A presenter for snippets.
    #
    class SnippetPresenter
      def initialize method_presenter, api, config: nil, transport: nil
        @method_presenter = method_presenter
        @api = api
        @config = config
        @transport = transport || @api.default_transport
        analyze_config
      end

      attr_reader :config
      attr_reader :transport

      def config?
        !config.nil?
      end

      def client_streaming?
        @method_presenter.client_streaming?
      end

      def server_streaming?
        @method_presenter.server_streaming?
      end

      def response_kind
        if @method_presenter.server_streaming?
          :streaming
        elsif @method_presenter.paged?
          :paged
        elsif @method_presenter.lro?
          :lro
        else
          :simple
        end
      end

      def snippet_file_path
        "#{@method_presenter.service.service_require.split('/').last}/#{snippet_method_name}.rb"
      end

      def require_path
        @method_presenter.service.package.package_require
      end

      def client_type
        service = @method_presenter.service
        service = service.rest if transport == :rest
        service.client_name_full.sub(/^::/, "")
      end

      def service_name_short
        @method_presenter.service.module_name
      end

      def request_type
        @method_presenter.request_type.sub(/^::/, "")
      end

      def return_type
        base_type = @method_presenter.return_type.sub(/^::/, "")
        @method_presenter.server_streaming? ? "Enumerable<#{base_type}>" : base_type
      end

      def paged_response_type
        @method_presenter.paged_response_type
      end

      def base_response_type
        @method_presenter.return_type
      end

      # TODO: Determine type of LRO response

      def method_name
        @method_presenter.name
      end

      def snippet_method_name
        config? ? "#{method_name}_#{snake_config_id}" : method_name
      end

      def snippet_name
        @config&.metadata&.snippet_name ||
          "Snippet for the #{method_name} call in the #{service_name_short} service"
      end

      def description
        @config&.metadata&.snippet_description ||
          "This is an auto-generated example demonstrating basic usage of #{client_type}##{method_name}. " \
          "It may require modification in order to execute successfully."
      end

      def snippet_method_parameters
        @snippet_method_parameters ||= begin
          parameters_proto = @config&.signature&.parameters
          if parameters_proto
            parameters_json = @config.json_representation["signature"]["parameters"]
            parameters_proto.each_with_index.map do |param_proto, index|
              ParameterPresenter.new param_proto, parameters_json[index]
            end
          else
            []
          end
        end
      end

      def snippet_method_parameters_render
        return "" if snippet_method_parameters.empty?
        names = snippet_method_parameters.map { |param| "#{param.name}:" }.join ", "
        "(#{names})"
      end

      attr_reader :client_initialization
      attr_reader :request_initialization
      attr_reader :client_call
      attr_reader :response_handling
      attr_reader :final_statements

      def region_tag
        gem_presenter = @method_presenter.service.gem
        prefix = gem_presenter.doc_tag_prefix
        names = gem_presenter.name.split "-"
        final_name = names.pop
        if final_name =~ /^v\d/
          api_version = final_name
          prefix ||= names.last
        else
          prefix ||= final_name
          api_version = "v0"
        end
        prefix = prefix.downcase.gsub(/[^a-z0-9]/, "")
        service_name = @method_presenter.service.module_name
        method_name = @method_presenter.method.name
        type = config? ? "config" : "generated"
        config_id = config? ? "#{@config.metadata.config_id}_" : ""
        "#{prefix}_#{api_version}_#{type}_#{service_name}_#{method_name}_#{config_id}sync"
      end

      private

      def analyze_config
        snippet_proto, snippet_json = snippet_proto_info
        call_proto, call_json = call_proto_info snippet_proto, snippet_json
        @client_initialization = build_client_initialization_presenter snippet_proto, snippet_json
        @request_initialization = build_request_initialization_presenter call_proto, call_json
        @response_handling = build_response_handling_presenter call_proto, call_json
        @client_call = build_client_call_presenter call_proto, call_json,
                                                   @request_initialization.request_name,
                                                   @response_handling.response_name
        @final_statements = build_final_statements snippet_proto, snippet_json
      end

      def snippet_proto_info
        [@config&.snippet, @config&.json_representation&.fetch("snippet", nil)]
      end

      def call_proto_info snippet_proto, snippet_json
        if snippet_proto&.standard
          [snippet_proto.standard, snippet_json["standard"]]
        elsif snippet_proto&.paginated
          [snippet_proto.paginated, snippet_json["paginated"]]
        elsif snippet_proto&.lro
          [snippet_proto.lro, snippet_json["lro"]]
        elsif snippet_proto&.server_streaming
          [snippet_proto.server_streaming, snippet_json["serverStreaming"]]
        elsif snippet_proto&.client_streaming
          [snippet_proto.client_streaming, snippet_json["clientStreaming"]]
        elsif snippet_proto&.bidi_streaming
          [snippet_proto.bidi_streaming, snippet_json["bidiStreaming"]]
        else
          [nil, nil]
        end
      end

      def build_client_initialization_presenter snippet_proto, snippet_json
        ClientInitializationPresenter.new snippet_proto&.service_client_initialization,
                                          snippet_json&.fetch("serviceClientInitialization", nil),
                                          phase1: !config?, client_type: client_type
      end

      def build_request_initialization_presenter call_proto, call_json
        phase1 = !config?
        request_init_proto = call_proto&.request_initialization
        request_init_json = call_json&.fetch "requestInitialization", nil
        if client_streaming?
          request_name = phase1 ? "input" : call_proto.client_stream_name
          StreamingRequestInitializationPresenter.new request_init_proto, request_init_json,
                                                      request_name: request_name, request_type: request_type,
                                                      phase1: phase1
        else
          SimpleRequestInitializationPresenter.new request_init_proto, request_init_json,
                                                   request_type: request_type, phase1: phase1
        end
      end

      def build_response_handling_presenter call_proto, call_json
        phase1 = !config?
        case response_kind
        when :paged
          PaginatedResponseHandlingPresenter.new call_proto&.paginated_handling,
                                                 call_json&.fetch("paginatedHandling", nil),
                                                 paged_response_type: paged_response_type, phase1: phase1
        when :lro
          LroResponseHandlingPresenter.new call_proto&.lro_handling,
                                           call_json&.fetch("lroHandling", nil),
                                           phase1: phase1
        when :streaming
          response_name = phase1 ? "output" : call_proto&.server_stream_name
          response_name = nil if response_name == ""
          StreamingResponseHandlingPresenter.new call_proto&.response_handling,
                                                 call_json&.fetch("responseHandling", nil),
                                                 response_name: response_name, base_response_type: base_response_type,
                                                 phase1: phase1
        else
          SimpleResponseHandlingPresenter.new call_proto&.response_handling,
                                              call_json&.fetch("responseHandling", nil),
                                              response_type: return_type, phase1: phase1
        end
      end

      def build_client_call_presenter call_proto, call_json, request_name, response_name
        phase1 = !config?
        if response_kind == :paged
          ClientCallPresenter.new call_proto&.paginated_call, call_json&.fetch("paginatedCall", nil),
                                  method_name: method_name, request_name: request_name, response_name: response_name,
                                  client_streaming: client_streaming?, server_streaming: server_streaming?,
                                  phase1: phase1
        elsif client_streaming? || server_streaming?
          ClientCallPresenter.new call_proto&.initialization_call, call_json&.fetch("initializationCall", nil),
                                  method_name: method_name, request_name: request_name, response_name: response_name,
                                  client_streaming: client_streaming?, server_streaming: server_streaming?,
                                  phase1: phase1
        else
          ClientCallPresenter.new call_proto&.call, call_json&.fetch("call", nil),
                                  method_name: method_name, request_name: request_name, response_name: response_name,
                                  client_streaming: false, server_streaming: false, phase1: phase1
        end
      end

      def build_final_statements snippet_proto, snippet_json
        return [] unless snippet_proto&.final_statements
        snippet_proto.final_statements.each_with_index.map do |statement_proto, index|
          statement_json = snippet_json["finalStatements"][index]
          StatementPresenter.new statement_proto, statement_json
        end
      end

      def snake_config_id
        ActiveSupport::Inflector.underscore @config.metadata.config_id
      end
    end
  end
end
