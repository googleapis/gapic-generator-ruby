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

require "testing/grpc_service_config/grpc_service_config_pb"
require "testing/grpc_service_config/service_with_retries/rest/service_stub"
require "google/cloud/location/rest"

module Testing
  module GrpcServiceConfig
    module ServiceWithRetries
      module Rest
        ##
        # REST client for the ServiceWithRetries service.
        #
        class Client
          # @private
          attr_reader :service_with_retries_stub

          ##
          # Configure the ServiceWithRetries Client class.
          #
          # See {::Testing::GrpcServiceConfig::ServiceWithRetries::Rest::Client::Configuration}
          # for a description of the configuration fields.
          #
          # @example
          #
          #   # Modify the configuration for all ServiceWithRetries clients
          #   ::Testing::GrpcServiceConfig::ServiceWithRetries::Rest::Client.configure do |config|
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

              default_config.timeout = 20.0
              default_config.retry_policy = {
                initial_delay: 0.5, max_delay: 5.0, multiplier: 2.0, retry_codes: [4, 8]
              }

              default_config.rpcs.method_level_retry_method.timeout = 86_400.0
              default_config.rpcs.method_level_retry_method.retry_policy = {
                initial_delay: 1.0, max_delay: 10.0, multiplier: 3.0, retry_codes: [14]
              }

              default_config
            end
            yield @configure if block_given?
            @configure
          end

          ##
          # Configure the ServiceWithRetries Client instance.
          #
          # The configuration is set to the derived mode, meaning that values can be changed,
          # but structural changes (adding new fields, etc.) are not allowed. Structural changes
          # should be made on {Client.configure}.
          #
          # See {::Testing::GrpcServiceConfig::ServiceWithRetries::Rest::Client::Configuration}
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
          # Create a new ServiceWithRetries REST client object.
          #
          # @example
          #
          #   # Create a client using the default configuration
          #   client = ::Testing::GrpcServiceConfig::ServiceWithRetries::Rest::Client.new
          #
          #   # Create a client using a custom configuration
          #   client = ::Testing::GrpcServiceConfig::ServiceWithRetries::Rest::Client.new do |config|
          #     config.timeout = 10.0
          #   end
          #
          # @yield [config] Configure the ServiceWithRetries client.
          # @yieldparam config [Client::Configuration]
          #
          def initialize
            # Create the configuration object
            @config = Configuration.new Client.configure

            # Yield the configuration if needed
            yield @config if block_given?

            # Create credentials
            credentials = @config.credentials
            # Use self-signed JWT if the endpoint is unchanged from default,
            # but only if the default endpoint does not have a region prefix.
            enable_self_signed_jwt = @config.endpoint == Configuration::DEFAULT_ENDPOINT &&
                                     !@config.endpoint.split(".").first.include?("-")
            credentials ||= Credentials.default scope: @config.scope,
                                                enable_self_signed_jwt: enable_self_signed_jwt
            if credentials.is_a?(::String) || credentials.is_a?(::Hash)
              credentials = Credentials.new credentials, scope: @config.scope
            end

            @quota_project_id = @config.quota_project
            @quota_project_id ||= credentials.quota_project_id if credentials.respond_to? :quota_project_id

            @location_client = Google::Cloud::Location::Locations::Rest::Client.new do |config|
              config.credentials = credentials
              config.quota_project = @quota_project_id
              config.endpoint = @config.endpoint
              config.bindings_override = @config.bindings_override
            end

            @service_with_retries_stub = ::Testing::GrpcServiceConfig::ServiceWithRetries::Rest::ServiceStub.new endpoint: @config.endpoint,
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
          # @overload service_level_retry_method(request, options = nil)
          #   Pass arguments to `service_level_retry_method` via a request object, either of type
          #   {::Testing::GrpcServiceConfig::Request} or an equivalent Hash.
          #
          #   @param request [::Testing::GrpcServiceConfig::Request, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          # @yield [result, operation] Access the result along with the TransportOperation object
          # @yieldparam result [::Testing::GrpcServiceConfig::Response]
          # @yieldparam operation [::Gapic::Rest::TransportOperation]
          #
          # @return [::Testing::GrpcServiceConfig::Response]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def service_level_retry_method request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Testing::GrpcServiceConfig::Request

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.service_level_retry_method.metadata.to_h

            # Set x-goog-api-client and x-goog-user-project headers
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            call_metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            options.apply_defaults timeout:      @config.rpcs.service_level_retry_method.timeout,
                                   metadata:     call_metadata,
                                   retry_policy: @config.rpcs.service_level_retry_method.retry_policy

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @service_with_retries_stub.service_level_retry_method request, options do |result, operation|
              yield result, operation if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
          end

          ##
          # @overload method_level_retry_method(request, options = nil)
          #   Pass arguments to `method_level_retry_method` via a request object, either of type
          #   {::Testing::GrpcServiceConfig::Request} or an equivalent Hash.
          #
          #   @param request [::Testing::GrpcServiceConfig::Request, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          # @yield [result, operation] Access the result along with the TransportOperation object
          # @yieldparam result [::Testing::GrpcServiceConfig::Response]
          # @yieldparam operation [::Gapic::Rest::TransportOperation]
          #
          # @return [::Testing::GrpcServiceConfig::Response]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def method_level_retry_method request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Testing::GrpcServiceConfig::Request

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.method_level_retry_method.metadata.to_h

            # Set x-goog-api-client and x-goog-user-project headers
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            call_metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            options.apply_defaults timeout:      @config.rpcs.method_level_retry_method.timeout,
                                   metadata:     call_metadata,
                                   retry_policy: @config.rpcs.method_level_retry_method.retry_policy

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @service_with_retries_stub.method_level_retry_method request, options do |result, operation|
              yield result, operation if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
          end

          ##
          # Configuration class for the ServiceWithRetries REST API.
          #
          # This class represents the configuration for ServiceWithRetries REST,
          # providing control over timeouts, retry behavior, logging, transport
          # parameters, and other low-level controls. Certain parameters can also be
          # applied individually to specific RPCs. See
          # {::Testing::GrpcServiceConfig::ServiceWithRetries::Rest::Client::Configuration::Rpcs}
          # for a list of RPCs that can be configured independently.
          #
          # Configuration can be applied globally to all clients, or to a single client
          # on construction.
          #
          # @example
          #
          #   # Modify the global config, setting the timeout for
          #   # service_level_retry_method to 20 seconds,
          #   # and all remaining timeouts to 10 seconds.
          #   ::Testing::GrpcServiceConfig::ServiceWithRetries::Rest::Client.configure do |config|
          #     config.timeout = 10.0
          #     config.rpcs.service_level_retry_method.timeout = 20.0
          #   end
          #
          #   # Apply the above configuration only to a new client.
          #   client = ::Testing::GrpcServiceConfig::ServiceWithRetries::Rest::Client.new do |config|
          #     config.timeout = 10.0
          #     config.rpcs.service_level_retry_method.timeout = 20.0
          #   end
          #
          # @!attribute [rw] endpoint
          #   The hostname or hostname:port of the service endpoint.
          #   Defaults to `"grpcserviceconfig.example.com"`.
          #   @return [::String]
          # @!attribute [rw] credentials
          #   Credentials to send with calls. You may provide any of the following types:
          #    *  (`String`) The path to a service account key file in JSON format
          #    *  (`Hash`) A service account key as a Hash
          #    *  (`Google::Auth::Credentials`) A googleauth credentials object
          #       (see the [googleauth docs](https://rubydoc.info/gems/googleauth/Google/Auth/Credentials))
          #    *  (`Signet::OAuth2::Client`) A signet oauth2 client object
          #       (see the [signet docs](https://rubydoc.info/gems/signet/Signet/OAuth2/Client))
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
          #   Additional headers to be sent with the call.
          #   @return [::Hash{::Symbol=>::String}]
          # @!attribute [rw] retry_policy
          #   The retry policy. The value is a hash with the following keys:
          #    *  `:initial_delay` (*type:* `Numeric`) - The initial delay in seconds.
          #    *  `:max_delay` (*type:* `Numeric`) - The max delay in seconds.
          #    *  `:multiplier` (*type:* `Numeric`) - The incremental backoff multiplier.
          #    *  `:retry_codes` (*type:* `Array<String>`) - The error codes that should
          #       trigger a retry.
          #   @return [::Hash]
          # @!attribute [rw] quota_project
          #   A separate project against which to charge quota.
          #   @return [::String]
          #
          class Configuration
            extend ::Gapic::Config

            DEFAULT_ENDPOINT = "grpcserviceconfig.example.com"

            config_attr :endpoint,      DEFAULT_ENDPOINT, ::String
            config_attr :credentials,   nil do |value|
              allowed = [::String, ::Hash, ::Proc, ::Symbol, ::Google::Auth::Credentials, ::Signet::OAuth2::Client, nil]
              allowed.any? { |klass| klass === value }
            end
            config_attr :scope,         nil, ::String, ::Array, nil
            config_attr :lib_name,      nil, ::String, nil
            config_attr :lib_version,   nil, ::String, nil
            config_attr :timeout,       nil, ::Numeric, nil
            config_attr :metadata,      nil, ::Hash, nil
            config_attr :retry_policy,  nil, ::Hash, ::Proc, nil
            config_attr :quota_project, nil, ::String, nil

            # @private
            # Overrides for http bindings for the RPCs of this service
            # are only used when this service is used as mixin, and only
            # by the host service.
            # @return [::Hash{::Symbol=>::Array<::Gapic::Rest::GrpcTranscoder::HttpBinding>}]
            config_attr :bindings_override, {}, ::Hash, nil

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
            # Configuration RPC class for the ServiceWithRetries API.
            #
            # Includes fields providing the configuration for each RPC in this service.
            # Each configuration object is of type `Gapic::Config::Method` and includes
            # the following configuration fields:
            #
            #  *  `timeout` (*type:* `Numeric`) - The call timeout in seconds
            #  *  `metadata` (*type:* `Hash{Symbol=>String}`) - Additional headers
            #  *  `retry_policy (*type:* `Hash`) - The retry policy. The policy fields
            #     include the following keys:
            #      *  `:initial_delay` (*type:* `Numeric`) - The initial delay in seconds.
            #      *  `:max_delay` (*type:* `Numeric`) - The max delay in seconds.
            #      *  `:multiplier` (*type:* `Numeric`) - The incremental backoff multiplier.
            #      *  `:retry_codes` (*type:* `Array<String>`) - The error codes that should
            #         trigger a retry.
            #
            class Rpcs
              ##
              # RPC-specific configuration for `service_level_retry_method`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :service_level_retry_method
              ##
              # RPC-specific configuration for `method_level_retry_method`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :method_level_retry_method

              # @private
              def initialize parent_rpcs = nil
                service_level_retry_method_config = parent_rpcs.service_level_retry_method if parent_rpcs.respond_to? :service_level_retry_method
                @service_level_retry_method = ::Gapic::Config::Method.new service_level_retry_method_config
                method_level_retry_method_config = parent_rpcs.method_level_retry_method if parent_rpcs.respond_to? :method_level_retry_method
                @method_level_retry_method = ::Gapic::Config::Method.new method_level_retry_method_config

                yield self if block_given?
              end
            end
          end
        end
      end
    end
  end
end
