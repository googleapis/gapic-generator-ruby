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
require "gapic/path_template"
require_relative "service_presenter"
require_relative "field_presenter"

class MethodPresenter
  include NamespaceHelper

  def initialize api, method
    @api = api
    @method  = method
  end

  def service
    ServicePresenter.new @api, @method.parent
  end

  def name
    ActiveSupport::Inflector.underscore @method.name
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
    return nil if @method.docs.leading_comments.empty?

    @method
      .docs
      .leading_comments
      .each_line
      .map { |line| (line.start_with? " ") ? line[1..-1] : line }
      .join
  end

  def doc_response_type
    ret = return_type
    ret = "Gapic::Operation" if lro?
    if server_streaming?
      ret = "Enumerable<#{ret}>"
    elsif paged?
      paged_type = paged_response_type
      paged_type = "Gapic::Operation" if paged_type == "Google::Longrunning::Operation"
      ret = "Gapic::PagedEnumerable<#{paged_type}>"
    end
    ret
  end

  def arguments
    arguments = @method.input.fields.reject(&:output_only?)
    arguments.map { |arg| FieldPresenter.new @api, @method.input, arg }
  end

  def fields
    @method.input.fields.map { |field| FieldPresenter.new @api, @method.input, field }
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
          name: "operation",
          doc_types: "Gapic::Operation"
        )
      ]
    end
    [
      OpenStruct.new(
        name: "result",
        doc_types: return_type
      ),
      OpenStruct.new(
        name: "operation",
        doc_types: "GRPC::ActiveCall::Operation"
      )
    ]
  end

  #   rpc: Recognize
  # service: google.cloud.speech.v1.Speech   service: google.cloud.speech.v1.Speech rpc: Recognize
  def code_examples
    # raise @api.samples.inspect
    samples = @api.samples.select { |x| x["service"] == @method.address[0...-1].join(".") && x["rpc"] == @method.name }
    puts "service: #{@method.address[0...-1].join(".")} rpc: #{@method.name}"
    samples.map { |s| OpenStruct.new(title: s["title"], code: "# TODO") }

    # @api.samples # Array<Hash> -> SampleGen::Thingie
    # SampleGen#for MethodPresenter
    # SampleGen#for service_string, rpc_string
    # @api.samples.for @method.address[0...-1].join("."), @method.name
  end

  def lro?
    return paged_response_type == "Google::Longrunning::Operation" if paged?

    message_ruby_type(@method.output) == "Google::Longrunning::Operation"
  end

  def client_streaming?
    @method.client_streaming
  end

  def server_streaming?
    @method.server_streaming
  end

  def paged?
    return false if server_streaming? # Cannot page a streaming response
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
  #
  # @return [Array<String>] The segment key names.
  #
  def routing_params
    segments = Gapic::PathTemplate.parse method_path
    segments.select { |s| s.is_a? Gapic::PathTemplate::Segment }.map &:name
  end

  def routing_params?
    routing_params.any?
  end

  protected

  def message_ruby_type message
    ruby_namespace @api, message.address.join(".")
  end

  def doc_types_for arg
    if arg.message?
      "#{message_ruby_type arg.message} | Hash"
    elsif arg.enum?
      # TODO: handle when arg message is nil and enum is the type
      "ENUM(#{arg.enum.name})"
    else
      case arg.type
      when 1, 2                              then "Float"
      when 3, 4, 5, 6, 7, 13, 15, 16, 17, 18 then "Integer"
      when 9, 12                             then "String"
      when 8                                 then "Boolean"
      else
        "Object"
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
        "Object"
      end
    end
  end

  def method_path
    return "" if @method.http.nil?
    return @method.http.get unless @method.http.get.empty?
    return @method.http.post unless @method.http.post.empty?
    return @method.http.put unless @method.http.put.empty?
    return @method.http.patch unless @method.http.patch.empty?
    return @method.http.delete unless @method.http.delete.empty?
    return @method.http.custom.path unless @method.http.custom.nil?
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
