# Copyright 2024 Google LLC
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

require "google/cloud/env"
require "google/logging/message"
require "google/logging/structured_formatter"

module Gapic
  ##
  # A mixin module that handles logging setup for a stub.
  #
  module LoggingConcerns
    ##
    # The logger for this object.
    #
    # @return [Logger]
    #
    attr_reader :logger

    ##
    # @private
    # A convenience object used by stub-based logging.
    #
    class StubLogger
      OMIT_FILES = [
        /^#{Regexp.escape __dir__}/
      ].freeze

      def initialize logger: nil, **kwargs
        @logger = logger
        @kwargs = kwargs
      end

      def log severity
        return unless @logger
        locations = caller_locations
        @logger.add severity do
          builder = LogEntryBuilder.new(**@kwargs)
          builder.set_source_location_from locations
          yield builder
          builder.build
        rescue StandardError
          # Do nothing
        end
      end

      def info &block
        log Logger::INFO, &block
      end

      def debug &block
        log Logger::DEBUG, &block
      end

      ##
      # @private
      # Builder for a log entry, passed to {StubLogger#log}.
      #
      class LogEntryBuilder
        def initialize system_name: nil,
                       service: nil,
                       endpoint: nil,
                       client_id: nil
          @system_name = system_name
          @service = service
          @endpoint = endpoint
          @client_id = client_id
          @message = nil
          @caller_locations = caller_locations
          @fields = { "clientId" => @client_id }
        end

        attr_reader :system_name

        attr_reader :service

        attr_reader :endpoint

        attr_accessor :message

        attr_writer :source_location

        attr_reader :fields

        def set name, value
          fields[name] = value
        end

        def set_system_name
          set "system", system_name
        end

        def set_service
          set "serviceName", service
        end

        def set_credentials_fields creds
          creds = creds.client if creds.respond_to? :client
          set "credentialsId", creds.object_id
          set "credentialsType", creds.class.name
          set "credentialsScope", creds.scope if creds.respond_to? :scope
          set "useSelfSignedJWT", creds.enable_self_signed_jwt? if creds.respond_to? :enable_self_signed_jwt?
          set "universeDomain", creds.universe_domain if creds.respond_to? :universe_domain
        end

        def source_location
          @source_location ||= Google::Logging::SourceLocation.for_caller omit_files: OMIT_FILES,
                                                                          locations: @caller_locations
        end

        def set_source_location_from locations
          @caller_locations = locations
          @source_location = nil
        end

        def build
          Google::Logging::Message.from message: message, source_location: source_location, fields: fields
        end
      end
    end

    ##
    # @private
    # Initialize logging concerns.
    #
    def setup_logging logger: :default,
                      stream: nil,
                      formatter: nil,
                      level: nil,
                      system_name: nil,
                      service: nil,
                      endpoint: nil,
                      client_id: nil
      service = LoggingConcerns.normalize_service service
      system_name = LoggingConcerns.normalize_system_name system_name
      logging_env = ENV["GOOGLE_SDK_RUBY_LOGGING_GEMS"].to_s.downcase
      logger = nil if ["false", "none"].include? logging_env
      if logger == :default
        logger = nil
        if ["true", "all"].include?(logging_env) || logging_env.split(",").include?(system_name)
          stream ||= $stderr
          level ||= "DEBUG"
          formatter ||= Google::Logging::StructuredFormatter.new if Google::Cloud::Env.get.logging_agent_expected?
          logger = Logger.new stream, progname: system_name, level: level, formatter: formatter
        end
      end
      @logger = logger
      @stub_logger = StubLogger.new logger: logger,
                                    system_name: system_name,
                                    service: service,
                                    endpoint: endpoint,
                                    client_id: client_id
    end

    # @private
    attr_reader :stub_logger

    class << self
      # @private
      def random_uuid4
        ary = Random.bytes 16
        ary.setbyte 6, ((ary.getbyte(6) & 0x0f) | 0x40)
        ary.setbyte 8, ((ary.getbyte(8) & 0x3f) | 0x80)
        ary.unpack("H8H4H4H4H12").join "-"
      end

      # @private
      def normalize_system_name input
        case input
        when String
          input
        when Class
          input.name.split("::")[..-3]
               .map { |elem| elem.scan(/[A-Z][A-Z]*(?=[A-Z][a-z0-9]|$)|[A-Z][a-z0-9]+/).map(&:downcase).join("_") }
               .join("-")
        else
          "googleapis"
        end
      end

      # @private
      def normalize_service input
        case input
        when String
          input
        when Class
          mod = input.name.split("::")[..-2].inject(Object) { |m, n| m.const_get n }
          if mod.const_defined? "Service"
            mod.const_get("Service").service_name
          else
            name_segments = input.name.split("::")[..-3]
            mod = name_segments.inject(Object) { |m, n| m.const_get n }
            name_segments.join "." if mod.const_defined? "Rest"
          end
        end
      end
    end
  end
end
