# frozen_string_literal: true

# Copyright 2021 Google LLC
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
require "google/cloud/compute/v1/compute_pb"
require "google/cloud/compute/v1/machine_types/rest/service_stub"

module Google
  module Cloud
    module Compute
      module V1
        module MachineTypes
          module Rest
            ##
            # REST client for the MachineTypes service.
            #
            # The MachineTypes API.
            #
            class Client
              # @private
              attr_reader :machine_types_stub

              ##
              # Configure the MachineTypes Client class.
              #
              # See {::Google::Cloud::Compute::V1::MachineTypes::Rest::Client::Configuration}
              # for a description of the configuration fields.
              #
              # @example
              #
              #   # Modify the configuration for all MachineTypes clients
              #   ::Google::Cloud::Compute::V1::MachineTypes::Rest::Client.configure do |config|
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
                  namespace = ["Google", "Cloud", "Compute", "V1"]
                  parent_config = while namespace.any?
                                    parent_name = namespace.join "::"
                                    parent_const = const_get parent_name
                                    break parent_const.configure if parent_const.respond_to? :configure
                                    namespace.pop
                                  end
                  default_config = Client::Configuration.new parent_config

                  default_config.rpcs.aggregated_list.timeout = 600.0
                  default_config.rpcs.aggregated_list.retry_policy = {
                    initial_delay: 0.1, max_delay: 60.0, multiplier: 1.3, retry_codes: [4, 14]
                  }

                  default_config.rpcs.get.timeout = 600.0
                  default_config.rpcs.get.retry_policy = {
                    initial_delay: 0.1, max_delay: 60.0, multiplier: 1.3, retry_codes: [4, 14]
                  }

                  default_config.rpcs.list.timeout = 600.0
                  default_config.rpcs.list.retry_policy = {
                    initial_delay: 0.1, max_delay: 60.0, multiplier: 1.3, retry_codes: [4, 14]
                  }

                  default_config
                end
                yield @configure if block_given?
                @configure
              end

              ##
              # Configure the MachineTypes Client instance.
              #
              # The configuration is set to the derived mode, meaning that values can be changed,
              # but structural changes (adding new fields, etc.) are not allowed. Structural changes
              # should be made on {Client.configure}.
              #
              # See {::Google::Cloud::Compute::V1::MachineTypes::Rest::Client::Configuration}
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
              # Create a new MachineTypes REST client object.
              #
              # @example
              #
              #   # Create a client using the default configuration
              #   client = ::Google::Cloud::Compute::V1::MachineTypes::Rest::Client.new
              #
              #   # Create a client using a custom configuration
              #   client = ::Google::Cloud::Compute::V1::MachineTypes::Rest::Client.new do |config|
              #     config.timeout = 10.0
              #   end
              #
              # @yield [config] Configure the MachineTypes client.
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

                @machine_types_stub = ::Google::Cloud::Compute::V1::MachineTypes::Rest::ServiceStub.new endpoint: @config.endpoint, credentials: credentials
              end

              # Service calls

              ##
              # Retrieves an aggregated list of machine types.
              #
              # @overload aggregated_list(request, options = nil)
              #   Pass arguments to `aggregated_list` via a request object, either of type
              #   {::Google::Cloud::Compute::V1::AggregatedListMachineTypesRequest} or an equivalent Hash.
              #
              #   @param request [::Google::Cloud::Compute::V1::AggregatedListMachineTypesRequest, ::Hash]
              #     A request object representing the call parameters. Required. To specify no
              #     parameters, or to keep all the default parameter values, pass an empty Hash.
              #   @param options [::Gapic::CallOptions, ::Hash]
              #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
              #     Note: currently retry functionality is not implemented. While it is possible
              #     to set it using ::Gapic::CallOptions, it will not be applied
              #
              # @overload aggregated_list(filter: nil, include_all_scopes: nil, max_results: nil, order_by: nil, page_token: nil, project: nil, return_partial_success: nil)
              #   Pass arguments to `aggregated_list` via keyword arguments. Note that at
              #   least one keyword argument is required. To specify no parameters, or to keep all
              #   the default parameter values, pass an empty Hash as a request object (see above).
              #
              #   @param filter [::String]
              #     A filter expression that filters resources listed in the response. The expression must specify the field name, a comparison operator, and the value that you want to use for filtering. The value must be a string, a number, or a boolean. The comparison operator must be either `=`, `!=`, `>`, or `<`. For example, if you are filtering Compute Engine instances, you can exclude instances named `example-instance` by specifying `name != example-instance`. You can also filter nested fields. For example, you could specify `scheduling.automaticRestart = false` to include instances only if they are not scheduled for automatic restarts. You can use filtering on nested fields to filter based on resource labels. To filter on multiple expressions, provide each separate expression within parentheses. For example: ``` (scheduling.automaticRestart = true) (cpuPlatform = "Intel Skylake") ``` By default, each expression is an `AND` expression. However, you can include `AND` and `OR` expressions explicitly. For example: ``` (cpuPlatform = "Intel Skylake") OR (cpuPlatform = "Intel Broadwell") AND (scheduling.automaticRestart = true) ```
              #   @param include_all_scopes [::Boolean]
              #     Indicates whether every visible scope for each scope type (zone, region, global) should be included in the response. For new resource types added after this field, the flag has no effect as new resource types will always include every visible scope for each scope type in response. For resource types which predate this field, if this flag is omitted or false, only scopes of the scope types where the resource type is expected to be found will be included.
              #   @param max_results [::Integer]
              #     The maximum number of results per page that should be returned. If the number of available results is larger than `maxResults`, Compute Engine returns a `nextPageToken` that can be used to get the next page of results in subsequent list requests. Acceptable values are `0` to `500`, inclusive. (Default: `500`)
              #   @param order_by [::String]
              #     Sorts list results by a certain order. By default, results are returned in alphanumerical order based on the resource name. You can also sort results in descending order based on the creation timestamp using `orderBy="creationTimestamp desc"`. This sorts results based on the `creationTimestamp` field in reverse chronological order (newest result first). Use this to sort resources like operations so that the newest operation is returned first. Currently, only sorting by `name` or `creationTimestamp desc` is supported.
              #   @param page_token [::String]
              #     Specifies a page token to use. Set `pageToken` to the `nextPageToken` returned by a previous list request to get the next page of results.
              #   @param project [::String]
              #     Project ID for this request.
              #   @param return_partial_success [::Boolean]
              #     Opt-in for partial success behavior which provides partial results in case of failure. The default value is false.
              # @yield [result, response] Access the result along with the Faraday response object
              # @yieldparam result [::Gapic::Rest::PagedEnumerable<::String, ::Google::Cloud::Compute::V1::MachineTypesScopedList>]
              # @yieldparam response [::Faraday::Response]
              #
              # @return [::Gapic::Rest::PagedEnumerable<::String, ::Google::Cloud::Compute::V1::MachineTypesScopedList>]
              #
              # @raise [::Google::Cloud::Error] if the REST call is aborted.
              def aggregated_list request, options = nil
                raise ::ArgumentError, "request must be provided" if request.nil?

                request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Compute::V1::AggregatedListMachineTypesRequest

                # Converts hash and nil to an options object
                options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

                # Customize the options with defaults
                call_metadata = @config.rpcs.aggregated_list.metadata.to_h

                # Set x-goog-api-client header
                call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                  lib_name: @config.lib_name, lib_version: @config.lib_version,
                  gapic_version: ::Google::Cloud::Compute::V1::VERSION,
                  transports_version_send: [:rest]

                options.apply_defaults timeout:      @config.rpcs.aggregated_list.timeout,
                                       metadata:     call_metadata

                options.apply_defaults timeout:      @config.timeout,
                                       metadata:     @config.metadata

                @machine_types_stub.aggregated_list request, options do |result, response|
                  result = ::Gapic::Rest::PagedEnumerable.new @machine_types_stub, :aggregated_list, "items", request, result, options
                  yield result, response if block_given?
                  return result
                end
              rescue ::Faraday::Error => e
                gapic_error = ::Gapic::Rest::Error.wrap_faraday_error e
                raise ::Google::Cloud::Error.from_error(gapic_error)
              end

              ##
              # Returns the specified machine type. Gets a list of available machine types by making a list() request.
              #
              # @overload get(request, options = nil)
              #   Pass arguments to `get` via a request object, either of type
              #   {::Google::Cloud::Compute::V1::GetMachineTypeRequest} or an equivalent Hash.
              #
              #   @param request [::Google::Cloud::Compute::V1::GetMachineTypeRequest, ::Hash]
              #     A request object representing the call parameters. Required. To specify no
              #     parameters, or to keep all the default parameter values, pass an empty Hash.
              #   @param options [::Gapic::CallOptions, ::Hash]
              #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
              #     Note: currently retry functionality is not implemented. While it is possible
              #     to set it using ::Gapic::CallOptions, it will not be applied
              #
              # @overload get(machine_type: nil, project: nil, zone: nil)
              #   Pass arguments to `get` via keyword arguments. Note that at
              #   least one keyword argument is required. To specify no parameters, or to keep all
              #   the default parameter values, pass an empty Hash as a request object (see above).
              #
              #   @param machine_type [::String]
              #     Name of the machine type to return.
              #   @param project [::String]
              #     Project ID for this request.
              #   @param zone [::String]
              #     The name of the zone for this request.
              # @yield [result, response] Access the result along with the Faraday response object
              # @yieldparam result [::Google::Cloud::Compute::V1::MachineType]
              # @yieldparam response [::Faraday::Response]
              #
              # @return [::Google::Cloud::Compute::V1::MachineType]
              #
              # @raise [::Google::Cloud::Error] if the REST call is aborted.
              def get request, options = nil
                raise ::ArgumentError, "request must be provided" if request.nil?

                request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Compute::V1::GetMachineTypeRequest

                # Converts hash and nil to an options object
                options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

                # Customize the options with defaults
                call_metadata = @config.rpcs.get.metadata.to_h

                # Set x-goog-api-client header
                call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                  lib_name: @config.lib_name, lib_version: @config.lib_version,
                  gapic_version: ::Google::Cloud::Compute::V1::VERSION,
                  transports_version_send: [:rest]

                options.apply_defaults timeout:      @config.rpcs.get.timeout,
                                       metadata:     call_metadata

                options.apply_defaults timeout:      @config.timeout,
                                       metadata:     @config.metadata

                @machine_types_stub.get request, options do |result, response|
                  yield result, response if block_given?
                  return result
                end
              rescue ::Faraday::Error => e
                gapic_error = ::Gapic::Rest::Error.wrap_faraday_error e
                raise ::Google::Cloud::Error.from_error(gapic_error)
              end

              ##
              # Retrieves a list of machine types available to the specified project.
              #
              # @overload list(request, options = nil)
              #   Pass arguments to `list` via a request object, either of type
              #   {::Google::Cloud::Compute::V1::ListMachineTypesRequest} or an equivalent Hash.
              #
              #   @param request [::Google::Cloud::Compute::V1::ListMachineTypesRequest, ::Hash]
              #     A request object representing the call parameters. Required. To specify no
              #     parameters, or to keep all the default parameter values, pass an empty Hash.
              #   @param options [::Gapic::CallOptions, ::Hash]
              #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
              #     Note: currently retry functionality is not implemented. While it is possible
              #     to set it using ::Gapic::CallOptions, it will not be applied
              #
              # @overload list(filter: nil, max_results: nil, order_by: nil, page_token: nil, project: nil, return_partial_success: nil, zone: nil)
              #   Pass arguments to `list` via keyword arguments. Note that at
              #   least one keyword argument is required. To specify no parameters, or to keep all
              #   the default parameter values, pass an empty Hash as a request object (see above).
              #
              #   @param filter [::String]
              #     A filter expression that filters resources listed in the response. The expression must specify the field name, a comparison operator, and the value that you want to use for filtering. The value must be a string, a number, or a boolean. The comparison operator must be either `=`, `!=`, `>`, or `<`. For example, if you are filtering Compute Engine instances, you can exclude instances named `example-instance` by specifying `name != example-instance`. You can also filter nested fields. For example, you could specify `scheduling.automaticRestart = false` to include instances only if they are not scheduled for automatic restarts. You can use filtering on nested fields to filter based on resource labels. To filter on multiple expressions, provide each separate expression within parentheses. For example: ``` (scheduling.automaticRestart = true) (cpuPlatform = "Intel Skylake") ``` By default, each expression is an `AND` expression. However, you can include `AND` and `OR` expressions explicitly. For example: ``` (cpuPlatform = "Intel Skylake") OR (cpuPlatform = "Intel Broadwell") AND (scheduling.automaticRestart = true) ```
              #   @param max_results [::Integer]
              #     The maximum number of results per page that should be returned. If the number of available results is larger than `maxResults`, Compute Engine returns a `nextPageToken` that can be used to get the next page of results in subsequent list requests. Acceptable values are `0` to `500`, inclusive. (Default: `500`)
              #   @param order_by [::String]
              #     Sorts list results by a certain order. By default, results are returned in alphanumerical order based on the resource name. You can also sort results in descending order based on the creation timestamp using `orderBy="creationTimestamp desc"`. This sorts results based on the `creationTimestamp` field in reverse chronological order (newest result first). Use this to sort resources like operations so that the newest operation is returned first. Currently, only sorting by `name` or `creationTimestamp desc` is supported.
              #   @param page_token [::String]
              #     Specifies a page token to use. Set `pageToken` to the `nextPageToken` returned by a previous list request to get the next page of results.
              #   @param project [::String]
              #     Project ID for this request.
              #   @param return_partial_success [::Boolean]
              #     Opt-in for partial success behavior which provides partial results in case of failure. The default value is false.
              #   @param zone [::String]
              #     The name of the zone for this request.
              # @yield [result, response] Access the result along with the Faraday response object
              # @yieldparam result [::Gapic::Rest::PagedEnumerable<::Google::Cloud::Compute::V1::MachineType>]
              # @yieldparam response [::Faraday::Response]
              #
              # @return [::Gapic::Rest::PagedEnumerable<::Google::Cloud::Compute::V1::MachineType>]
              #
              # @raise [::Google::Cloud::Error] if the REST call is aborted.
              def list request, options = nil
                raise ::ArgumentError, "request must be provided" if request.nil?

                request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Compute::V1::ListMachineTypesRequest

                # Converts hash and nil to an options object
                options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

                # Customize the options with defaults
                call_metadata = @config.rpcs.list.metadata.to_h

                # Set x-goog-api-client header
                call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                  lib_name: @config.lib_name, lib_version: @config.lib_version,
                  gapic_version: ::Google::Cloud::Compute::V1::VERSION,
                  transports_version_send: [:rest]

                options.apply_defaults timeout:      @config.rpcs.list.timeout,
                                       metadata:     call_metadata

                options.apply_defaults timeout:      @config.timeout,
                                       metadata:     @config.metadata

                @machine_types_stub.list request, options do |result, response|
                  result = ::Gapic::Rest::PagedEnumerable.new @machine_types_stub, :list, "items", request, result, options
                  yield result, response if block_given?
                  return result
                end
              rescue ::Faraday::Error => e
                gapic_error = ::Gapic::Rest::Error.wrap_faraday_error e
                raise ::Google::Cloud::Error.from_error(gapic_error)
              end

              ##
              # Configuration class for the MachineTypes REST API.
              #
              # This class represents the configuration for MachineTypes REST,
              # providing control over credentials, timeouts, retry behavior, logging.
              #
              # Configuration can be applied globally to all clients, or to a single client
              # on construction.
              #
              # # Examples
              #
              # To modify the global config, setting the timeout for all calls to 10 seconds:
              #
              #     ::Google::Cloud::Compute::V1::MachineTypes::Client.configure do |config|
              #       config.timeout = 10.0
              #     end
              #
              # To apply the above configuration only to a new client:
              #
              #     client = ::Google::Cloud::Compute::V1::MachineTypes::Client.new do |config|
              #       config.timeout = 10.0
              #     end
              #
              # @!attribute [rw] endpoint
              #   The hostname or hostname:port of the service endpoint.
              #   Defaults to `"compute.googleapis.com"`.
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

                config_attr :endpoint,      "compute.googleapis.com", ::String
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
                # Configuration RPC class for the MachineTypes API.
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
                  # RPC-specific configuration for `aggregated_list`
                  # @return [::Gapic::Config::Method]
                  #
                  attr_reader :aggregated_list
                  ##
                  # RPC-specific configuration for `get`
                  # @return [::Gapic::Config::Method]
                  #
                  attr_reader :get
                  ##
                  # RPC-specific configuration for `list`
                  # @return [::Gapic::Config::Method]
                  #
                  attr_reader :list

                  # @private
                  def initialize parent_rpcs = nil
                    aggregated_list_config = parent_rpcs.aggregated_list if parent_rpcs.respond_to? :aggregated_list
                    @aggregated_list = ::Gapic::Config::Method.new aggregated_list_config
                    get_config = parent_rpcs.get if parent_rpcs.respond_to? :get
                    @get = ::Gapic::Config::Method.new get_config
                    list_config = parent_rpcs.list if parent_rpcs.respond_to? :list
                    @list = ::Gapic::Config::Method.new list_config

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
end
