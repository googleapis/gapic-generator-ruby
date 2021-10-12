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

require 'yaml'
require 'google/api/service.pb'

module Gapic
  module Schema
    # Contains logic for parsing a subset of service.yaml used 
    # for the service generation
    module ServiceConfigParser
      class << self
        CONFIG_VERSION_KEY = "config_version"
        NAME_KEY = "name"
        VERSION_KEY = "version"
        ID_KEY = "id"
        TITLE_KEY = "title"
        APIS_KEY = "apis"
        HTTP_KEY = "http"
        HTTP_RULES_KEY = "rules"
        HTTP_RULES_SELECTOR_KEY = "selector"
        HTTP_RULES_VERBS_ALLOWED = ["get", "post", "put", "patch", "delete"]
        HTTP_RULES_BODY_KEY = "body"
        HTTP_RULES_ADDITIONAL_BINDINGS_KEY = "additional_bindings"

        def parse_service_yaml service_yaml_text
          return nil unless service_yaml_text && !service_yaml_text.empty?
          service_yaml = YAML.load service_yaml_text
          service = Google::Api::Service.new

          if service_yaml.key? CONFIG_VERSION_KEY
            config_ver = Google::Protobuf::UInt32Value.new
            config_ver.value = service_yaml[CONFIG_VERSION_KEY]
            service.config_version = config_ver
          end

          service.name = service_yaml[NAME_KEY] if service_yaml.key? NAME_KEY
          service.id = service_yaml[ID_KEY] if service_yaml.key? ID_KEY
          service.title = service_yaml[TITLE_KEY] if service_yaml.key? TITLE_KEY

          service.apis = parse_apis(service_yaml[APIS_KEY]) if service_yaml.key? APIS_KEY
          service.http = parse_http(service_yaml[HTTP_KEY]) if service_yaml.key? HTTP_KEY
          service
        end

        def parse_apis apis_yaml
          apis_yaml.map { |api_yaml|  parse_api api_yaml }
        end

        def parse_api api_yaml
          api = ::Google::Protobuf::Api.new
          api.name = api_yaml[NAME_KEY] if api_yaml.key? NAME_KEY
          api.version = api_yaml[VERSION_KEY] if api_yaml.key? VERSION_KEY
          api
        end

        def parse_http http_yaml
          http = Google::Api::Http.new

          if http_yaml.key? HTTP_RULES_KEY
            http.rules = http_yaml[HTTP_RULES_KEY].map { |rule_yaml| parse_http_rule rule_yaml }
          end

          http
        end

        def parse_http_rule rule_yaml
          rule = Google::Api::HttpRule.new
          rule.selector = rule_yaml[HTTP_RULES_SELECTOR_KEY] if rule_yaml.key? HTTP_RULES_SELECTOR_KEY
          verb_path = HTTP_RULES_VERBS_ALLOWED.find { |verb| rule_yaml[verb] }
          rule.send("#{verb_path}=", rule_yaml[verb_path]) if verb_path
          rule.body = rule_yaml[HTTP_RULES_BODY_KEY] if rule_yaml.key? HTTP_RULES_BODY_KEY

          if rule_yaml.key? HTTP_RULES_ADDITIONAL_BINDINGS_KEY
            rule.additional_bindings = rule_yaml[HTTP_RULES_ADDITIONAL_BINDINGS_KEY].map do |binding_yaml|
              parse_http_rule binding_yaml
            end
          end

          rule
        end
      end
    end
  end
end
