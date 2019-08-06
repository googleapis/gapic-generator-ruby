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

require "gapic/common"
require "gapic/operation"

require "google/cloud/speech/version"
require "google/cloud/speech/v1/speech/client"
require "google/longrunning/operations_pb"

module Google
  module Cloud
    module Speech
      module V1
        module Speech
          # Service that implements Longrunning Operations API.
          class Operations
            # @private
            attr_reader :operations_stub

            ##
            # Configuration for the Speech Operations API.
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
            # Configure the Speech Operations instance.
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

              @operations_stub = Gapic::Grpc::Stub.new(
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
            #   @param options [Gapic::ApiCall::Options, Hash]
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
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def list_operations request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Longrunning::ListOperationsRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.list_operations.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Speech::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.list_operations.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.list_operations.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              wrap_gax_operation = ->(response) { Gapic::Operation.new response, @operations_client }
              wrap_paged_enum = ->(response) { Gapic::PagedEnumerable.new @operations_stub, :list_operations, request, response, options, format_resource: wrap_gax_operation }

              @operations_stub.call_rpc :list_operations, request, options: options, operation_callback: block, format_response: wrap_paged_enum
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
            #   @param options [Gapic::ApiCall::Options, Hash]
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
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def get_operation request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Longrunning::GetOperationRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.get_operation.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Speech::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.get_operation.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.get_operation.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              wrap_gax_operation = ->(response) { Gapic::Operation.new response, @operations_client }

              @operations_stub.call_rpc :get_operation, request, options: options, operation_callback: block, format_response: wrap_gax_operation
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
            #   @param options [Gapic::ApiCall::Options, Hash]
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
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def delete_operation request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Longrunning::DeleteOperationRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.delete_operation.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Speech::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.delete_operation.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.delete_operation.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @operations_stub.call_rpc :delete_operation, request, options: options, operation_callback: block
            end

            ##
            # Starts asynchronous cancellation on a long-running operation.  The server
            # makes a best effort to cancel the operation, but success is not
            # guaranteed.  If the server doesn't support this method, it returns
            # `google.rpc.Code.UNIMPLEMENTED`.  Clients can use
            # [Operations.GetOperation][google.longrunning.Operations.GetOperation] or
            # other methods to check whether the cancellation succeeded or whether the
            # operation completed despite cancellation. On successful cancellation,
            # the operation is not deleted; instead, it becomes an operation with
            # an [Operation.error][google.longrunning.Operation.error] value with a [google.rpc.Status.code][google.rpc.Status.code] of 1,
            # corresponding to `Code.CANCELLED`.
            #
            # @overload cancel_operation(request, options = nil)
            #   @param request [Google::Longrunning::CancelOperationRequest | Hash]
            #     Starts asynchronous cancellation on a long-running operation.  The server
            #     makes a best effort to cancel the operation, but success is not
            #     guaranteed.  If the server doesn't support this method, it returns
            #     `google.rpc.Code.UNIMPLEMENTED`.  Clients can use
            #     [Operations.GetOperation][google.longrunning.Operations.GetOperation] or
            #     other methods to check whether the cancellation succeeded or whether the
            #     operation completed despite cancellation. On successful cancellation,
            #     the operation is not deleted; instead, it becomes an operation with
            #     an [Operation.error][google.longrunning.Operation.error] value with a [google.rpc.Status.code][google.rpc.Status.code] of 1,
            #     corresponding to `Code.CANCELLED`.
            #   @param options [Gapic::ApiCall::Options, Hash]
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
            # @raise [Gapic::GapicError] if the RPC is aborted.
            #
            # @example
            #   TODO
            #
            def cancel_operation request, options = nil, &block
              raise ArgumentError, "request must be provided" if request.nil?

              request = Gapic::Protobuf.coerce request, to: Google::Longrunning::CancelOperationRequest

              # Converts hash and nil to an options object
              options = Gapic::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.cancel_operation.metadata.to_h

              # Set x-goog-api-client header
              metadata[:"x-goog-api-client"] ||= Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: Google::Cloud::Speech::VERSION

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata[:"x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.rpcs.cancel_operation.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.cancel_operation.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @operations_stub.call_rpc :cancel_operation, request, options: options, operation_callback: block
            end

            class Configuration
              extend Gapic::Config

              config_attr :endpoint,     "speech.googleapis.com", String
              config_attr :credentials,  nil do |value|
                allowed = [::String, ::Hash, ::Proc, ::Google::Auth::Credentials, ::Signet::OAuth2::Client, nil]
                allowed += [::GRPC::Core::Channel, ::GRPC::Core::ChannelCredentials] if defined? ::GRPC
                allowed.any? { |klass| klass === value }
              end
              config_attr :scope,        nil,                                   String, Array, nil
              config_attr :lib_name,     nil,                                   String, nil
              config_attr :lib_version,  nil,                                   String, nil
              config_attr :channel_args, nil,                                   Hash, nil
              config_attr :interceptors, nil,                                   Array, nil
              config_attr :timeout,      nil,                                   Numeric, nil
              config_attr :metadata,     nil,                                   Hash, nil
              config_attr :retry_policy, nil,                                   Hash, Proc, nil

              def initialize parent_config = nil
                @parent_config = parent_config unless parent_config.nil?

                yield self if block_given?
              end

              def rpcs
                @rpcs ||= begin
                  parent_rpcs = nil
                  parent_rpcs = @parent_config.rpcs if @parent_config&.respond_to? :rpcs
                  Rpcs.new parent_rpcs
                end
              end

              class Rpcs
                attr_reader :list_operations
                attr_reader :get_operation
                attr_reader :delete_operation
                attr_reader :cancel_operation

                def initialize parent_rpcs = nil
                  list_operations_config = nil
                  list_operations_config = parent_rpcs&.list_operations if parent_rpcs&.respond_to? :list_operations
                  @list_operations = Gapic::Config::Method.new list_operations_config
                  get_operation_config = nil
                  get_operation_config = parent_rpcs&.get_operation if parent_rpcs&.respond_to? :get_operation
                  @get_operation = Gapic::Config::Method.new get_operation_config
                  delete_operation_config = nil
                  delete_operation_config = parent_rpcs&.delete_operation if parent_rpcs&.respond_to? :delete_operation
                  @delete_operation = Gapic::Config::Method.new delete_operation_config
                  cancel_operation_config = nil
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
end
