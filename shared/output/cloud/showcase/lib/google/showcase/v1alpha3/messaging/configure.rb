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
  module Showcase
    module V1alpha3
      module Messaging
        ##
        # Configure the Messaging API.
        #
        def self.configure
          @configure ||= Configure.create
          yield @configure if block_given?
          @configure
        end

        # Configuration for the Messaging API.
        class Configure
          def self.create
            Google::Gax::Configuration.create do |config|
              default_scope = Google::Gax::Configuration.deferred do
                Credentials::SCOPE
              end
              config.add_field! :host,         "localhost", match: [String]
              config.add_field! :port,         7469, match: [Integer]
              config.add_field! :scope,        default_scope,                         match: [String, Array], allow_nil: true
              config.add_field! :lib_name,     nil,                                   match: [String],        allow_nil: true
              config.add_field! :lib_version,  nil,                                   match: [String],        allow_nil: true
              config.add_field! :interceptors, [],                                    match: [Array]

              config.add_field! :timeout, 60,   match: [Numeric]
              config.add_field! :metadata, nil, match: [Hash], allow_nil: true
              config.add_config! :retry_policy do |retry_policy|
                retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
              end

              config.add_config! :methods do |methods|
                methods.add_config! :create_room do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :get_room do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :update_room do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :delete_room do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :list_rooms do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :create_blurb do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :get_blurb do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :update_blurb do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :delete_blurb do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :list_blurbs do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :search_blurbs do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :stream_blurbs do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :send_blurbs do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :connect do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
              end
            end
          end

          def self.wrap parent
            Google::Gax::Configuration.create do |config|
              config.add_field! :host,        defer_to(parent, :host),          match: [String]
              config.add_field! :port,        defer_to(parent, :port),          match: [Integer]
              config.add_field! :scope,       defer_to(parent, :scope),         match: [String, Array], allow_nil: true
              config.add_field! :lib_name,    defer_to(parent, :lib_name),      match: [String],        allow_nil: true
              config.add_field! :lib_version, defer_to(parent, :lib_version),   match: [String],        allow_nil: true
              config.add_field! :interceptors, defer_to(parent, :interceptors), match: [Array]

              config.add_field! :timeout,  defer_to(parent, :timeout),  match: [Numeric]
              config.add_field! :metadata, defer_to(parent, :metadata), match: [Hash], allow_nil: true
              config.add_config! :retry_policy do |retry_policy|
                retry_policy.add_field! :retry_codes,   defer_to(parent.retry_policy, :retry_codes),
                                        match: [Array],   allow_nil: true
                retry_policy.add_field! :initial_delay, defer_to(parent.retry_policy, :initial_delay),
                                        match: [Numeric], allow_nil: true
                retry_policy.add_field! :multiplier,    defer_to(parent.retry_policy, :multiplier),
                                        match: [Numeric], allow_nil: true
                retry_policy.add_field! :max_delay,     defer_to(parent.retry_policy, :max_delay),
                                        match: [Numeric], allow_nil: true
              end

              config.add_config! :methods do |methods|
                methods.add_config! :create_room do |method|
                  method_parent = parent.methods[:create_room]
                  method.add_field! :timeout,  defer_to(method_parent, :timeout), match: [Numeric], allow_nil: true
                  method.add_field! :metadata, defer_to(method_parent, :metadata), match: [Hash], allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :retry_codes),
                                            match: [Array], allow_nil: true
                    retry_policy.add_field! :initial_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :initial_delay),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :multiplier),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :max_delay),
                                            match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :get_room do |method|
                  method_parent = parent.methods[:get_room]
                  method.add_field! :timeout,  defer_to(method_parent, :timeout), match: [Numeric], allow_nil: true
                  method.add_field! :metadata, defer_to(method_parent, :metadata), match: [Hash], allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :retry_codes),
                                            match: [Array], allow_nil: true
                    retry_policy.add_field! :initial_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :initial_delay),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :multiplier),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :max_delay),
                                            match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :update_room do |method|
                  method_parent = parent.methods[:update_room]
                  method.add_field! :timeout,  defer_to(method_parent, :timeout), match: [Numeric], allow_nil: true
                  method.add_field! :metadata, defer_to(method_parent, :metadata), match: [Hash], allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :retry_codes),
                                            match: [Array], allow_nil: true
                    retry_policy.add_field! :initial_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :initial_delay),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :multiplier),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :max_delay),
                                            match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :delete_room do |method|
                  method_parent = parent.methods[:delete_room]
                  method.add_field! :timeout,  defer_to(method_parent, :timeout), match: [Numeric], allow_nil: true
                  method.add_field! :metadata, defer_to(method_parent, :metadata), match: [Hash], allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :retry_codes),
                                            match: [Array], allow_nil: true
                    retry_policy.add_field! :initial_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :initial_delay),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :multiplier),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :max_delay),
                                            match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :list_rooms do |method|
                  method_parent = parent.methods[:list_rooms]
                  method.add_field! :timeout,  defer_to(method_parent, :timeout), match: [Numeric], allow_nil: true
                  method.add_field! :metadata, defer_to(method_parent, :metadata), match: [Hash], allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :retry_codes),
                                            match: [Array], allow_nil: true
                    retry_policy.add_field! :initial_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :initial_delay),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :multiplier),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :max_delay),
                                            match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :create_blurb do |method|
                  method_parent = parent.methods[:create_blurb]
                  method.add_field! :timeout,  defer_to(method_parent, :timeout), match: [Numeric], allow_nil: true
                  method.add_field! :metadata, defer_to(method_parent, :metadata), match: [Hash], allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :retry_codes),
                                            match: [Array], allow_nil: true
                    retry_policy.add_field! :initial_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :initial_delay),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :multiplier),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :max_delay),
                                            match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :get_blurb do |method|
                  method_parent = parent.methods[:get_blurb]
                  method.add_field! :timeout,  defer_to(method_parent, :timeout), match: [Numeric], allow_nil: true
                  method.add_field! :metadata, defer_to(method_parent, :metadata), match: [Hash], allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :retry_codes),
                                            match: [Array], allow_nil: true
                    retry_policy.add_field! :initial_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :initial_delay),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :multiplier),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :max_delay),
                                            match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :update_blurb do |method|
                  method_parent = parent.methods[:update_blurb]
                  method.add_field! :timeout,  defer_to(method_parent, :timeout), match: [Numeric], allow_nil: true
                  method.add_field! :metadata, defer_to(method_parent, :metadata), match: [Hash], allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :retry_codes),
                                            match: [Array], allow_nil: true
                    retry_policy.add_field! :initial_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :initial_delay),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :multiplier),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :max_delay),
                                            match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :delete_blurb do |method|
                  method_parent = parent.methods[:delete_blurb]
                  method.add_field! :timeout,  defer_to(method_parent, :timeout), match: [Numeric], allow_nil: true
                  method.add_field! :metadata, defer_to(method_parent, :metadata), match: [Hash], allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :retry_codes),
                                            match: [Array], allow_nil: true
                    retry_policy.add_field! :initial_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :initial_delay),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :multiplier),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :max_delay),
                                            match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :list_blurbs do |method|
                  method_parent = parent.methods[:list_blurbs]
                  method.add_field! :timeout,  defer_to(method_parent, :timeout), match: [Numeric], allow_nil: true
                  method.add_field! :metadata, defer_to(method_parent, :metadata), match: [Hash], allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :retry_codes),
                                            match: [Array], allow_nil: true
                    retry_policy.add_field! :initial_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :initial_delay),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :multiplier),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :max_delay),
                                            match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :search_blurbs do |method|
                  method_parent = parent.methods[:search_blurbs]
                  method.add_field! :timeout,  defer_to(method_parent, :timeout), match: [Numeric], allow_nil: true
                  method.add_field! :metadata, defer_to(method_parent, :metadata), match: [Hash], allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :retry_codes),
                                            match: [Array], allow_nil: true
                    retry_policy.add_field! :initial_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :initial_delay),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :multiplier),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :max_delay),
                                            match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :stream_blurbs do |method|
                  method_parent = parent.methods[:stream_blurbs]
                  method.add_field! :timeout,  defer_to(method_parent, :timeout), match: [Numeric], allow_nil: true
                  method.add_field! :metadata, defer_to(method_parent, :metadata), match: [Hash], allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :retry_codes),
                                            match: [Array], allow_nil: true
                    retry_policy.add_field! :initial_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :initial_delay),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :multiplier),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :max_delay),
                                            match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :send_blurbs do |method|
                  method_parent = parent.methods[:send_blurbs]
                  method.add_field! :timeout,  defer_to(method_parent, :timeout), match: [Numeric], allow_nil: true
                  method.add_field! :metadata, defer_to(method_parent, :metadata), match: [Hash], allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :retry_codes),
                                            match: [Array], allow_nil: true
                    retry_policy.add_field! :initial_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :initial_delay),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :multiplier),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :max_delay),
                                            match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :connect do |method|
                  method_parent = parent.methods[:connect]
                  method.add_field! :timeout,  defer_to(method_parent, :timeout), match: [Numeric], allow_nil: true
                  method.add_field! :metadata, defer_to(method_parent, :metadata), match: [Hash], allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :retry_codes),
                                            match: [Array], allow_nil: true
                    retry_policy.add_field! :initial_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :initial_delay),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :multiplier),
                                            match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,
                                            defer_to(parent.retry_policy, method_parent.retry_policy, :max_delay),
                                            match: [Numeric], allow_nil: true
                  end
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
