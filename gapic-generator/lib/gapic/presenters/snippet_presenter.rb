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

module Gapic
  module Presenters
    ##
    # A presenter for snippets.
    #
    class SnippetPresenter
      def initialize method_presenter, api, config
        @method_presenter = method_presenter
        @api = api
        @config = config
        analyze_call
      end

      def config?
        !@config.nil?
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
        @method_presenter.service.client_name_full.sub(/^::/, "")
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
        @config&.metadata&.snippet_name
      end

      def description
        @config&.metadata&.snippet_description ||
          "Example demonstrating basic usage of #{client_type}##{method_name}"
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
      attr_accessor :request_name
      attr_accessor :response_name

      def region_tag
        gem_presenter = @method_presenter.service.gem
        api_id = gem_presenter.api_shortname || gem_presenter.api_id&.split(".")&.first
        names = gem_presenter.name.split "-"
        final_name = names.pop
        if final_name =~ /^v\d/
          api_version = final_name
          api_id ||= names.last
        else
          api_id ||= final_name
          api_version = "v0"
        end
        api_id = api_id.downcase.gsub(/[^a-z0-9]/, "")
        service_name = @method_presenter.service.module_name
        method_name = @method_presenter.method.name
        type = config? ? "config" : "generated"
        config_id = config? ? "#{@config.metadata.config_id}_" : ""
        "#{api_id}_#{api_version}_#{type}_#{service_name}_#{method_name}_#{config_id}sync"
      end

      # @private
      def interpret_variable_name proto_value, default_name
        if @config.nil?
          default_name
        elsif proto_value.to_s.empty?
          nil
        else
          proto_value
        end
      end

      ##
      # Presentation information about a snippet method parameter
      #
      class ParameterPresenter
        def initialize proto, json
          @name = proto.name
          @description = proto.description
          @description = nil if @description&.empty?
          @type = TypePresenter.new proto.type, json["type"]
          @example = ExpressionPresenter.new proto.value, json["value"]
        end

        attr_reader :name
        attr_reader :description
        attr_reader :type
        attr_reader :example
      end

      ##
      # Presentation information about a type
      #
      class TypePresenter
        def initialize proto, json
          @render =
            if json.key? "scalarType"
              SCALAR_TYPE_MAPPING[proto.scalar_type] || "Object"
            elsif json.key? "messageType"
              proto.message_type.message_full_name.split(".").map(&:capitalize).join "::"
            elsif json.key? "enumType"
              proto.message_type.enum_full_name.split(".").map(&:capitalize).join "::"
            elsif json.key? "repeatedType"
              repeated_render proto, json
            elsif json.key? "mapType"
              map_render proto, json
            else
              "Object"
            end
        end

        attr_reader :render

        private

        def repeated_render proto, json
          inner_type = TypePresenter.new proto.repeated_type.element_type, json["repeatedType"]["elementType"]
          "Array<#{inner_type.render}>"
        end

        def map_render proto, json
          proto = proto.map_type
          json = json["mapType"]
          key_type = TypePresenter.new proto.key_type, json["keyType"]
          value_type = TypePresenter.new proto.value_type, json["valueType"]
          "Hash{#{key_type.render} => #{value_type.render}}"
        end

        scalar_type = Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Type::ScalarType
        SCALAR_TYPE_MAPPING = {
          scalar_type::TYPE_DOUBLE => "Float",
          scalar_type::TYPE_FLOAT => "Float",
          scalar_type::TYPE_INT64 => "Integer",
          scalar_type::TYPE_UINT64 => "Integer",
          scalar_type::TYPE_INT32 => "Integer",
          scalar_type::TYPE_FIXED64 => "Integer",
          scalar_type::TYPE_FIXED32 => "Integer",
          scalar_type::TYPE_BOOL => "boolean",
          scalar_type::TYPE_STRING => "String",
          scalar_type::TYPE_UINT32 => "Integer",
          scalar_type::TYPE_SFIXED32 => "Integer",
          scalar_type::TYPE_SFIXED64 => "Integer",
          scalar_type::TYPE_SINT32 => "Integer",
          scalar_type::TYPE_SINT64 => "Integer"
        }.freeze
      end

      ##
      # Presentation information about an expression
      #
      class ExpressionPresenter
        def initialize proto, json
          @render_lines =
            if json.key? "stringValue"
              [proto.string_value.inspect]
            elsif json.key? "numberValue"
              [proto.number_value.inspect]
            elsif json.key? "booleanValue"
              [proto.boolean_value.inspect]
            elsif json.key? "nullValue"
              ["nil"]
            end
          @render = @render_lines&.join " "
        end

        attr_reader :render_lines
        attr_reader :render

        def exist?
          !render_lines.nil?
        end
      end

      ##
      # Presentation information about a statement
      #
      class StatementPresenter
        def initialize proto, json
          @render_lines =
            if json.key? "declaration"
              declaration_lines proto.declaration, json["declaration"]
            elsif json.key? "standardOutput"
              output_lines proto.standard_output, json["standardOutput"]
            elsif json.key? "return"
              return_lines proto.return, json["return"]
            elsif json.key? "conditional"
              conditional_lines proto.conditional, json["conditional"]
            elsif json.key? "iteration"
              iteration_lines proto.iteration, json["iteration"]
            else
              ["# Unknown statement omitted here."]
            end
          @render = @render_lines.join "\n"
        end

        attr_reader :render_lines
        attr_reader :render

        private

        def declaration_lines proto, json
          expr = ExpressionPresenter.new proto.value, json["value"]
          return ["# Unknown declaration statement omitted here."] if expr.render_lines.nil?
          lines = expr.render_lines
          lines.first = "#{proto.name} = #{lines.first}"
          if proto.description && !proto.description.empty?
            lines.unshift "# #{description}"
          end
          lines
        end

        def output_lines proto, json
          expr = ExpressionPresenter.new proto.value, json["value"]
          return ["# Unknown output statement omitted here."] if expr.render_lines.nil?
          lines = expr.render_lines
          if lines.size == 1
            ["puts(#{lines.first})"]
          else
            ["puts("] + lines.map { |line| "  #{line}" } + [")"]
          end
        end

        def return_lines proto, json
          expr = ExpressionPresenter.new proto.result, json["result"]
          return ["# Unknown return statement omitted here."] if expr.render_lines.nil?
          lines = expr.render_lines
          lines.first = "return #{lines.first}"
          lines
        end

        def conditional_lines proto, json
          expr = ExpressionPresenter.new proto.condition, json["condition"]
          return ["# Unknown conditional statement omitted here."] if expr.render_lines.nil?
          lines = ["if #{expr.render}"]
          proto.on_true&.each_with_index do |statement_proto, index|
            statement = StatementPresenter.new statement_proto, json["onTrue"][index]
            lines += statement.render_lines.map { |line| "  #{line}" }
          end
          if json.key? "onFalse"
            lines << ["else"]
            proto.on_false&.each_with_index do |statement_proto, index|
              statement = StatementPresenter.new statement_proto, json["onFalse"][index]
              lines += statement.render_lines.map { |line| "  #{line}" }
            end
          end
          lines << ["end"]
          lines
        end

        def iteration_lines _proto, _json
          # TODO
          ["# Unknown iteration statement omitted here."]
        end
      end

      ##
      # Presentation information about client object initialization
      #
      class ClientInitializationPresenter
        def initialize parent, proto, json
          @render_lines = []
          if json&.key? "preClientInitialization"
            proto.pre_client_initialization.each_with_index do |stmt_proto, index|
              @render_lines += StatementPresenter.new(stmt_proto, json["preClientInitialization"][index]).render_lines
            end
          elsif !parent.config?
            @render_lines << "# Create a client object. The client can be reused for multiple calls."
          end
          @render_lines += build_create_code parent, proto
          @render = @render_lines.join "\n"
        end

        attr_reader :render_lines
        attr_reader :render

        private

        def build_create_code parent, proto
          create_code = "client = #{parent.client_type}.new"
          if proto&.custom_service_endpoint
            endpoint = [proto.custom_service_endpoint.region, proto.custom_service_endpoint.host].compact.join "-"
            [
              "#{create_code} do |config|",
              "  config.endpoint = #{endpoint.inspect}",
              "end"
            ]
          else
            [create_code]
          end
        end
      end

      ##
      # Presentation information about simple request initialization
      #
      class SimpleRequestInitializationPresenter
        def initialize parent, proto, json, standalone: false
          parent.request_name = parent.interpret_variable_name proto&.request_name, "request" unless standalone
          @render_precall_lines =
            if proto
              configured_lines parent, proto, json, standalone
            else
              fallback_lines parent
            end
          @render_precall = @render_precall_lines.join "\n"
          @render_postcall_lines = []
          @render_postcall = ""
        end

        attr_reader :render_precall_lines
        attr_reader :render_precall
        attr_reader :render_postcall_lines
        attr_reader :render_postcall

        private

        def fallback_lines parent
          [
            "# Create a request. To set request fields, pass in keyword arguments.",
            "#{parent.request_name} = #{parent.request_type}.new"
          ]
        end

        def configured_lines parent, proto, json, standalone
          lines = []
          if json.key? "preRequestInitialization"
            proto.pre_request_initialization&.each_with_index do |statement_proto, index|
              statement = StatementPresenter.new statement_proto, json["preRequestInitialization"][index]
              lines += statement.render_lines
            end
          end
          expr = ExpressionPresenter.new proto.request_value, proto["requestValue"]
          if expr.render_lines.nil?
            lines + fallback_lines(parent)
          else
            expr_lines = expr.render_lines
            expr_lines[0] = "#{parent.request_name} = #{expr_lines.first}" unless standalone
            lines + expr_lines
          end
        end
      end

      ##
      # Presentation information about client-streaming request initialization
      #
      class StreamingRequestInitializationPresenter
        def initialize parent, _proto, _json
          @render_precall_lines = []
          @render_precall_lines << "# Create an input stream" unless parent.config?
          @render_precall_lines << "#{parent.request_name} = Gapic::StreamInput.new"
          @render_precall = @render_precall_lines.join "\n"

          # TODO
          @render_postcall_lines = fallback_lines parent
          @render_postcall = @render_postcall_lines.join "\n"
        end

        attr_reader :render_precall_lines
        attr_reader :render_precall
        attr_reader :render_postcall_lines
        attr_reader :render_postcall

        private

        def fallback_lines parent
          [
            "# Send requests on the stream. For each request object, set fields by",
            "# passing keyword arguments. Be sure to close the stream when done.",
            "#{parent.request_name} << #{parent.request_type}.new",
            "#{parent.request_name} << #{parent.request_type}.new",
            "#{parent.request_name}.close"
          ]
        end
      end

      ##
      # Presentation information about client call invocation
      #
      class ClientCallPresenter
        def initialize parent, proto, json
          @render_lines = pre_call_lines parent, proto, json
          main_line = "client.#{parent.method_name} #{parent.request_name}"
          main_line = "#{parent.response_name} = #{main_line}" if parent.response_name
          @render_lines << main_line
          @render = @render_lines.join "\n"
        end

        attr_reader :render_lines
        attr_reader :render

        private

        def pre_call_lines parent, proto, json
          lines = []
          if json&.key? "preCall"
            proto.pre_call.each_with_index do |statement_proto, index|
              statement = StatementPresenter.new statement_proto, json["preCall"][index]
              lines += statement.render_lines
            end
          elsif !parent.config?
            lines <<
              if parent.client_streaming? || parent.server_streaming?
                "# Call the #{parent.method_name} method to start streaming."
              else
                "# Call the #{parent.method_name} method."
              end
          end
          lines
        end
      end

      ##
      # Presentation information about simple response handling
      #
      class SimpleResponseHandlingPresenter
        def initialize parent, proto, _json
          parent.response_name = parent.interpret_variable_name proto&.response_name, "result"
          @render_lines = []
          if parent.response_name
            @render_lines << "# The returned object is of type #{parent.return_type}." unless parent.config?
            @render_lines << "p #{parent.response_name}"
          end
          @render = @render_lines.join "\n"
        end

        attr_reader :render_lines
        attr_reader :render
      end

      ##
      # Presentation information about LRO response handling
      #
      class LroResponseHandlingPresenter
        def initialize parent, proto, _json
          parent.response_name = parent.interpret_variable_name proto&.response_name, "result"
          @render_lines = []
          if parent.response_name
            unless parent.config?
              @render_lines << "# The returned object is of type Gapic::Operation. You can use it to"
              @render_lines << "# check the status of an operation, cancel it, or wait for results."
            end
            polling_type_class =
              Google::Cloud::Tools::Snippetgen::Configlanguage::V1::Snippet::LroResponseHandling::PollingType
            case proto&.polling_type
            when polling_type_class::NONE
              # Do nothing
            when polling_type_class::ONCE
              @render_lines += check_once_lines parent
            else
              @render_lines += wait_response_lines parent
            end
          end
          @render = @render_lines.join "\n"
        end

        attr_reader :render_lines
        attr_reader :render

        private

        def check_once_lines parent
          lines = []
          lines << "# Here is how to check once for a response." unless parent.config?
          lines + [
            "if #{parent.response_name}.response?",
            "  p #{parent.response_name}.response",
            "else",
            '  puts "Response not yet arrived"',
            "end"
          ]
        end

        def wait_response_lines parent
          lines = []
          lines << "# Here is how to wait for a response." unless parent.config?
          lines + [
            "#{parent.response_name}.wait_until_done! timeout: 60",
            "if #{parent.response_name}.response?",
            "  p #{parent.response_name}.response",
            "else",
            '  puts "No response received."',
            "end"
          ]
        end
      end

      ##
      # Presentation information about server-streaming response handling
      #
      class StreamingResponseHandlingPresenter
        def initialize parent, proto, json
          @render_lines = []
          if parent.response_name
            @render_lines << "# The returned object is a streamed enumerable yielding elements of type"
            @render_lines << "# #{parent.base_response_type}"
            item_name = parent.interpret_variable_name proto&.current_response_name, "current_response"
            @render_lines << "#{parent.response_name}.each do |#{item_name}|"
            if json&.key? "perStreamResponseStatements"
              proto.per_stream_response_statements&.each_with_index do |statement_proto, index|
                statement = StatementPresenter.new statement_proto, json["perStreamResponseStatements"][index]
                @render_lines += statement.render_lines.map { |line| "  #{line}" }
              end
            else
              @render_lines << "  p #{item_name}"
            end
            @render_lines << "end"
          end
          @render = @render_lines.join "\n"
        end

        attr_reader :render_lines
        attr_reader :render
      end

      ##
      # Presentation information about paginated response handling
      #
      class PaginatedResponseHandlingPresenter
        def initialize parent, proto, json
          parent.response_name = parent.interpret_variable_name proto&.response_name, "result"
          @render_lines = []
          if parent.response_name
            unless parent.config?
              @render_lines << "# The returned object is of type Gapic::PagedEnumerable. You can iterate"
              @render_lines << "# overal elements, and API calls will be issued to fetch pages as needed."
            end
            @render_lines +=
              if proto&.by_page
                by_page_lines parent, proto, json
              elsif proto&.next_page_token
                next_page_token_lines parent, proto, json
              else
                by_item_lines parent, proto, json, parent.response_name
              end
          end
          @render = @render_lines.join "\n"
        end

        attr_reader :render_lines
        attr_reader :render

        private

        def by_item_lines parent, proto, json, collection_name
          lines = []
          proto = proto&.by_item
          json = json&.fetch "byItem", nil
          item_name = parent.interpret_variable_name proto&.item_name, "item"
          lines << "#{collection_name}.each do |#{item_name}|"
          if json&.key? "perItemStatements"
            proto.per_item_statements&.each_with_index do |item_proto, index|
              statement = StatementPresenter.new item_proto, json["perItemStatements"][index]
              lines += statement.render_lines.map { |line| "  #{line}" }
            end
          else
            lines << "  # Each element is of type #{parent.paged_response_type}." unless parent.config?
            lines << "  p #{item_name}"
          end
          lines << "end"
          lines
        end

        def by_page_lines parent, proto, json
          lines = []
          proto = proto.by_page
          json = json["byPage"]
          page_name = parent.interpret_variable_name proto&.page_name, "page"
          lines << "#{parent.response_name}.each_page do |#{item_name}|"
          if json&.key? "perPageStatements"
            proto.per_page_statements&.each_with_index do |page_proto, index|
              statement = StatementPresenter.new page_proto, json["perPageStatements"][index]
              lines += statement.render_lines.map { |line| "  #{line}" }
            end
          end
          lines += by_item_lines(parent, proto, json, page_name).map { |line| "  #{line}" }
          lines + ["end"]
        end

        def next_page_token_lines
          # TODO
          []
        end
      end

      private

      def analyze_call
        snippet_proto, snippet_json = snippet_proto_info
        call_proto, call_json = call_proto_info snippet_proto, snippet_json
        @client_initialization = build_client_initialization_presenter snippet_proto, snippet_json
        @request_initialization = build_request_initialization_presenter call_proto, call_json
        @response_handling = build_response_handling_presenter call_proto, call_json
        @client_call = build_client_call_presenter call_proto, call_json
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
        build_presenter ClientInitializationPresenter, snippet_proto, snippet_json,
                        "serviceClientInitialization"
      end

      def build_request_initialization_presenter call_proto, call_json
        if client_streaming?
          self.request_name = interpret_variable_name call_proto&.client_stream_name, "input"
          build_presenter StreamingRequestInitializationPresenter, call_proto, call_json, "requestInitialization"
        else
          build_presenter SimpleRequestInitializationPresenter, call_proto, call_json, "requestInitialization"
        end
      end

      def build_response_handling_presenter call_proto, call_json
        case response_kind
        when :paged
          build_presenter PaginatedResponseHandlingPresenter, call_proto, call_json, "paginatedHandling"
        when :lro
          build_presenter LroResponseHandlingPresenter, call_proto, call_json, "lroHandling"
        when :streaming
          self.response_name = interpret_variable_name call_proto&.server_stream_name, "output"
          build_presenter StreamingResponseHandlingPresenter, call_proto, call_json, "responseHandling"
        else
          build_presenter SimpleResponseHandlingPresenter, call_proto, call_json, "responseHandling"
        end
      end

      def build_client_call_presenter call_proto, call_json
        if response_kind == :paged
          build_presenter ClientCallPresenter, call_proto, call_json, "paginatedCall"
        elsif client_streaming? || server_streaming?
          build_presenter ClientCallPresenter, call_proto, call_json, "initializationCall"
        else
          build_presenter ClientCallPresenter, call_proto, call_json, "call"
        end
      end

      def build_presenter klass, proto, json, field_name
        if proto
          proto = proto[ActiveSupport::Inflector.underscore field_name]
          json = json[field_name]
        end
        klass.new self, proto, json
      end

      def snake_config_id
        ActiveSupport::Inflector.underscore @config.metadata.config_id
      end
    end
  end
end
