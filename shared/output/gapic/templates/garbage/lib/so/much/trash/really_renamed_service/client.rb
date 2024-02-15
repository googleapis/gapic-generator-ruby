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

require "garbage/garbage_pb"

module So
  module Much
    module Trash
      module ReallyRenamedService
        ##
        # Client for the ReallyRenamedService service.
        #
        class Client
          # @private
          DEFAULT_ENDPOINT_TEMPLATE = "endlesstrash.example.net"

          # @private
          attr_reader :really_renamed_service_stub

          ##
          # Configure the ReallyRenamedService Client class.
          #
          # See {::So::Much::Trash::ReallyRenamedService::Client::Configuration}
          # for a description of the configuration fields.
          #
          # @example
          #
          #   # Modify the configuration for all ReallyRenamedService clients
          #   ::So::Much::Trash::ReallyRenamedService::Client.configure do |config|
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
          # Configure the ReallyRenamedService Client instance.
          #
          # The configuration is set to the derived mode, meaning that values can be changed,
          # but structural changes (adding new fields, etc.) are not allowed. Structural changes
          # should be made on {Client.configure}.
          #
          # See {::So::Much::Trash::ReallyRenamedService::Client::Configuration}
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
          # The effective universe domain
          #
          # @return [String]
          #
          def universe_domain
            @really_renamed_service_stub.universe_domain
          end

          ##
          # Create a new ReallyRenamedService client object.
          #
          # @example
          #
          #   # Create a client using the default configuration
          #   client = ::So::Much::Trash::ReallyRenamedService::Client.new
          #
          #   # Create a client using a custom configuration
          #   client = ::So::Much::Trash::ReallyRenamedService::Client.new do |config|
          #     config.timeout = 10.0
          #   end
          #
          # @yield [config] Configure the ReallyRenamedService client.
          # @yieldparam config [Client::Configuration]
          #
          def initialize
            # These require statements are intentionally placed here to initialize
            # the gRPC module only when it's required.
            # See https://github.com/googleapis/toolkit/issues/446
            require "gapic/grpc"
            require "gapic/telemetry"
            require "garbage/garbage_services_pb"

            # Create the configuration object
            @config = Configuration.new Client.configure

            # Yield the configuration if needed
            yield @config if block_given?

            # Create credentials
            credentials = @config.credentials
            # Use self-signed JWT if the endpoint is unchanged from default,
            # but only if the default endpoint does not have a region prefix.
            enable_self_signed_jwt = @config.endpoint.nil? ||
                                     (@config.endpoint == Configuration::DEFAULT_ENDPOINT &&
                                     !@config.endpoint.split(".").first.include?("-"))
            credentials ||= Credentials.default scope: @config.scope,
                                                enable_self_signed_jwt: enable_self_signed_jwt
            if credentials.is_a?(::String) || credentials.is_a?(::Hash)
              credentials = Credentials.new credentials, scope: @config.scope
            end
            @quota_project_id = @config.quota_project
            @quota_project_id ||= credentials.quota_project_id if credentials.respond_to? :quota_project_id

            @really_renamed_service_stub = ::Gapic::ServiceStub.new(
              ::So::Much::Trash::RenamedService::Stub,
              credentials: credentials,
              endpoint: @config.endpoint,
              endpoint_template: DEFAULT_ENDPOINT_TEMPLATE,
              universe_domain: @config.universe_domain,
              channel_args: @config.channel_args,
              interceptors: @config.interceptors,
              channel_pool_config: @config.channel_pool
            )

            @tracer_method = ::Gapic::Telemetry::Tracer.new.get_trace_wrapper @config
          end

          # Service calls

          ##
          # Retrieves an EmptyGarbage resource
          #
          # @overload get_empty_garbage(request, options = nil)
          #   Pass arguments to `get_empty_garbage` via a request object, either of type
          #   {::So::Much::Trash::EmptyGarbage} or an equivalent Hash.
          #
          #   @param request [::So::Much::Trash::EmptyGarbage, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [::So::Much::Trash::EmptyGarbage]
          # @yieldparam operation [::GRPC::ActiveCall::Operation]
          #
          # @return [::So::Much::Trash::EmptyGarbage]
          #
          # @raise [::GRPC::BadStatus] if the RPC is aborted.
          #
          # @example Basic example
          #   require "so/much/trash"
          #
          #   # Create a client object. The client can be reused for multiple calls.
          #   client = So::Much::Trash::ReallyRenamedService::Client.new
          #
          #   # Create a request. To set request fields, pass in keyword arguments.
          #   request = So::Much::Trash::EmptyGarbage.new
          #
          #   # Call the get_empty_garbage method.
          #   result = client.get_empty_garbage request
          #
          #   # The returned object is of type So::Much::Trash::EmptyGarbage.
          #   p result
          #
          def get_empty_garbage request, options = nil
            @tracer_method.call __method__ do
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::So::Much::Trash::EmptyGarbage

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.get_empty_garbage.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Garbage::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              options.apply_defaults timeout:      @config.rpcs.get_empty_garbage.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.get_empty_garbage.retry_policy

              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @really_renamed_service_stub.call_rpc :get_empty_garbage, request,
                                                    options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            end
          end

          ##
          # Configuration class for the ReallyRenamedService API.
          #
          # This class represents the configuration for ReallyRenamedService,
          # providing control over timeouts, retry behavior, logging, transport
          # parameters, and other low-level controls. Certain parameters can also be
          # applied individually to specific RPCs. See
          # {::So::Much::Trash::ReallyRenamedService::Client::Configuration::Rpcs}
          # for a list of RPCs that can be configured independently.
          #
          # Configuration can be applied globally to all clients, or to a single client
          # on construction.
          #
          # @example
          #
          #   # Modify the global config, setting the timeout for
          #   # get_empty_garbage to 20 seconds,
          #   # and all remaining timeouts to 10 seconds.
          #   ::So::Much::Trash::ReallyRenamedService::Client.configure do |config|
          #     config.timeout = 10.0
          #     config.rpcs.get_empty_garbage.timeout = 20.0
          #   end
          #
          #   # Apply the above configuration only to a new client.
          #   client = ::So::Much::Trash::ReallyRenamedService::Client.new do |config|
          #     config.timeout = 10.0
          #     config.rpcs.get_empty_garbage.timeout = 20.0
          #   end
          #
          # @!attribute [rw] endpoint
          #   A custom service endpoint, as a hostname or hostname:port. The default is
          #   nil, indicating to use the default endpoint in the current universe domain.
          #   @return [::String,nil]
          # @!attribute [rw] credentials
          #   Credentials to send with calls. You may provide any of the following types:
          #    *  (`String`) The path to a service account key file in JSON format
          #    *  (`Hash`) A service account key as a Hash
          #    *  (`Google::Auth::Credentials`) A googleauth credentials object
          #       (see the [googleauth docs](https://rubydoc.info/gems/googleauth/Google/Auth/Credentials))
          #    *  (`Signet::OAuth2::Client`) A signet oauth2 client object
          #       (see the [signet docs](https://rubydoc.info/gems/signet/Signet/OAuth2/Client))
          #    *  (`GRPC::Core::Channel`) a gRPC channel with included credentials
          #    *  (`GRPC::Core::ChannelCredentials`) a gRPC credentails object
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
          # @!attribute [rw] channel_args
          #   Extra parameters passed to the gRPC channel. Note: this is ignored if a
          #   `GRPC::Core::Channel` object is provided as the credential.
          #   @return [::Hash]
          # @!attribute [rw] interceptors
          #   An array of interceptors that are run before calls are executed.
          #   @return [::Array<::GRPC::ClientInterceptor>]
          # @!attribute [rw] timeout
          #   The call timeout in seconds.
          #   @return [::Numeric]
          # @!attribute [rw] metadata
          #   Additional gRPC headers to be sent with the call.
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
          # @!attribute [rw] universe_domain
          #   The universe domain within which to make requests. This determines the
          #   default endpoint URL. The default value of nil uses the environment
          #   universe (usually the default "googleapis.com" universe).
          #   @return [::String,nil]
          #
          class Configuration
            extend ::Gapic::Config

            # @private
            # The endpoint specific to the default "googleapis.com" universe. Deprecated.
            DEFAULT_ENDPOINT = "endlesstrash.example.net"

            config_attr :endpoint,      nil, ::String, nil
            config_attr :credentials,   nil do |value|
              allowed = [::String, ::Hash, ::Proc, ::Symbol, ::Google::Auth::Credentials, ::Signet::OAuth2::Client, nil]
              allowed += [::GRPC::Core::Channel, ::GRPC::Core::ChannelCredentials] if defined? ::GRPC
              allowed.any? { |klass| klass === value }
            end
            config_attr :scope,         nil, ::String, ::Array, nil
            config_attr :lib_name,      nil, ::String, nil
            config_attr :lib_version,   nil, ::String, nil
            config_attr(:channel_args,  { "grpc.service_config_disable_resolution" => 1 }, ::Hash, nil)
            config_attr :interceptors,  nil, ::Array, nil
            config_attr :timeout,       nil, ::Numeric, nil
            config_attr :metadata,      nil, ::Hash, nil
            config_attr :retry_policy,  nil, ::Hash, ::Proc, nil
            config_attr :quota_project, nil, ::String, nil
            config_attr :universe_domain, nil, ::String, nil
            config_attr :tracing_enabled, false, ::TrueClass, ::FalseClass, nil

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
            # Configuration for the channel pool
            # @return [::Gapic::ServiceStub::ChannelPool::Configuration]
            #
            def channel_pool
              @channel_pool ||= ::Gapic::ServiceStub::ChannelPool::Configuration.new
            end

            ##
            # Configuration RPC class for the ReallyRenamedService API.
            #
            # Includes fields providing the configuration for each RPC in this service.
            # Each configuration object is of type `Gapic::Config::Method` and includes
            # the following configuration fields:
            #
            #  *  `timeout` (*type:* `Numeric`) - The call timeout in seconds
            #  *  `metadata` (*type:* `Hash{Symbol=>String}`) - Additional gRPC headers
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
              # RPC-specific configuration for `get_empty_garbage`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :get_empty_garbage

              # @private
              def initialize parent_rpcs = nil
                get_empty_garbage_config = parent_rpcs.get_empty_garbage if parent_rpcs.respond_to? :get_empty_garbage
                @get_empty_garbage = ::Gapic::Config::Method.new get_empty_garbage_config

                yield self if block_given?
              end
            end
          end
        end
      end
    end
  end
end
