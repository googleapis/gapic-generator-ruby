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

module MethodHelper
  def method_name method
    ActiveSupport::Inflector.underscore method.name
  end

  def method_doc_return_type method
    if method_server_streaming? method
      return "Enumerable<#{method_return_type method}>"
    end

    method_return_type method
  end

  def method_return_type method
    return "Google::Gax::Operation" if message_lro? method.output

    message_ruby_type method.output
  end

  def method_lro? method
    message_lro? method.output
  end

  def method_desc _method
    "TODO"
  end

  def method_client_streaming? method
    method.client_streaming
  end

  def method_server_streaming? method
    method.server_streaming
  end

  def method_arguments method
    if method.client_streaming
      return [
        OpenStruct.new(
          name: "reqs",
          ruby_type: "Enumerable<#{message_ruby_type method.input} | Hash>"
        )
      ]
    end

    method.input.fields
  end

  def method_arg_name arg
    arg.name
  end

  def method_doc_arg_type arg
    return arg.ruby_type if arg.respond_to? :ruby_type

    if arg.message?
      "#{message_ruby_type arg.message} | Hash"
    elsif arg.enum?
      # TODO: handle when arg message is nil and enum is the type
      "ENUM(#{arg.enum.name})"
    else
      String # arg.name
    end
  end

  def method_arg_desc _arg
    "TODO"
  end

  def method_code_example _method
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

  ##
  # @private
  def message_lro? message
    message_ruby_type(message) == "Google::Longrunning::Operation"
  end

  ##
  # @private
  def message_ruby_type message
    message.address.map do |namespace_node|
      ActiveSupport::Inflector.classify namespace_node
    end.join "::"
  end
end
