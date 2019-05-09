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

require "grpc"
require "google/showcase/v1alpha3/identity_pb"

module Google
  module Showcase
    module V1alpha3
      module Identity
        # A simple identity service.
        class Service
          include ::GRPC::GenericService

          self.marshal_class_method = :encode
          self.unmarshal_class_method = :decode
          self.service_name = "google.showcase.v1alpha3.Identity"

          # Creates a user.
          rpc :CreateUser,
              Google::Showcase::V1alpha3::CreateUserRequest,
              Google::Showcase::V1alpha3::User

          # Retrieves the User with the given uri.
          rpc :GetUser,
              Google::Showcase::V1alpha3::GetUserRequest,
              Google::Showcase::V1alpha3::User

          # Updates a user.
          rpc :UpdateUser,
              Google::Showcase::V1alpha3::UpdateUserRequest,
              Google::Showcase::V1alpha3::User

          # Deletes a user, their profile, and all of their authored messages.
          rpc :DeleteUser,
              Google::Showcase::V1alpha3::DeleteUserRequest,
              Google::Protobuf::Empty

          # Lists all users.
          rpc :ListUsers,
              Google::Showcase::V1alpha3::ListUsersRequest,
              Google::Showcase::V1alpha3::ListUsersResponse
        end

        Stub = Service.rpc_stub_class
      end
    end
  end
end
