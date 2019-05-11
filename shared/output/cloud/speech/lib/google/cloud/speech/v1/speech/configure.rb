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

require "google/gax"
require "google/gax/configuration"

module Google
  module Cloud
    module Speech
      module V1
        module Speech
          ##
          # Configure the Speech API.
          #
          def self.configure
            @configure ||= Configure.create
            yield @configure if block_given?
            @configure
          end

          # Configuration for the Speech API.
          class Configure
            def self.create
              Google::Gax::Configuration.new do |config|
                default_scope = Google::Gax::Configuration.deferred do
                  Credentials::SCOPE
                end
                config.add_field! :host,         "speech.googleapis.com", match: [String]
                config.add_field! :port,         443, match: [Integer]
                config.add_field! :scope,        default_scope,                         match: [String, Array], allow_nil: true
                config.add_field! :lib_name,     nil,                                   match: [String],        allow_nil: true
                config.add_field! :lib_version,  nil,                                   match: [String],        allow_nil: true
                config.add_field! :interceptors, [],                                    match: [Array]

                config.add_field! :timeout,     60,  match: [Numeric]
                config.add_field! :metadata,    nil, match: [Hash],       allow_nil: true
                config.add_field! :retry_codes, nil, match: [Hash, Proc], allow_nil: true

                config.add_config! :methods do |methods|
                  methods.add_config! :recognize do |method|
                    method.add_field! :timeout,     nil, match: [Numeric],    allow_nil: true
                    method.add_field! :metadata,    nil, match: [Hash],       allow_nil: true
                    method.add_field! :retry_codes, nil, match: [Hash, Proc], allow_nil: true
                  end
                  methods.add_config! :long_running_recognize do |method|
                    method.add_field! :timeout,     nil, match: [Numeric],    allow_nil: true
                    method.add_field! :metadata,    nil, match: [Hash],       allow_nil: true
                    method.add_field! :retry_codes, nil, match: [Hash, Proc], allow_nil: true
                  end
                  methods.add_config! :streaming_recognize do |method|
                    method.add_field! :timeout,     nil, match: [Numeric],    allow_nil: true
                    method.add_field! :metadata,    nil, match: [Hash],       allow_nil: true
                    method.add_field! :retry_codes, nil, match: [Hash, Proc], allow_nil: true
                  end
                end
              end
            end

            def self.wrap parent
              Google::Gax::Configuration.new do |config|
                config.add_field! :host,        defer_to(parent, :host),          match: [String]
                config.add_field! :port,        defer_to(parent, :port),          match: [Integer]
                config.add_field! :scope,       defer_to(parent, :scope),         match: [String, Array], allow_nil: true
                config.add_field! :lib_name,    defer_to(parent, :lib_name),      match: [String],        allow_nil: true
                config.add_field! :lib_version, defer_to(parent, :lib_version),   match: [String],        allow_nil: true
                config.add_field! :interceptors, defer_to(parent, :interceptors), match: [Array]

                config.add_field! :timeout,     defer_to(parent, :timeout),     match: [Numeric]
                config.add_field! :metadata,    defer_to(parent, :metadata),    match: [Hash],       allow_nil: true
                config.add_field! :retry_codes, defer_to(parent, :retry_codes), match: [Hash, Proc], allow_nil: true

                config.add_config! :methods do |methods|
                  methods.add_config! :recognize do |method|
                    method_parent = parent.methods[:recognize]
                    method.add_field! :timeout,     defer_to(method_parent, :timeout),     match: [Numeric],    allow_nil: true
                    method.add_field! :metadata,    defer_to(method_parent, :metadata),    match: [Hash],       allow_nil: true
                    method.add_field! :retry_codes, defer_to(method_parent, :retry_codes), match: [Hash, Proc], allow_nil: true
                  end
                  methods.add_config! :long_running_recognize do |method|
                    method_parent = parent.methods[:long_running_recognize]
                    method.add_field! :timeout,     defer_to(method_parent, :timeout),     match: [Numeric],    allow_nil: true
                    method.add_field! :metadata,    defer_to(method_parent, :metadata),    match: [Hash],       allow_nil: true
                    method.add_field! :retry_codes, defer_to(method_parent, :retry_codes), match: [Hash, Proc], allow_nil: true
                  end
                  methods.add_config! :streaming_recognize do |method|
                    method_parent = parent.methods[:streaming_recognize]
                    method.add_field! :timeout,     defer_to(method_parent, :timeout),     match: [Numeric],    allow_nil: true
                    method.add_field! :metadata,    defer_to(method_parent, :metadata),    match: [Hash],       allow_nil: true
                    method.add_field! :retry_codes, defer_to(method_parent, :retry_codes), match: [Hash, Proc], allow_nil: true
                  end
                end
              end
            end

            # @private
            def self.defer_to parent = nil, config, field
              if parent
                return Google::Gax::Configuration.deferred do
                  config[field] || parent[field]
                end
              end

              Google::Gax::Configuration.deferred do
                config[field]
              end
            end
            private_class_method :defer_to
          end
        end
      end
    end
  end
end
