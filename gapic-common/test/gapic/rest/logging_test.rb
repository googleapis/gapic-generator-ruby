# Copyright 2024 Google LLC
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

describe Gapic::Rest::ClientStub do
  describe "logging" do
    FakeOptions = ::Struct.new :timeout, :on_data do
      def eql? other
        return false unless other.is_a? FakeOptions
        timeout == other.timeout && !!on_data == !!other.on_data
      end
      alias == eql?
    end

    FakeRequest = ::Struct.new :params, :body, :headers, :options do
      def initialize
        self.options = FakeOptions.new
        self.headers = {}
      end

      def self.default
        req = FakeRequest.new
        req.headers = { "Content-Type" => "application/json" }
        req
      end
    end

    def expect_connection client_stub, verb, uri, req
      mock = ::Minitest::Mock.new
      client_stub.instance_variable_set :@connection, mock
      mock.expect verb, nil do |actual_uri, &block|
        actual_req = FakeRequest.default
        block.call actual_req
        (uri == actual_uri && req == actual_req)
      end
    end

    def make_client_stub logger: :default
      ::Gapic::Rest::ClientStub.new endpoint: "google.example.com",
                                    credentials: :dummy_credentials,
                                    logging_system: system_name,
                                    service_name: service_name,
                                    logger: logger
    end

    let(:system_name) { "google-example-system" }
    let(:service_name) { "google.myapi" }
    let(:endpoint) { "google.example.com" }
    let(:creds) { :this_channel_is_insecure }
    let(:rpc_name) { "sample_rpc" }
    let(:logio) { StringIO.new }

    it "does not log by default" do
      client_stub = make_client_stub
      assert_nil client_stub.logger
      mock = expect_connection client_stub, :get, "/foo", FakeRequest.default
      _out, err = capture_subprocess_io do
        client_stub.make_get_request uri: "/foo", method_name: rpc_name
      end
      assert_equal "", err
      mock.verify
    end

    it "logs to a default logger when the environment variable is true" do
      spoof_logging_env enabled: "true" do
        client_stub = make_client_stub
        client_stub.logger.reopen logio
        mock = expect_connection client_stub, :get, "/foo", FakeRequest.default
        client_stub.make_get_request uri: "/foo", method_name: rpc_name
        mock.verify
        logs = logio.string.split("\n")
        assert_includes logs[0], "INFO -- #{system_name}: Sending request to #{service_name}.#{rpc_name} (try 1)"
        assert_includes logs[1], "INFO -- #{system_name}: Received response for #{service_name}.#{rpc_name} (try 1)"
      end
    end

    it "logs to a programmatically given logger" do
      logger = Logger.new logio, progname: "custom_prog"
      client_stub = make_client_stub logger: logger
      mock = expect_connection client_stub, :get, "/foo", FakeRequest.default
      client_stub.make_get_request uri: "/foo", method_name: rpc_name
      mock.verify
      logs = logio.string.split("\n")
      assert_includes logs[0], "INFO -- custom_prog: Sending request to #{service_name}.#{rpc_name} (try 1)"
      assert_includes logs[1], "INFO -- custom_prog: Received response for #{service_name}.#{rpc_name} (try 1)"
    end

    it "logs in structured format in a google compute environment" do
      spoof_logging_env enabled: "true", cloud_run: true do
        client_stub = make_client_stub
        client_stub.logger.reopen logio
        mock = expect_connection client_stub, :get, "/foo", FakeRequest.default
        client_stub.make_get_request uri: "/foo", method_name: rpc_name
        mock.verify
        logs = logio.string.split("\n")
        entry = JSON.load logs[0]
        assert_equal "Sending request to #{service_name}.#{rpc_name} (try 1)", entry["message"]
        assert_equal system_name, entry["system"]
        assert_equal service_name, entry["serviceName"]
        assert_equal rpc_name, entry["rpcName"]
        assert_equal 1, entry["retryAttempt"]
        refute_nil entry["requestId"]
        refute_nil entry["timestamp"]
        assert_equal __FILE__, entry["logging.googleapis.com/sourceLocation"]["file"]
        entry = JSON.load logs[1]
        assert_equal "Received response for #{service_name}.#{rpc_name} (try 1)", entry["message"]
        assert_equal system_name, entry["system"]
        assert_equal service_name, entry["serviceName"]
        assert_equal rpc_name, entry["rpcName"]
        assert_equal 1, entry["retryAttempt"]
        refute_nil entry["requestId"]
        refute_nil entry["timestamp"]
        assert_equal __FILE__, entry["logging.googleapis.com/sourceLocation"]["file"]
      end
    end

    it "logs for server streaming" do
      spoof_logging_env enabled: "true" do
        client_stub = make_client_stub
        client_stub.logger.reopen logio
        expected_request = FakeRequest.default
        expected_request.options.on_data = true
        mock = expect_connection client_stub, :get, "/foo", expected_request
        client_stub.make_http_request :get, uri: "/foo", body: nil, params: {}, options: nil, method_name: rpc_name,
                                            is_server_streaming: true
        mock.verify
        logs = logio.string.split("\n")
        assert_includes logs[0], "INFO -- #{system_name}: Sending request to #{service_name}.#{rpc_name} (try 1)"
        assert_includes logs[1], "INFO -- #{system_name}: Receiving stream for #{service_name}.#{rpc_name} (try 1)"
      end
    end
  end
end
