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

require "testing/routing_headers/routing_headers_pb"
require "testing/routing_headers/service_implicit_headers/rest/service_stub"
require "google/cloud/location/rest"

module Testing
  module RoutingHeaders
    module ServiceImplicitHeaders
      module Rest
        ##
        # REST client for the ServiceImplicitHeaders service.
        #
        class Client
          # @private
          attr_reader :service_implicit_headers_stub

          ##
          # Configure the ServiceImplicitHeaders Client class.
          #
          # See {::Testing::RoutingHeaders::ServiceImplicitHeaders::Rest::Client::Configuration}
          # for a description of the configuration fields.
          #
          # @example
          #
          #   # Modify the configuration for all ServiceImplicitHeaders clients
          #   ::Testing::RoutingHeaders::ServiceImplicitHeaders::Rest::Client.configure do |config|
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
          # Configure the ServiceImplicitHeaders Client instance.
          #
          # The configuration is set to the derived mode, meaning that values can be changed,
          # but structural changes (adding new fields, etc.) are not allowed. Structural changes
          # should be made on {Client.configure}.
          #
          # See {::Testing::RoutingHeaders::ServiceImplicitHeaders::Rest::Client::Configuration}
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
          # Create a new ServiceImplicitHeaders REST client object.
          #
          # @example
          #
          #   # Create a client using the default configuration
          #   client = ::Testing::RoutingHeaders::ServiceImplicitHeaders::Rest::Client.new
          #
          #   # Create a client using a custom configuration
          #   client = ::Testing::RoutingHeaders::ServiceImplicitHeaders::Rest::Client.new do |config|
          #     config.timeout = 10.0
          #   end
          #
          # @yield [config] Configure the ServiceImplicitHeaders client.
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
              config.bindings_override = @config.bindings_override
            end

            @service_implicit_headers_stub = ::Testing::RoutingHeaders::ServiceImplicitHeaders::Rest::ServiceStub.new endpoint: @config.endpoint,
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
          # @overload plain(request, options = nil)
          #   Pass arguments to `plain` via a request object, either of type
          #   {::Testing::RoutingHeaders::Request} or an equivalent Hash.
          #
          #   @param request [::Testing::RoutingHeaders::Request, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #     Note: currently retry functionality is not implemented. While it is possible
          #     to set it using ::Gapic::CallOptions, it will not be applied
          #
          # @overload plain(table_name: nil, app_profile_id: nil, resource: nil)
          #   Pass arguments to `plain` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param table_name [::String]
          #     The name of the Table
          #     Values can be of the following formats:
          #     - `projects/<project>/tables/<table>`
          #     - `projects/<project>/instances/<instance>/tables/<table>`
          #     - `region/<region>/zones/<zone>/tables/<table>`
          #   @param app_profile_id [::String]
          #     This value specifies routing for replication.
          #     It can be in the following formats:
          #     - profiles/<profile_id>
          #     - a legacy profile_id that can be any string
          #   @param resource [::Testing::RoutingHeaders::RequestResource, ::Hash]
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Testing::RoutingHeaders::Response]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Testing::RoutingHeaders::Response]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def plain request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Testing::RoutingHeaders::Request

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.plain.metadata.to_h

            # Set x-goog-api-client header
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            options.apply_defaults timeout:      @config.rpcs.plain.timeout,
                                   metadata:     call_metadata

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata

            @service_implicit_headers_stub.plain request, options do |result, response|
              yield result, response if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
          end

          ##
          # @overload with_sub_message(request, options = nil)
          #   Pass arguments to `with_sub_message` via a request object, either of type
          #   {::Testing::RoutingHeaders::Request} or an equivalent Hash.
          #
          #   @param request [::Testing::RoutingHeaders::Request, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #     Note: currently retry functionality is not implemented. While it is possible
          #     to set it using ::Gapic::CallOptions, it will not be applied
          #
          # @overload with_sub_message(table_name: nil, app_profile_id: nil, resource: nil)
          #   Pass arguments to `with_sub_message` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param table_name [::String]
          #     The name of the Table
          #     Values can be of the following formats:
          #     - `projects/<project>/tables/<table>`
          #     - `projects/<project>/instances/<instance>/tables/<table>`
          #     - `region/<region>/zones/<zone>/tables/<table>`
          #   @param app_profile_id [::String]
          #     This value specifies routing for replication.
          #     It can be in the following formats:
          #     - profiles/<profile_id>
          #     - a legacy profile_id that can be any string
          #   @param resource [::Testing::RoutingHeaders::RequestResource, ::Hash]
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Testing::RoutingHeaders::Response]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Testing::RoutingHeaders::Response]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def with_sub_message request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Testing::RoutingHeaders::Request

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.with_sub_message.metadata.to_h

            # Set x-goog-api-client header
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            options.apply_defaults timeout:      @config.rpcs.with_sub_message.timeout,
                                   metadata:     call_metadata

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata

            @service_implicit_headers_stub.with_sub_message request, options do |result, response|
              yield result, response if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
          end

          ##
          # @overload with_multiple_levels(request, options = nil)
          #   Pass arguments to `with_multiple_levels` via a request object, either of type
          #   {::Testing::RoutingHeaders::Request} or an equivalent Hash.
          #
          #   @param request [::Testing::RoutingHeaders::Request, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #     Note: currently retry functionality is not implemented. While it is possible
          #     to set it using ::Gapic::CallOptions, it will not be applied
          #
          # @overload with_multiple_levels(table_name: nil, app_profile_id: nil, resource: nil)
          #   Pass arguments to `with_multiple_levels` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param table_name [::String]
          #     The name of the Table
          #     Values can be of the following formats:
          #     - `projects/<project>/tables/<table>`
          #     - `projects/<project>/instances/<instance>/tables/<table>`
          #     - `region/<region>/zones/<zone>/tables/<table>`
          #   @param app_profile_id [::String]
          #     This value specifies routing for replication.
          #     It can be in the following formats:
          #     - profiles/<profile_id>
          #     - a legacy profile_id that can be any string
          #   @param resource [::Testing::RoutingHeaders::RequestResource, ::Hash]
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Testing::RoutingHeaders::Response]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Testing::RoutingHeaders::Response]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def with_multiple_levels request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Testing::RoutingHeaders::Request

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.with_multiple_levels.metadata.to_h

            # Set x-goog-api-client header
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            options.apply_defaults timeout:      @config.rpcs.with_multiple_levels.timeout,
                                   metadata:     call_metadata

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata

            @service_implicit_headers_stub.with_multiple_levels request, options do |result, response|
              yield result, response if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
          end

          ##
          # Configuration class for the ServiceImplicitHeaders REST API.
          #
          # This class represents the configuration for ServiceImplicitHeaders REST,
          # providing control over credentials, timeouts, retry behavior, logging.
          #
          # Configuration can be applied globally to all clients, or to a single client
          # on construction.
          #
          # # Examples
          #
          # To modify the global config, setting the timeout for all calls to 10 seconds:
          #
          #     ::Testing::RoutingHeaders::ServiceImplicitHeaders::Client.configure do |config|
          #       config.timeout = 10.0
          #     end
          #
          # To apply the above configuration only to a new client:
          #
          #     client = ::Testing::RoutingHeaders::ServiceImplicitHeaders::Client.new do |config|
          #       config.timeout = 10.0
          #     end
          #
          # @!attribute [rw] endpoint
          #   The hostname or hostname:port of the service endpoint.
          #   Defaults to `"routingheaders.example.com"`.
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

            config_attr :endpoint,      "routingheaders.example.com", ::String
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
            # Configuration RPC class for the ServiceImplicitHeaders API.
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
              # RPC-specific configuration for `plain`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :plain
              ##
              # RPC-specific configuration for `with_sub_message`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :with_sub_message
              ##
              # RPC-specific configuration for `with_multiple_levels`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :with_multiple_levels

              # @private
              def initialize parent_rpcs = nil
                plain_config = parent_rpcs.plain if parent_rpcs.respond_to? :plain
                @plain = ::Gapic::Config::Method.new plain_config
                with_sub_message_config = parent_rpcs.with_sub_message if parent_rpcs.respond_to? :with_sub_message
                @with_sub_message = ::Gapic::Config::Method.new with_sub_message_config
                with_multiple_levels_config = parent_rpcs.with_multiple_levels if parent_rpcs.respond_to? :with_multiple_levels
                @with_multiple_levels = ::Gapic::Config::Method.new with_multiple_levels_config

                yield self if block_given?
              end
            end
          end
        end
      end
    end
  end
end
