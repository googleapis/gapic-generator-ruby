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
