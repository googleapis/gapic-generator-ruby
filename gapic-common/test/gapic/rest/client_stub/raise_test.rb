# Copyright 2022 Google LLC
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

require "test_helper"
require "gapic/rest"

class ClientStubRaiseTest < ClientStubTestBase
  def expect_connection client_stub, verb, uri
    mock = ::Minitest::Mock.new
    client_stub.instance_variable_set :@connection, mock

    mock.expect verb, nil do |actual_uri, &block|
      yield
    end
  end

  ##
  # Tests that a faraday exception gets wrapped in ::Gapic::Rest::Error
  #
  def test_wraps_faraday_exception
    client_stub = make_client_stub

    mock = expect_connection client_stub, :get, "/foo" do
      raise ::Faraday::Error.new
    end

    assert_raises ::Gapic::Rest::Error do
      client_stub.make_get_request uri: "/foo"
    end
    mock.verify
  end

  ##
  # Tests that a faraday exception gets raised as is if 
  # `raise_faraday_errors` is true
  #
  def test_raises_faraday_exception_if_option_set
    client_stub = make_client_stub raise_faraday_errors: true

    mock = expect_connection client_stub, :get, "/foo" do
      raise ::Faraday::Error.new
    end

    assert_raises ::Faraday::Error do
      client_stub.make_get_request uri: "/foo"
    end
    mock.verify
  end

  ##
  # Tests that a non-faraday exception gets raised as is
  #
  def test_passes_other_exceptions
    client_stub = make_client_stub

    mock = expect_connection client_stub, :get, "/foo" do
      raise FakeCodeError.new("Not a real GRPC error",
        GRPC::Core::StatusCodes::UNAVAILABLE)
    end

    assert_raises FakeCodeError do
      client_stub.make_get_request uri: "/foo"
    end
    mock.verify
  end
end
