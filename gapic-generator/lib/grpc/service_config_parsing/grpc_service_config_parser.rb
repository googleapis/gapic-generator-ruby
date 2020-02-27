# frozen_string_literal: true

# Copyright 2020 Google LLC
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

require 'grpc/service_config_parsing/parsed_grpc_service_config'
require 'grpc/service_config_parsing/parsed_method_config'
require 'grpc/service_config_parsing/parsed_retry_policy'
require 'grpc/service_config_parsing/parsing_error'

require 'grpc/service_config_parsing/interval'

module Grpc
  module ServiceConfigParsing
    module GrpcServiceConfigParser
      METHOD_CONFIG_JSON_KEY = "method_config"
      RETRY_POLICY_JSON_KEY = "retry_policy"
      
      NAMES_JSON_KEY = "name"
      SERVICE_NAME_JSON_KEY = "service"
      METHOD_NAME_JSON_KEY = "method"

      TIMEOUT_JSON_KEY = "timeout"

      INITIAL_DELAY_JSON_KEY = "initial_backoff"
      MAX_DELAY_JSON_KEY = "max_backoff"
      MULTIPLIER_JSON_KEY = "backoff_multiplier"
      STATUS_CODES_JSON_KEY = "retryable_status_codes"

      def self.parse service_config_json
        service_level_result = {}
        service_method_level_result = {}

        if !service_config_json.nil? && service_config_json.key?(METHOD_CONFIG_JSON_KEY)
          method_configs_json = service_config_json[METHOD_CONFIG_JSON_KEY]
         
          method_configs_json.each do |method_config_json| 
            method_config = parse_config method_config_json
            service_names = parse_service_names method_config_json[NAMES_JSON_KEY]
            service_method_names = filter_service_method_names method_config_json[NAMES_JSON_KEY]

            service_names.each do |service_name|
              service_level_result[service_name] = method_config
            end

            service_method_names.each do |service_method_name| 
              service_name = service_method_name[SERVICE_NAME_JSON_KEY]
              method_name = service_method_name[METHOD_NAME_JSON_KEY]

              if !service_method_level_result.key? service_name
                service_method_level_result[service_name] = {}
              end

              service_method_level_result[service_name][method_name] = method_config
            end
          end
        end

        ParsedGrpcServiceConfig.new(service_level_result, service_method_level_result)
      end

      def self.parse_service_names method_config_json_names
        method_config_json_names.select { |names_json| 
          names_json.size == 1 && names_json.key?(SERVICE_NAME_JSON_KEY)
        }.map {|names_json| names_json[SERVICE_NAME_JSON_KEY]}
      end

      def self.filter_service_method_names method_config_json_names
        method_config_json_names.select { |names_json| 
          names_json.size == 2 && names_json.key?(SERVICE_NAME_JSON_KEY) && names_json.key?(METHOD_NAME_JSON_KEY)
        }
      end

      def self.parse_config method_config_json
        timeout_seconds = parse_interval_seconds method_config_json[TIMEOUT_JSON_KEY]
        retry_policy = parse_retry_policy method_config_json[RETRY_POLICY_JSON_KEY]

        ParsedMethodConfig.new(timeout_seconds, retry_policy)
      end

      def self.parse_retry_policy retry_policy_json
        if retry_policy_json.nil? || retry_policy_json.empty?
          nil
        else
          initial_delay_seconds = parse_interval_seconds retry_policy_json[INITIAL_DELAY_JSON_KEY]
          max_delay_seconds = parse_interval_seconds retry_policy_json[MAX_DELAY_JSON_KEY]
          multiplier = retry_policy_json[MULTIPLIER_JSON_KEY]
          status_codes = retry_policy_json[STATUS_CODES_JSON_KEY]

          ParsedRetryPolicy.new(initial_delay_seconds, max_delay_seconds, multiplier, status_codes)
        end
      end

      def self.parse_interval_seconds timestring
        if timestring.empty?
          nil
        else
          timestring_nos = timestring.delete_suffix('s')
          if !valid_float?(timestring_nos)
            raise ParsingError "Was not able to convert the string `#{timestring}` to a time interval when parsing a grpc service config"
          end
          time_seconds = Float(timestring_nos)
          time_seconds
        end    
      end

      def self.valid_float?(str)
        !!Float(str) rescue false
      end

    end
  end
end