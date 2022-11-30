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

require "testing/nonstandard_lro_grpc/nonstandard_lro_grpc_pb"
require "testing/nonstandard_lro_grpc/all_subclients_consumer/rest/service_stub"
require "google/cloud/location/rest"
require "testing/nonstandard_lro_grpc/plain_lro_provider/rest"
require "testing/nonstandard_lro_grpc/another_lro_provider/rest"

module Testing
  module NonstandardLroGrpc
    module AllSubclientsConsumer
      module Rest
        ##
        # REST client for the AllSubclientsConsumer service.
        #
        class Client
          # @private
          attr_reader :all_subclients_consumer_stub

          ##
          # Configure the AllSubclientsConsumer Client class.
          #
          # See {::Testing::NonstandardLroGrpc::AllSubclientsConsumer::Rest::Client::Configuration}
          # for a description of the configuration fields.
          #
          # @example
          #
          #   # Modify the configuration for all AllSubclientsConsumer clients
          #   ::Testing::NonstandardLroGrpc::AllSubclientsConsumer::Rest::Client.configure do |config|
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
          # Configure the AllSubclientsConsumer Client instance.
          #
          # The configuration is set to the derived mode, meaning that values can be changed,
          # but structural changes (adding new fields, etc.) are not allowed. Structural changes
          # should be made on {Client.configure}.
          #
          # See {::Testing::NonstandardLroGrpc::AllSubclientsConsumer::Rest::Client::Configuration}
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
          # Create a new AllSubclientsConsumer REST client object.
          #
          # @example
          #
          #   # Create a client using the default configuration
          #   client = ::Testing::NonstandardLroGrpc::AllSubclientsConsumer::Rest::Client.new
          #
          #   # Create a client using a custom configuration
          #   client = ::Testing::NonstandardLroGrpc::AllSubclientsConsumer::Rest::Client.new do |config|
          #     config.timeout = 10.0
          #   end
          #
          # @yield [config] Configure the AllSubclientsConsumer client.
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
            enable_self_signed_jwt = @config.endpoint == Client.configure.endpoint &&
                                     !@config.endpoint.split(".").first.include?("-")
            credentials ||= Credentials.default scope: @config.scope,
                                                enable_self_signed_jwt: enable_self_signed_jwt
            if credentials.is_a?(::String) || credentials.is_a?(::Hash)
              credentials = Credentials.new credentials, scope: @config.scope
            end

            @quota_project_id = @config.quota_project
            @quota_project_id ||= credentials.quota_project_id if credentials.respond_to? :quota_project_id

            @operations_client = ::Testing::NonstandardLroGrpc::AllSubclientsConsumer::Rest::Operations.new do |config|
              config.credentials = credentials
              config.quota_project = @quota_project_id
              config.endpoint = @config.endpoint
            end

            @location_client = Google::Cloud::Location::Locations::Rest::Client.new do |config|
              config.credentials = credentials
              config.quota_project = @quota_project_id
              config.endpoint = @config.endpoint
              config.bindings_override = @config.bindings_override
            end

            @plain_lro_provider = ::Testing::NonstandardLroGrpc::PlainLroProvider::Rest::Client.new do |config|
              config.credentials = credentials
              config.quota_project = @quota_project_id
              config.endpoint = @config.endpoint
            end

            @another_lro_provider = ::Testing::NonstandardLroGrpc::AnotherLroProvider::Rest::Client.new do |config|
              config.credentials = credentials
              config.quota_project = @quota_project_id
              config.endpoint = @config.endpoint
            end

            @all_subclients_consumer_stub = ::Testing::NonstandardLroGrpc::AllSubclientsConsumer::Rest::ServiceStub.new endpoint: @config.endpoint,
                                                                                                                        credentials: credentials
          end

          ##
          # Get the associated client for long-running operations.
          #
          # @return [::Testing::NonstandardLroGrpc::AllSubclientsConsumer::Rest::Operations]
          #
          attr_reader :operations_client

          ##
          # Get the associated client for mix-in of the Locations.
          #
          # @return [Google::Cloud::Location::Locations::Rest::Client]
          #
          attr_reader :location_client

          ##
          # Get the associated client for long-running operations via PlainLroProvider.
          #
          # @return [::Testing::NonstandardLroGrpc::PlainLroProvider::Rest::Client]
          #
          attr_reader :plain_lro_provider

          ##
          # Get the associated client for long-running operations via AnotherLroProvider.
          #
          # @return [::Testing::NonstandardLroGrpc::AnotherLroProvider::Rest::Client]
          #
          attr_reader :another_lro_provider

          # Service calls

          ##
          # A request using a PlainLroProvider
          #
          # @overload plain_lro_rpc(request, options = nil)
          #   Pass arguments to `plain_lro_rpc` via a request object, either of type
          #   {::Testing::NonstandardLroGrpc::Request} or an equivalent Hash.
          #
          #   @param request [::Testing::NonstandardLroGrpc::Request, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #
          # @overload plain_lro_rpc(request_id: nil)
          #   Pass arguments to `plain_lro_rpc` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param request_id [::String]
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Gapic::GenericLRO::Operation]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Gapic::GenericLRO::Operation]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def plain_lro_rpc request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Testing::NonstandardLroGrpc::Request

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.plain_lro_rpc.metadata.to_h

            # Set x-goog-api-client and x-goog-user-project headers
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            call_metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            options.apply_defaults timeout:      @config.rpcs.plain_lro_rpc.timeout,
                                   metadata:     call_metadata,
                                   retry_policy: @config.rpcs.plain_lro_rpc.retry_policy

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @all_subclients_consumer_stub.plain_lro_rpc request, options do |result, response|
              result = ::Testing::NonstandardLroGrpc::PlainLroProvider::Rest::NonstandardLro.create_operation(
                operation: result,
                client: plain_lro_provider,
                request_values: {
                  "initial_request_id" => request.request_id
                },
                options: options
              )
              yield result, response if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
          end

          ##
          # A request using AnotherLroProvider
          #
          # @overload another_lro_rpc(request, options = nil)
          #   Pass arguments to `another_lro_rpc` via a request object, either of type
          #   {::Testing::NonstandardLroGrpc::AnotherRequest} or an equivalent Hash.
          #
          #   @param request [::Testing::NonstandardLroGrpc::AnotherRequest, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #
          # @overload another_lro_rpc(request_id: nil)
          #   Pass arguments to `another_lro_rpc` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param request_id [::String]
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Gapic::GenericLRO::Operation]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Gapic::GenericLRO::Operation]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def another_lro_rpc request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Testing::NonstandardLroGrpc::AnotherRequest

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.another_lro_rpc.metadata.to_h

            # Set x-goog-api-client and x-goog-user-project headers
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            call_metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            options.apply_defaults timeout:      @config.rpcs.another_lro_rpc.timeout,
                                   metadata:     call_metadata,
                                   retry_policy: @config.rpcs.another_lro_rpc.retry_policy

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @all_subclients_consumer_stub.another_lro_rpc request, options do |result, response|
              result = ::Testing::NonstandardLroGrpc::AnotherLroProvider::Rest::NonstandardLro.create_operation(
                operation: result,
                client: another_lro_provider,
                request_values: {
                  "another_request_id" => request.request_id
                },
                options: options
              )
              yield result, response if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
          end

          ##
          # A request using AnotherLroProvider.
          # This one is different because it is using the NonCopyRequest message
          # which does not specify any fields to copy into the LroAnotherGetRequest
          #
          # @overload non_copy_another_lro_rpc(request, options = nil)
          #   Pass arguments to `non_copy_another_lro_rpc` via a request object, either of type
          #   {::Testing::NonstandardLroGrpc::NonCopyRequest} or an equivalent Hash.
          #
          #   @param request [::Testing::NonstandardLroGrpc::NonCopyRequest, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Gapic::GenericLRO::Operation]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Gapic::GenericLRO::Operation]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def non_copy_another_lro_rpc request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Testing::NonstandardLroGrpc::NonCopyRequest

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.non_copy_another_lro_rpc.metadata.to_h

            # Set x-goog-api-client and x-goog-user-project headers
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            call_metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            options.apply_defaults timeout:      @config.rpcs.non_copy_another_lro_rpc.timeout,
                                   metadata:     call_metadata,
                                   retry_policy: @config.rpcs.non_copy_another_lro_rpc.retry_policy

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @all_subclients_consumer_stub.non_copy_another_lro_rpc request, options do |result, response|
              result = ::Testing::NonstandardLroGrpc::AnotherLroProvider::Rest::NonstandardLro.create_operation(
                operation: result,
                client: another_lro_provider,
                request_values: {},
                options: options
              )
              yield result, response if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
          end

          ##
          # A classic (AIP-151) LRO request
          #
          # @overload aip_lro(request, options = nil)
          #   Pass arguments to `aip_lro` via a request object, either of type
          #   {::Testing::NonstandardLroGrpc::Request} or an equivalent Hash.
          #
          #   @param request [::Testing::NonstandardLroGrpc::Request, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #
          # @overload aip_lro(request_id: nil)
          #   Pass arguments to `aip_lro` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param request_id [::String]
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Gapic::Operation]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Gapic::Operation]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def aip_lro request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Testing::NonstandardLroGrpc::Request

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.aip_lro.metadata.to_h

            # Set x-goog-api-client and x-goog-user-project headers
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            call_metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            options.apply_defaults timeout:      @config.rpcs.aip_lro.timeout,
                                   metadata:     call_metadata,
                                   retry_policy: @config.rpcs.aip_lro.retry_policy

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @all_subclients_consumer_stub.aip_lro request, options do |result, response|
              result = ::Gapic::Operation.new result, @operations_client, options: options
              yield result, response if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
          end

          ##
          # Control group
          #
          # @overload no_lro(request, options = nil)
          #   Pass arguments to `no_lro` via a request object, either of type
          #   {::Testing::NonstandardLroGrpc::Request} or an equivalent Hash.
          #
          #   @param request [::Testing::NonstandardLroGrpc::Request, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #
          # @overload no_lro(request_id: nil)
          #   Pass arguments to `no_lro` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param request_id [::String]
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Testing::NonstandardLroGrpc::Response]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Testing::NonstandardLroGrpc::Response]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def no_lro request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Testing::NonstandardLroGrpc::Request

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.no_lro.metadata.to_h

            # Set x-goog-api-client and x-goog-user-project headers
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            call_metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            options.apply_defaults timeout:      @config.rpcs.no_lro.timeout,
                                   metadata:     call_metadata,
                                   retry_policy: @config.rpcs.no_lro.retry_policy

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @all_subclients_consumer_stub.no_lro request, options do |result, response|
              yield result, response if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
          end

          ##
          # Configuration class for the AllSubclientsConsumer REST API.
          #
          # This class represents the configuration for AllSubclientsConsumer REST,
          # providing control over timeouts, retry behavior, logging, transport
          # parameters, and other low-level controls. Certain parameters can also be
          # applied individually to specific RPCs. See
          # {::Testing::NonstandardLroGrpc::AllSubclientsConsumer::Rest::Client::Configuration::Rpcs}
          # for a list of RPCs that can be configured independently.
          #
          # Configuration can be applied globally to all clients, or to a single client
          # on construction.
          #
          # @example
          #
          #   # Modify the global config, setting the timeout for
          #   # plain_lro_rpc to 20 seconds,
          #   # and all remaining timeouts to 10 seconds.
          #   ::Testing::NonstandardLroGrpc::AllSubclientsConsumer::Rest::Client.configure do |config|
          #     config.timeout = 10.0
          #     config.rpcs.plain_lro_rpc.timeout = 20.0
          #   end
          #
          #   # Apply the above configuration only to a new client.
          #   client = ::Testing::NonstandardLroGrpc::AllSubclientsConsumer::Rest::Client.new do |config|
          #     config.timeout = 10.0
          #     config.rpcs.plain_lro_rpc.timeout = 20.0
          #   end
          #
          # @!attribute [rw] endpoint
          #   The hostname or hostname:port of the service endpoint.
          #   Defaults to `"nonstandardlro.example.com"`.
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

            config_attr :endpoint,      "nonstandardlro.example.com", ::String
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
            # @return [::Hash{::Symbol=>::Array{::Gapic::Rest::GrpcTranscoder::HttpBinding}}]
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
            # Configuration RPC class for the AllSubclientsConsumer API.
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
              # RPC-specific configuration for `plain_lro_rpc`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :plain_lro_rpc
              ##
              # RPC-specific configuration for `another_lro_rpc`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :another_lro_rpc
              ##
              # RPC-specific configuration for `non_copy_another_lro_rpc`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :non_copy_another_lro_rpc
              ##
              # RPC-specific configuration for `aip_lro`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :aip_lro
              ##
              # RPC-specific configuration for `no_lro`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :no_lro

              # @private
              def initialize parent_rpcs = nil
                plain_lro_rpc_config = parent_rpcs.plain_lro_rpc if parent_rpcs.respond_to? :plain_lro_rpc
                @plain_lro_rpc = ::Gapic::Config::Method.new plain_lro_rpc_config
                another_lro_rpc_config = parent_rpcs.another_lro_rpc if parent_rpcs.respond_to? :another_lro_rpc
                @another_lro_rpc = ::Gapic::Config::Method.new another_lro_rpc_config
                non_copy_another_lro_rpc_config = parent_rpcs.non_copy_another_lro_rpc if parent_rpcs.respond_to? :non_copy_another_lro_rpc
                @non_copy_another_lro_rpc = ::Gapic::Config::Method.new non_copy_another_lro_rpc_config
                aip_lro_config = parent_rpcs.aip_lro if parent_rpcs.respond_to? :aip_lro
                @aip_lro = ::Gapic::Config::Method.new aip_lro_config
                no_lro_config = parent_rpcs.no_lro if parent_rpcs.respond_to? :no_lro
                @no_lro = ::Gapic::Config::Method.new no_lro_config

                yield self if block_given?
              end
            end
          end
        end
      end
    end
  end
end
