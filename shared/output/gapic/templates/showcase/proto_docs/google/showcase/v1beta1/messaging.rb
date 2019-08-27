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

module Google
  module Showcase
    module V1beta1
      # A chat room.
      # @!attribute [rw] name
      #   @return [String]
      #     The resource name of the chat room.
      # @!attribute [rw] display_name
      #   @return [String]
      #     The human readable name of the chat room.
      # @!attribute [rw] description
      #   @return [String]
      #     The description of the chat room.
      # @!attribute [r] create_time
      #   @return [Google::Protobuf::Timestamp]
      #     The timestamp at which the room was created.
      # @!attribute [r] update_time
      #   @return [Google::Protobuf::Timestamp]
      #     The latest timestamp at which the room was updated.
      class Room
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1beta1.Messaging\CreateRoom
      # method.
      # @!attribute [rw] room
      #   @return [Google::Showcase::V1beta1::Room]
      #     The room to create.
      class CreateRoomRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1beta1.Messaging\GetRoom
      # method.
      # @!attribute [rw] name
      #   @return [String]
      #     The resource name of the requested room.
      class GetRoomRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1beta1.Messaging\UpdateRoom
      # method.
      # @!attribute [rw] room
      #   @return [Google::Showcase::V1beta1::Room]
      #     The room to update.
      # @!attribute [rw] update_mask
      #   @return [Google::Protobuf::FieldMask]
      #     The field mask to determine wich fields are to be updated. If empty, the
      #     server will assume all fields are to be updated.
      class UpdateRoomRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1beta1.Messaging\DeleteRoom
      # method.
      # @!attribute [rw] name
      #   @return [String]
      #     The resource name of the requested room.
      class DeleteRoomRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1beta1.Messaging\ListRooms
      # method.
      # @!attribute [rw] page_size
      #   @return [Integer]
      #     The maximum number of rooms return. Server may return fewer rooms
      #     than requested. If unspecified, server will pick an appropriate default.
      # @!attribute [rw] page_token
      #   @return [String]
      #     The value of google.showcase.v1beta1.ListRoomsResponse.next_page_token
      #     returned from the previous call to
      #     `google.showcase.v1beta1.Messaging\ListRooms` method.
      class ListRoomsRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The response message for the google.showcase.v1beta1.Messaging\ListRooms
      # method.
      # @!attribute [rw] rooms
      #   @return [Google::Showcase::V1beta1::Room]
      #     The list of rooms.
      # @!attribute [rw] next_page_token
      #   @return [String]
      #     A token to retrieve next page of results.
      #     Pass this value in ListRoomsRequest.page_token field in the subsequent
      #     call to `google.showcase.v1beta1.Messaging\ListRooms` method to retrieve the
      #     next page of results.
      class ListRoomsResponse
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # This protocol buffer message represents a blurb sent to a chat room or
      # posted on a user profile.
      # @!attribute [rw] name
      #   @return [String]
      #     The resource name of the chat room.
      # @!attribute [rw] user
      #   @return [String]
      #     The resource name of the blurb's author.
      # @!attribute [rw] text
      #   @return [String]
      #     The textual content of this blurb.
      # @!attribute [rw] image
      #   @return [String]
      #     The image content of this blurb.
      # @!attribute [r] create_time
      #   @return [Google::Protobuf::Timestamp]
      #     The timestamp at which the blurb was created.
      # @!attribute [r] update_time
      #   @return [Google::Protobuf::Timestamp]
      #     The latest timestamp at which the blurb was updated.
      class Blurb
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1beta1.Messaging\CreateBlurb
      # method.
      # @!attribute [rw] parent
      #   @return [String]
      #     The resource name of the chat room or user profile that this blurb will
      #     be tied to.
      # @!attribute [rw] blurb
      #   @return [Google::Showcase::V1beta1::Blurb]
      #     The blurb to create.
      class CreateBlurbRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1beta1.Messaging\GetBlurb
      # method.
      # @!attribute [rw] name
      #   @return [String]
      #     The resource name of the requested blurb.
      class GetBlurbRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1beta1.Messaging\UpdateBlurb
      # method.
      # @!attribute [rw] blurb
      #   @return [Google::Showcase::V1beta1::Blurb]
      #     The blurb to update.
      # @!attribute [rw] update_mask
      #   @return [Google::Protobuf::FieldMask]
      #     The field mask to determine wich fields are to be updated. If empty, the
      #     server will assume all fields are to be updated.
      class UpdateBlurbRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1beta1.Messaging\DeleteBlurb
      # method.
      # @!attribute [rw] name
      #   @return [String]
      #     The resource name of the requested blurb.
      class DeleteBlurbRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1beta1.Messaging\ListBlurbs
      # method.
      # @!attribute [rw] parent
      #   @return [String]
      #     The resource name of the requested room or profile whos blurbs to list.
      # @!attribute [rw] page_size
      #   @return [Integer]
      #     The maximum number of blurbs to return. Server may return fewer
      #     blurbs than requested. If unspecified, server will pick an appropriate
      #     default.
      # @!attribute [rw] page_token
      #   @return [String]
      #     The value of google.showcase.v1beta1.ListBlurbsResponse.next_page_token
      #     returned from the previous call to
      #     `google.showcase.v1beta1.Messaging\ListBlurbs` method.
      class ListBlurbsRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The response message for the google.showcase.v1beta1.Messaging\ListBlurbs
      # method.
      # @!attribute [rw] blurbs
      #   @return [Google::Showcase::V1beta1::Blurb]
      #     The list of blurbs.
      # @!attribute [rw] next_page_token
      #   @return [String]
      #     A token to retrieve next page of results.
      #     Pass this value in ListBlurbsRequest.page_token field in the subsequent
      #     call to `google.showcase.v1beta1.Blurb\ListBlurbs` method to retrieve
      #     the next page of results.
      class ListBlurbsResponse
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1beta1.Messaging\SearchBlurbs
      # method.
      # @!attribute [rw] query
      #   @return [String]
      #     The query used to search for blurbs containing to words of this string.
      #     Only posts that contain an exact match of a queried word will be returned.
      # @!attribute [rw] parent
      #   @return [String]
      #     The rooms or profiles to search. If unset, `SearchBlurbs` will search all
      #     rooms and all profiles.
      # @!attribute [rw] page_size
      #   @return [Integer]
      #     The maximum number of blurbs return. Server may return fewer
      #     blurbs than requested. If unspecified, server will pick an appropriate
      #     default.
      # @!attribute [rw] page_token
      #   @return [String]
      #     The value of
      #     google.showcase.v1beta1.SearchBlurbsResponse.next_page_token
      #     returned from the previous call to
      #     `google.showcase.v1beta1.Messaging\SearchBlurbs` method.
      class SearchBlurbsRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The operation metadata message for the
      # google.showcase.v1beta1.Messaging\SearchBlurbs method.
      # @!attribute [rw] retry_info
      #   @return [Google::Rpc::RetryInfo]
      #     This signals to the client when to next poll for response.
      class SearchBlurbsMetadata
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The operation response message for the
      # google.showcase.v1beta1.Messaging\SearchBlurbs method.
      # @!attribute [rw] blurbs
      #   @return [Google::Showcase::V1beta1::Blurb]
      #     Blurbs that matched the search query.
      # @!attribute [rw] next_page_token
      #   @return [String]
      #     A token to retrieve next page of results.
      #     Pass this value in SearchBlurbsRequest.page_token field in the subsequent
      #     call to `google.showcase.v1beta1.Blurb\SearchBlurbs` method to
      #     retrieve the next page of results.
      class SearchBlurbsResponse
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1beta1.Messaging\StreamBlurbs
      # method.
      # @!attribute [rw] name
      #   @return [String]
      #     The resource name of a chat room or user profile whose blurbs to stream.
      # @!attribute [rw] expire_time
      #   @return [Google::Protobuf::Timestamp]
      #     The time at which this stream will close.
      class StreamBlurbsRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The response message for the google.showcase.v1beta1.Messaging\StreamBlurbs
      # method.
      # @!attribute [rw] blurb
      #   @return [Google::Showcase::V1beta1::Blurb]
      #     The blurb that was either created, updated, or deleted.
      # @!attribute [rw] action
      #   @return [ENUM(Action)]
      #     The action that triggered the blurb to be returned.
      class StreamBlurbsResponse
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods

        # The action that triggered the blurb to be returned.
        module Action
          ACTION_UNSPECIFIED = 0

          # Specifies that the blurb was created.
          CREATE = 1

          # Specifies that the blurb was updated.
          UPDATE = 2

          # Specifies that the blurb was deleted.
          DELETE = 3
        end
      end

      # The response message for the google.showcase.v1beta1.Messaging\SendBlurbs
      # method.
      # @!attribute [rw] names
      #   @return [String]
      #     The names of successful blurb creations.
      class SendBlurbsResponse
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1beta1.Messaging\Connect
      # method.
      # @!attribute [rw] config
      #   @return [Google::Showcase::V1beta1::ConnectRequest::ConnectConfig]
      #     Provides information that specifies how to process subsequent requests.
      #     The first `ConnectRequest` message must contain a `config`  message.
      # @!attribute [rw] blurb
      #   @return [Google::Showcase::V1beta1::Blurb]
      #     The blurb to be created.
      class ConnectRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods

        # @!attribute [rw] parent
        #   @return [String]
        #     The room or profile to follow and create messages for.
        class ConnectConfig
          include Google::Protobuf::MessageExts
          extend Google::Protobuf::MessageExts::ClassMethods
        end
      end
    end
  end
end
