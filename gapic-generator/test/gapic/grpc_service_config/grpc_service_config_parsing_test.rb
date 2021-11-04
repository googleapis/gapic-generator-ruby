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

require "json"
require "minitest/autorun"
require "gapic/schema"

##
# Test for GRPCServiceConfig parsing
#
class GrpcServiceConfigParsingTest < Minitest::Test
  ##
  # Testing that the empty hash (default raw value for the absent config
  # in Gapic::Schema::Api) will result in a correct empty config
  #
  def test_empty_config
    config_json = {}
    config = ::Gapic::GrpcServiceConfig::Parser.parse config_json

    assert_equal({}, config.service_level_configs)
    assert_equal({}, config.service_method_level_configs)
  end

  ##
  # Testing that the service-level config is populated correctly from a sample json
  #
  def test_varied_config_service
    config_json = JSON.parse ::File.read("protofiles_input/testing/grpc_service_config/grpc_service_config.json")
    config = ::Gapic::GrpcServiceConfig::Parser.parse config_json

    service_with_retries_config = config.service_level_configs["testing.grpcserviceconfig.ServiceWithRetries"]

    assert_equal 20, service_with_retries_config.timeout_seconds
    assert_equal 0.5, service_with_retries_config.retry_policy.initial_delay_seconds
    assert_equal 5, service_with_retries_config.retry_policy.max_delay_seconds
    assert_equal 2.0, service_with_retries_config.retry_policy.multiplier
    assert_equal 2, service_with_retries_config.retry_policy.status_codes.count
    assert_includes service_with_retries_config.retry_policy.status_codes, 4
    assert_includes service_with_retries_config.retry_policy.status_codes, 8
  end

  ##
  # Testing that the method-level config is populated correctly from a sample json
  #
  def test_varied_config_method
    config_json = JSON.parse ::File.read("protofiles_input/testing/grpc_service_config/grpc_service_config2.json")
    config = ::Gapic::GrpcServiceConfig::Parser.parse config_json

    service_method_configs = config.service_method_level_configs["testing.grpcserviceconfig.ServiceWithRetries"]
    method_level_retry_config = service_method_configs["MethodLevelRetryMethod"]

    assert_equal 86_400, method_level_retry_config.timeout_seconds
    assert_equal 1, method_level_retry_config.retry_policy.initial_delay_seconds
    assert_equal 10, method_level_retry_config.retry_policy.max_delay_seconds
    assert_equal 3.0, method_level_retry_config.retry_policy.multiplier
    assert_equal 1, method_level_retry_config.retry_policy.status_codes.count
    assert_includes method_level_retry_config.retry_policy.status_codes, 14
  end
end
