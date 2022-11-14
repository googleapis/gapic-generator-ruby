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

require "gapic/operation"

module Testing
  module NonstandardLroGrpc
    module AllSubclientsConsumer
      module Rest
        # Service that implements Longrunning Operations API.
        class Operations
          # @private
          attr_reader :operations_stub

          ##
          # Configuration for the AllSubclientsConsumer Operations API.
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
          # Configure the AllSubclientsConsumer Operations instance.
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
            # Create the configuration object
            @config = Configuration.new Operations.configure

            # Yield the configuration if needed
            yield @config if block_given?

            # Create credentials
            credentials = @config.credentials
            credentials ||= Credentials.default scope: @config.scope
            if credentials.is_a?(::String) || credentials.is_a?(::Hash)
              credentials = Credentials.new credentials, scope: @config.scope
            end

            @operations_stub = OperationsServiceStub.new(
              endpoint:     @config.endpoint,
              credentials:  credentials
            )

            # Used by an LRO wrapper for some methods of this service
            @operations_client = self
          end

          # Service calls

          ##
          # Lists operations that match the specified filter in the request. If the
          # server doesn't support this method, it returns `UNIMPLEMENTED`.
          #
          # NOTE: the `name` binding allows API services to override the binding
          # to use different resource name schemes, such as `users/*/operations`. To
          # override the binding, API services can add a binding such as
          # `"/v1/{name=users/*}/operations"` to their service configuration.
          # For backwards compatibility, the default name includes the operations
          # collection id, however overriding users must ensure the name binding
          # is the parent resource, without the operations collection id.
          #
          # @overload list_operations(request, options = nil)
          #   Pass arguments to `list_operations` via a request object, either of type
          #   {::Google::Longrunning::ListOperationsRequest} or an equivalent Hash.
          #
          #   @param request [::Google::Longrunning::ListOperationsRequest, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #     Note: currently retry functionality is not implemented. While it is possible
          #     to set it using ::Gapic::CallOptions, it will not be applied
          #
          # @overload list_operations(name: nil, filter: nil, page_size: nil, page_token: nil)
          #   Pass arguments to `list_operations` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param name [::String]
          #     The name of the operation's parent resource.
          #   @param filter [::String]
          #     The standard list filter.
          #   @param page_size [::Integer]
          #     The standard list page size.
          #   @param page_token [::String]
          #     The standard list page token.
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Gapic::Operation]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Gapic::Operation]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def list_operations request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Google::Longrunning::ListOperationsRequest

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.list_operations.metadata.to_h

            # Set x-goog-api-client header
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            options.apply_defaults timeout:      @config.rpcs.list_operations.timeout,
                                   metadata:     call_metadata

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata

            @operations_stub.list_operations request, options do |result, response|
              result = ::Gapic::Rest::PagedEnumerable.new @operations_stub, :list_operations, "operations", request,
                                                          result, options
              yield result, response if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
          end

          ##
          # Gets the latest state of a long-running operation.  Clients can use this
          # method to poll the operation result at intervals as recommended by the API
          # service.
          #
          # @overload get_operation(request, options = nil)
          #   Pass arguments to `get_operation` via a request object, either of type
          #   {::Google::Longrunning::GetOperationRequest} or an equivalent Hash.
          #
          #   @param request [::Google::Longrunning::GetOperationRequest, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #     Note: currently retry functionality is not implemented. While it is possible
          #     to set it using ::Gapic::CallOptions, it will not be applied
          #
          # @overload get_operation(name: nil)
          #   Pass arguments to `get_operation` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param name [::String]
          #     The name of the operation resource.
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Gapic::Operation]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Gapic::Operation]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def get_operation request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Google::Longrunning::GetOperationRequest

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.get_operation.metadata.to_h

            # Set x-goog-api-client header
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            options.apply_defaults timeout:      @config.rpcs.get_operation.timeout,
                                   metadata:     call_metadata

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata

            @operations_stub.get_operation request, options do |result, response|
              result = ::Gapic::Operation.new result, @operations_client, options: options
              yield result, response if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
          end

          ##
          # Deletes a long-running operation. This method indicates that the client is
          # no longer interested in the operation result. It does not cancel the
          # operation. If the server doesn't support this method, it returns
          # `google.rpc.Code.UNIMPLEMENTED`.
          #
          # @overload delete_operation(request, options = nil)
          #   Pass arguments to `delete_operation` via a request object, either of type
          #   {::Google::Longrunning::DeleteOperationRequest} or an equivalent Hash.
          #
          #   @param request [::Google::Longrunning::DeleteOperationRequest, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #     Note: currently retry functionality is not implemented. While it is possible
          #     to set it using ::Gapic::CallOptions, it will not be applied
          #
          # @overload delete_operation(name: nil)
          #   Pass arguments to `delete_operation` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param name [::String]
          #     The name of the operation resource to be deleted.
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Google::Protobuf::Empty]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Google::Protobuf::Empty]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def delete_operation request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Google::Longrunning::DeleteOperationRequest

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.delete_operation.metadata.to_h

            # Set x-goog-api-client header
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            options.apply_defaults timeout:      @config.rpcs.delete_operation.timeout,
                                   metadata:     call_metadata

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata

            @operations_stub.delete_operation request, options do |result, response|
              yield result, response if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
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
          # an {::Google::Longrunning::Operation#error Operation.error} value with a {::Google::Rpc::Status#code google.rpc.Status.code} of 1,
          # corresponding to `Code.CANCELLED`.
          #
          # @overload cancel_operation(request, options = nil)
          #   Pass arguments to `cancel_operation` via a request object, either of type
          #   {::Google::Longrunning::CancelOperationRequest} or an equivalent Hash.
          #
          #   @param request [::Google::Longrunning::CancelOperationRequest, ::Hash]
          #     A request object representing the call parameters. Required. To specify no
          #     parameters, or to keep all the default parameter values, pass an empty Hash.
          #   @param options [::Gapic::CallOptions, ::Hash]
          #     Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #     Note: currently retry functionality is not implemented. While it is possible
          #     to set it using ::Gapic::CallOptions, it will not be applied
          #
          # @overload cancel_operation(name: nil)
          #   Pass arguments to `cancel_operation` via keyword arguments. Note that at
          #   least one keyword argument is required. To specify no parameters, or to keep all
          #   the default parameter values, pass an empty Hash as a request object (see above).
          #
          #   @param name [::String]
          #     The name of the operation resource to be cancelled.
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Google::Protobuf::Empty]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Google::Protobuf::Empty]
          #
          # @raise [::Gapic::Rest::Error] if the REST call is aborted.
          def cancel_operation request, options = nil
            raise ::ArgumentError, "request must be provided" if request.nil?

            request = ::Gapic::Protobuf.coerce request, to: ::Google::Longrunning::CancelOperationRequest

            # Converts hash and nil to an options object
            options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

            # Customize the options with defaults
            call_metadata = @config.rpcs.cancel_operation.metadata.to_h

            # Set x-goog-api-client header
            call_metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
              lib_name: @config.lib_name, lib_version: @config.lib_version,
              gapic_version: ::Testing::VERSION,
              transports_version_send: [:rest]

            options.apply_defaults timeout:      @config.rpcs.cancel_operation.timeout,
                                   metadata:     call_metadata

            options.apply_defaults timeout:      @config.timeout,
                                   metadata:     @config.metadata

            @operations_stub.cancel_operation request, options do |result, response|
              yield result, response if block_given?
              return result
            end
          rescue ::Faraday::Error => e
            raise ::Gapic::Rest::Error.wrap_faraday_error e
          end

          ##
          # Configuration class for the Operations REST API.
          #
          # This class represents the configuration for Operations REST,
          # providing control over credentials, timeouts, retry behavior, logging.
          #
          # Configuration can be applied globally to all clients, or to a single client
          # on construction.
          #
          # # Examples
          #
          # To modify the global config, setting the timeout for all calls to 10 seconds:
          #
          #     ::Google::Longrunning::Operations::Client.configure do |config|
          #       config.timeout = 10.0
          #     end
          #
          # To apply the above configuration only to a new client:
          #
          #     client = ::Google::Longrunning::Operations::Client.new do |config|
          #       config.timeout = 10.0
          #     end
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
          #   Additional REST headers to be sent with the call.
          #   @return [::Hash{::Symbol=>::String}]
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
            # Configuration RPC class for the Operations API.
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
              # RPC-specific configuration for `list_operations`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :list_operations
              ##
              # RPC-specific configuration for `get_operation`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :get_operation
              ##
              # RPC-specific configuration for `delete_operation`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :delete_operation
              ##
              # RPC-specific configuration for `cancel_operation`
              # @return [::Gapic::Config::Method]
              #
              attr_reader :cancel_operation

              # @private
              def initialize parent_rpcs = nil
                list_operations_config = parent_rpcs.list_operations if parent_rpcs.respond_to? :list_operations
                @list_operations = ::Gapic::Config::Method.new list_operations_config
                get_operation_config = parent_rpcs.get_operation if parent_rpcs.respond_to? :get_operation
                @get_operation = ::Gapic::Config::Method.new get_operation_config
                delete_operation_config = parent_rpcs.delete_operation if parent_rpcs.respond_to? :delete_operation
                @delete_operation = ::Gapic::Config::Method.new delete_operation_config
                cancel_operation_config = parent_rpcs.cancel_operation if parent_rpcs.respond_to? :cancel_operation
                @cancel_operation = ::Gapic::Config::Method.new cancel_operation_config

                yield self if block_given?
              end
            end
          end
        end

        # REST service stub for the Longrunning Operations API.
        # Service stub contains baseline method implementations
        # including transcoding, making the REST call, and deserialing the response.
        class OperationsServiceStub
          def initialize endpoint:, credentials:
            # These require statements are intentionally placed here to initialize
            # the REST modules only when it's required.
            require "gapic/rest"

            @client_stub = ::Gapic::Rest::ClientStub.new endpoint: endpoint, credentials: credentials
          end

          ##
          # Baseline implementation for the list_operations REST call
          #
          # @param request_pb [::Google::Longrunning::ListOperationsRequest]
          #   A request object representing the call parameters. Required.
          # @param options [::Gapic::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Google::Longrunning::ListOperationsResponse]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Google::Longrunning::ListOperationsResponse]
          #   A result object deserialized from the server's reply
          def list_operations request_pb, options = nil
            raise ::ArgumentError, "request must be provided" if request_pb.nil?

            verb, uri, query_string_params, body = transcode_list_operations_request request_pb
            query_string_params = if query_string_params.any?
                                    query_string_params.to_h { |p| p.split("=", 2) }
                                  else
                                    {}
                                  end

            response = @client_stub.make_http_request(
              verb,
              uri:     uri,
              body:    body || "",
              params:  query_string_params,
              options: options
            )
            result = ::Google::Longrunning::ListOperationsResponse.decode_json response.body,
                                                                               ignore_unknown_fields: true

            yield result, response if block_given?
            result
          end

          ##
          # Baseline implementation for the get_operation REST call
          #
          # @param request_pb [::Google::Longrunning::GetOperationRequest]
          #   A request object representing the call parameters. Required.
          # @param options [::Gapic::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Google::Longrunning::Operation]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Google::Longrunning::Operation]
          #   A result object deserialized from the server's reply
          def get_operation request_pb, options = nil
            raise ::ArgumentError, "request must be provided" if request_pb.nil?

            verb, uri, query_string_params, body = transcode_get_operation_request request_pb
            query_string_params = if query_string_params.any?
                                    query_string_params.to_h { |p| p.split("=", 2) }
                                  else
                                    {}
                                  end

            response = @client_stub.make_http_request(
              verb,
              uri:     uri,
              body:    body || "",
              params:  query_string_params,
              options: options
            )
            result = ::Google::Longrunning::Operation.decode_json response.body, ignore_unknown_fields: true

            yield result, response if block_given?
            result
          end

          ##
          # Baseline implementation for the delete_operation REST call
          #
          # @param request_pb [::Google::Longrunning::DeleteOperationRequest]
          #   A request object representing the call parameters. Required.
          # @param options [::Gapic::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Google::Protobuf::Empty]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Google::Protobuf::Empty]
          #   A result object deserialized from the server's reply
          def delete_operation request_pb, options = nil
            raise ::ArgumentError, "request must be provided" if request_pb.nil?

            verb, uri, query_string_params, body = transcode_delete_operation_request request_pb
            query_string_params = if query_string_params.any?
                                    query_string_params.to_h { |p| p.split("=", 2) }
                                  else
                                    {}
                                  end

            response = @client_stub.make_http_request(
              verb,
              uri:     uri,
              body:    body || "",
              params:  query_string_params,
              options: options
            )
            result = ::Google::Protobuf::Empty.decode_json response.body, ignore_unknown_fields: true

            yield result, response if block_given?
            result
          end

          ##
          # Baseline implementation for the cancel_operation REST call
          #
          # @param request_pb [::Google::Longrunning::CancelOperationRequest]
          #   A request object representing the call parameters. Required.
          # @param options [::Gapic::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout, retries etc. Optional.
          #
          # @yield [result, response] Access the result along with the Faraday response object
          # @yieldparam result [::Google::Protobuf::Empty]
          # @yieldparam response [::Faraday::Response]
          #
          # @return [::Google::Protobuf::Empty]
          #   A result object deserialized from the server's reply
          def cancel_operation request_pb, options = nil
            raise ::ArgumentError, "request must be provided" if request_pb.nil?

            verb, uri, query_string_params, body = transcode_cancel_operation_request request_pb
            query_string_params = if query_string_params.any?
                                    query_string_params.to_h { |p| p.split("=", 2) }
                                  else
                                    {}
                                  end

            response = @client_stub.make_http_request(
              verb,
              uri:     uri,
              body:    body || "",
              params:  query_string_params,
              options: options
            )
            result = ::Google::Protobuf::Empty.decode_json response.body, ignore_unknown_fields: true

            yield result, response if block_given?
            result
          end


          private

          ##
          # @private
          #
          # GRPC transcoding helper method for the list_operations REST call
          #
          # @param request_pb [::Google::Longrunning::ListOperationsRequest]
          #   A request object representing the call parameters. Required.
          # @return [Array(String, [String, nil], Hash{String => String})]
          #   Uri, Body, Query string parameters
          def transcode_list_operations_request request_pb
            transcoder = Gapic::Rest::GrpcTranscoder.new
                                                    .with_bindings(
                                                      uri_method: :get,
                                                      uri_template: "/v1beta1/operations",
                                                      matches: []
                                                    )
            transcoder.transcode request_pb
          end

          ##
          # @private
          #
          # GRPC transcoding helper method for the get_operation REST call
          #
          # @param request_pb [::Google::Longrunning::GetOperationRequest]
          #   A request object representing the call parameters. Required.
          # @return [Array(String, [String, nil], Hash{String => String})]
          #   Uri, Body, Query string parameters
          def transcode_get_operation_request request_pb
            transcoder = Gapic::Rest::GrpcTranscoder.new
                                                    .with_bindings(
                                                      uri_method: :get,
                                                      uri_template: "/v1/{name}",
                                                      matches: [
                                                        ["name", %r{^operations(?:/.*)?$}, true]
                                                      ]
                                                    )
            transcoder.transcode request_pb
          end

          ##
          # @private
          #
          # GRPC transcoding helper method for the delete_operation REST call
          #
          # @param request_pb [::Google::Longrunning::DeleteOperationRequest]
          #   A request object representing the call parameters. Required.
          # @return [Array(String, [String, nil], Hash{String => String})]
          #   Uri, Body, Query string parameters
          def transcode_delete_operation_request request_pb
            transcoder = Gapic::Rest::GrpcTranscoder.new
                                                    .with_bindings(
                                                      uri_method: :delete,
                                                      uri_template: "/v1/{name}",
                                                      matches: [
                                                        ["name", %r{^operations(?:/.*)?$}, true]
                                                      ]
                                                    )
            transcoder.transcode request_pb
          end

          ##
          # @private
          #
          # GRPC transcoding helper method for the cancel_operation REST call
          #
          # @param request_pb [::Google::Longrunning::CancelOperationRequest]
          #   A request object representing the call parameters. Required.
          # @return [Array(String, [String, nil], Hash{String => String})]
          #   Uri, Body, Query string parameters
          def transcode_cancel_operation_request request_pb
            transcoder = Gapic::Rest::GrpcTranscoder.new
                                                    .with_bindings(
                                                      uri_method: :post,
                                                      uri_template: "/v1/{name}:cancel",
                                                      body: "*",
                                                      matches: [
                                                        ["name", %r{^operations(?:/.*)?$}, true]
                                                      ]
                                                    )
            transcoder.transcode request_pb
          end
        end
      end
    end
  end
end
