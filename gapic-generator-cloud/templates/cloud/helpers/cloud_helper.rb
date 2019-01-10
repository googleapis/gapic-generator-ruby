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

module CloudHelper
  def gem_name api
    gem_address(api).join "-"
  end

  def gem_path api
    gem_address(api).join "/"
  end

  def gem_address api
    s = api_services(api).first
    version = s.address.find { |x| x =~ /^v[0-9][0-9a-z.]*\z/ }
    version_index = s.address.index version
    s.address[0...version_index]
  end

  def client_file_path service
    ruby_file_path(service).sub ".rb", "_client.rb"
  end

  def credentials_file_path api
    s = api_services(api).first
    path_nodes = ruby_file_path(s).split "/"
    path_nodes.pop
    path_nodes << "credentials.rb"
    path_nodes.join "/"
  end

  def client_lro? _service
    true # TODO
  end

  def client_name service
    "#{service.name}Client"
  end

  def client_require _service
    "google/cloud/speech/v1/cloud_speech_pb"
  end

  def credentials_require _service
    "google/cloud/speech/v1/credentials"
  end

  def client_stub _service
    "speech_stub"
  end

  def client_address _service
    "speech.googleapis.com"
  end

  def client_port _service
    443
  end

  def client_scopes _service
    ["https://www.googleapis.com/auth/cloud-platform"]
  end

  def service_proto_require _service
    "google/cloud/speech/v1/cloud_speech_services_pb"
  end

  def method_name method
    ActiveSupport::Inflector.underscore method.name
  end

  def method_return_type _method
    "Google::Cloud::Speech::V1::RecognizeResponse"
  end

  def method_desc _method
    "TODO"
  end

  def method_arguments _method
    %w[config audio]
  end

  def method_arg_name arg
    arg.to_s
  end

  def method_arg_type arg
    return "Google::Cloud::Speech::V1::RecognitionConfig" if arg == "config"

    "Google::Cloud::Speech::V1::RecognitionAudio"
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

  def prepend_with input, prepend
    input.strip.each_line.map { |line| prepend + line }.join
  end

  def indent input, spacing
    prepend_with(input, " " * spacing).lstrip
  end

  def client_json_config_file_name _service
    "speech_client_config.json"
  end

  def client_proto_name _service
    "google.cloud.speech.v1.Speech"
  end
end
