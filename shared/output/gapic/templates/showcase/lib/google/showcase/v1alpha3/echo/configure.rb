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
require "google/showcase/v1alpha3/echo/credentials"

module Google
  module Showcase
    module V1alpha3
      module Echo
        ##
        # Configuration for the Echo API.
        #
        def self.configure
          @configure ||= Google::Gax::Configuration.new do |config|
            default_scope = Google::Gax::Configuration.deferred do
              Credentials::SCOPE
            end
            config.add_field! :host,         "localhost", match: [String]
            config.add_field! :port,         7469, match: [Integer]
            config.add_field! :scope,        default_scope,                         match: [String, Array], allow_nil: true
            config.add_field! :lib_name,     nil,                                   match: [String],        allow_nil: true
            config.add_field! :lib_version,  nil,                                   match: [String],        allow_nil: true
            config.add_field! :interceptors, [],                                    match: [Array]

            config.add_field! :timeout,     60,  match: [Numeric]
            config.add_field! :metadata,    nil, match: [Hash],       allow_nil: true
            config.add_field! :retry_codes, nil, match: [Hash, Proc], allow_nil: true

            config.add_config! :methods do |methods|
              methods.add_config! :echo do |method|
                method.add_field! :timeout,     nil, match: [Numeric],    allow_nil: true
                method.add_field! :metadata,    nil, match: [Hash],       allow_nil: true
                method.add_field! :retry_codes, nil, match: [Hash, Proc], allow_nil: true
              end
              methods.add_config! :expand do |method|
                method.add_field! :timeout,     nil, match: [Numeric],    allow_nil: true
                method.add_field! :metadata,    nil, match: [Hash],       allow_nil: true
                method.add_field! :retry_codes, nil, match: [Hash, Proc], allow_nil: true
              end
              methods.add_config! :collect do |method|
                method.add_field! :timeout,     nil, match: [Numeric],    allow_nil: true
                method.add_field! :metadata,    nil, match: [Hash],       allow_nil: true
                method.add_field! :retry_codes, nil, match: [Hash, Proc], allow_nil: true
              end
              methods.add_config! :chat do |method|
                method.add_field! :timeout,     nil, match: [Numeric],    allow_nil: true
                method.add_field! :metadata,    nil, match: [Hash],       allow_nil: true
                method.add_field! :retry_codes, nil, match: [Hash, Proc], allow_nil: true
              end
              methods.add_config! :paged_expand do |method|
                method.add_field! :timeout,     nil, match: [Numeric],    allow_nil: true
                method.add_field! :metadata,    nil, match: [Hash],       allow_nil: true
                method.add_field! :retry_codes, nil, match: [Hash, Proc], allow_nil: true
              end
              methods.add_config! :wait do |method|
                method.add_field! :timeout,     nil, match: [Numeric],    allow_nil: true
                method.add_field! :metadata,    nil, match: [Hash],       allow_nil: true
                method.add_field! :retry_codes, nil, match: [Hash, Proc], allow_nil: true
              end
            end
          end
          yield @configure if block_given?
          @configure
        end
      end
    end
  end
end
