# Copyright 2019 Google LLC
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

require "gapic/call_options"
require "gapic/errors"

module Gapic
  class ServiceStub
    class RpcCall
      attr_reader :stub_method

      ##
      # Creates an API object for making a single RPC call.
      #
      # In typical usage, `stub_method` will be a proc used to make an RPC request. This will mostly likely be a bound
      # method from a request Stub used to make an RPC call.
      #
      # The result is created by applying a series of function decorators defined in this module to `stub_method`.
      #
      # The result is another proc which has the same signature as the original.
      #
      # @param stub_method [Proc] Used to make a bare rpc call.
      #
      def initialize stub_method
        @stub_method = stub_method
      end

      ##
      # Invoke the RPC call.
      #
      # @param request [Object] The request object.
      # @param options [Gapic::CallOptions, Hash] The options for making the RPC call. A Hash can be provided to
      #   customize the options object, using keys that match the arguments for {Gapic::CallOptions.new}. This object
      #   should only be used once.
      # @param format_response [Proc] A Proc object to format the response object. The Proc should accept response as
      #   an argument, and return a formatted response object. Optional.
      #
      #   If `stream_callback` is also provided, the response argument will be an Enumerable of the responses.
      #   Returning a lazy enumerable that adds the desired formatting is recommended.
      # @param operation_callback [Proc] A Proc object to provide a callback of the response and operation objects.
      #   The response will be formatted with `format_response` if that is also provided. Optional.
      # @param stream_callback [Proc] A Proc object to provide a callback for every streamed response received. The
      #   Proc will be called with the response object. Should only be used on Bidi and Server streaming RPC calls.
      #   Optional.
      #
      # @return [Object, Thread] The response object. Or, when `stream_callback` is provided, a thread running the
      #   callback for every streamed response is returned.
      #
      # @example
      #   require "google/showcase/v1beta1/echo_pb"
      #   require "google/showcase/v1beta1/echo_services_pb"
      #   require "gapic"
      #   require "gapic/grpc"
      #
      #   echo_channel = GRPC::Core::Channel.new(
      #     "localhost:7469", nil, :this_channel_is_insecure
      #   )
      #   echo_stub = Gapic::ServiceStub.new(
      #     Google::Showcase::V1beta1::Echo::Stub,
      #     endpoint: "localhost:7469", credentials: echo_channel
      #   )
      #   echo_call = Gapic::ServiceStub::RpcCall.new echo_stub.method :echo
      #
      #   request = Google::Showcase::V1beta1::EchoRequest.new
      #   response = echo_call.call request
      #
      # @example Using custom call options:
      #   require "google/showcase/v1beta1/echo_pb"
      #   require "google/showcase/v1beta1/echo_services_pb"
      #   require "gapic"
      #   require "gapic/grpc"
      #
      #   echo_channel = GRPC::Core::Channel.new(
      #     "localhost:7469", nil, :this_channel_is_insecure
      #   )
      #   echo_stub = Gapic::ServiceStub.new(
      #     Google::Showcase::V1beta1::Echo::Stub,
      #     endpoint: "localhost:7469", credentials: echo_channel
      #   )
      #   echo_call = Gapic::ServiceStub::RpcCall.new echo_stub.method :echo
      #
      #   request = Google::Showcase::V1beta1::EchoRequest.new
      #   options = Gapic::CallOptions.new(
      #     retry_policy = {
      #       retry_codes: [GRPC::Core::StatusCodes::UNAVAILABLE]
      #     }
      #   )
      #   response = echo_call.call request, options: options
      #
      # @example Formatting the response in the call:
      #   require "google/showcase/v1beta1/echo_pb"
      #   require "google/showcase/v1beta1/echo_services_pb"
      #   require "gapic"
      #   require "gapic/grpc"
      #
      #   echo_channel = GRPC::Core::Channel.new(
      #     "localhost:7469", nil, :this_channel_is_insecure
      #   )
      #   echo_stub = Gapic::ServiceStub.new(
      #     Google::Showcase::V1beta1::Echo::Stub,
      #     endpoint: "localhost:7469", credentials: echo_channel
      #   )
      #   echo_call = Gapic::ServiceStub::RpcCall.new echo_stub.method :echo
      #
      #   request = Google::Showcase::V1beta1::EchoRequest.new
      #   content_upcaser = proc do |response|
      #     format_response = response.dup
      #     format_response.content.upcase!
      #     format_response
      #   end
      #   response = echo_call.call request, format_response: content_upcaser
      #
      def call request, options: nil, format_response: nil, operation_callback: nil, stream_callback: nil
        # Converts hash and nil to an options object
        options = Gapic::CallOptions.new options.to_h if options.respond_to? :to_h
        stream_proc = compose_stream_proc stream_callback: stream_callback, format_response: format_response
        deadline = calculate_deadline options
        metadata = options.metadata

        begin
          operation = stub_method.call request, deadline: deadline, metadata: metadata, return_op: true, &stream_proc

          if stream_proc
            Thread.new { operation.execute }
          else
            response = operation.execute
            response = format_response.call response if format_response
            operation_callback&.call response, operation
            response
          end
        rescue StandardError => error
          if check_retry? deadline
            retry if options.retry_policy.call error
          end

          error = wrap_error error if wrap_error? error

          raise error
        end
      end

      private

      def compose_stream_proc stream_callback: nil, format_response: nil
        return unless stream_callback
        return stream_callback unless format_response

        proc { |response| stream_callback.call format_response.call response }
      end

      def calculate_deadline options
        Time.now + options.timeout
      end

      def check_retry? deadline
        deadline > Time.now
      end

      def wrap_error? error
        error.is_a? GRPC::BadStatus
      end

      def wrap_error error
        Gapic.from_error(error).new "RPC failed: #{error.message}"
      end
    end
  end
end
