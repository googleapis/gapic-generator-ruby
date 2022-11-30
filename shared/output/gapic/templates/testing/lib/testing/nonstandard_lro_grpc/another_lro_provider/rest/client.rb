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
require "testing/nonstandard_lro_grpc/another_lro_provider/rest/service_stub"
require "google/cloud/location/rest"

module Testing
  module NonstandardLroGrpc
    module AnotherLroProvider
      module Rest
        ##
        # REST client for the AnotherLroProvider service.
        #
        class Client
          # @private
          attr_reader :another_lro_provider_stub

          ##
          # Configure the AnotherLroProvider Client class.
          #
          # See {::Testing::NonstandardLroGrpc::AnotherLroProvider::Rest::Client::Configuration}
          # for a description of the configuration fields.
          #
          # @example
          #
          #   # Modify the configuration for all AnotherLroProvider clients
          #   ::Testing::NonstandardLroGrpc::AnotherLroProvider::Rest::Client.configure do |config|
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
          # Configure the AnotherLroProvider Client instance.
          #
          # The configuration is set to the derived mode, meaning that values can be changed,
          # but structural changes (adding new fields, etc.) are not allowed. Structural changes
          # should be made on {Client.configure}.
          #
          # See {::Testing::NonstandardLroGrpc::AnotherLroProvider::Rest::Client::Configuration}
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
          # Create a new AnotherLroProvider REST client object.
          #
          # @example
          #
          #   # Create a client using the default configuration
          #   client = ::Testing::NonstandardLroGrpc::AnotherLroProvider::Rest::Client.new
          #
          #   # Create a client using a custom configuration
          #   client = ::Testing::NonstandardLroGrpc::AnotherLroProvider::Rest::Client.new do |config|
          #     config.timeout = 10.0
          #   end
          #
          # @yield [config] Configure the AnotherLroProvider client.
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

            @location_client = Google::Cloud::Location::Locations::Rest::Client.new do |config|
              config.credentials = credentials
              config.quota_project = @quota_project_id
              config.endpoint = @config.endpoint
              config.bindings_override = @config.bindings_override
            end

            @another_lro_provider_stub = ::Testing::NonstandardLroGrpc::AnotherLroProvider::Rest::ServiceStub.new endpoint: @config.endpoint,
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
          # @overload get_another(request, options = nil)
          #   Pass arguments to `get_another` via a request object, either of type
          #   {::Testing::NonstandardLroGrpc::LroAnotherGetRequest} or an equivalent Hash.
          #
          #   @param request [::Testing::NonstandardLroGrpc::LroAnotherGetRequest, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #
          # @overload get_another(another_request_id: nil, another_lro_name: nil)
          #   Pass arguments to `get_another` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param another_request_id [::String]
          #   @param another_lro_name [::String]
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Testing::NonstandardLroGrpc::NonstandardOperation]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Testing::NonstandardLroGrpc::NonstandardOperation]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def get_another request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Testing::NonstandardLroGrpc::LroAnotherGetRequest

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.get_another.metadata.to_h

            # Set x-goog-api-client and x-goog-user-project headers
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            call_metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            options.apply_defaults timeout:      @config.rpcs.get_another.timeout,
                                   metadata:     call_metadata,
                                   retry_policy: @config.rpcs.get_another.retry_policy

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @another_lro_provider_stub.get_another request, options do |result, response|
              yield result, response if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
          end

          ##
          # Configuration class for the AnotherLroProvider REST API.
          #
          # This class represents the configuration for AnotherLroProvider REST,
          # providing control over timeouts, retry behavior, logging, transport
          # parameters, and other low-level controls. Certain parameters can also be
          # applied individually to specific RPCs. See
          # {::Testing::NonstandardLroGrpc::AnotherLroProvider::Rest::Client::Configuration::Rpcs}
          # for a list of RPCs that can be configured independently.
          #
          # Configuration can be applied globally to all clients, or to a single client
          # on construction.
          #
          # @example
          #
          #   # Modify the global config, setting the timeout for
          #   # get_another to 20 seconds,
          #   # and all remaining timeouts to 10 seconds.
          #   ::Testing::NonstandardLroGrpc::AnotherLroProvider::Rest::Client.configure do |config|
          #     config.timeout = 10.0
          #     config.rpcs.get_another.timeout = 20.0
          #   end
          #
          #   # Apply the above configuration only to a new client.
          #   client = ::Testing::NonstandardLroGrpc::AnotherLroProvider::Rest::Client.new do |config|
          #     config.timeout = 10.0
          #     config.rpcs.get_another.timeout = 20.0
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
            # Configuration RPC class for the AnotherLroProvider API.
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
              # RPC-specific configuration for `get_another`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :get_another

              # @private
              def initialize parent_rpcs = nil
                get_another_config = parent_rpcs.get_another if parent_rpcs.respond_to? :get_another
                @get_another = ::Gapic::Config::Method.new get_another_config

                yield self if block_given?
              end
            end
          end
        end
      end
    end
  end
end
