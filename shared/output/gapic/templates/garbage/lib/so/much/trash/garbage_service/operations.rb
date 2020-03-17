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

require "gapic/common"
require "gapic/operation"

require "google/garbage/version"
require "so/much/trash/garbage_service/client"
require "google/longrunning/operations_pb"


module So
  module Much
    module Trash
      module GarbageService
        # Service that implements Longrunning Operations API.
        class Operations
          # @private
          attr_reader :operations_stub

          ##
          # Configuration for the GarbageService Operations API.
          #
          # @yield [config] Configure the Operations client.
          # @yieldparam config [Operations::Configuration]
          #
          # @return [Operations::Configuration]
          #
          def self.configure
            @configure ||= Operations::Configuration.new
            yield @configure if block_given?
            @configure
          end

          ##
          # Configure the GarbageService Operations instance.
          #
          # The configuration is set to the derived mode, meaning that values can be changed,
          # but structural changes (adding new fields, etc.) are not allowed. Structural changes
          # should be made on {Operations.configure}.
          #
          # @yield [config] Configure the Operations client.
          # @yieldparam config [Operations::Configuration]
          #
          # @return [Operations::Configuration]
          #
          def configure
            yield @config if block_given?
            @config
          end

          ##
          # Create a new Operations client object.
          #
          # @yield [config] Configure the Client client.
          # @yieldparam config [Operations::Configuration]
          #
          def initialize
            # These require statements are intentionally placed here to initialize
            # the gRPC module only when it's required.
            # See https://github.com/googleapis/toolkit/issues/446
            require "gapic/grpc"
            require "google/longrunning/operations_services_pb"

            # Create the configuration object
            @config = Configuration.new Operations.configure

            # Yield the configuration if needed
            yield @config if block_given?

            # Create credentials
            credentials = @config.credentials
            credentials ||= Credentials.default scope: @config.scope
            if credentials.is_a?(String) || credentials.is_a?(Hash)
              credentials = Credentials.new credentials, scope: @config.scope
            end

            @operations_stub = Gapic::ServiceStub.new(
              Google::Longrunning::Operations::Stub,
              credentials:  credentials,
              endpoint:     @config.endpoint,
              channel_args: @config.channel_args,
              interceptors: @config.interceptors
            )
          end

          # Service calls

          ##
          # Lists operations that match the specified filter in the request. If the
          # server doesn't support this method, it returns `UNIMPLEMENTED`.
          #
          # NOTE: the `name` binding below allows API services to override the binding
          # to use different resource name schemes, such as `users/*/operations`.
          #
          # @overload list_operations(request, options = nil)
          #   @param request [Google::Longrunning::ListOperationsRequest | Hash]
          #     Lists operations that match the specified filter in the request. If the
          #     server doesn't support this method, it returns `UNIMPLEMENTED`.
          #
          #     NOTE: the `name` binding below allows API services to override the binding
          #     to use different resource name schemes, such as `users/*/operations`.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload list_operations(name: nil, filter: nil, page_size: nil, page_token: nil)
          #   @param name [String]
          #     The name of the operation collection.
          #   @param filter [String]
          #     The standard list filter.
          #   @param page_size [Integer]
          #     The standard list page size.
          #   @param page_token [String]
          #     The standard list page token.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Gapic::PagedEnumerable<Gapic::Operation>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Gapic::PagedEnumerable<Gapic::Operation>]
          #
          # @raise [GRPC::BadStatus] if the RPC is aborted.
          #
          def list_operations request, options = nil
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Longrunning::ListOperationsRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.list_operations.metadata.to_h

            # Set x-goog-api-client and x-goog-user-project headers
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Google::Garbage::VERSION
            metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.list_operations.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.list_operations.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @operations_stub.call_rpc :list_operations, request, options: options do |response, operation|
              wrap_lro_operation = ->(op_response) { Gapic::Operation.new op_response, @operations_client }
              response = Gapic::PagedEnumerable.new @operations_stub, :list_operations, request, response, operation, options, format_resource: wrap_lro_operation
              yield response, operation if block_given?
              return response
            end
          end

          ##
          # Gets the latest state of a long-running operation.  Clients can use this
          # method to poll the operation result at intervals as recommended by the API
          # service.
          #
          # @overload get_operation(request, options = nil)
          #   @param request [Google::Longrunning::GetOperationRequest | Hash]
          #     Gets the latest state of a long-running operation.  Clients can use this
          #     method to poll the operation result at intervals as recommended by the API
          #     service.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload get_operation(name: nil)
          #   @param name [String]
          #     The name of the operation resource.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Gapic::Operation]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Gapic::Operation]
          #
          # @raise [GRPC::BadStatus] if the RPC is aborted.
          #
          def get_operation request, options = nil
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Longrunning::GetOperationRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.get_operation.metadata.to_h

            # Set x-goog-api-client and x-goog-user-project headers
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Google::Garbage::VERSION
            metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.get_operation.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.get_operation.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @operations_stub.call_rpc :get_operation, request, options: options do |response, operation|
              response = Gapic::Operation.new response, @operations_client, options: options
              yield response, operation if block_given?
              return response
            end
          end

          ##
          # Deletes a long-running operation. This method indicates that the client is
          # no longer interested in the operation result. It does not cancel the
          # operation. If the server doesn't support this method, it returns
          # `google.rpc.Code.UNIMPLEMENTED`.
          #
          # @overload delete_operation(request, options = nil)
          #   @param request [Google::Longrunning::DeleteOperationRequest | Hash]
          #     Deletes a long-running operation. This method indicates that the client is
          #     no longer interested in the operation result. It does not cancel the
          #     operation. If the server doesn't support this method, it returns
          #     `google.rpc.Code.UNIMPLEMENTED`.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload delete_operation(name: nil)
          #   @param name [String]
          #     The name of the operation resource to be deleted.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Protobuf::Empty]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Protobuf::Empty]
          #
          # @raise [GRPC::BadStatus] if the RPC is aborted.
          #
          def delete_operation request, options = nil
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Longrunning::DeleteOperationRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.delete_operation.metadata.to_h

            # Set x-goog-api-client and x-goog-user-project headers
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Google::Garbage::VERSION
            metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.delete_operation.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.delete_operation.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @operations_stub.call_rpc :delete_operation, request, options: options do |response, operation|
              yield response, operation if block_given?
              return response
            end
          end

          ##
          # Starts asynchronous cancellation on a long-running operation.  The server
          # makes a best effort to cancel the operation, but success is not
          # guaranteed.  If the server doesn't support this method, it returns
          # `google.rpc.Code.UNIMPLEMENTED`.  Clients can use
          # Operations.GetOperation or
          # other methods to check whether the cancellation succeeded or whether the
          # operation completed despite cancellation. On successful cancellation,
          # the operation is not deleted; instead, it becomes an operation with
          # an {Google::Longrunning::Operation#error Operation.error} value with a {Google::Rpc::Status#code google.rpc.Status.code} of 1,
          # corresponding to `Code.CANCELLED`.
          #
          # @overload cancel_operation(request, options = nil)
          #   @param request [Google::Longrunning::CancelOperationRequest | Hash]
          #     Starts asynchronous cancellation on a long-running operation.  The server
          #     makes a best effort to cancel the operation, but success is not
          #     guaranteed.  If the server doesn't support this method, it returns
          #     `google.rpc.Code.UNIMPLEMENTED`.  Clients can use
          #     Operations.GetOperation or
          #     other methods to check whether the cancellation succeeded or whether the
          #     operation completed despite cancellation. On successful cancellation,
          #     the operation is not deleted; instead, it becomes an operation with
          #     an {Google::Longrunning::Operation#error Operation.error} value with a {Google::Rpc::Status#code google.rpc.Status.code} of 1,
          #     corresponding to `Code.CANCELLED`.
          #   @param options [Gapic::CallOptions, Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
          #
          # @overload cancel_operation(name: nil)
          #   @param name [String]
          #     The name of the operation resource to be cancelled.
          #
          #
          # @yield [response, operation] Access the result along with the RPC operation
          # @yieldparam response [Google::Protobuf::Empty]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          #
          # @return [Google::Protobuf::Empty]
          #
          # @raise [GRPC::BadStatus] if the RPC is aborted.
          #
          def cancel_operation request, options = nil
            raise ArgumentError, "request must be provided" if request.nil?

            request = Gapic::Protobuf.coerce request, to: Google::Longrunning::CancelOperationRequest

            # Converts hash and nil to an options object
            options = Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            metadata = @config.rpcs.cancel_operation.metadata.to_h

            # Set x-goog-api-client and x-goog-user-project headers
            metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Google::Garbage::VERSION
            metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

            header_params = {
              "name" => request.name
            }
            request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
            metadata[:"x-goog-request-params"] ||= request_params_header

            options.apply_defaults timeout:      @config.rpcs.cancel_operation.timeout,
                                   metadata:     metadata,
                                   retry_policy: @config.rpcs.cancel_operation.retry_policy
            options.apply_defaults metadata:     @config.metadata,
                                   retry_policy: @config.retry_policy

            @operations_stub.call_rpc :cancel_operation, request, options: options do |response, operation|
              yield response, operation if block_given?
              return response
            end
          end

          ##
          # Configuration class for the Operations API.
          #
          # This class represents the configuration for Operations,
          # providing control over timeouts, retry behavior, logging, transport
          # parameters, and other low-level controls. Certain parameters can also be
          # applied individually to specific RPCs. See
          # {Google::Longrunning::Operations::Client::Configuration::Rpcs}
          # for a list of RPCs that can be configured independently.
          #
          # Configuration can be applied globally to all clients, or to a single client
          # on construction.
          #
          # # Examples
          #
          # To modify the global config, setting the timeout for list_operations
          # to 20 seconds, and all remaining timeouts to 10 seconds:
          #
          #     Google::Longrunning::Operations::Client.configure do |config|
          #       config.timeout = 10_000
          #       config.rpcs.list_operations.timeout = 20_000
          #     end
          #
          # To apply the above configuration only to a new client:
          #
          #     client = Google::Longrunning::Operations::Client.new do |config|
          #       config.timeout = 10_000
          #       config.rpcs.list_operations.timeout = 20_000
          #     end
          #
          # @!attribute [rw] endpoint
          #   The hostname or hostname:port of the service endpoint.
          #   Defaults to `"localhost"`.
          #   @return [String]
          # @!attribute [rw] credentials
          #   Credentials to send with calls. You may provide any of the following types:
          #    *  (`String`) The path to a service account key file in JSON format
          #    *  (`Hash`) A service account key as a Hash
          #    *  (`Google::Auth::Credentials`) A googleauth credentials object
          #       (see the [googleauth docs](https://googleapis.dev/ruby/googleauth/latest/index.html))
          #    *  (`Signet::OAuth2::Client`) A signet oauth2 client object
          #       (see the [signet docs](https://googleapis.dev/ruby/signet/latest/Signet/OAuth2/Client.html))
          #    *  (`GRPC::Core::Channel`) a gRPC channel with included credentials
          #    *  (`GRPC::Core::ChannelCredentials`) a gRPC credentails object
          #    *  (`nil`) indicating no credentials
          #   @return [Object]
          # @!attribute [rw] scope
          #   The OAuth scopes
          #   @return [Array<String>]
          # @!attribute [rw] lib_name
          #   The library name as recorded in instrumentation and logging
          #   @return [String]
          # @!attribute [rw] lib_version
          #   The library version as recorded in instrumentation and logging
          #   @return [String]
          # @!attribute [rw] channel_args
          #   Extra parameters passed to the gRPC channel. Note: this is ignored if a
          #   `GRPC::Core::Channel` object is provided as the credential.
          #   @return [Hash]
          # @!attribute [rw] interceptors
          #   An array of interceptors that are run before calls are executed.
          #   @return [Array<GRPC::ClientInterceptor>]
          # @!attribute [rw] timeout
          #   The call timeout in milliseconds.
          #   @return [Numeric]
          # @!attribute [rw] metadata
          #   Additional gRPC headers to be sent with the call.
          #   @return [Hash{Symbol=>String}]
          # @!attribute [rw] retry_policy
          #   The retry policy. The value is a hash with the following keys:
          #    *  `:initial_delay` (*type:* `Numeric`) - The initial delay in seconds.
          #    *  `:max_delay` (*type:* `Numeric`) - The max delay in seconds.
          #    *  `:multiplier` (*type:* `Numeric`) - The incremental backoff multiplier.
          #    *  `:retry_codes` (*type:* `Array<String>`) - The error codes that should
          #       trigger a retry.
          #   @return [Hash]
          #
          class Configuration
            extend Gapic::Config

            config_attr :endpoint,     "localhost", String
            config_attr :credentials,  nil do |value|
              allowed = [::String, ::Hash, ::Proc, ::Google::Auth::Credentials, ::Signet::OAuth2::Client, nil]
              allowed += [::GRPC::Core::Channel, ::GRPC::Core::ChannelCredentials] if defined? ::GRPC
              allowed.any? { |klass| klass === value }
            end
            config_attr :scope,        nil, String, Array, nil
            config_attr :lib_name,     nil, String, nil
            config_attr :lib_version,  nil, String, nil
            config_attr(:channel_args, { "grpc.service_config_disable_resolution"=>1 }, Hash, nil)
            config_attr :interceptors, nil, Array, nil
            config_attr :timeout,      nil, Numeric, nil
            config_attr :metadata,     nil, Hash, nil
            config_attr :retry_policy, nil, Hash, Proc, nil

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
                parent_rpcs = @parent_config.rpcs if @parent_config&.respond_to? :rpcs
                Rpcs.new parent_rpcs
              end
            end

            ##
            # Configuration RPC class for the Operations API.
            #
            # Includes fields providing the configuration for each RPC in this service.
            # Each configuration object is of type `Gapic::Config::Method` and includes
            # the following configuration fields:
            #
            #  *  `timeout` (*type:* `Numeric`) - The call timeout in milliseconds
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
              # RPC-specific configuration for `list_operations`
              # @return [Gapic::Config::Method]
              #
              attr_reader :list_operations
              ##
              # RPC-specific configuration for `get_operation`
              # @return [Gapic::Config::Method]
              #
              attr_reader :get_operation
              ##
              # RPC-specific configuration for `delete_operation`
              # @return [Gapic::Config::Method]
              #
              attr_reader :delete_operation
              ##
              # RPC-specific configuration for `cancel_operation`
              # @return [Gapic::Config::Method]
              #
              attr_reader :cancel_operation

              # @private
              def initialize parent_rpcs = nil
                list_operations_config = parent_rpcs&.list_operations if parent_rpcs&.respond_to? :list_operations
                @list_operations = Gapic::Config::Method.new list_operations_config
                get_operation_config = parent_rpcs&.get_operation if parent_rpcs&.respond_to? :get_operation
                @get_operation = Gapic::Config::Method.new get_operation_config
                delete_operation_config = parent_rpcs&.delete_operation if parent_rpcs&.respond_to? :delete_operation
                @delete_operation = Gapic::Config::Method.new delete_operation_config
                cancel_operation_config = parent_rpcs&.cancel_operation if parent_rpcs&.respond_to? :cancel_operation
                @cancel_operation = Gapic::Config::Method.new cancel_operation_config

                yield self if block_given?
              end
            end
          end
        end
      end
    end
  end
end
