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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!

require "google/showcase/v1beta1/testing_pb"
require "google/showcase/v1beta1/testing/rest/service_stub"

module Google
  module Showcase
    module V1beta1
      module Testing
        module Rest
          ##
          # REST client for the Testing service.
          #
          # A service to facilitate running discrete sets of tests
          # against Showcase.
          #
          class Client
            include Paths

            # @private
            attr_reader :testing_stub

            ##
            # Configure the Testing Client class.
            #
            # See {::Google::Showcase::V1beta1::Testing::Rest::Client::Configuration}
            # for a description of the configuration fields.
            #
            # @example
            #
            #   # Modify the configuration for all Testing clients
            #   ::Google::Showcase::V1beta1::Testing::Rest::Client.configure do |config|
            #     config.timeout = 10.0
            #   end
            #
            # @yield [config] Configure the Client client.
            # @yieldparam config [Client::Configuration]
            #
            # @return [Client::Configuration]
            #
            def self.configure
              @configure ||= begin
                default_config = Client::Configuration.new

                default_config
              end
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
            # See {::Google::Showcase::V1beta1::Testing::Rest::Client::Configuration}
            # for a description of the configuration fields.
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
            # Create a new Testing REST client object.
            #
            # @example
            #
            #   # Create a client using the default configuration
            #   client = ::Google::Showcase::V1beta1::Testing::Rest::Client.new
            #
            #   # Create a client using a custom configuration
            #   client = ::Google::Showcase::V1beta1::Testing::Rest::Client.new do |config|
            #     config.timeout = 10.0
            #   end
            #
            # @yield [config] Configure the Testing client.
            # @yieldparam config [Client::Configuration]
            #
            def initialize
              # Create the configuration object
              @config = Configuration.new Client.configure

              # Yield the configuration if needed
              yield @config if block_given?

              # Create credentials
              credentials = @config.credentials
              credentials ||= Credentials.default scope: @config.scope
              if credentials.is_a?(::String) || credentials.is_a?(::Hash)
                credentials = Credentials.new credentials, scope: @config.scope
              end

              @testing_stub = ::Google::Showcase::V1beta1::Testing::Rest::ServiceStub.new endpoint: @config.endpoint,
                                                                                          credentials: credentials
            end

            # Service calls

            ##
            # Creates a new testing session.
            #
            # @overload create_session(request, options = nil)
            #   Pass arguments to `create_session` via a request object, either of type
            #   {::Google::Showcase::V1beta1::CreateSessionRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Showcase::V1beta1::CreateSessionRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #     Note: currently retry functionality is not implemented. While it is possible
            #     to set it using ::Gapic::CallOptions, it will not be applied
            #
            # @overload create_session(session: nil)
            #   Pass arguments to `create_session` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param session [::Google::Showcase::V1beta1::Session, ::Hash]
            #     The session to be created.
            #     Sessions are immutable once they are created (although they can
            #     be deleted).
            #
            # @return [::Google::Showcase::V1beta1::Session]
            #
            # @raise [::Gapic::Rest::Error] if the REST call is aborted.
            def create_session request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Showcase::V1beta1::CreateSessionRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              call_metadata = @config.rpcs.create_session.metadata.to_h

              # Set x-goog-api-client header
              call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Showcase::VERSION,
                transports_version_send: [:rest]

              options.apply_defaults timeout:      @config.rpcs.create_session.timeout,
                                     metadata:     call_metadata

              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata

              @testing_stub.create_session request, options do |result, response|
                yield result, response if block_given?
                return result
              end
            rescue ::Faraday::Error => e
              raise ::Gapic::Rest::Error.wrap_faraday_error e
            end

            ##
            # Gets a testing session.
            #
            # @overload get_session(request, options = nil)
            #   Pass arguments to `get_session` via a request object, either of type
            #   {::Google::Showcase::V1beta1::GetSessionRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Showcase::V1beta1::GetSessionRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #     Note: currently retry functionality is not implemented. While it is possible
            #     to set it using ::Gapic::CallOptions, it will not be applied
            #
            # @overload get_session(name: nil)
            #   Pass arguments to `get_session` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param name [::String]
            #     The session to be retrieved.
            #
            # @return [::Google::Showcase::V1beta1::Session]
            #
            # @raise [::Gapic::Rest::Error] if the REST call is aborted.
            def get_session request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Showcase::V1beta1::GetSessionRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              call_metadata = @config.rpcs.get_session.metadata.to_h

              # Set x-goog-api-client header
              call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Showcase::VERSION,
                transports_version_send: [:rest]

              options.apply_defaults timeout:      @config.rpcs.get_session.timeout,
                                     metadata:     call_metadata

              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata

              @testing_stub.get_session request, options do |result, response|
                yield result, response if block_given?
                return result
              end
            rescue ::Faraday::Error => e
              raise ::Gapic::Rest::Error.wrap_faraday_error e
            end

            ##
            # Lists the current test sessions.
            #
            # @overload list_sessions(request, options = nil)
            #   Pass arguments to `list_sessions` via a request object, either of type
            #   {::Google::Showcase::V1beta1::ListSessionsRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Showcase::V1beta1::ListSessionsRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #     Note: currently retry functionality is not implemented. While it is possible
            #     to set it using ::Gapic::CallOptions, it will not be applied
            #
            # @overload list_sessions(page_size: nil, page_token: nil)
            #   Pass arguments to `list_sessions` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param page_size [::Integer]
            #     The maximum number of sessions to return per page.
            #   @param page_token [::String]
            #     The page token, for retrieving subsequent pages.
            #
            # @return [::Gapic::Rest::PagedEnumerable<::Google::Showcase::V1beta1::Session>]
            #
            # @raise [::Gapic::Rest::Error] if the REST call is aborted.
            def list_sessions request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Showcase::V1beta1::ListSessionsRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              call_metadata = @config.rpcs.list_sessions.metadata.to_h

              # Set x-goog-api-client header
              call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Showcase::VERSION,
                transports_version_send: [:rest]

              options.apply_defaults timeout:      @config.rpcs.list_sessions.timeout,
                                     metadata:     call_metadata

              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata

              @testing_stub.list_sessions request, options do |result, response|
                result = ::Gapic::Rest::PagedEnumerable.new @testing_stub, :list_sessions, "sessions", request, result,
                                                            options
                yield result, response if block_given?
                return result
              end
            rescue ::Faraday::Error => e
              raise ::Gapic::Rest::Error.wrap_faraday_error e
            end

            ##
            # Delete a test session.
            #
            # @overload delete_session(request, options = nil)
            #   Pass arguments to `delete_session` via a request object, either of type
            #   {::Google::Showcase::V1beta1::DeleteSessionRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Showcase::V1beta1::DeleteSessionRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #     Note: currently retry functionality is not implemented. While it is possible
            #     to set it using ::Gapic::CallOptions, it will not be applied
            #
            # @overload delete_session(name: nil)
            #   Pass arguments to `delete_session` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param name [::String]
            #     The session to be deleted.
            #
            # @return [::Google::Protobuf::Empty]
            #
            # @raise [::Gapic::Rest::Error] if the REST call is aborted.
            def delete_session request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Showcase::V1beta1::DeleteSessionRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              call_metadata = @config.rpcs.delete_session.metadata.to_h

              # Set x-goog-api-client header
              call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Showcase::VERSION,
                transports_version_send: [:rest]

              options.apply_defaults timeout:      @config.rpcs.delete_session.timeout,
                                     metadata:     call_metadata

              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata

              @testing_stub.delete_session request, options do |result, response|
                yield result, response if block_given?
                return result
              end
            rescue ::Faraday::Error => e
              raise ::Gapic::Rest::Error.wrap_faraday_error e
            end

            ##
            # Report on the status of a session.
            # This generates a report detailing which tests have been completed,
            # and an overall rollup.
            #
            # @overload report_session(request, options = nil)
            #   Pass arguments to `report_session` via a request object, either of type
            #   {::Google::Showcase::V1beta1::ReportSessionRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Showcase::V1beta1::ReportSessionRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #     Note: currently retry functionality is not implemented. While it is possible
            #     to set it using ::Gapic::CallOptions, it will not be applied
            #
            # @overload report_session(name: nil)
            #   Pass arguments to `report_session` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param name [::String]
            #     The session to be reported on.
            #
            # @return [::Google::Showcase::V1beta1::ReportSessionResponse]
            #
            # @raise [::Gapic::Rest::Error] if the REST call is aborted.
            def report_session request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Showcase::V1beta1::ReportSessionRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              call_metadata = @config.rpcs.report_session.metadata.to_h

              # Set x-goog-api-client header
              call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Showcase::VERSION,
                transports_version_send: [:rest]

              options.apply_defaults timeout:      @config.rpcs.report_session.timeout,
                                     metadata:     call_metadata

              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata

              @testing_stub.report_session request, options do |result, response|
                yield result, response if block_given?
                return result
              end
            rescue ::Faraday::Error => e
              raise ::Gapic::Rest::Error.wrap_faraday_error e
            end

            ##
            # List the tests of a sessesion.
            #
            # @overload list_tests(request, options = nil)
            #   Pass arguments to `list_tests` via a request object, either of type
            #   {::Google::Showcase::V1beta1::ListTestsRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Showcase::V1beta1::ListTestsRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #     Note: currently retry functionality is not implemented. While it is possible
            #     to set it using ::Gapic::CallOptions, it will not be applied
            #
            # @overload list_tests(parent: nil, page_size: nil, page_token: nil)
            #   Pass arguments to `list_tests` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param parent [::String]
            #     The session.
            #   @param page_size [::Integer]
            #     The maximum number of tests to return per page.
            #   @param page_token [::String]
            #     The page token, for retrieving subsequent pages.
            #
            # @return [::Gapic::Rest::PagedEnumerable<::Google::Showcase::V1beta1::Test>]
            #
            # @raise [::Gapic::Rest::Error] if the REST call is aborted.
            def list_tests request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Showcase::V1beta1::ListTestsRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              call_metadata = @config.rpcs.list_tests.metadata.to_h

              # Set x-goog-api-client header
              call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Showcase::VERSION,
                transports_version_send: [:rest]

              options.apply_defaults timeout:      @config.rpcs.list_tests.timeout,
                                     metadata:     call_metadata

              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata

              @testing_stub.list_tests request, options do |result, response|
                result = ::Gapic::Rest::PagedEnumerable.new @testing_stub, :list_tests, "tests", request, result,
                                                            options
                yield result, response if block_given?
                return result
              end
            rescue ::Faraday::Error => e
              raise ::Gapic::Rest::Error.wrap_faraday_error e
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
            #   Pass arguments to `delete_test` via a request object, either of type
            #   {::Google::Showcase::V1beta1::DeleteTestRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Showcase::V1beta1::DeleteTestRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #     Note: currently retry functionality is not implemented. While it is possible
            #     to set it using ::Gapic::CallOptions, it will not be applied
            #
            # @overload delete_test(name: nil)
            #   Pass arguments to `delete_test` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param name [::String]
            #     The test to be deleted.
            #
            # @return [::Google::Protobuf::Empty]
            #
            # @raise [::Gapic::Rest::Error] if the REST call is aborted.
            def delete_test request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Showcase::V1beta1::DeleteTestRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              call_metadata = @config.rpcs.delete_test.metadata.to_h

              # Set x-goog-api-client header
              call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Showcase::VERSION,
                transports_version_send: [:rest]

              options.apply_defaults timeout:      @config.rpcs.delete_test.timeout,
                                     metadata:     call_metadata

              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata

              @testing_stub.delete_test request, options do |result, response|
                yield result, response if block_given?
                return result
              end
            rescue ::Faraday::Error => e
              raise ::Gapic::Rest::Error.wrap_faraday_error e
            end

            ##
            # Register a response to a test.
            #
            # In cases where a test involves registering a final answer at the
            # end of the test, this method provides the means to do so.
            #
            # @overload verify_test(request, options = nil)
            #   Pass arguments to `verify_test` via a request object, either of type
            #   {::Google::Showcase::V1beta1::VerifyTestRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Showcase::V1beta1::VerifyTestRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #     Note: currently retry functionality is not implemented. While it is possible
            #     to set it using ::Gapic::CallOptions, it will not be applied
            #
            # @overload verify_test(name: nil, answer: nil, answers: nil)
            #   Pass arguments to `verify_test` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param name [::String]
            #     The test to have an answer registered to it.
            #   @param answer [::String]
            #     The answer from the test.
            #   @param answers [::Array<::String>]
            #     The answers from the test if multiple are to be checked
            #
            # @return [::Google::Showcase::V1beta1::VerifyTestResponse]
            #
            # @raise [::Gapic::Rest::Error] if the REST call is aborted.
            def verify_test request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Showcase::V1beta1::VerifyTestRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              call_metadata = @config.rpcs.verify_test.metadata.to_h

              # Set x-goog-api-client header
              call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Showcase::VERSION,
                transports_version_send: [:rest]

              options.apply_defaults timeout:      @config.rpcs.verify_test.timeout,
                                     metadata:     call_metadata

              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata

              @testing_stub.verify_test request, options do |result, response|
                yield result, response if block_given?
                return result
              end
            rescue ::Faraday::Error => e
              raise ::Gapic::Rest::Error.wrap_faraday_error e
            end

            ##
            # Configuration class for the Testing REST API.
            #
            # This class represents the configuration for Testing REST,
            # providing control over credentials, timeouts, retry behavior, logging.
            #
            # Configuration can be applied globally to all clients, or to a single client
            # on construction.
            #
            # # Examples
            #
            # To modify the global config, setting the timeout for all calls to 10 seconds:
            #
            #     ::Google::Showcase::V1beta1::Testing::Client.configure do |config|
            #       config.timeout = 10.0
            #     end
            #
            # To apply the above configuration only to a new client:
            #
            #     client = ::Google::Showcase::V1beta1::Testing::Client.new do |config|
            #       config.timeout = 10.0
            #     end
            #
            # @!attribute [rw] endpoint
            #   The hostname or hostname:port of the service endpoint.
            #   Defaults to `"localhost:7469"`.
            #   @return [::String]
            # @!attribute [rw] credentials
            #   Credentials to send with calls. You may provide any of the following types:
            #    *  (`String`) The path to a service account key file in JSON format
            #    *  (`Hash`) A service account key as a Hash
            #    *  (`Google::Auth::Credentials`) A googleauth credentials object
            #       (see the [googleauth docs](https://googleapis.dev/ruby/googleauth/latest/index.html))
            #    *  (`Signet::OAuth2::Client`) A signet oauth2 client object
            #       (see the [signet docs](https://googleapis.dev/ruby/signet/latest/Signet/OAuth2/Client.html))
            #    *  (`nil`) indicating no credentials
            #   @return [::Object]
            # @!attribute [rw] scope
            #   The OAuth scopes
            #   @return [::Array<::String>]
            # @!attribute [rw] lib_name
            #   The library name as recorded in instrumentation and logging
            #   @return [::String]
            # @!attribute [rw] lib_version
            #   The library version as recorded in instrumentation and logging
            #   @return [::String]
            # @!attribute [rw] timeout
            #   The call timeout in seconds.
            #   @return [::Numeric]
            # @!attribute [rw] metadata
            #   Additional REST headers to be sent with the call.
            #   @return [::Hash{::Symbol=>::String}]
            #
            class Configuration
              extend ::Gapic::Config

              config_attr :endpoint,      "localhost:7469", ::String
              config_attr :credentials,   nil do |value|
                allowed = [::String, ::Hash, ::Proc, ::Symbol, ::Google::Auth::Credentials, ::Signet::OAuth2::Client,
                           nil]
                allowed.any? { |klass| klass === value }
              end
              config_attr :scope,         nil, ::String, ::Array, nil
              config_attr :lib_name,      nil, ::String, nil
              config_attr :lib_version,   nil, ::String, nil
              config_attr :timeout,       nil, ::Numeric, nil
              config_attr :metadata,      nil, ::Hash, nil

              # @private
              def initialize parent_config = nil
                @parent_config = parent_config unless parent_config.nil?

                yield self if block_given?
              end

              ##
              # Configurations for individual RPCs
              # @return [Rpcs]
              #
              def rpcs
                @rpcs ||= begin
                  parent_rpcs = nil
                  parent_rpcs = @parent_config.rpcs if defined?(@parent_config) && @parent_config.respond_to?(:rpcs)
                  Rpcs.new parent_rpcs
                end
              end

              ##
              # Configuration RPC class for the Testing API.
              #
              # Includes fields providing the configuration for each RPC in this service.
              # Each configuration object is of type `Gapic::Config::Method` and includes
              # the following configuration fields:
              #
              #  *  `timeout` (*type:* `Numeric`) - The call timeout in seconds
              #
              # there is one other field (`retry_policy`) that can be set
              # but is currently not supported for REST Gapic libraries.
              #
              class Rpcs
                ##
                # RPC-specific configuration for `create_session`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :create_session
                ##
                # RPC-specific configuration for `get_session`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :get_session
                ##
                # RPC-specific configuration for `list_sessions`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :list_sessions
                ##
                # RPC-specific configuration for `delete_session`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :delete_session
                ##
                # RPC-specific configuration for `report_session`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :report_session
                ##
                # RPC-specific configuration for `list_tests`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :list_tests
                ##
                # RPC-specific configuration for `delete_test`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :delete_test
                ##
                # RPC-specific configuration for `verify_test`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :verify_test

                # @private
                def initialize parent_rpcs = nil
                  create_session_config = parent_rpcs.create_session if parent_rpcs.respond_to? :create_session
                  @create_session = ::Gapic::Config::Method.new create_session_config
                  get_session_config = parent_rpcs.get_session if parent_rpcs.respond_to? :get_session
                  @get_session = ::Gapic::Config::Method.new get_session_config
                  list_sessions_config = parent_rpcs.list_sessions if parent_rpcs.respond_to? :list_sessions
                  @list_sessions = ::Gapic::Config::Method.new list_sessions_config
                  delete_session_config = parent_rpcs.delete_session if parent_rpcs.respond_to? :delete_session
                  @delete_session = ::Gapic::Config::Method.new delete_session_config
                  report_session_config = parent_rpcs.report_session if parent_rpcs.respond_to? :report_session
                  @report_session = ::Gapic::Config::Method.new report_session_config
                  list_tests_config = parent_rpcs.list_tests if parent_rpcs.respond_to? :list_tests
                  @list_tests = ::Gapic::Config::Method.new list_tests_config
                  delete_test_config = parent_rpcs.delete_test if parent_rpcs.respond_to? :delete_test
                  @delete_test = ::Gapic::Config::Method.new delete_test_config
                  verify_test_config = parent_rpcs.verify_test if parent_rpcs.respond_to? :verify_test
                  @verify_test = ::Gapic::Config::Method.new verify_test_config

                  yield self if block_given?
                end
              end
            end
          end
        end
      end
    end
  end
end
