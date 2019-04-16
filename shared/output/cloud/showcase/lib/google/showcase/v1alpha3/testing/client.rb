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

require "json"
require "pathname"

require "google/gax"
require "google/gax/operation"
require "google/longrunning/operations_client"

require "google/showcase/version"
require "google/showcase/v1alpha3/testing_pb"
require "google/showcase/v1alpha3/testing/credentials"
require "google/showcase/v1alpha3/testing/paths"

module Google
  module Showcase
    module V1alpha3
      module Testing
        # Service that implements Testing API.
        class Client
          include Paths

          # @private
          attr_reader :testing_stub

          # The default address of the service.
          SERVICE_ADDRESS = "localhost"

          # The default port of the service.
          DEFAULT_SERVICE_PORT = 7469

          # rubocop:disable Style/MutableConstant

          # The default set of gRPC interceptors.
          GRPC_INTERCEPTORS = []

          # rubocop:enable Style/MutableConstant

          DEFAULT_TIMEOUT = 30

          # The scopes needed to make gRPC calls to all of the methods defined
          # in this service.
          ALL_SCOPES = [].freeze

          # @private
          class OperationsClient < Google::Longrunning::OperationsClient
            SERVICE_ADDRESS = Client::SERVICE_ADDRESS
            GRPC_INTERCEPTORS = Client::GRPC_INTERCEPTORS.dup
          end

          ##
          # @param credentials [Google::Auth::Credentials, String, Hash,
          #   GRPC::Core::Channel, GRPC::Core::ChannelCredentials, Proc]
          #   Provides the means for authenticating requests made by the client. This
          #   parameter can be many types.
          #   A `Google::Auth::Credentials` uses a the properties of its represented
          #   keyfile for authenticating requests made by this client.
          #   A `String` will be treated as the path to the keyfile to be used for the
          #   construction of credentials for this client.
          #   A `Hash` will be treated as the contents of a keyfile to be used for the
          #   construction of credentials for this client.
          #   A `GRPC::Core::Channel` will be used to make calls through.
          #   A `GRPC::Core::ChannelCredentials` for the setting up the RPC client. The
          #   channel credentials should already be composed with a
          #   `GRPC::Core::CallCredentials` object.
          #   A `Proc` will be used as an updater_proc for the Grpc channel. The proc
          #   transforms the metadata for requests, generally, to give OAuth credentials.
          # @param scopes [Array<String>]
          #   The OAuth scopes for this service. This parameter is ignored if an
          #   updater_proc is supplied.
          # @param timeout [Numeric]
          #   The default timeout, in seconds, for calls made through this client.
          # @param metadata [Hash]
          #   Default metadata to be sent with each request. This can be overridden on a
          #   per call basis.
          #
          def initialize \
              credentials: nil,
              scopes: ALL_SCOPES,
              timeout: DEFAULT_TIMEOUT,
              metadata: nil,
              lib_name: nil,
              lib_version: ""
            # These require statements are intentionally placed here to initialize
            # the gRPC module only when it's required.
            # See https://github.com/googleapis/toolkit/issues/446
            require "google/gax/grpc"
            require "google/showcase/v1alpha3/testing_services_pb"

            credentials ||= Credentials.default

            @operations_client = OperationsClient.new(
              credentials: credentials,
              scopes:      scopes,
              timeout:     timeout,
              lib_name:    lib_name,
              lib_version: lib_version
            )
            @testing_stub = create_stub credentials, scopes

            @timeout = timeout
            @metadata = metadata.to_h
            @metadata["x-goog-api-client"] ||= x_goog_api_client_header lib_name, lib_version
          end

          # Service calls

          ##
          # Creates a new testing session.
          #
          # @overload create_session(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::CreateSessionRequest | Hash]
          #     Creates a new testing session.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload create_session(session: nil, options: nil)
          #   @param session [Google::Showcase::V1alpha3::Session | Hash]
          #     The session to be created.
          #     Sessions are immutable once they are created (although they can
          #     be deleted).
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::Session]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::Session]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def create_session request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            # request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::CreateSessionRequest
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::CreateSessionRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            header_params = {} # { name: request.name }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata = @metadata.merge "x-goog-request-params" => request_params_header
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.merge timeout: @timeout, metadata: metadata, retry_policy: retry_policy

            @create_session ||= Google::Gax::ApiCall.new @testing_stub.method :create_session
            @create_session.call request, options: options, on_operation: block
          end

          ##
          # Gets a testing session.
          #
          # @overload get_session(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::GetSessionRequest | Hash]
          #     Gets a testing session.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload get_session(name: nil, options: nil)
          #   @param name [String]
          #     The session to be retrieved.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::Session]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::Session]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def get_session request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            # request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::GetSessionRequest
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::GetSessionRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            header_params = {} # { name: request.name }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata = @metadata.merge "x-goog-request-params" => request_params_header
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.merge timeout: @timeout, metadata: metadata, retry_policy: retry_policy

            @get_session ||= Google::Gax::ApiCall.new @testing_stub.method :get_session
            @get_session.call request, options: options, on_operation: block
          end

          ##
          # Lists the current test sessions.
          #
          # @overload list_sessions(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::ListSessionsRequest | Hash]
          #     Lists the current test sessions.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload list_sessions(page_size: nil, page_token: nil, options: nil)
          #   @param page_size [Integer]
          #     The maximum number of sessions to return per page.
          #   @param page_token [String]
          #     The page token, for retrieving subsequent pages.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::ListSessionsResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::ListSessionsResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def list_sessions request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            # request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::ListSessionsRequest
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::ListSessionsRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            header_params = {} # { name: request.name }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata = @metadata.merge "x-goog-request-params" => request_params_header
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.merge timeout: @timeout, metadata: metadata, retry_policy: retry_policy

            @list_sessions ||= Google::Gax::ApiCall.new @testing_stub.method :list_sessions
            @list_sessions.call request, options: options, on_operation: block
          end

          ##
          # Delete a test session.
          #
          # @overload delete_session(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::DeleteSessionRequest | Hash]
          #     Delete a test session.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload delete_session(name: nil, options: nil)
          #   @param name [String]
          #     The session to be deleted.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Protobuf::Empty]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Protobuf::Empty]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def delete_session request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            # request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::DeleteSessionRequest
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::DeleteSessionRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            header_params = {} # { name: request.name }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata = @metadata.merge "x-goog-request-params" => request_params_header
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.merge timeout: @timeout, metadata: metadata, retry_policy: retry_policy

            @delete_session ||= Google::Gax::ApiCall.new @testing_stub.method :delete_session
            @delete_session.call request, options: options, on_operation: block
          end

          ##
          # Report on the status of a session.
          # This generates a report detailing which tests have been completed,
          # and an overall rollup.
          #
          # @overload report_session(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::ReportSessionRequest | Hash]
          #     Report on the status of a session.
          #     This generates a report detailing which tests have been completed,
          #     and an overall rollup.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload report_session(name: nil, options: nil)
          #   @param name [String]
          #     The session to be reported on.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::ReportSessionResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::ReportSessionResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def report_session request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            # request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::ReportSessionRequest
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::ReportSessionRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            header_params = {} # { name: request.name }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata = @metadata.merge "x-goog-request-params" => request_params_header
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.merge timeout: @timeout, metadata: metadata, retry_policy: retry_policy

            @report_session ||= Google::Gax::ApiCall.new @testing_stub.method :report_session
            @report_session.call request, options: options, on_operation: block
          end

          ##
          # List the tests of a sessesion.
          #
          # @overload list_tests(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::ListTestsRequest | Hash]
          #     List the tests of a sessesion.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload list_tests(parent: nil, page_size: nil, page_token: nil, options: nil)
          #   @param parent [String]
          #     The session.
          #   @param page_size [Integer]
          #     The maximum number of tests to return per page.
          #   @param page_token [String]
          #     The page token, for retrieving subsequent pages.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::ListTestsResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::ListTestsResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def list_tests request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            # request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::ListTestsRequest
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::ListTestsRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            header_params = {} # { name: request.name }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata = @metadata.merge "x-goog-request-params" => request_params_header
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.merge timeout: @timeout, metadata: metadata, retry_policy: retry_policy

            @list_tests ||= Google::Gax::ApiCall.new @testing_stub.method :list_tests
            @list_tests.call request, options: options, on_operation: block
          end

          ##
          # Explicitly decline to implement a test.
          #
          # This removes the test from subsequent `ListTests` calls, and
          # attempting to do the test will error.
          #
          # This method will error if attempting to delete a required test.
          #
          # @overload delete_test(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::DeleteTestRequest | Hash]
          #     Explicitly decline to implement a test.
          #
          #     This removes the test from subsequent `ListTests` calls, and
          #     attempting to do the test will error.
          #
          #     This method will error if attempting to delete a required test.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload delete_test(name: nil, options: nil)
          #   @param name [String]
          #     The test to be deleted.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Protobuf::Empty]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Protobuf::Empty]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def delete_test request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            # request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::DeleteTestRequest
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::DeleteTestRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            header_params = {} # { name: request.name }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata = @metadata.merge "x-goog-request-params" => request_params_header
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.merge timeout: @timeout, metadata: metadata, retry_policy: retry_policy

            @delete_test ||= Google::Gax::ApiCall.new @testing_stub.method :delete_test
            @delete_test.call request, options: options, on_operation: block
          end

          ##
          # Register a response to a test.
          #
          # In cases where a test involves registering a final answer at the
          # end of the test, this method provides the means to do so.
          #
          # @overload verify_test(request, options: nil)
          #   @param request [Google::Showcase::V1alpha3::VerifyTestRequest | Hash]
          #     Register a response to a test.
          #
          #     In cases where a test involves registering a final answer at the
          #     end of the test, this method provides the means to do so.
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @overload verify_test(name: nil, answer: nil, answers: nil, options: nil)
          #   @param name [String]
          #     The test to have an answer registered to it.
          #   @param answer [String]
          #     The answer from the test.
          #   @param answers [String]
          #     The answers from the test if multiple are to be checked
          #   @param options [Google::Gax::ApiCall::Options, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Showcase::V1alpha3::VerifyTestResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Showcase::V1alpha3::VerifyTestResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   TODO
          #
          def verify_test request = nil, options: nil, **request_fields, &block
            raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
            if !request.nil? && !request_fields.empty?
              raise ArgumentError, "cannot pass both request object and named arguments"
            end

            request ||= request_fields
            # request = Google::Gax::Protobuf.coerce request, to: Google::Showcase::V1alpha3::VerifyTestRequest
            request = Google::Gax.to_proto request, Google::Showcase::V1alpha3::VerifyTestRequest

            # Converts hash and nil to an options object
            options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

            # Customize the options with defaults
            header_params = {} # { name: request.name }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata = @metadata.merge "x-goog-request-params" => request_params_header
            retry_policy = {} # retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE] }
            options.merge timeout: @timeout, metadata: metadata, retry_policy: retry_policy

            @verify_test ||= Google::Gax::ApiCall.new @testing_stub.method :verify_test
            @verify_test.call request, options: options, on_operation: block
          end

          protected

          def create_stub credentials, scopes
            if credentials.is_a?(String) || credentials.is_a?(Hash)
              updater_proc = Credentials.new(credentials).updater_proc
            elsif credentials.is_a? GRPC::Core::Channel
              channel = credentials
            elsif credentials.is_a? GRPC::Core::ChannelCredentials
              chan_creds = credentials
            elsif credentials.is_a? Proc
              updater_proc = credentials
            elsif credentials.is_a? Google::Auth::Credentials
              updater_proc = credentials.updater_proc
            end

            # Allow overriding the service path/port in subclasses.
            service_path = self.class::SERVICE_ADDRESS
            port = self.class::DEFAULT_SERVICE_PORT
            interceptors = self.class::GRPC_INTERCEPTORS
            stub_new = Google::Showcase::V1alpha3::Testing::Stub.method :new
            Google::Gax::Grpc.create_stub(
              service_path,
              port,
              chan_creds:   chan_creds,
              channel:      channel,
              updater_proc: updater_proc,
              scopes:       scopes,
              interceptors: interceptors,
              &stub_new
            )
          end

          def x_goog_api_client_header lib_name, lib_version
            x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
            x_goog_api_client_header << "#{lib_name}/#{lib_version}" if lib_name
            x_goog_api_client_header << "gapic/#{Google::Showcase::VERSION}"
            x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
            x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
            x_goog_api_client_header.join " "
          end
        end
      end
    end
  end
end

# rubocop:disable Lint/HandleExceptions

# Once client is loaded, load helpers.rb if it exists.
begin
  require "google/showcase/v1alpha3/testing/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
