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

require "test_helper"
require "gapic/grpc"
require "google/type/phone_number_pb"

module MyFakeService
  SAMPLE_PROTO_FOR_TESTING = Google::Type::PhoneNumber.new(
    short_code: Google::Type::PhoneNumber::ShortCode.new(
      region_code: "US",
      number: "911"
    )
  )

  SAMPLE_PROTO_FOR_TESTING_2 = Google::Type::PhoneNumber.new(
    short_code: Google::Type::PhoneNumber::ShortCode.new(
      region_code: "US",
      number: "411"
    )
  )

  module FakeServiceModule
    class Stub
      def initialize *args, **kwargs
      end

      def sample_rpc request, **kwargs
        self
      end

      def execute
        SAMPLE_PROTO_FOR_TESTING
      end
    end

    module Service
      def self.service_name
        "google.fakeService"
      end
    end
  end

  module FakeStreamingServiceModule
    class Stub
      def initialize *args, **kwargs
      end

      def sample_rpc request, **kwargs
        request.each{}
        self
      end

      def execute
        [SAMPLE_PROTO_FOR_TESTING, SAMPLE_PROTO_FOR_TESTING_2]
      end
    end

    module Service
      def self.service_name
        "google.fakeStreamingService"
      end
    end
  end
end

describe Gapic::ServiceStub do
  describe "logging" do
    let(:creds) { :this_channel_is_insecure }
    let(:rpc_name) { "sample_rpc" }
    let(:logio) { StringIO.new }
    let(:stub_class) { MyFakeService::FakeServiceModule::Stub }
    let(:streaming_stub_class) { MyFakeService::FakeStreamingServiceModule::Stub }
    let(:sample_request) { MyFakeService::SAMPLE_PROTO_FOR_TESTING }
    let(:sample_stream) { [MyFakeService::SAMPLE_PROTO_FOR_TESTING, MyFakeService::SAMPLE_PROTO_FOR_TESTING_2] }
    let(:sample_metadata) { { "myheader" => "myvalue" } }

    it "does not log by default" do
      service_stub = Gapic::ServiceStub.new stub_class, endpoint: "service:port", credentials: creds
      assert_nil service_stub.logger
      _out, err = capture_subprocess_io do
        service_stub.call_rpc rpc_name, sample_request, options: { metadata: sample_metadata }
      end
      assert_equal "", err
    end

    it "logs to a default logger when the environment variable is true" do
      spoof_logging_env enabled: "true" do
        service_stub = Gapic::ServiceStub.new stub_class, endpoint: "service:port", credentials: creds
        service_stub.logger.reopen logio
        service_stub.call_rpc rpc_name, sample_request, options: { metadata: sample_metadata }
        logs = logio.string.split("\n")
        assert_includes logs[0], "INFO -- my_fake_service: Sending request to google.fakeService.sample_rpc (try 1)"
        assert_includes logs[1], "DEBUG -- my_fake_service: (request payload as Google::Type::PhoneNumber)"
        assert_includes logs[2], "INFO -- my_fake_service: Received response for google.fakeService.sample_rpc (try 1)"
        assert_includes logs[3], "DEBUG -- my_fake_service: (response payload as Google::Type::PhoneNumber)"
      end
    end

    it "does not log when the environment variable is false even with a programmatically given logger" do
      spoof_logging_env enabled: "false" do
        logger = Logger.new logio, progname: "custom_prog"
        service_stub = Gapic::ServiceStub.new stub_class, endpoint: "service:port", credentials: creds, logger: logger
        assert_nil service_stub.logger
        _out, err = capture_subprocess_io do
          service_stub.call_rpc rpc_name, sample_request, options: { metadata: sample_metadata }
        end
        assert_equal "", err
      end
    end

    it "does not log when the environment variable is true but the system does not match" do
      spoof_logging_env enabled: "something,something-else" do
        service_stub = Gapic::ServiceStub.new stub_class, endpoint: "service:port", credentials: creds
        assert_nil service_stub.logger
        _out, err = capture_subprocess_io do
          service_stub.call_rpc rpc_name, sample_request, options: { metadata: sample_metadata }
        end
        assert_equal "", err
      end
    end

    it "logs logger when the environment variable is true and the system does match" do
      spoof_logging_env enabled: "my_fake_service,something-else" do
        service_stub = Gapic::ServiceStub.new stub_class, endpoint: "service:port", credentials: creds
        service_stub.logger.reopen logio
        service_stub.call_rpc rpc_name, sample_request, options: { metadata: sample_metadata }
        logs = logio.string.split("\n")
        assert_includes logs[0], "INFO -- my_fake_service: Sending request to google.fakeService.sample_rpc (try 1)"
        assert_includes logs[1], "DEBUG -- my_fake_service: (request payload as Google::Type::PhoneNumber)"
        assert_includes logs[2], "INFO -- my_fake_service: Received response for google.fakeService.sample_rpc (try 1)"
        assert_includes logs[3], "DEBUG -- my_fake_service: (response payload as Google::Type::PhoneNumber)"
      end
    end

    it "logs to a programmatically given logger" do
      logger = Logger.new logio, progname: "custom_prog"
      service_stub = Gapic::ServiceStub.new stub_class, endpoint: "service:port", credentials: creds, logger: logger
      service_stub.call_rpc rpc_name, sample_request, options: { metadata: sample_metadata }
      logs = logio.string.split("\n")
      assert_includes logs[0], "INFO -- custom_prog: Sending request to google.fakeService.sample_rpc (try 1)"
      assert_includes logs[1], "DEBUG -- custom_prog: (request payload as Google::Type::PhoneNumber)"
      assert_includes logs[2], "INFO -- custom_prog: Received response for google.fakeService.sample_rpc (try 1)"
      assert_includes logs[3], "DEBUG -- custom_prog: (response payload as Google::Type::PhoneNumber)"
    end

    it "logs in structured format in a google compute environment" do
      spoof_logging_env enabled: "all", cloud_run: true do
        service_stub = Gapic::ServiceStub.new stub_class, endpoint: "service:port", credentials: creds
        service_stub.logger.reopen logio
        service_stub.call_rpc rpc_name, sample_request, options: { metadata: sample_metadata }
        logs = logio.string.split("\n")

        entry = JSON.load logs[0]
        assert_equal "INFO", entry["severity"]
        assert_equal "Sending request to google.fakeService.sample_rpc (try 1)", entry["message"]
        assert_equal "my_fake_service", entry["system"]
        assert_equal "google.fakeService", entry["serviceName"]
        assert_equal "sample_rpc", entry["rpcName"]
        assert_equal 1, entry["retryAttempt"]
        refute_nil entry["timestamp"]
        request_id = entry["requestId"]
        client_id = entry["clientId"]
        refute_nil request_id
        refute_nil client_id
        assert_equal __FILE__, entry["logging.googleapis.com/sourceLocation"]["file"]

        entry = JSON.load logs[1]
        assert_equal "DEBUG", entry["severity"]
        assert_equal "(request payload as Google::Type::PhoneNumber)", entry["message"]
        refute_nil entry["timestamp"]
        assert_equal request_id, entry["requestId"]
        assert_equal client_id, entry["clientId"]
        assert_equal({"short_code" => {"region_code" => "US", "number" => "911"}}, entry["request"])
        assert_equal sample_metadata, entry["headers"]
        assert_equal __FILE__, entry["logging.googleapis.com/sourceLocation"]["file"]

        entry = JSON.load logs[2]
        assert_equal "INFO", entry["severity"]
        assert_equal "Received response for google.fakeService.sample_rpc (try 1)", entry["message"]
        assert_equal "my_fake_service", entry["system"]
        assert_equal "google.fakeService", entry["serviceName"]
        assert_equal "sample_rpc", entry["rpcName"]
        assert_equal 1, entry["retryAttempt"]
        refute_nil entry["timestamp"]
        assert_equal request_id, entry["requestId"]
        assert_equal client_id, entry["clientId"]
        assert_equal __FILE__, entry["logging.googleapis.com/sourceLocation"]["file"]

        entry = JSON.load logs[3]
        assert_equal "DEBUG", entry["severity"]
        assert_equal "(response payload as Google::Type::PhoneNumber)", entry["message"]
        refute_nil entry["timestamp"]
        assert_equal request_id, entry["requestId"]
        assert_equal client_id, entry["clientId"]
        assert_equal({"short_code" => {"region_code" => "US", "number" => "911"}}, entry["response"])
        assert_equal __FILE__, entry["logging.googleapis.com/sourceLocation"]["file"]
      end
    end

    it "logs streaming" do
      spoof_logging_env enabled: "true" do
        service_stub = Gapic::ServiceStub.new streaming_stub_class, endpoint: "service:port", credentials: creds
        service_stub.logger.reopen logio
        response = service_stub.call_rpc rpc_name, sample_stream, options: { metadata: sample_metadata }
        response.each{}
        logs = logio.string.split("\n")
        assert_includes logs[0], "INFO -- my_fake_service: Sending stream to google.fakeStreamingService.sample_rpc (try 1)"
        assert_includes logs[1], "DEBUG -- my_fake_service: (request payload as Google::Type::PhoneNumber)"
        assert_includes logs[2], "DEBUG -- my_fake_service: (request payload as Google::Type::PhoneNumber)"
        assert_includes logs[3], "INFO -- my_fake_service: Receiving stream for google.fakeStreamingService.sample_rpc (try 1)"
        assert_includes logs[4], "DEBUG -- my_fake_service: (response payload as Google::Type::PhoneNumber)"
        assert_includes logs[5], "DEBUG -- my_fake_service: (response payload as Google::Type::PhoneNumber)"
        assert_equal 6, logs.size
      end
    end
  end
end
