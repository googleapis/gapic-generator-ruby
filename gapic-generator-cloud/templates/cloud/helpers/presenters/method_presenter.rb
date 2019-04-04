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
require_relative "service_presenter"
require_relative "field_presenter"

class MethodPresenter
  def initialize method
    @method  = method
  end

  def service
    ServicePresenter.new @method.parent
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
    elsif lro?
      :lro
    else
      :normal
    end
  end

  def ivar
    "@#{name}"
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

  def arguments
    arguments = @method.input.fields.reject(&:output_only?)
    arguments.map { |arg| FieldPresenter.new @method.input, arg }
  end

  def fields
    @method.input.fields.map { |field| FieldPresenter.new @method.input, field }
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
          doc_types: "Google::Gax::Operation"
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

  def code_example
    "TODO "
  end

  def lro?
    message_ruby_type(@method.output) == "Google::Longrunning::Operation"
  end

  def client_streaming?
    @method.client_streaming
  end

  def server_streaming?
    @method.server_streaming
  end

  protected

  def message_ruby_type message
    message.address.map do |namespace_node|
      ActiveSupport::Inflector.classify namespace_node
    end.join "::"
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
end
