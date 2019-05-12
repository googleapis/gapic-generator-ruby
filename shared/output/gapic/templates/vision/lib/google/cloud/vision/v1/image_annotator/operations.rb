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

require "google/gax"
require "google/gax/operation"

require "google/cloud/vision/version"
require "google/cloud/vision/v1/image_annotator/client"
require "google/longrunning/operations_pb"

module Google
  module Cloud
    module Vision
      module V1
        module ImageAnnotator
          # Service that implements Longrunning Operations API.
          class Operations
            # @private
            attr_reader :operations_stub

            ##
            # Configuration for the Operations API.
            #
            def self.configure
              @configure ||= Google::Gax::Configuration.new do |config|
                default_scope = Google::Gax::Configuration.deferred do
                  Credentials::SCOPE
                end
                config.add_field! :host,         "vision.googleapis.com", match: [String]
                config.add_field! :port,         443, match: [Integer]
                config.add_field! :scope,        default_scope,                         match: [String, Array], allow_nil: true
                config.add_field! :lib_name,     nil,                                   match: [String],        allow_nil: true
                config.add_field! :lib_version,  nil,                                   match: [String],        allow_nil: true
                config.add_field! :interceptors, [],                                    match: [Array]

                config.add_field! :timeout,      60,  match: [Numeric]
                config.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
                config.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true

                config.add_config! :methods do |methods|
                  methods.add_config! :list_operations do |method|
                    method.add_field! :timeout,      nil, match: [Numeric],    allow_nil: true
                    method.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
                    method.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true
                  end
                  methods.add_config! :get_operation do |method|
                    method.add_field! :timeout,      nil, match: [Numeric],    allow_nil: true
                    method.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
                    method.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true
                  end
                  methods.add_config! :delete_operation do |method|
                    method.add_field! :timeout,      nil, match: [Numeric],    allow_nil: true
                    method.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
                    method.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true
                  end
                  methods.add_config! :cancel_operation do |method|
                    method.add_field! :timeout,      nil, match: [Numeric],    allow_nil: true
                    method.add_field! :metadata,     nil, match: [Hash],       allow_nil: true
                    method.add_field! :retry_policy, nil, match: [Hash, Proc], allow_nil: true
                  end
                end
              end
              yield @configure if block_given?
              @configure
            end

            ##
            # Configure the Client client.
            #
            def configure
              yield @config if block_given?
              @config
            end

            ##
            # @param credentials [Google::Auth::Credentials, String, Hash,
            #   GRPC::Core::Channel, GRPC::Core::ChannelCredentials, Proc]
            #   Provides the means for authenticating requests made by the client. This
            #   parameter can be many types.
            #   A `Google::Auth::Credentials` uses a the properties of its represented
            #   keyfile for authenticating requests made by this client.
            #   A `String` will be treated as the path to the keyfile to be used for the
            #   construction of credentials for this client.
            #   A `Hash` will be treated as the contents of a keyfile to be used for the
            #   construction of credentials for this client.
            #   A `GRPC::Core::Channel` will be used to make calls through.
            #   A `GRPC::Core::ChannelCredentials` for the setting up the RPC client. The
            #   channel credentials should already be composed with a
            #   `GRPC::Core::CallCredentials` object.
            #   A `Proc` will be used as an updater_proc for the Grpc channel. The proc
            #   transforms the metadata for requests, generally, to give OAuth credentials.
            # @param config [Google::Gax::Configuration]
            #   The configuration object to use in place of the default configuration. It is
            #   preferable to configure the default configuration using the
            #   {Client.configure} method or by passing a block instead. Optional.
            #
            #   The configuration is set to the derived mode, meaning that values can be changed,
            #   but structural changes (adding new fields, etc.) are not allowed. Structural changes
            #   should be made on {Client.configure}.
            #
            # @yield [config] Configure the Client client.
            # @yieldparam config [Google::Gax::Configuration]
            #
            def initialize credentials: nil, config: nil
              # These require statements are intentionally placed here to initialize
              # the gRPC module only when it's required.
              # See https://github.com/googleapis/toolkit/issues/446
              require "google/gax/grpc"
              require "google/longrunning/operations_services_pb"

              # Create the configuration object
              config ||= Operations.configure
              config = config.derive! unless config.derived?

              # Yield the configuration if needed
              yield config if block_given?

              @config = config

              # Create credentials
              credentials ||= Credentials.default scope: @config.scope
              if credentials.is_a?(String) || credentials.is_a?(Hash)
                credentials = Credentials.new credentials, scope: @config.scope
              end

              @operations_stub = Google::Gax::Grpc::Stub.new(
                Google::Longrunning::Operations::Stub,
                credentials:  credentials,
                host:         @config.host,
                port:         @config.port,
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
            # @overload list_operations(request, options: nil)
            #   @param request [Google::Longrunning::ListOperationsRequest | Hash]
            #     Lists operations that match the specified filter in the request. If the
            #     server doesn't support this method, it returns `UNIMPLEMENTED`.
            #
            #     NOTE: the `name` binding below allows API services to override the binding
            #     to use different resource name schemes, such as `users/*/operations`.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload list_operations(name: nil, filter: nil, page_size: nil, page_token: nil, options: nil)
            #   @param name [String]
            #     The name of the operation collection.
            #   @param filter [String]
            #     The standard list filter.
            #   @param page_size [Integer]
            #     The standard list page size.
            #   @param page_token [String]
            #     The standard list page token.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Gax::PagedEnumerable<Google::Longrunning::Operation>]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Gax::PagedEnumerable<Google::Longrunning::Operation>]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def list_operations request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Longrunning::ListOperationsRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.methods.list_operations.metadata.to_h

              x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
              x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
              x_goog_api_client_header << "gapic/#{Google::Cloud::Vision::VERSION}"
              x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
              x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
              metadata["x-goog-api-client"] ||= x_goog_api_client_header.join " "

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata["x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.methods.list_operations.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.methods.list_operations.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @list_operations ||= Google::Gax::ApiCall.new @operations_stub.method :list_operations

              wrap_gax_operation = ->(resource) { Google::Gax::Operation.new resource, @operations_client }
              wrap_paged_enum = ->(response) { Google::Gax::PagedEnumerable.new @list_operations, request, response, options, format_resource: wrap_gax_operation }

              @list_operations.call request, options: options, operation_callback: block, format_response: wrap_paged_enum
            end

            ##
            # Gets the latest state of a long-running operation.  Clients can use this
            # method to poll the operation result at intervals as recommended by the API
            # service.
            #
            # @overload get_operation(request, options: nil)
            #   @param request [Google::Longrunning::GetOperationRequest | Hash]
            #     Gets the latest state of a long-running operation.  Clients can use this
            #     method to poll the operation result at intervals as recommended by the API
            #     service.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload get_operation(name: nil, options: nil)
            #   @param name [String]
            #     The name of the operation resource.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Gax::Operation]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Gax::Operation]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def get_operation request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Longrunning::GetOperationRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.methods.get_operation.metadata.to_h

              x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
              x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
              x_goog_api_client_header << "gapic/#{Google::Cloud::Vision::VERSION}"
              x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
              x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
              metadata["x-goog-api-client"] ||= x_goog_api_client_header.join " "

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata["x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.methods.get_operation.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.methods.get_operation.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @get_operation ||= Google::Gax::ApiCall.new @operations_stub.method :get_operation

              wrap_gax_operation = ->(response) { Google::Gax::Operation.new response, @operations_client }

              @get_operation.call request, options: options, operation_callback: block, format_response: wrap_gax_operation
            end

            ##
            # Deletes a long-running operation. This method indicates that the client is
            # no longer interested in the operation result. It does not cancel the
            # operation. If the server doesn't support this method, it returns
            # `google.rpc.Code.UNIMPLEMENTED`.
            #
            # @overload delete_operation(request, options: nil)
            #   @param request [Google::Longrunning::DeleteOperationRequest | Hash]
            #     Deletes a long-running operation. This method indicates that the client is
            #     no longer interested in the operation result. It does not cancel the
            #     operation. If the server doesn't support this method, it returns
            #     `google.rpc.Code.UNIMPLEMENTED`.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload delete_operation(name: nil, options: nil)
            #   @param name [String]
            #     The name of the operation resource to be deleted.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def delete_operation request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Longrunning::DeleteOperationRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.methods.delete_operation.metadata.to_h

              x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
              x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
              x_goog_api_client_header << "gapic/#{Google::Cloud::Vision::VERSION}"
              x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
              x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
              metadata["x-goog-api-client"] ||= x_goog_api_client_header.join " "

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata["x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.methods.delete_operation.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.methods.delete_operation.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @delete_operation ||= Google::Gax::ApiCall.new @operations_stub.method :delete_operation

              @delete_operation.call request, options: options, operation_callback: block
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
            # @overload cancel_operation(request, options: nil)
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
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @overload cancel_operation(name: nil, options: nil)
            #   @param name [String]
            #     The name of the operation resource to be cancelled.
            #   @param options [Google::Gax::ApiCall::Options, Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def cancel_operation request = nil, options: nil, **request_fields, &block
              raise ArgumentError, "request must be provided" if request.nil? && request_fields.empty?
              if !request.nil? && !request_fields.empty?
                raise ArgumentError, "cannot pass both request object and named arguments"
              end

              request ||= request_fields
              request = Google::Gax::Protobuf.coerce request, to: Google::Longrunning::CancelOperationRequest

              # Converts hash and nil to an options object
              options = Google::Gax::ApiCall::Options.new options.to_h if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.methods.cancel_operation.metadata.to_h

              x_goog_api_client_header = ["gl-ruby/#{RUBY_VERSION}"]
              x_goog_api_client_header << "#{@config.lib_name}/#{@config.lib_version}" if @config.lib_name
              x_goog_api_client_header << "gapic/#{Google::Cloud::Vision::VERSION}"
              x_goog_api_client_header << "gax/#{Google::Gax::VERSION}"
              x_goog_api_client_header << "grpc/#{GRPC::VERSION}"
              metadata["x-goog-api-client"] ||= x_goog_api_client_header.join " "

              header_params = {
                "name" => request.name
              }
              request_params_header = header_params.map { |k, v| "#{k}=#{v}" }.join("&")
              metadata["x-goog-request-params"] ||= request_params_header

              options.apply_defaults timeout:      @config.methods.cancel_operation.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.methods.cancel_operation.retry_policy
              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @cancel_operation ||= Google::Gax::ApiCall.new @operations_stub.method :cancel_operation

              @cancel_operation.call request, options: options, operation_callback: block
            end
          end
        end
      end
    end
  end
end
