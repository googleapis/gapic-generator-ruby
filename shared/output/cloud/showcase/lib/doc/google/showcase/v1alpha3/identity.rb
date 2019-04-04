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
      # A user.
      # @!attribute [rw] name
      #   @return [String]
      #     The resource name of the user.
      # @!attribute [rw] display_name
      #   @return [String]
      #     The display_name of the user.
      # @!attribute [rw] email
      #   @return [String]
      #     The email address of the user.
      # @!attribute [rw] create_time
      #   @return [Google::Protobuf::Timestamp]
      #     The timestamp at which the user was created.
      # @!attribute [rw] update_time
      #   @return [Google::Protobuf::Timestamp]
      #     The latest timestamp at which the user was updated.
      class User
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1alpha3.Identity\CreateUser
      # method.
      # @!attribute [rw] user
      #   @return [Google::Showcase::V1alpha3::User]
      #     The user to create.
      class CreateUserRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1alpha3.Identity\GetUser
      # method.
      # @!attribute [rw] name
      #   @return [String]
      #     The resource name of the requested user.
      class GetUserRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1alpha3.Identity\UpdateUser
      # method.
      # @!attribute [rw] user
      #   @return [Google::Showcase::V1alpha3::User]
      #     The user to update.
      # @!attribute [rw] update_mask
      #   @return [Google::Protobuf::FieldMask]
      #     The field mask to determine wich fields are to be updated. If empty, the
      #     server will assume all fields are to be updated.
      class UpdateUserRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1alpha3.Identity\DeleteUser
      # method.
      # @!attribute [rw] name
      #   @return [String]
      #     The resource name of the user to delete.
      class DeleteUserRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The request message for the google.showcase.v1alpha3.Identity\ListUsers
      # method.
      # @!attribute [rw] page_size
      #   @return [Integer]
      #     The maximum number of users to return. Server may return fewer users
      #     than requested. If unspecified, server will pick an appropriate default.
      # @!attribute [rw] page_token
      #   @return [String]
      #     The value of google.showcase.v1alpha3.ListUsersResponse.next_page_token
      #     returned from the previous call to
      #     `google.showcase.v1alpha3.Identity\ListUsers` method.
      class ListUsersRequest
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end

      # The response message for the google.showcase.v1alpha3.Identity\ListUsers
      # method.
      # @!attribute [rw] users
      #   @return [Google::Showcase::V1alpha3::User]
      #     The list of users.
      # @!attribute [rw] next_page_token
      #   @return [String]
      #     A token to retrieve next page of results.
      #     Pass this value in ListUsersRequest.page_token field in the subsequent
      #     call to `google.showcase.v1alpha3.Message\ListUsers` method to retrieve the
      #     next page of results.
      class ListUsersResponse
        include Google::Protobuf::MessageExts
        extend Google::Protobuf::MessageExts::ClassMethods
      end
    end
  end
end
