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

class ClientStubTest < ClientStubTestBase
  ENDPOINT = "google.example.com"
  CREDENTIALS = :dummy_credentials
  STANDARD_HEADER = { "Content-Type" => "application/json" }

  FakeOptions = ::Struct.new :timeout

  FakeRequest = ::Struct.new :params, :body, :headers, :options do
    def initialize
      self.options = FakeOptions.new
      self.headers = {}
    end

    def self.default
      req = FakeRequest.new
      req.headers = STANDARD_HEADER.dup
      req
    end
  end

  def expect_connection client_stub, verb, uri, req
    mock = ::Minitest::Mock.new
    client_stub.instance_variable_set :@connection, mock
    mock.expect verb, nil do |actual_uri, &block|
      actual_req = FakeRequest.default
      block.call actual_req
      uri == actual_uri && req == actual_req
    end
  end

  def test_make_get_request_simple
    client_stub = make_client_stub
    expected_req = FakeRequest.default
    mock = expect_connection client_stub, :get, "/foo", expected_req
    client_stub.make_get_request uri: "/foo"
    mock.verify
  end

  def test_make_get_request_with_params
    client_stub = make_client_stub
    expected_req = FakeRequest.default
    expected_req.params = {"Foo" => "bar"}
    mock = expect_connection client_stub, :get, "/foo", expected_req
    client_stub.make_get_request uri: "/foo", params: {"Foo" => "bar"}
    mock.verify
  end

  def test_make_get_request_with_numeric_enums
    client_stub = make_client_stub numeric_enums: true
    expected_req = FakeRequest.default
    expected_req.params = {"$alt" => "json;enum-encoding=int"}
    mock = expect_connection client_stub, :get, "/foo", expected_req
    client_stub.make_get_request uri: "/foo"
    mock.verify
  end

  def test_make_get_request_with_numeric_enums_and_existing_alt_param
    client_stub = make_client_stub numeric_enums: true
    expected_req = FakeRequest.default
    expected_req.params = {"Foo" => "bar", "$alt" => "json;enum-encoding=int"}
    mock = expect_connection client_stub, :get, "/foo", expected_req
    client_stub.make_get_request uri: "/foo", params: {"Foo" => "bar", "$alt" => "json"}
    mock.verify
  end

  def test_make_delete_request_simple
    client_stub = make_client_stub
    expected_req = FakeRequest.default
    mock = expect_connection client_stub, :delete, "/foo", expected_req
    client_stub.make_delete_request uri: "/foo"
    mock.verify
  end

  def test_make_patch_request_simple
    client_stub = make_client_stub
    expected_req = FakeRequest.default
    expected_req.body = "hello"
    mock = expect_connection client_stub, :patch, "/foo", expected_req
    client_stub.make_patch_request uri: "/foo", body: "hello"
    mock.verify
  end

  def test_make_post_request_simple
    client_stub = make_client_stub
    expected_req = FakeRequest.default
    expected_req.body = "hello"
    mock = expect_connection client_stub, :post, "/foo", expected_req
    client_stub.make_post_request uri: "/foo", body: "hello"
    mock.verify
  end

  def test_make_put_request_simple
    client_stub = make_client_stub
    expected_req = FakeRequest.default
    expected_req.body = "hello"
    mock = expect_connection client_stub, :put, "/foo", expected_req
    client_stub.make_put_request uri: "/foo", body: "hello"
    mock.verify
  end

  def test_default_universe_domain
    client_stub = ::Gapic::Rest::ClientStub.new endpoint_template: "myservice.$UNIVERSE_DOMAIN$",
                                                credentials: :dummy_credentials
    assert_equal "googleapis.com", client_stub.universe_domain
    assert_equal "myservice.googleapis.com", client_stub.endpoint
  end

  def test_custom_universe_domain
    client_stub = ::Gapic::Rest::ClientStub.new universe_domain: "myuniverse.com",
                                                endpoint_template: "myservice.$UNIVERSE_DOMAIN$",
                                                credentials: :dummy_credentials
    assert_equal "myuniverse.com", client_stub.universe_domain
    assert_equal "myservice.myuniverse.com", client_stub.endpoint
  end

  def test_universe_domain_env
    old_domain = ENV["GOOGLE_CLOUD_UNIVERSE_DOMAIN"]
    ENV["GOOGLE_CLOUD_UNIVERSE_DOMAIN"] = "myuniverse.com"
    begin
      client_stub = ::Gapic::Rest::ClientStub.new endpoint_template: "myservice.$UNIVERSE_DOMAIN$",
                                                  credentials: :dummy_credentials
      assert_equal "myuniverse.com", client_stub.universe_domain
      assert_equal "myservice.myuniverse.com", client_stub.endpoint
    ensure
      ENV["GOOGLE_CLOUD_UNIVERSE_DOMAIN"] = old_domain
    end
  end

  def test_endpoint_override
    client_stub = ::Gapic::Rest::ClientStub.new universe_domain: "myuniverse.com",
                                                endpoint_template: "myservice.$UNIVERSE_DOMAIN$",
                                                endpoint: "myservice.otheruniverse.com",
                                                credentials: :dummy_credentials
    assert_equal "myuniverse.com", client_stub.universe_domain
    assert_equal "myservice.otheruniverse.com", client_stub.endpoint
  end

  FakeCredentials = Class.new Google::Auth::Credentials do
    def initialize universe_domain: nil
      @custom_universe_domain = universe_domain || "googleapis.com"
    end

    def updater_proc
      ->{}
    end
    
    def universe_domain
      @custom_universe_domain
    end
  end

  def test_universe_domain_credentials_mismatch
    creds = FakeCredentials.new universe_domain: "myuniverse.com"
    assert_raises Gapic::UniverseDomainMismatch do
      ::Gapic::Rest::ClientStub.new endpoint_template: "myservice.$UNIVERSE_DOMAIN$",
                                    credentials: creds
    end
  end
end
