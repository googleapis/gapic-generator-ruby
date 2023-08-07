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

require "grpc"
require "googleauth"
require "gapic/config"


module Gapic
  class ServiceStub
    ##
    # Gapic gRPC ServiceStub channel pool
    #
    # This class creates multiple gRPC connection and sends RPC through
    # them using the algorithm configured by the user
    #
    class ChannelPool
      ##
      # Initialize an instance of ServiceStub::ChannelPool
      #
      def initialize grpc_stub_class, endpoint:, credentials:, channel_args: nil, interceptors: nil, config: nil
        if credentials.is_a? ::GRPC::Core::Channel
          raise ArgumentError, "Can't create a channel pool with GRPC::Core::Channel as credentials"
        end

        @grpc_stub_class = grpc_stub_class
        @endpoint = endpoint
        @credentials = credentials
        @channel_args = channel_args
        @interceptors = interceptors
        @config = config || Configuration.new

        yield @config if block_given?
        @channels = (1..@config.channel_count).map { create_channel }
      end

      ##
      # Creates a new channel.
      def create_channel
        Channel.new @grpc_stub_class, endpoint: @endpoint, credentials: @credentials, channel_args: @channel_args,
                    interceptors: @interceptors
      end

      ##
      # Invoke the specified RPC call.
      #
      # @param method_name [Symbol] The RPC method name.
      # @param request [Object] The request object.
      # @param options [Gapic::CallOptions, Hash] The options for making the RPC call. A Hash can be provided to
      #   customize the options object, using keys that match the arguments for {Gapic::CallOptions.new}. This object
      #   should only be used once.
      #
      # @yield [response, operation] Access the response along with the RPC operation.
      # @yieldparam response [Object] The response object.
      # @yieldparam operation [::GRPC::ActiveCall::Operation] The RPC operation for the response.
      #
      # @return [Object] The response object.
      #
      def call_rpc method_name, request, options: nil, &block
        case @config.channel_selection.downcase.to_sym
        when :least_loaded
          channel = least_loaded_channel
          channel.call_rpc method_name, request, options: options, &block
        end
      end


      private

      ##
      # Return the least loaded channel in the pool
      #
      # @return [::Grpc::ServiceStub::Channel]
      #
      def least_loaded_channel
        @channels.min_by(&:concurrent_streams)
      end

      # @!attribute [rw] channel_count
      #  The number of channels in the channel pool.
      #  return [Integer]
      # @!attribute [rw] channel_selection
      #  The algorithm for selecting a channel for an RPC.
      #  return [Symbol]
      #
      class Configuration
        extend ::Gapic::Config

        config_attr :channel_count, 1, ::Integer, nil
        config_attr :channel_selection, :least_loaded do |value|
          allowed = [:least_loaded]
          allowed.any? { |klass| klass === value }
        end
      end
    end
  end
end
