# frozen_string_literal: true

# Copyright 2021 Google LLC
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

require "test_helper"

# Unit tests for the parameter parsing
class ServiceYamlParserTest < Minitest::Test
    def test_parse_service_yaml
        config_version = 2
        service_name = "my_service"

        api1_name = "test_api1"

        yaml = <<~HEREDOC
                type: google.api.Service
                config_version: #{config_version}
                name: #{service_name}
                apis:
                - name: #{api1_name}
                - name: test_api2
        HEREDOC
        
        service = Gapic::Schema::ServiceYamlParser.parse_service_yaml yaml
        $stderr.puts ("-"*7)+"decode"+("-"*7)
        $stderr.puts service.to_json
        $stderr.puts ("-"*20)

        assert_equal config_version, service.config_version.value
        assert_equal service_name, service.name
        assert_equal 2, service.apis.length
        assert service.apis.any? { |api| api.name == api1_name } 
    end
end