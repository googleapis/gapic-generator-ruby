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
require "google/showcase/v1alpha3/testing_pb"

module Google
  module Showcase
    module V1alpha3
      module Testing
        # A service to facilitate running discrete sets of tests
        # against Showcase.
        class Service
          include ::GRPC::GenericService

          self.marshal_class_method = :encode
          self.unmarshal_class_method = :decode
          self.service_name = "google.showcase.v1alpha3.Testing"

          # Creates a new testing session.
          rpc :CreateSession,
              Google::Showcase::V1alpha3::CreateSessionRequest,
              Google::Showcase::V1alpha3::Session

          # Gets a testing session.
          rpc :GetSession,
              Google::Showcase::V1alpha3::GetSessionRequest,
              Google::Showcase::V1alpha3::Session

          # Lists the current test sessions.
          rpc :ListSessions,
              Google::Showcase::V1alpha3::ListSessionsRequest,
              Google::Showcase::V1alpha3::ListSessionsResponse

          # Delete a test session.
          rpc :DeleteSession,
              Google::Showcase::V1alpha3::DeleteSessionRequest,
              Google::Protobuf::Empty

          # Report on the status of a session.
          # This generates a report detailing which tests have been completed,
          # and an overall rollup.
          rpc :ReportSession,
              Google::Showcase::V1alpha3::ReportSessionRequest,
              Google::Showcase::V1alpha3::ReportSessionResponse

          # List the tests of a sessesion.
          rpc :ListTests,
              Google::Showcase::V1alpha3::ListTestsRequest,
              Google::Showcase::V1alpha3::ListTestsResponse

          # Explicitly decline to implement a test.
          #
          # This removes the test from subsequent `ListTests` calls, and
          # attempting to do the test will error.
          #
          # This method will error if attempting to delete a required test.
          rpc :DeleteTest,
              Google::Showcase::V1alpha3::DeleteTestRequest,
              Google::Protobuf::Empty

          # Register a response to a test.
          #
          # In cases where a test involves registering a final answer at the
          # end of the test, this method provides the means to do so.
          rpc :VerifyTest,
              Google::Showcase::V1alpha3::VerifyTestRequest,
              Google::Showcase::V1alpha3::VerifyTestResponse
        end

        Stub = Service.rpc_stub_class
      end
    end
  end
end
