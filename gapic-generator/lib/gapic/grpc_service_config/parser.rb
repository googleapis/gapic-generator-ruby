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

require "gapic/grpc_service_config/service_config"
require "gapic/grpc_service_config/method_config"
require "gapic/grpc_service_config/retry_policy"
require "gapic/grpc_service_config/parsing_error"

module Gapic
  module GrpcServiceConfig
    ##
    # Takes a json of a GRPC service Config and parses it into the form
    # usable by the microgenerator templates
    #
    module Parser
      METHOD_CONFIG_JSON_KEY = "methodConfig"
      RETRY_POLICY_JSON_KEY = "retryPolicy"

      NAMES_JSON_KEY = "name"
      SERVICE_NAME_JSON_KEY = "service"
      METHOD_NAME_JSON_KEY = "method"

      TIMEOUT_JSON_KEY = "timeout"

      INITIAL_DELAY_JSON_KEY = "initialBackoff"
      MAX_DELAY_JSON_KEY = "maxBackoff"
      MULTIPLIER_JSON_KEY = "backoffMultiplier"
      STATUS_CODES_JSON_KEY = "retryableStatusCodes"

      ERROR_CODE_MAPPING = [
        "OK",
        "CANCELLED",
        "UNKNOWN",
        "INVALID_ARGUMENT",
        "DEADLINE_EXCEEDED",
        "NOT_FOUND",
        "ALREADY_EXISTS",
        "PERMISSION_DENIED",
        "RESOURCE_EXHAUSTED",
        "FAILED_PRECONDITION",
        "ABORTED",
        "OUT_OF_RANGE",
        "UNIMPLEMENTED",
        "INTERNAL",
        "UNAVAILABLE",
        "DATA_LOSS",
        "UNAUTHENTICATED"
      ].freeze

      ERROR_STRING_MAPPING = ERROR_CODE_MAPPING.each_with_index.each_with_object({}) do |(str, num), hash|
        hash[str] = num
      end.freeze

      ##
      # Parses ServiceConfig from a json of a GRPC service config
      #
      # @param service_config_json [Hash] a hash that results from JSON.parse
      #
      # @return [Gapic::GrpcServiceConfig::ServiceConfig] parsed ServiceConfig
      #
      def self.parse service_config_json
        service_level_result = {}
        service_method_level_result = {}

        if !service_config_json.nil? && key?(service_config_json, METHOD_CONFIG_JSON_KEY)
          method_configs_json = get service_config_json, METHOD_CONFIG_JSON_KEY

          method_configs_json.each do |method_config_json|
            method_config = parse_config method_config_json
            service_names = parse_service_names get(method_config_json, NAMES_JSON_KEY)
            service_method_names = filter_service_method_names get(method_config_json, NAMES_JSON_KEY)

            service_names.each do |service_name|
              service_level_result[service_name] = method_config
            end

            service_method_names.each do |service_method_name|
              service_name = get service_method_name, SERVICE_NAME_JSON_KEY
              method_name = get service_method_name, METHOD_NAME_JSON_KEY

              service_method_level_result[service_name] ||= {}
              service_method_level_result[service_name][method_name] = method_config
            end
          end
        end

        ServiceConfig.new service_level_result, service_method_level_result
      end

      ##
      # Parses the names of the services for which the service-level
      # config is defined from the GRPC service config json.
      # Within the json the names are arranged in hashes. Each hash contains a
      # required "service" key and an optional "method" key. Here we select only
      # the hashes WITHOUT the optional key -- meaning that the config will be
      # applied on a service-level -- and return just the service names.
      #
      # @param method_config_json_names [Array<Hash<String, String>>] "name" hashes from
      #   the GRPC service config
      #
      # @return [Array<String>] parsed names of services
      #
      def self.parse_service_names method_config_json_names
        service_names_jsons = method_config_json_names.select do |names_json|
          names_json.size == 1 && key?(names_json, SERVICE_NAME_JSON_KEY)
        end

        service_names_jsons.map { |names_json| get names_json, SERVICE_NAME_JSON_KEY }
      end

      ##
      # Filters the "name" hashes from the GRPC service config json
      # to exclude service-level names
      # Within the json the names are arranged in hashes. Each hash contains a
      # required "service" key and an optional "method" key. Here we select only
      # the hashes WITH the optional key -- meaning that the config will be
      # applied on a method-level -- and return the hashes in full.
      #
      # @param method_config_json_names [Array<Hash<String, String>>] "name" hashes
      #   from the GRPC service config
      #
      # @return [Array<Hash<String, String>>] filtered hashes for methods
      #
      def self.filter_service_method_names method_config_json_names
        method_config_json_names.select do |names_json|
          names_json.size == 2 && key?(names_json, SERVICE_NAME_JSON_KEY) && key?(names_json, METHOD_NAME_JSON_KEY)
        end
      end

      ##
      # Parses MethodConfig from the GRPC service config json
      #
      # @param method_config_json [Hash] a hash of a single "method_config"
      #   from the GRPC service config
      #
      # @return [Gapic::GrpcServiceConfig::MethodConfig] parsed MethodConfig
      #
      def self.parse_config method_config_json
        timeout_seconds = parse_interval_seconds get(method_config_json, TIMEOUT_JSON_KEY)
        retry_policy = parse_retry_policy get(method_config_json, RETRY_POLICY_JSON_KEY)

        MethodConfig.new timeout_seconds, retry_policy
      end

      ##
      # Parses RetryPolicy from the GRPC service config json
      #
      # @param retry_policy_json [Hash<String, String>] a hash of a single "retry_policy"
      #   from the GRPC service config
      #
      # @return [Gapic::GrpcServiceConfig::RetryPolicy] parsed RetryPolicy
      #
      def self.parse_retry_policy retry_policy_json
        return nil if retry_policy_json.nil? || retry_policy_json.empty?

        initial_delay_seconds = parse_interval_seconds get(retry_policy_json, INITIAL_DELAY_JSON_KEY)
        max_delay_seconds = parse_interval_seconds get(retry_policy_json, MAX_DELAY_JSON_KEY)
        multiplier = get retry_policy_json, MULTIPLIER_JSON_KEY
        status_codes = convert_codes get retry_policy_json, STATUS_CODES_JSON_KEY

        RetryPolicy.new initial_delay_seconds, max_delay_seconds, multiplier, status_codes
      end

      ##
      # Interpret input status codes. Convert strings to their associated integer codes.
      #
      def self.convert_codes input_codes
        return nil if input_codes.nil?
        Array(input_codes).map do |obj|
          case obj
          when String
            ERROR_STRING_MAPPING[obj]
          when Integer
            obj
          end
        end.compact
      end

      ##
      # Parses time expressed in secondds from the GRPC service config json
      # The time is encoded is a string as float or integer with a letter 's' afterwards
      # If given a nil or an empty string returns nil for 'not set' semantic
      # If a string sans the 's' cannot be converted throws a ParsingError
      #
      # @param timestring [String, nil] a string of a time inerval from the GRPC service config
      #
      # @raise [ParsingError] if the time interval string could not be converted
      #
      # @return [Float, nil] converted time interval or nil for 'not set'
      #
      def self.parse_interval_seconds timestring
        return nil if timestring.empty?

        timestring_nos = timestring.delete_suffix "s"
        unless valid_float? timestring_nos
          error_text = "Was not able to convert the string `#{timestring}` " \
                        "to a time interval when parsing a grpc service config"
          raise ParsingError, error_text
        end
        Float(timestring_nos)
      end

      ##
      # Determines if the key or its underscore form exists
      #
      # @param hash [Hash] hash structure
      # @param key [String] lowerCamelCase string
      # @return [Boolean]
      #
      def self.key? hash, key
        hash.key?(key) || hash.key?(ActiveSupport::Inflector.underscore(key))
      end

      ##
      # Look up a key including checking its underscore form
      #
      # @param hash [Hash] hash structure
      # @param key [String] lowerCamelCase string
      # @return [Object] the result, or `nil` if not found
      #
      def self.get hash, key
        hash[key] || hash[ActiveSupport::Inflector.underscore(key)]
      end

      ##
      # Determines if a given string can be converted to a float
      #
      # @param str [String, nil] a given string, can be nil
      #
      # @return [Boolean] true, if converstion to float is possible
      #
      def self.valid_float? str
        Float(str)
        true
      rescue ::ArgumentError, ::TypeError
        false
      end

      private_class_method :parse_service_names, :filter_service_method_names, :parse_config,
                           :parse_retry_policy, :parse_interval_seconds, :valid_float?, :convert_codes
    end
  end
end
