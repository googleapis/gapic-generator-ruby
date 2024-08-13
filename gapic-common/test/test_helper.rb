# Copyright 2019 Google LLC
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

gem "minitest"
require "minitest/autorun"
require "minitest/focus"
require "minitest/rg"
require "pp"

require "grpc"
require "gapic/common"
require "gapic/rest"
require "google/cloud/env"
require "google/protobuf/any_pb"
require "ostruct"
require_relative "./fixtures/fixture_pb"
require_relative "./fixtures/fixture2_pb"
require_relative "./fixtures/transcoding_example_pb"

class FakeFaradayError < ::Faraday::Error
  def initialize code
    if code < 100 && ::Gapic::CallOptions::ErrorCodes::HTTP_GRPC_CODE_MAP.invert.key?(code)
      code = ::Gapic::CallOptions::ErrorCodes::HTTP_GRPC_CODE_MAP.invert[code]
    end

    @code = code
  end

  def http_code
    @code if @code >= 100
  end

  def grpc_code
    ::Gapic::CallOptions::ErrorCodes::HTTP_GRPC_CODE_MAP[@code]
  end

  def response_status
    @code
  end
end

class FakeCodeError < StandardError
  attr_reader :code

  def initialize msg, code
    super msg
    @code = code
  end
end

class OperationStub
  def initialize &block
    @block = block
  end

  def execute
    @block.call
  end
end

class FakeGapicStub
  def initialize *responses
    @responses = responses
    @count = 0
  end

  def call_rpc *args
    result = @responses.shift
    @count += 1
    fake_operation = "fake_operation_#{@count}".to_sym
    yield result, fake_operation if block_given?
    result
  end
end

class FakeReGapicServiceStub
  def initialize *responses
    @responses = responses
    @count = 0
  end

  def call_rest *args
    result = @responses.shift
    @count += 1
    yield result, result if block_given?
    result
  end
end

class ClientStubTestBase < Minitest::Test
  ##
  # NB: raise_faraday_errors is set to false here by default,
  # even though it's default-true in `::Gapic::Rest::ClientStub`'s initialize
  # for backward compatibility reasons
  #
  def make_client_stub numeric_enums: false, raise_faraday_errors: false
    ::Gapic::Rest::ClientStub.new endpoint: "google.example.com",
                                  credentials: :dummy_credentials,
                                  numeric_enums: numeric_enums,
                                  raise_faraday_errors: raise_faraday_errors
  end
end

def spoof_logging_env enabled: nil, cloud_run: false
  old_enabled = ENV["GOOGLE_SDK_RUBY_LOGGING_GEMS"]
  ENV["GOOGLE_SDK_RUBY_LOGGING_GEMS"] = enabled
  if cloud_run
    Google::Cloud.env.compute_smbios.with_override_product_name "Fake Google" do
      Google::Cloud.env.variables.with_backing_data({ "K_SERVICE" => "123" }) do
        yield
      end
    end
  else
    yield
  end
ensure
  ENV["GOOGLE_SDK_RUBY_LOGGING_GEMS"] = old_enabled
end
