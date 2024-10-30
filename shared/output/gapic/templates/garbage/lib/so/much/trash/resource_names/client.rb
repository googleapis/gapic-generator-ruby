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

require "garbage/resource_names_pb"

module So
  module Much
    module Trash
      module ResourceNames
        ##
        # Client for the ResourceNames service.
        #
        # A service that exposes the messages that test the various combinations of path patterns
        #
        class Client
          # @private
          API_VERSION = ""

          # @private
          DEFAULT_ENDPOINT_TEMPLATE = "endlesstrash.example.net"

          include Paths

          # @private
          attr_reader :resource_names_stub

          ##
          # Configure the ResourceNames Client class.
          #
          # See {::So::Much::Trash::ResourceNames::Client::Configuration}
          # for a description of the configuration fields.
          #
          # @example
          #
          #   # Modify the configuration for all ResourceNames clients
          #   ::So::Much::Trash::ResourceNames::Client.configure do |config|
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
          # Configure the ResourceNames Client instance.
          #
          # The configuration is set to the derived mode, meaning that values can be changed,
          # but structural changes (adding new fields, etc.) are not allowed. Structural changes
          # should be made on {Client.configure}.
          #
          # See {::So::Much::Trash::ResourceNames::Client::Configuration}
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
            @resource_names_stub.universe_domain
          end

          ##
          # Create a new ResourceNames client object.
          #
          # @example
          #
          #   # Create a client using the default configuration
          #   client = ::So::Much::Trash::ResourceNames::Client.new
          #
          #   # Create a client using a custom configuration
          #   client = ::So::Much::Trash::ResourceNames::Client.new do |config|
          #     config.timeout = 10.0
          #   end
          #
          # @yield [config] Configure the ResourceNames client.
          # @yieldparam config [Client::Configuration]
          #
          def initialize
            # These require statements are intentionally placed here to initialize
            # the gRPC module only when it's required.
            # See https://github.com/googleapis/toolkit/issues/446
            require "gapic/grpc"
            require "garbage/resource_names_services_pb"

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

            @resource_names_stub = ::Gapic::ServiceStub.new(
              ::So::Much::Trash::ResourceNames::Stub,
              credentials: credentials,
              endpoint: @config.endpoint,
              endpoint_template: DEFAULT_ENDPOINT_TEMPLATE,
              universe_domain: @config.universe_domain,
              channel_args: @config.channel_args,
              interceptors: @config.interceptors,
              channel_pool_config: @config.channel_pool,
              logger: @config.logger
            )

            @resource_names_stub.stub_logger&.info do |entry|
              entry.set_system_name
              entry.set_service
              entry.message = "Created client for #{entry.service}"
              entry.set_credentials_fields credentials
              entry.set "customEndpoint", @config.endpoint if @config.endpoint
              entry.set "defaultTimeout", @config.timeout if @config.timeout
              entry.set "quotaProject", @quota_project_id if @quota_project_id
            end
          end

          ##
          # The logger used for request/response debug logging.
          #
          # @return [Logger]
          #
          def logger
            @resource_names_stub.logger
          end

          # Service calls

          ##
          # @overload simple_pattern_method(request, options = nil)
          #   Pass arguments to `simple_pattern_method` via a request object, either of type
          #   {::So::Much::Trash::SimplePatternRequest} or an equivalent Hash.
          #
          #   @param request [::So::Much::Trash::SimplePatternRequest, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload simple_pattern_method(real_name: nil, ref: nil, repeated_ref: nil)
          #   Pass arguments to `simple_pattern_method` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param real_name [::String]
          #   @param ref [::String]
          #   @param repeated_ref [::Array<::String>]
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [::So::Much::Trash::Response]
          # @yieldparam operation [::GRPC::ActiveCall::Operation]
          #
          # @return [::So::Much::Trash::Response]
          #
          # @raise [::GRPC::BadStatus] if the RPC is aborted.
          #
          # @example Basic example
          #   require "so/much/trash"
          #
          #   # Create a client object. The client can be reused for multiple calls.
          #   client = So::Much::Trash::ResourceNames::Client.new
          #
          #   # Create a request. To set request fields, pass in keyword arguments.
          #   request = So::Much::Trash::SimplePatternRequest.new
          #
          #   # Call the simple_pattern_method method.
          #   result = client.simple_pattern_method request
          #
          #   # The returned object is of type So::Much::Trash::Response.
          #   p result
          #
          def simple_pattern_method request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::So::Much::Trash::SimplePatternRequest

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.simple_pattern_method.metadata.to_h

            # Set x-goog-api-client, x-goog-user-project and x-goog-api-version headers
            metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Google::Garbage::VERSION
            metadata[:"x-goog-api-version"] = API_VERSION unless API_VERSION.empty?
            metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            options.apply_defaults timeout:      @config.rpcs.simple_pattern_method.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.simple_pattern_method.retry_policy

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @resource_names_stub.call_rpc :simple_pattern_method, request, options: options do |response, operation|
              yield response, operation if block_given?
            end
          end

          ##
          # @overload complex_pattern_method(request, options = nil)
          #   Pass arguments to `complex_pattern_method` via a request object, either of type
          #   {::So::Much::Trash::ComplexPatternRequest} or an equivalent Hash.
          #
          #   @param request [::So::Much::Trash::ComplexPatternRequest, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload complex_pattern_method(real_name: nil, ref: nil, repeated_ref: nil)
          #   Pass arguments to `complex_pattern_method` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param real_name [::String]
          #   @param ref [::String]
          #   @param repeated_ref [::Array<::String>]
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [::So::Much::Trash::Response]
          # @yieldparam operation [::GRPC::ActiveCall::Operation]
          #
          # @return [::So::Much::Trash::Response]
          #
          # @raise [::GRPC::BadStatus] if the RPC is aborted.
          #
          # @example Basic example
          #   require "so/much/trash"
          #
          #   # Create a client object. The client can be reused for multiple calls.
          #   client = So::Much::Trash::ResourceNames::Client.new
          #
          #   # Create a request. To set request fields, pass in keyword arguments.
          #   request = So::Much::Trash::ComplexPatternRequest.new
          #
          #   # Call the complex_pattern_method method.
          #   result = client.complex_pattern_method request
          #
          #   # The returned object is of type So::Much::Trash::Response.
          #   p result
          #
          def complex_pattern_method request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::So::Much::Trash::ComplexPatternRequest

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.complex_pattern_method.metadata.to_h

            # Set x-goog-api-client, x-goog-user-project and x-goog-api-version headers
            metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Google::Garbage::VERSION
            metadata[:"x-goog-api-version"] = API_VERSION unless API_VERSION.empty?
            metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            options.apply_defaults timeout:      @config.rpcs.complex_pattern_method.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.complex_pattern_method.retry_policy

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @resource_names_stub.call_rpc :complex_pattern_method, request, options: options do |response, operation|
              yield response, operation if block_given?
            end
          end

          ##
          # @overload resource_name_pattern_method(request, options = nil)
          #   Pass arguments to `resource_name_pattern_method` via a request object, either of type
          #   {::So::Much::Trash::ResourceNamePatternRequest} or an equivalent Hash.
          #
          #   @param request [::So::Much::Trash::ResourceNamePatternRequest, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload resource_name_pattern_method(name: nil)
          #   Pass arguments to `resource_name_pattern_method` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param name [::String]
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [::So::Much::Trash::Response]
          # @yieldparam operation [::GRPC::ActiveCall::Operation]
          #
          # @return [::So::Much::Trash::Response]
          #
          # @raise [::GRPC::BadStatus] if the RPC is aborted.
          #
          # @example Basic example
          #   require "so/much/trash"
          #
          #   # Create a client object. The client can be reused for multiple calls.
          #   client = So::Much::Trash::ResourceNames::Client.new
          #
          #   # Create a request. To set request fields, pass in keyword arguments.
          #   request = So::Much::Trash::ResourceNamePatternRequest.new
          #
          #   # Call the resource_name_pattern_method method.
          #   result = client.resource_name_pattern_method request
          #
          #   # The returned object is of type So::Much::Trash::Response.
          #   p result
          #
          def resource_name_pattern_method request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::So::Much::Trash::ResourceNamePatternRequest

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.resource_name_pattern_method.metadata.to_h

            # Set x-goog-api-client, x-goog-user-project and x-goog-api-version headers
            metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Google::Garbage::VERSION
            metadata[:"x-goog-api-version"] = API_VERSION unless API_VERSION.empty?
            metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            options.apply_defaults timeout:      @config.rpcs.resource_name_pattern_method.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.resource_name_pattern_method.retry_policy

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @resource_names_stub.call_rpc :resource_name_pattern_method, request,
                                          options: options do |response, operation|
              yield response, operation if block_given?
            end
          end

          ##
          # @overload multiparent_method(request, options = nil)
          #   Pass arguments to `multiparent_method` via a request object, either of type
          #   {::So::Much::Trash::MultiparentRequest} or an equivalent Hash.
          #
          #   @param request [::So::Much::Trash::MultiparentRequest, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload multiparent_method(parent: nil)
          #   Pass arguments to `multiparent_method` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param parent [::String]
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [::So::Much::Trash::Response]
          # @yieldparam operation [::GRPC::ActiveCall::Operation]
          #
          # @return [::So::Much::Trash::Response]
          #
          # @raise [::GRPC::BadStatus] if the RPC is aborted.
          #
          # @example Basic example
          #   require "so/much/trash"
          #
          #   # Create a client object. The client can be reused for multiple calls.
          #   client = So::Much::Trash::ResourceNames::Client.new
          #
          #   # Create a request. To set request fields, pass in keyword arguments.
          #   request = So::Much::Trash::MultiparentRequest.new
          #
          #   # Call the multiparent_method method.
          #   result = client.multiparent_method request
          #
          #   # The returned object is of type So::Much::Trash::Response.
          #   p result
          #
          def multiparent_method request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::So::Much::Trash::MultiparentRequest

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.multiparent_method.metadata.to_h

            # Set x-goog-api-client, x-goog-user-project and x-goog-api-version headers
            metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Google::Garbage::VERSION
            metadata[:"x-goog-api-version"] = API_VERSION unless API_VERSION.empty?
            metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            options.apply_defaults timeout:      @config.rpcs.multiparent_method.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.multiparent_method.retry_policy

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @resource_names_stub.call_rpc :multiparent_method, request, options: options do |response, operation|
              yield response, operation if block_given?
            end
          end

          ##
          # @overload no_arguments_multi_method(request, options = nil)
          #   Pass arguments to `no_arguments_multi_method` via a request object, either of type
          #   {::So::Much::Trash::NoArgumentsMultiRequest} or an equivalent Hash.
          #
          #   @param request [::So::Much::Trash::NoArgumentsMultiRequest, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload no_arguments_multi_method(name: nil)
          #   Pass arguments to `no_arguments_multi_method` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param name [::String]
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [::So::Much::Trash::Response]
          # @yieldparam operation [::GRPC::ActiveCall::Operation]
          #
          # @return [::So::Much::Trash::Response]
          #
          # @raise [::GRPC::BadStatus] if the RPC is aborted.
          #
          # @example Basic example
          #   require "so/much/trash"
          #
          #   # Create a client object. The client can be reused for multiple calls.
          #   client = So::Much::Trash::ResourceNames::Client.new
          #
          #   # Create a request. To set request fields, pass in keyword arguments.
          #   request = So::Much::Trash::NoArgumentsMultiRequest.new
          #
          #   # Call the no_arguments_multi_method method.
          #   result = client.no_arguments_multi_method request
          #
          #   # The returned object is of type So::Much::Trash::Response.
          #   p result
          #
          def no_arguments_multi_method request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::So::Much::Trash::NoArgumentsMultiRequest

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.no_arguments_multi_method.metadata.to_h

            # Set x-goog-api-client, x-goog-user-project and x-goog-api-version headers
            metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Google::Garbage::VERSION
            metadata[:"x-goog-api-version"] = API_VERSION unless API_VERSION.empty?
            metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            options.apply_defaults timeout:      @config.rpcs.no_arguments_multi_method.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.no_arguments_multi_method.retry_policy

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @resource_names_stub.call_rpc :no_arguments_multi_method, request, options: options do |response, operation|
              yield response, operation if block_given?
            end
          end

          ##
          # Configuration class for the ResourceNames API.
          #
          # This class represents the configuration for ResourceNames,
          # providing control over timeouts, retry behavior, logging, transport
          # parameters, and other low-level controls. Certain parameters can also be
          # applied individually to specific RPCs. See
          # {::So::Much::Trash::ResourceNames::Client::Configuration::Rpcs}
          # for a list of RPCs that can be configured independently.
          #
          # Configuration can be applied globally to all clients, or to a single client
          # on construction.
          #
          # @example
          #
          #   # Modify the global config, setting the timeout for
          #   # simple_pattern_method to 20 seconds,
          #   # and all remaining timeouts to 10 seconds.
          #   ::So::Much::Trash::ResourceNames::Client.configure do |config|
          #     config.timeout = 10.0
          #     config.rpcs.simple_pattern_method.timeout = 20.0
          #   end
          #
          #   # Apply the above configuration only to a new client.
          #   client = ::So::Much::Trash::ResourceNames::Client.new do |config|
          #     config.timeout = 10.0
          #     config.rpcs.simple_pattern_method.timeout = 20.0
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
          # @!attribute [rw] logger
          #   A custom logger to use for request/response debug logging, or the value
          #   `:default` (the default) to construct a default logger, or `nil` to
          #   explicitly disable logging.
          #   @return [::Logger,:default,nil]
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
            config_attr :logger, :default, ::Logger, nil, :default

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
            # Configuration RPC class for the ResourceNames API.
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
              # RPC-specific configuration for `simple_pattern_method`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :simple_pattern_method
              ##
              # RPC-specific configuration for `complex_pattern_method`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :complex_pattern_method
              ##
              # RPC-specific configuration for `resource_name_pattern_method`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :resource_name_pattern_method
              ##
              # RPC-specific configuration for `multiparent_method`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :multiparent_method
              ##
              # RPC-specific configuration for `no_arguments_multi_method`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :no_arguments_multi_method

              # @private
              def initialize parent_rpcs = nil
                simple_pattern_method_config = parent_rpcs.simple_pattern_method if parent_rpcs.respond_to? :simple_pattern_method
                @simple_pattern_method = ::Gapic::Config::Method.new simple_pattern_method_config
                complex_pattern_method_config = parent_rpcs.complex_pattern_method if parent_rpcs.respond_to? :complex_pattern_method
                @complex_pattern_method = ::Gapic::Config::Method.new complex_pattern_method_config
                resource_name_pattern_method_config = parent_rpcs.resource_name_pattern_method if parent_rpcs.respond_to? :resource_name_pattern_method
                @resource_name_pattern_method = ::Gapic::Config::Method.new resource_name_pattern_method_config
                multiparent_method_config = parent_rpcs.multiparent_method if parent_rpcs.respond_to? :multiparent_method
                @multiparent_method = ::Gapic::Config::Method.new multiparent_method_config
                no_arguments_multi_method_config = parent_rpcs.no_arguments_multi_method if parent_rpcs.respond_to? :no_arguments_multi_method
                @no_arguments_multi_method = ::Gapic::Config::Method.new no_arguments_multi_method_config

                yield self if block_given?
              end
            end
          end
        end
      end
    end
  end
end
