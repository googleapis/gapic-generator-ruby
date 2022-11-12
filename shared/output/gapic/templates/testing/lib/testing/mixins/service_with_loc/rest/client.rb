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

require "testing/mixins/mixins_pb"
require "testing/mixins/service_with_loc/rest/service_stub"
require "google/cloud/location/rest"

module Testing
  module Mixins
    module ServiceWithLoc
      module Rest
        ##
        # REST client for the ServiceWithLoc service.
        #
        class Client
          # @private
          attr_reader :service_with_loc_stub

          ##
          # Configure the ServiceWithLoc Client class.
          #
          # See {::Testing::Mixins::ServiceWithLoc::Rest::Client::Configuration}
          # for a description of the configuration fields.
          #
          # @example
          #
          #   # Modify the configuration for all ServiceWithLoc clients
          #   ::Testing::Mixins::ServiceWithLoc::Rest::Client.configure do |config|
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
          # Configure the ServiceWithLoc Client instance.
          #
          # The configuration is set to the derived mode, meaning that values can be changed,
          # but structural changes (adding new fields, etc.) are not allowed. Structural changes
          # should be made on {Client.configure}.
          #
          # See {::Testing::Mixins::ServiceWithLoc::Rest::Client::Configuration}
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
          # Create a new ServiceWithLoc REST client object.
          #
          # @example
          #
          #   # Create a client using the default configuration
          #   client = ::Testing::Mixins::ServiceWithLoc::Rest::Client.new
          #
          #   # Create a client using a custom configuration
          #   client = ::Testing::Mixins::ServiceWithLoc::Rest::Client.new do |config|
          #     config.timeout = 10.0
          #   end
          #
          # @yield [config] Configure the ServiceWithLoc client.
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

            @location_client = Google::Cloud::Location::Locations::Rest::Client.new do |config|
              config.credentials = credentials
              config.endpoint = @config.endpoint
            end

            @service_with_loc_stub = ::Testing::Mixins::ServiceWithLoc::Rest::ServiceStub.new endpoint: @config.endpoint,
                                                                                              credentials: credentials
          end

          ##
          # Get the associated client for mix-in of the Locations.
          #
          # @return [Google::Cloud::Location::Locations::Rest::Client]
          #
          attr_reader :location_client

          # Service calls

          ##
          # @overload call_method(request, options = nil)
          #   Pass arguments to `call_method` via a request object, either of type
          #   {::Testing::Mixins::Request} or an equivalent Hash.
          #
          #   @param request [::Testing::Mixins::Request, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #     Note: currently retry functionality is not implemented. While it is possible
          #     to set it using ::Gapic::CallOptions, it will not be applied
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Testing::Mixins::Response]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Testing::Mixins::Response]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def call_method request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Testing::Mixins::Request

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.call_method.metadata.to_h

            # Set x-goog-api-client header
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            options.apply_defaults timeout:      @config.rpcs.call_method.timeout,
                                   metadata:     call_metadata

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata

            @service_with_loc_stub.call_method request, options do |result, response|
              yield result, response if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
          end

          ##
          # Configuration class for the ServiceWithLoc REST API.
          #
          # This class represents the configuration for ServiceWithLoc REST,
          # providing control over credentials, timeouts, retry behavior, logging.
          #
          # Configuration can be applied globally to all clients, or to a single client
          # on construction.
          #
          # # Examples
          #
          # To modify the global config, setting the timeout for all calls to 10 seconds:
          #
          #     ::Testing::Mixins::ServiceWithLoc::Client.configure do |config|
          #       config.timeout = 10.0
          #     end
          #
          # To apply the above configuration only to a new client:
          #
          #     client = ::Testing::Mixins::ServiceWithLoc::Client.new do |config|
          #       config.timeout = 10.0
          #     end
          #
          # @!attribute [rw] endpoint
          #   The hostname or hostname:port of the service endpoint.
          #   Defaults to `"servicewithloc.example.com"`.
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

            config_attr :endpoint,      "servicewithloc.example.com", ::String
            config_attr :credentials,   nil do |value|
              allowed = [::String, ::Hash, ::Proc, ::Symbol, ::Google::Auth::Credentials, ::Signet::OAuth2::Client, nil]
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
            # Configuration RPC class for the ServiceWithLoc API.
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
              # RPC-specific configuration for `call_method`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :call_method

              # @private
              def initialize parent_rpcs = nil
                call_method_config = parent_rpcs.call_method if parent_rpcs.respond_to? :call_method
                @call_method = ::Gapic::Config::Method.new call_method_config

                yield self if block_given?
              end
            end
          end
        end
      end
    end
  end
end
