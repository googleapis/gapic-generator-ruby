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

require "gapic/common"
require "gapic/config"
require "gapic/config/method"

require "google/showcase/version"
require "google/showcase/v1beta1/testing_pb"
require "google/showcase/v1beta1/testing/credentials"
require "google/showcase/v1beta1/testing/paths"

module Google
  module Showcase
    module V1beta1
      module Testing
        # Service that implements Testing API.
        class Client
          include Paths

          # @private
          attr_reader :testing_stub

          ##
          # Configuration for the Testing Client API.
          #
          # @yield [config] Configure the Client client.
          # @yieldparam config [Client::Configuration]
          #
          # @return [Client::Configuration]
          #
          def self.configure
            @configure ||= Client::Configuration.new
            yield @configure if block_given?
            @configure
          end

          ##
          # Configure the Testing Client instance.
          #
          # The configuration is set to the derived mode, meaning that values can be changed,
          # but structural changes (adding new fields, etc.) are not allowed. Structural changes
          # should be made on {Client.configure}.
          #
          # @yield [config] Configure the Client client.
          # @yieldparam config [Client::Configuration]
          #
          # @return [Client::Configuration]
          #
          def configure
            yield @config if block_given?
            @config
          end

          ##
          # Create a new Client client object.
          #
          # @yield [config] Configure the Client client.
          # @yieldparam config [Client::Configuration]
          #
          def initialize
            # These require statements are intentionally placed here to initialize
            # the gRPC module only when it's required.
            # See https://github.com/googleapis/toolkit/issues/446
            require "gapic/grpc"
            require "google/showcase/v1beta1/testing_services_pb"

            # Create the configuration object
            @config = Configuration.new Client.configure

            # Yield the configuration if needed
            yield @config if block_given?

            # Create credentials
            credentials = @config.credentials
            credentials ||= Credentials.default scope: @config.scope
            if credentials.is_a?(String) || credentials.is_a?(Hash)
              credentials = Credentials.new credentials, scope: @config.scope
            end


            @testing_stub = Gapic::ServiceStub.new(
              Google::Showcase::V1beta1::Testing::Stub,
              credentials:  credentials,
              endpoint:     @config.endpoint,
              channel_args: @config.channel_args,
              interceptors: @config.interceptors
            )
          end

          # Service calls

          ##
          # Creates a new testing session.
          #
          # @overload create_session(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::CreateSessionRequest | Hash]
          #     Creates a new testing session.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload create_session(session: nil)
          #   @param session [Google::Showcase::V1beta1::Session | Hash]
          #     The session to be created.
          #     Sessions are immutable once they are created (although they can
          #     be deleted).
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::Session]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::Session]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def create_session request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::CreateSessionRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.create_session.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            options.apply_defaults timeout:      @config.rpcs.create_session.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.create_session.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @testing_stub.call_rpc :create_session, request, options: options, operation_callback: block
          end

          ##
          # Gets a testing session.
          #
          # @overload get_session(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::GetSessionRequest | Hash]
          #     Gets a testing session.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload get_session(name: nil)
          #   @param name [String]
          #     The session to be retrieved.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::Session]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::Session]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def get_session request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::GetSessionRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.get_session.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.get_session.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.get_session.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @testing_stub.call_rpc :get_session, request, options: options, operation_callback: block
          end

          ##
          # Lists the current test sessions.
          #
          # @overload list_sessions(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::ListSessionsRequest | Hash]
          #     Lists the current test sessions.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload list_sessions(page_size: nil, page_token: nil)
          #   @param page_size [Integer]
          #     The maximum number of sessions to return per page.
          #   @param page_token [String]
          #     The page token, for retrieving subsequent pages.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Gapic::PagedEnumerable<Google::Showcase::V1beta1::Session>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Gapic::PagedEnumerable<Google::Showcase::V1beta1::Session>]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def list_sessions request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::ListSessionsRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.list_sessions.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            options.apply_defaults timeout:      @config.rpcs.list_sessions.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.list_sessions.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            paged_response = nil
            paged_operation_callback = lambda do |response, operation|
              paged_response = Gapic::PagedEnumerable.new @testing_stub, :list_sessions, request, response, operation, options
              yield paged_response, operation if block
            end
            @testing_stub.call_rpc :list_sessions, request, options: options, operation_callback: paged_operation_callback
            paged_response
          end

          ##
          # Delete a test session.
          #
          # @overload delete_session(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::DeleteSessionRequest | Hash]
          #     Delete a test session.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload delete_session(name: nil)
          #   @param name [String]
          #     The session to be deleted.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Protobuf::Empty]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Protobuf::Empty]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def delete_session request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::DeleteSessionRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.delete_session.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.delete_session.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.delete_session.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @testing_stub.call_rpc :delete_session, request, options: options, operation_callback: block
          end

          ##
          # Report on the status of a session.
          # This generates a report detailing which tests have been completed,
          # and an overall rollup.
          #
          # @overload report_session(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::ReportSessionRequest | Hash]
          #     Report on the status of a session.
          #     This generates a report detailing which tests have been completed,
          #     and an overall rollup.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload report_session(name: nil)
          #   @param name [String]
          #     The session to be reported on.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::ReportSessionResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::ReportSessionResponse]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def report_session request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::ReportSessionRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.report_session.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.report_session.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.report_session.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @testing_stub.call_rpc :report_session, request, options: options, operation_callback: block
          end

          ##
          # List the tests of a sessesion.
          #
          # @overload list_tests(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::ListTestsRequest | Hash]
          #     List the tests of a sessesion.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload list_tests(parent: nil, page_size: nil, page_token: nil)
          #   @param parent [String]
          #     The session.
          #   @param page_size [Integer]
          #     The maximum number of tests to return per page.
          #   @param page_token [String]
          #     The page token, for retrieving subsequent pages.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Gapic::PagedEnumerable<Google::Showcase::V1beta1::Test>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Gapic::PagedEnumerable<Google::Showcase::V1beta1::Test>]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def list_tests request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::ListTestsRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.list_tests.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "parent" => request.parent
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.list_tests.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.list_tests.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            paged_response = nil
            paged_operation_callback = lambda do |response, operation|
              paged_response = Gapic::PagedEnumerable.new @testing_stub, :list_tests, request, response, operation, options
              yield paged_response, operation if block
            end
            @testing_stub.call_rpc :list_tests, request, options: options, operation_callback: paged_operation_callback
            paged_response
          end

          ##
          # Explicitly decline to implement a test.
          #
          # This removes the test from subsequent `ListTests` calls, and
          # attempting to do the test will error.
          #
          # This method will error if attempting to delete a required test.
          #
          # @overload delete_test(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::DeleteTestRequest | Hash]
          #     Explicitly decline to implement a test.
          #
          #     This removes the test from subsequent `ListTests` calls, and
          #     attempting to do the test will error.
          #
          #     This method will error if attempting to delete a required test.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload delete_test(name: nil)
          #   @param name [String]
          #     The test to be deleted.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Protobuf::Empty]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Protobuf::Empty]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def delete_test request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::DeleteTestRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.delete_test.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.delete_test.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.delete_test.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @testing_stub.call_rpc :delete_test, request, options: options, operation_callback: block
          end

          ##
          # Register a response to a test.
          #
          # In cases where a test involves registering a final answer at the
          # end of the test, this method provides the means to do so.
          #
          # @overload verify_test(request, options = nil)
          #   @param request [Google::Showcase::V1beta1::VerifyTestRequest | Hash]
          #     Register a response to a test.
          #
          #     In cases where a test involves registering a final answer at the
          #     end of the test, this method provides the means to do so.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload verify_test(name: nil, answer: nil, answers: nil)
          #   @param name [String]
          #     The test to have an answer registered to it.
          #   @param answer [String]
          #     The answer from the test.
          #   @param answers [String]
          #     The answers from the test if multiple are to be checked
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1beta1::VerifyTestResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1beta1::VerifyTestResponse]
          #
          # @raise [Gapic::GapicError] if the RPC is aborted.
          #
          def verify_test request, options = nil, &block
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Showcase::V1beta1::VerifyTestRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.verify_test.metadata.to_h

            # Set x-goog-api-client header
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: Google::Showcase::VERSION

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.verify_test.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.verify_test.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @testing_stub.call_rpc :verify_test, request, options: options, operation_callback: block
          end

          class Configuration
            extend Gapic::Config

            config_attr :endpoint,     "localhost:7469", String
            config_attr :credentials,  nil do |value|
              allowed = [::String, ::Hash, ::Proc, ::Google::Auth::Credentials, ::Signet::OAuth2::Client, nil]
              allowed += [::GRPC::Core::Channel, ::GRPC::Core::ChannelCredentials] if defined? ::GRPC
              allowed.any? { |klass| klass === value }
            end
            config_attr :scope,        nil, String, Array, nil
            config_attr :lib_name,     nil, String, nil
            config_attr :lib_version,  nil, String, nil
            config_attr(:channel_args, { "grpc.service_config_disable_resolution"=>1 }, Hash, nil)
            config_attr :interceptors, nil, Array, nil
            config_attr :timeout,      nil, Numeric, nil
            config_attr :metadata,     nil, Hash, nil
            config_attr :retry_policy, nil, Hash, Proc, nil

            def initialize parent_config = nil
              @parent_config = parent_config unless parent_config.nil?

              yield self if block_given?
            end

            def rpcs
              @rpcs ||= begin
                parent_rpcs = nil
                parent_rpcs = @parent_config.rpcs if @parent_config&.respond_to? :rpcs
                Rpcs.new parent_rpcs
              end
            end

            class Rpcs
              attr_reader :create_session
              attr_reader :get_session
              attr_reader :list_sessions
              attr_reader :delete_session
              attr_reader :report_session
              attr_reader :list_tests
              attr_reader :delete_test
              attr_reader :verify_test

              def initialize parent_rpcs = nil
                create_session_config = nil
                create_session_config = parent_rpcs&.create_session if parent_rpcs&.respond_to? :create_session
                @create_session = Gapic::Config::Method.new create_session_config
                get_session_config = nil
                get_session_config = parent_rpcs&.get_session if parent_rpcs&.respond_to? :get_session
                @get_session = Gapic::Config::Method.new get_session_config
                list_sessions_config = nil
                list_sessions_config = parent_rpcs&.list_sessions if parent_rpcs&.respond_to? :list_sessions
                @list_sessions = Gapic::Config::Method.new list_sessions_config
                delete_session_config = nil
                delete_session_config = parent_rpcs&.delete_session if parent_rpcs&.respond_to? :delete_session
                @delete_session = Gapic::Config::Method.new delete_session_config
                report_session_config = nil
                report_session_config = parent_rpcs&.report_session if parent_rpcs&.respond_to? :report_session
                @report_session = Gapic::Config::Method.new report_session_config
                list_tests_config = nil
                list_tests_config = parent_rpcs&.list_tests if parent_rpcs&.respond_to? :list_tests
                @list_tests = Gapic::Config::Method.new list_tests_config
                delete_test_config = nil
                delete_test_config = parent_rpcs&.delete_test if parent_rpcs&.respond_to? :delete_test
                @delete_test = Gapic::Config::Method.new delete_test_config
                verify_test_config = nil
                verify_test_config = parent_rpcs&.verify_test if parent_rpcs&.respond_to? :verify_test
                @verify_test = Gapic::Config::Method.new verify_test_config

                yield self if block_given?
              end
            end
          end
        end
      end
    end
  end
end

# rubocop:disable Lint/HandleExceptions

# Once client is loaded, load helpers.rb if it exists.
begin
  require "google/showcase/v1beta1/testing/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
