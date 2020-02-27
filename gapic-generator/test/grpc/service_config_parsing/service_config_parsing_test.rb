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

require "minitest/autorun"
require "json"
require 'grpc/service_config_parsing/grpc_service_config_parser'

require 'pry'

##
# Test for GRPC ServiceConfig parsing
#
class ServiceConfigParsingTest < Minitest::Test
  def test_empty_config 
    config_json = {}
    service_config = ::Grpc::ServiceConfigParsing::GrpcServiceConfigParser::parse(config_json)

    assert_equal({}, service_config.service_level_configs)
    assert_equal({}, service_config.service_method_level_configs)
  end

  def test_varied_config 
    config_json = JSON.load(::File.read("protofiles_input/testing/grpc_service_config/grpc_service_config.json"))
    service_config = ::Grpc::ServiceConfigParsing::GrpcServiceConfigParser::parse(config_json)

    assert_equal 20, service_config.service_level_configs["testing.grpcserviceconfig.ServiceWithRetries"].timeout_seconds
    assert_equal 0.5, service_config.service_level_configs["testing.grpcserviceconfig.ServiceWithRetries"].retry_policy.initial_delay_seconds
    assert_equal 5, service_config.service_level_configs["testing.grpcserviceconfig.ServiceWithRetries"].retry_policy.max_delay_seconds
    assert_equal 2.0, service_config.service_level_configs["testing.grpcserviceconfig.ServiceWithRetries"].retry_policy.multiplier
    assert_equal 2, service_config.service_level_configs["testing.grpcserviceconfig.ServiceWithRetries"].retry_policy.status_codes.count
    assert service_config.service_level_configs["testing.grpcserviceconfig.ServiceWithRetries"].retry_policy.status_codes.include?("DEADLINE_EXCEEDED")
    assert service_config.service_level_configs["testing.grpcserviceconfig.ServiceWithRetries"].retry_policy.status_codes.include?("RESOURCE_EXHAUSTED")

    assert_equal 60, service_config.service_method_level_configs["testing.grpcserviceconfig.ServiceWithRetries"]["MethodLevelRetryMethod"].timeout_seconds
    assert_equal 1, service_config.service_method_level_configs["testing.grpcserviceconfig.ServiceWithRetries"]["MethodLevelRetryMethod"].retry_policy.initial_delay_seconds
    assert_equal 10, service_config.service_method_level_configs["testing.grpcserviceconfig.ServiceWithRetries"]["MethodLevelRetryMethod"].retry_policy.max_delay_seconds 
    assert_equal 3.0, service_config.service_method_level_configs["testing.grpcserviceconfig.ServiceWithRetries"]["MethodLevelRetryMethod"].retry_policy.multiplier
    assert_equal 1, service_config.service_method_level_configs["testing.grpcserviceconfig.ServiceWithRetries"]["MethodLevelRetryMethod"].retry_policy.status_codes.count
    assert service_config.service_method_level_configs["testing.grpcserviceconfig.ServiceWithRetries"]["MethodLevelRetryMethod"].retry_policy.status_codes.include?("UNAVAILABLE")
  end
end