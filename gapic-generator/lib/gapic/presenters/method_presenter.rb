# frozen_string_literal: true

# Copyright 2018 Google LLC
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
require "gapic/ruby_info"
require "gapic/helpers/namespace_helper"

module Gapic
  module Presenters
    ##
    # A presenter for rpc methods.
    #
    class MethodPresenter
      include Gapic::Helpers::NamespaceHelper

      # @return [Gapic::Schema::Method]
      attr_accessor :method

      # @return [Gapic::Presenters::MethodRestPresenter]
      attr_accessor :rest

      ##
      # @param service_presenter [Gapic::Presenters::ServicePresenter]
      # @param api [Gapic::Schema::Api]
      # @param method [Gapic::Schema::Method]
      def initialize service_presenter, api, method
        @service_presenter = service_presenter
        @api = api
        @method = method
        @rest = MethodRestPresenter.new self
      end

      ##
      # @return [Gapic::Presenters::ServicePresenter]
      #
      def service
        @service_presenter
      end

      def name
        @name ||= begin
          candidate = ActiveSupport::Inflector.underscore @method.name
          candidate = "call_#{candidate}" if Gapic::RubyInfo.excluded_method_names.include? candidate
          candidate
        end
      end

      def kind
        if client_streaming?
          if server_streaming?
            :bidi
          else
            :client
          end
        elsif server_streaming?
          :server
        else
          :normal
        end
      end

      def doc_description
        @method.docs_leading_comments
      end

      def doc_response_type
        ret = return_type
        ret = "::Gapic::Operation" if lro?
        if server_streaming?
          ret = "::Enumerable<#{ret}>"
        elsif paged?
          paged_type = paged_response_type
          paged_type = "::Gapic::Operation" if paged_type == "::Google::Longrunning::Operation"
          ret = "::Gapic::PagedEnumerable<#{paged_type}>"
        end
        ret
      end

      def is_deprecated?
        @method.is_deprecated?
      end

      def arguments
        arguments = @method.input.fields.reject(&:output_only?)
        arguments.map { |arg| FieldPresenter.new @api, @method.input, arg }
      end

      def fields
        @method.input.fields.map { |field| FieldPresenter.new @api, @method.input, field }
      end

      def fields_with_first_oneof
        return fields if @method.input.oneof_decl.empty?

        selected_fields = []
        have_oneof = []

        @method.input.fields.each do |field|
          unless field.oneof?
            selected_fields << field
            next
          end

          idx = field.oneof_index
          selected_fields << field unless have_oneof.include? idx
          have_oneof << idx
        end

        selected_fields.map { |field| FieldPresenter.new @api, @method.input, field }
      end

      def request_type
        message_ruby_type @method.input
      end

      def return_type
        message_ruby_type @method.output
      end

      def yields?
        # Server streaming RCP calls are the only one that does not yield
        !server_streaming?
      end

      def yield_doc_description
        return "Register a callback to be run when an operation is done." if lro?

        "Access the result along with the RPC operation"
      end

      def yield_params
        if lro?
          return [
            OpenStruct.new(
              name:      "operation",
              doc_types: "::Gapic::Operation"
            )
          ]
        end
        [
          OpenStruct.new(
            name:      "result",
            doc_types: return_type
          ),
          OpenStruct.new(
            name:      "operation",
            doc_types: "::GRPC::ActiveCall::Operation"
          )
        ]
      end

      # @api.incode samples and sample_configs are yaml configuration files such as
      # speech_transcribe_sync_gcs.yaml
      def samples
        sample_configs = @api.incode_samples.select do |sample_config|
          sample_config["service"] == @method.address[0...-1].join(".") &&
            sample_config["rpc"] == @method.name
        end
        sample_configs.map { |sample_config| SamplePresenter.new @api, sample_config }
      end

      def lro?
        return paged_response_type == "::Google::Longrunning::Operation" if paged?

        message_ruby_type(@method.output) == "::Google::Longrunning::Operation"
      end

      def client_streaming?
        @method.client_streaming
      end

      def server_streaming?
        @method.server_streaming
      end

      def paged?
        return false if server_streaming? # Cannot page a streaming response

        # HACK(dazuma, 2020-04-06): Two specific RPCs should not be paged.
        # This is an intentionally hard-coded exception (and a temporary one,
        # to be removed when these methods no longer conform to AIP-4233.) For
        # detailed information, see internal link go/actools-talent-pagination.
        address = @method.address.join "."
        return false if address == "google.cloud.talent.v4beta1.ProfileService.SearchProfiles"
        return false if address == "google.cloud.talent.v4beta1.JobService.SearchJobs"
        return false if address == "google.cloud.talent.v4beta1.JobService.SearchJobsForAlert"

        paged_request?(@method.input) && paged_response?(@method.output)
      end

      def paged_response_type
        return nil unless paged_response? @method.output

        repeated_field = @method.output.fields.find do |f|
          f.label == Google::Protobuf::FieldDescriptorProto::Label::LABEL_REPEATED &&
            f.type == Google::Protobuf::FieldDescriptorProto::Type::TYPE_MESSAGE
        end
        message_ruby_type repeated_field.message
      end

      ##
      # @return [Array<String>] The segment key names.
      #
      def routing_params
        rest.routing_params
      end

      ##
      # @return [Boolean] Whether any routing params are present
      #
      def routing_params?
        rest.routing_params?
      end

      def grpc_service_config
        if @api.grpc_service_config&.service_method_level_configs&.key?(service.grpc_full_name) &&
           @api.grpc_service_config.service_method_level_configs[service.grpc_full_name]&.key?(grpc_method_name)
          @api.grpc_service_config.service_method_level_configs[service.grpc_full_name][grpc_method_name]
        end
      end

      def grpc_method_name
        @method.name
      end

      ##
      # Returns a hash with a drift_manifest of this rpc method
      # describing correspondence between the proto description
      # of the rpc with the generated code for the method.
      # For ruby currently [03/2021] only one method is generated per RPC,
      # so the correspondence is very basic.
      # See https://github.com/googleapis/googleapis/blob/master/gapic/metadata/gapic_metadata.proto
      #
      # @return [Hash]
      def drift_manifest
        { methods: [name] }
      end

      protected

      def message_ruby_type message
        ruby_namespace @api, message.address.join(".")
      end

      def doc_types_for arg
        if arg.message?
          "#{message_ruby_type arg.message}, Hash"
        elsif arg.enum?
          # TODO: handle when arg message is nil and enum is the type
          message_ruby_type arg.enum
        else
          case arg.type
          when 1, 2                              then "::Float"
          when 3, 4, 5, 6, 7, 13, 15, 16, 17, 18 then "::Integer"
          when 9, 12                             then "::String"
          when 8                                 then "::Boolean"
          else
            "::Object"
          end
        end
      end

      def doc_desc_for arg
        return nil if arg.docs.leading_comments.empty?

        arg.docs.leading_comments
      end

      def default_value_for arg
        if arg.message?
          "{}"
        elsif arg.enum?
          # TODO: select the first non-0 enum value
          # ":ENUM"
          arg.enum.values.first
        else
          case arg.type
          when 1, 2                              then "3.14"
          when 3, 4, 5, 6, 7, 13, 15, 16, 17, 18 then "42"
          when 9, 12                             then "\"hello world\""
          when 8                                 then "true"
          else
            "::Object"
          end
        end
      end

      def paged_request? request
        page_token = request.fields.find do |f|
          f.name == "page_token" && f.type == Google::Protobuf::FieldDescriptorProto::Type::TYPE_STRING
        end
        return false if page_token.nil?

        page_size_types = [
          Google::Protobuf::FieldDescriptorProto::Type::TYPE_INT32,
          Google::Protobuf::FieldDescriptorProto::Type::TYPE_INT64
        ]
        page_size = request.fields.find do |f|
          f.name == "page_size" && page_size_types.include?(f.type)
        end
        return false if page_size.nil?

        true
      end

      def paged_response? response
        next_page_token = response.fields.find do |f|
          f.name == "next_page_token" && f.type == Google::Protobuf::FieldDescriptorProto::Type::TYPE_STRING
        end
        return false if next_page_token.nil?

        repeated_field = response.fields.find do |f|
          f.label == Google::Protobuf::FieldDescriptorProto::Label::LABEL_REPEATED &&
            f.type == Google::Protobuf::FieldDescriptorProto::Type::TYPE_MESSAGE
        end
        return false if repeated_field.nil?

        # We want to make sure the first repeated field is also has the lowest field number,
        # but the google-protobuf gem sorts fields by number, so we lose the original order.

        true
      end
    end
  end
end
