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
require "gapic/logging_concerns"
require "grpc/errors"

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
      def initialize stub_method, stub_logger: nil, method_name: nil
        @stub_method = stub_method
        @stub_logger = stub_logger
        @method_name = method_name
        @request_id = LoggingConcerns.random_uuid4
      end

      ##
      # Invoke the RPC call.
      #
      # @param request [Object] The request object.
      # @param options [Gapic::CallOptions, Hash] The options for making the RPC call. A Hash can be provided to
      #   customize the options object, using keys that match the arguments for {Gapic::CallOptions.new}. This object
      #   should only be used once.
      #
      # @yield [response, operation] Access the response along with the RPC operation. Additionally, throwing
      #   `:response, obj` within the block will change the return value to `obj`.
      # @yieldparam response [Object] The response object.
      # @yieldparam operation [::GRPC::ActiveCall::Operation] The RPC operation for the response.
      #
      # @return [Object] The response object.
      #
      # @example
      #   require "google/showcase/v1beta1/echo_pb"
      #   require "google/showcase/v1beta1/echo_services_pb"
      #   require "gapic"
      #   require "gapic/grpc"
      #
      #   echo_channel = ::GRPC::Core::Channel.new(
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
      #   echo_channel = ::GRPC::Core::Channel.new(
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
      #       retry_codes: [::GRPC::Core::StatusCodes::UNAVAILABLE]
      #     }
      #   )
      #   response = echo_call.call request, options: options
      #
      # @example Accessing the RPC operation using a block:
      #   require "google/showcase/v1beta1/echo_pb"
      #   require "google/showcase/v1beta1/echo_services_pb"
      #   require "gapic"
      #   require "gapic/grpc"
      #
      #   echo_channel = ::GRPC::Core::Channel.new(
      #     "localhost:7469", nil, :this_channel_is_insecure
      #   )
      #   echo_stub = Gapic::ServiceStub.new(
      #     Google::Showcase::V1beta1::Echo::Stub,
      #     endpoint: "localhost:7469", credentials: echo_channel
      #   )
      #   echo_call = Gapic::ServiceStub::RpcCall.new echo_stub.method :echo
      #
      #   request = Google::Showcase::V1beta1::EchoRequest.new
      #   metadata = echo_call.call request do |_response, operation|
      #     throw :response, operation.trailing_metadata
      #   end
      #
      def call request, options: nil
        # Converts hash and nil to an options object
        options = Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h
        deadline = calculate_deadline options
        metadata = options.metadata

        try_number = 1
        retried_exception = nil
        begin
          request = log_request request, metadata, try_number
          operation = stub_method.call request, deadline: deadline, metadata: metadata, return_op: true
          response = operation.execute
          catch :response do
            response = log_response response, try_number
            yield response, operation if block_given?
            response
          end
        rescue ::GRPC::DeadlineExceeded => e
          log_response e, try_number
          raise Gapic::GRPC::DeadlineExceededError.new e.message, root_cause: retried_exception
        rescue StandardError => e
          e = normalize_exception e
          log_response e, try_number

          if check_retry?(deadline) && options.retry_policy.call(e)
            retried_exception = e
            try_number += 1
            retry
          end

          raise e
        end
      end

      private

      def calculate_deadline options
        return if options.timeout.nil?
        return if options.timeout.negative?

        current_time + options.timeout
      end

      def check_retry? deadline
        return true if deadline.nil?

        deadline > current_time
      end

      def current_time
        # An alternative way of saying Time.now without actually calling
        # Time.now. This allows clients that replace Time.now (e.g. via the
        # timecop gem) to do so without interfering with the deadline.
        nanos = Process.clock_gettime Process::CLOCK_REALTIME, :nanosecond
        secs_part = nanos / 1_000_000_000
        nsecs_part = nanos % 1_000_000_000
        Time.at secs_part, nsecs_part, :nanosecond
      end

      def normalize_exception exception
        if exception.is_a?(::GRPC::Unavailable) && /Signet::AuthorizationError/ =~ exception.message
          exception = Gapic::GRPC::AuthorizationError.new exception.message.gsub(%r{^\d+:}, "")
        end
        exception
      end

      def log_request request, metadata, try_number
        return request unless @stub_logger
        @stub_logger.info do |entry|
          entry.set_system_name
          entry.set_service
          entry.set "rpcName", @method_name
          entry.set "retryAttempt", try_number
          entry.set "requestId", @request_id
          entry.message =
            if request.is_a? Enumerable
              "Sending stream to #{entry.service}.#{@method_name} (try #{try_number})"
            else
              "Sending request to #{entry.service}.#{@method_name} (try #{try_number})"
            end
        end
        loggable_metadata = metadata.to_h rescue {}
        if request.is_a? Enumerable
          request.lazy.map do |req|
            log_single_request req, loggable_metadata
          end
        else
          log_single_request request, loggable_metadata
        end
      end

      def log_single_request request, metadata
        request_content = request.respond_to?(:to_h) ? (request.to_h rescue {}) : request.to_s
        if !request_content.empty? || !metadata.empty?
          @stub_logger.debug do |entry|
            entry.set "requestId", @request_id
            entry.set "request", request_content
            entry.set "headers", metadata
            entry.message = "(request payload as #{request.class})"
          end
        end
        request
      end

      def log_response response, try_number
        return response unless @stub_logger
        @stub_logger.info do |entry|
          entry.set_system_name
          entry.set_service
          entry.set "rpcName", @method_name
          entry.set "retryAttempt", try_number
          entry.set "requestId", @request_id
          case response
          when StandardError
            entry.set "exception", response.to_s
            entry.message = "Received error for #{entry.service}.#{@method_name} (try #{try_number}): #{response}"
          when Enumerable
            entry.message = "Receiving stream for #{entry.service}.#{@method_name} (try #{try_number})"
          else
            entry.message = "Received response for #{entry.service}.#{@method_name} (try #{try_number})"
          end
        end
        case response
        when StandardError
          response
        when Enumerable
          response.lazy.map do |resp|
            log_single_response resp
          end
        else
          log_single_response response
        end
      end

      def log_single_response response
        response_content = response.respond_to?(:to_h) ? (response.to_h rescue {}) : response.to_s
        unless response_content.empty?
          @stub_logger.debug do |entry|
            entry.set "requestId", @request_id
            entry.set "response", response_content
            entry.message = "(response payload as #{response.class})"
          end
        end
        response
      end
    end
  end
end
