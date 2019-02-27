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

class MethodPresenter
  attr_reader :api, :service, :method

  def initialize api, service, method
    @api     = api
    @service = service
    @method  = method
  end

  def name
    ActiveSupport::Inflector.underscore method.name
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
    "TODO "
  end

  def arguments
    # TODO: Define the options and &block arguments here, not templates

    if client_streaming?
      return [
        OpenStruct.new(
          name: "reqs",
          doc_types: "Enumerable<#{message_ruby_type method.input} | Hash>",
          doc_description: "TODO"
        )
      ]
    end

    method.input.fields.map do |field|
      nested_arguments = field.message.descriptor.field.map do |nested_field|
        OpenStruct.new(
          name: nested_field.name,
          type_name: nested_field.type_name,
          default_value: default_value(nested_field.name)
        )
      end
      OpenStruct.new(
        name: field.name,
        doc_types: doc_types_for(field),
        doc_description: "TODO",
        type_name: field.type_name,
        arguments: nested_arguments,
        example_arguments: example_arguments(field.name, nested_arguments),
        default_value: default_value(field.name)
      )
    end
  end

  def argument_names
    arguments.map(&:name)
  end

  def request_type
    message_ruby_type method.input
  end

  def return_type
    return "Google::Gax::Operation" if lro?

    message_ruby_type method.output
  end

  def doc_return_type
    orig = return_type
    orig = "Enumerable<#{orig}>" if server_streaming?
    orig
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
    <<~CODE_EXAMPLE
      require "google/cloud/speech"

      speech_client = Google::Cloud::Speech.new(version: :v1)
      encoding = :FLAC
      sample_rate_hertz = 44100
      language_code = "en-US"
      config = {
        encoding: encoding,
        sample_rate_hertz: sample_rate_hertz,
        language_code: language_code
      }
      uri = "gs://bucket_name/file_name.flac"
      audio = { uri: uri }
      response = speech_client.recognize(config, audio)
    CODE_EXAMPLE
  end

  def lro?
    message_ruby_type(method.output) == "Google::Longrunning::Operation"
  end

  def client_streaming?
    method.client_streaming
  end

  def server_streaming?
    method.server_streaming
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
      # TODO: look at arg.type to determine the actual type
      "String" # default type for now
    end
  end

  # TODO: replace field name comparison with type
  def default_value type_name
    case type_name
    when "encoding"
      ":FLAC"
    when "sample_rate_hertz"
      "44_100"
    when "language_code"
      "\"en-US\""
    when "uri"
      "\"gs://bucket_name/file_name.flac\""
    end
  end

  # TODO: replace hardcoded logic with annotation data
  def example_arguments field_name, nested_arguments
    filter = case field_name
             when "config"
               %w[encoding sample_rate_hertz language_code]
             when "audio"
               ["uri"]
             else
               []
             end
    nested_arguments.select { |na| filter.include? na.name }
  end
end
