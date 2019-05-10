# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright <YEAR> <COPYRIGHT HOLDER>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require "google/gax"
require "google/gax/configuration"

module Google
  module Showcase
    module V1alpha3
      module Testing
        ##
        # Configure the Testing API.
        #
        def self.configure
          @configure ||= Configure.create
          yield @configure if block_given?
          @configure
        end

        # Configuration for the Testing API.
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
                methods.add_config! :create_session do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :get_session do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :list_sessions do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :delete_session do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :report_session do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :list_tests do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :delete_test do |method|
                  method.add_field! :timeout,  nil, match: [Numeric], allow_nil: true
                  method.add_field! :metadata, nil, match: [Hash],    allow_nil: true
                  method.add_config! :retry_policy do |retry_policy|
                    retry_policy.add_field! :retry_codes,   nil, match: [Array],   allow_nil: true
                    retry_policy.add_field! :initial_delay, nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :multiplier,    nil, match: [Numeric], allow_nil: true
                    retry_policy.add_field! :max_delay,     nil, match: [Numeric], allow_nil: true
                  end
                end
                methods.add_config! :verify_test do |method|
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
                methods.add_config! :create_session do |method|
                  method_parent = parent.methods[:create_session]
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
                methods.add_config! :get_session do |method|
                  method_parent = parent.methods[:get_session]
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
                methods.add_config! :list_sessions do |method|
                  method_parent = parent.methods[:list_sessions]
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
                methods.add_config! :delete_session do |method|
                  method_parent = parent.methods[:delete_session]
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
                methods.add_config! :report_session do |method|
                  method_parent = parent.methods[:report_session]
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
                methods.add_config! :list_tests do |method|
                  method_parent = parent.methods[:list_tests]
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
                methods.add_config! :delete_test do |method|
                  method_parent = parent.methods[:delete_test]
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
                methods.add_config! :verify_test do |method|
                  method_parent = parent.methods[:verify_test]
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
