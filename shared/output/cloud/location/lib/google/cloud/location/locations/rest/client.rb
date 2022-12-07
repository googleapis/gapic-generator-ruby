# frozen_string_literal: true

# Copyright 2022 Google LLC
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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!

require "google/cloud/errors"
require "google/cloud/location/locations_pb"
require "google/cloud/location/locations/rest/service_stub"

module Google
  module Cloud
    module Location
      module Locations
        module Rest
          ##
          # REST client for the Locations service.
          #
          # An abstract interface that provides location-related information for
          # a service. Service-specific metadata is provided through the
          # {::Google::Cloud::Location::Location#metadata Location.metadata} field.
          #
          class Client
            # @private
            attr_reader :locations_stub

            ##
            # Configure the Locations Client class.
            #
            # See {::Google::Cloud::Location::Locations::Rest::Client::Configuration}
            # for a description of the configuration fields.
            #
            # @example
            #
            #   # Modify the configuration for all Locations clients
            #   ::Google::Cloud::Location::Locations::Rest::Client.configure do |config|
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
                namespace = ["Google", "Cloud", "Location"]
                parent_config = while namespace.any?
                                  parent_name = namespace.join "::"
                                  parent_const = const_get parent_name
                                  break parent_const.configure if parent_const.respond_to? :configure
                                  namespace.pop
                                end
                default_config = Client::Configuration.new parent_config

                default_config
              end
              yield @configure if block_given?
              @configure
            end

            ##
            # Configure the Locations Client instance.
            #
            # The configuration is set to the derived mode, meaning that values can be changed,
            # but structural changes (adding new fields, etc.) are not allowed. Structural changes
            # should be made on {Client.configure}.
            #
            # See {::Google::Cloud::Location::Locations::Rest::Client::Configuration}
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
            # Create a new Locations REST client object.
            #
            # @example
            #
            #   # Create a client using the default configuration
            #   client = ::Google::Cloud::Location::Locations::Rest::Client.new
            #
            #   # Create a client using a custom configuration
            #   client = ::Google::Cloud::Location::Locations::Rest::Client.new do |config|
            #     config.timeout = 10.0
            #   end
            #
            # @yield [config] Configure the Locations client.
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

              @locations_stub = ::Google::Cloud::Location::Locations::Rest::ServiceStub.new endpoint: @config.endpoint, credentials: credentials
            end

            # Service calls

            ##
            # Lists information about the supported locations for this service.
            #
            # @overload list_locations(request, options = nil)
            #   Pass arguments to `list_locations` via a request object, either of type
            #   {::Google::Cloud::Location::ListLocationsRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Location::ListLocationsRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @overload list_locations(name: nil, filter: nil, page_size: nil, page_token: nil)
            #   Pass arguments to `list_locations` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param name [::String]
            #     The resource that owns the locations collection, if applicable.
            #   @param filter [::String]
            #     The standard list filter.
            #   @param page_size [::Integer]
            #     The standard list page size.
            #   @param page_token [::String]
            #     The standard list page token.
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Gapic::Rest::PagedEnumerable<::Google::Cloud::Location::Location>]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Gapic::Rest::PagedEnumerable<::Google::Cloud::Location::Location>]
            #
            # @raise [::Google::Cloud::Error] if the REST call is aborted.
            def list_locations request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Location::ListLocationsRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              call_metadata = @config.rpcs.list_locations.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Location::VERSION,
                transports_version_send: [:rest]

              call_metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              options.apply_defaults timeout:      @config.rpcs.list_locations.timeout,
                                     metadata:     call_metadata,
                                     retry_policy: @config.rpcs.list_locations.retry_policy

              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              bindings_override = @config.bindings_override["google.cloud.location.Locations.ListLocations"]

              @locations_stub.list_locations request, options, bindings_override: bindings_override do |result, response|
                result = ::Gapic::Rest::PagedEnumerable.new @locations_stub, :list_locations, "locations", request, result, options
                yield result, response if block_given?
                return result
              end
            rescue ::Gapic::Rest::Error => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Gets information about a location.
            #
            # @overload get_location(request, options = nil)
            #   Pass arguments to `get_location` via a request object, either of type
            #   {::Google::Cloud::Location::GetLocationRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Location::GetLocationRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
            #
            # @overload get_location(name: nil)
            #   Pass arguments to `get_location` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param name [::String]
            #     Resource name for the location.
            # @yield [result, response] Access the result along with the Faraday response object
            # @yieldparam result [::Google::Cloud::Location::Location]
            # @yieldparam response [::Faraday::Response]
            #
            # @return [::Google::Cloud::Location::Location]
            #
            # @raise [::Google::Cloud::Error] if the REST call is aborted.
            def get_location request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Location::GetLocationRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              call_metadata = @config.rpcs.get_location.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Location::VERSION,
                transports_version_send: [:rest]

              call_metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              options.apply_defaults timeout:      @config.rpcs.get_location.timeout,
                                     metadata:     call_metadata,
                                     retry_policy: @config.rpcs.get_location.retry_policy

              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              bindings_override = @config.bindings_override["google.cloud.location.Locations.GetLocation"]

              @locations_stub.get_location request, options, bindings_override: bindings_override do |result, response|
                yield result, response if block_given?
                return result
              end
            rescue ::Gapic::Rest::Error => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Configuration class for the Locations REST API.
            #
            # This class represents the configuration for Locations REST,
            # providing control over timeouts, retry behavior, logging, transport
            # parameters, and other low-level controls. Certain parameters can also be
            # applied individually to specific RPCs. See
            # {::Google::Cloud::Location::Locations::Rest::Client::Configuration::Rpcs}
            # for a list of RPCs that can be configured independently.
            #
            # Configuration can be applied globally to all clients, or to a single client
            # on construction.
            #
            # @example
            #
            #   # Modify the global config, setting the timeout for
            #   # list_locations to 20 seconds,
            #   # and all remaining timeouts to 10 seconds.
            #   ::Google::Cloud::Location::Locations::Rest::Client.configure do |config|
            #     config.timeout = 10.0
            #     config.rpcs.list_locations.timeout = 20.0
            #   end
            #
            #   # Apply the above configuration only to a new client.
            #   client = ::Google::Cloud::Location::Locations::Rest::Client.new do |config|
            #     config.timeout = 10.0
            #     config.rpcs.list_locations.timeout = 20.0
            #   end
            #
            # @!attribute [rw] endpoint
            #   The hostname or hostname:port of the service endpoint.
            #   Defaults to `"cloud.googleapis.com"`.
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

              config_attr :endpoint,      "cloud.googleapis.com", ::String
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
              # Configuration RPC class for the Locations API.
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
                # RPC-specific configuration for `list_locations`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :list_locations
                ##
                # RPC-specific configuration for `get_location`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :get_location

                # @private
                def initialize parent_rpcs = nil
                  list_locations_config = parent_rpcs.list_locations if parent_rpcs.respond_to? :list_locations
                  @list_locations = ::Gapic::Config::Method.new list_locations_config
                  get_location_config = parent_rpcs.get_location if parent_rpcs.respond_to? :get_location
                  @get_location = ::Gapic::Config::Method.new get_location_config

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
