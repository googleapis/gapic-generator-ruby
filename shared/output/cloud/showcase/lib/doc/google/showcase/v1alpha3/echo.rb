# frozen_string_literal: true

# Copyright 2018 Google LLC
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

raise "This file is for documentation purposes only."

module Google
  module Showcase
    module V1alpha3
      # The request message used for the Echo, Collect and Chat methods. If content
      # is set in this message then the request will succeed. If a status is
      # @!attribute [rw] content
      #   @return [String]
      #     The content to be echoed by the server.
      # @!attribute [rw] error
      #   @return [Google::Rpc::Status]
      #     The error to be thrown by the server.
      class EchoRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The response message for the Echo methods.
      # @!attribute [rw] content
      #   @return [String]
      #     The content specified in the request.
      class EchoResponse
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the Expand method.
      # @!attribute [rw] content
      #   @return [String]
      #     The content that will be split into words and returned on the stream.
      # @!attribute [rw] error
      #   @return [Google::Rpc::Status]
      #     The error that is thrown after all words are sent on the stream.
      class ExpandRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request for the PagedExpand method.
      # @!attribute [rw] content
      #   @return [String]
      #     The string to expand.
      # @!attribute [rw] page_size
      #   @return [Integer]
      #     The amount of words to returned in each page.
      # @!attribute [rw] page_token
      #   @return [String]
      #     The position of the page to be returned.
      class PagedExpandRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The response for the PagedExpand method.
      # @!attribute [rw] responses
      #   @return [Google::Showcase::V1alpha3::EchoResponse]
      #     The words that were expanded.
      # @!attribute [rw] next_page_token
      #   @return [String]
      #     The next page token.
      class PagedExpandResponse
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request for Wait method.
      # @!attribute [rw] end_time
      #   @return [Google::Protobuf::Timestamp]
      #     The time that this operation will complete.
      # @!attribute [rw] ttl
      #   @return [Google::Protobuf::Duration]
      #     The duration of this operation.
      # @!attribute [rw] error
      #   @return [Google::Rpc::Status]
      #     The error that will be returned by the server. If this code is specified
      #     to be the OK rpc code, an empty response will be returned.
      # @!attribute [rw] success
      #   @return [Google::Showcase::V1alpha3::WaitResponse]
      #     The response to be returned on operation completion.
      class WaitRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The result of the Wait operation.
      # @!attribute [rw] content
      #   @return [String]
      #     This content of the result.
      class WaitResponse
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The metadata for Wait operation.
      # @!attribute [rw] end_time
      #   @return [Google::Protobuf::Timestamp]
      #     The time that this operation will complete.
      class WaitMetadata
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end
    end
  end
end
