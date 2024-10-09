# Copyright 2023 Google LLC
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
require "concurrent"

class ServiceStubTest < Minitest::Test
  FakeCallCredentials = Class.new GRPC::Core::CallCredentials do
    attr_reader :updater_proc

    def initialize updater_proc
      @updater_proc = updater_proc
    end
  end

  FakeChannel = Class.new GRPC::Core::Channel do
    def initialize
    end
  end

  FakeChannelCredentials = Class.new GRPC::Core::ChannelCredentials do
    attr_reader :call_creds

    def compose call_creds
      @call_creds = call_creds
    end
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

  FakeCredentialsWithDisabledCheck = Class.new FakeCredentials do
    def disable_universe_domain_check
      true
    end
  end

  FakeRpcCall = Class.new do
    def initialize method_stub
      @method_stub = method_stub
    end

    def call request, options: nil, &block
      @method_stub&.call(request, options)
    end
  end

  def test_with_channel
    fake_channel = FakeChannel.new
    channel_pool_config = Gapic::ServiceStub::ChannelPool::Configuration.new
    channel_pool_config.channel_count = 2
    mock = Minitest::Mock.new
    mock.expect :nil?, false
    mock.expect :nil?, false
    mock.expect :new, nil, ["service:port", nil], channel_override: fake_channel, interceptors: []

    assert_raises ArgumentError do
      Gapic::ServiceStub.new mock, endpoint: "service:port", credentials: fake_channel,
                             channel_pool_config: channel_pool_config
    end

    service_stub = Gapic::ServiceStub.new mock, endpoint: "service:port", credentials: fake_channel
    assert service_stub.instance_variable_get(:@channel_pool).nil?

    mock.verify
  end

  def test_with_channel_credentials
    fake_channel_creds = FakeChannelCredentials.new
    channel_pool_config = Gapic::ServiceStub::ChannelPool::Configuration.new
    channel_pool_config.channel_count = 2
    mock = Minitest::Mock.new
    mock.expect :nil?, false
    (1..3).each do
      mock.expect :nil?, false
      mock.expect :new, nil, ["service:port", fake_channel_creds], channel_args: {}, interceptors: []
    end

    service_stub = Gapic::ServiceStub.new mock, endpoint: "service:port", credentials: fake_channel_creds,
                                          channel_pool_config: channel_pool_config
    assert service_stub.instance_variable_get(:@grpc_stub).nil?

    service_stub = Gapic::ServiceStub.new mock, endpoint: "service:port", credentials: fake_channel_creds
    assert service_stub.instance_variable_get(:@channel_pool).nil?

    mock.verify
  end

  def test_with_symbol_credentials
    creds = :this_channel_is_insecure
    channel_pool_config = Gapic::ServiceStub::ChannelPool::Configuration.new
    channel_pool_config.channel_count = 2
    mock = Minitest::Mock.new
    mock.expect :nil?, false
    (1..3).each do
      mock.expect :nil?, false
      mock.expect :new, nil, ["service:port", creds], channel_args: {}, interceptors: []
    end

    service_stub = Gapic::ServiceStub.new mock, endpoint: "service:port", credentials: creds,
                                          channel_pool_config: channel_pool_config
    assert service_stub.instance_variable_get(:@grpc_stub).nil?

    service_stub = Gapic::ServiceStub.new mock, endpoint: "service:port", credentials: creds
    assert service_stub.instance_variable_get(:@channel_pool).nil?

    mock.verify
  end

  def test_with_credentials
    GRPC::Core::CallCredentials.stub :new, FakeCallCredentials.method(:new) do
      GRPC::Core::ChannelCredentials.stub :new, FakeChannelCredentials.method(:new) do
        channel_pool_config = Gapic::ServiceStub::ChannelPool::Configuration.new
        channel_pool_config.channel_count = 2
        mock = Minitest::Mock.new
        mock.expect :nil?, false
        (1..3).each do
          mock.expect :nil?, false
          mock.expect :new, nil, ["service:port", FakeCallCredentials], channel_args: {}, interceptors: []
        end

        service_stub = Gapic::ServiceStub.new mock, endpoint: "service:port", credentials: FakeCredentials.new,
                                              channel_pool_config: channel_pool_config
        assert service_stub.instance_variable_get(:@grpc_stub).nil?

        service_stub = Gapic::ServiceStub.new mock, endpoint: "service:port", credentials: FakeCredentials.new
        assert service_stub.instance_variable_get(:@channel_pool).nil?

        mock.verify
      end
    end
  end

  def test_with_proc
    GRPC::Core::CallCredentials.stub :new, FakeCallCredentials.method(:new) do
      GRPC::Core::ChannelCredentials.stub :new, FakeChannelCredentials.method(:new) do
        channel_pool_config = Gapic::ServiceStub::ChannelPool::Configuration.new
        channel_pool_config.channel_count = 2
        mock = Minitest::Mock.new
        mock.expect :nil?, false
        (1..3).each do
          mock.expect :nil?, false
          mock.expect :new, nil, ["service:port", FakeCallCredentials], channel_args: {}, interceptors: []
        end

        credentials_proc = ->{}

        service_stub = Gapic::ServiceStub.new mock, endpoint: "service:port", credentials: credentials_proc,
                                              channel_pool_config: channel_pool_config
        assert service_stub.instance_variable_get(:@grpc_stub).nil?

        service_stub = Gapic::ServiceStub.new mock, endpoint: "service:port", credentials: credentials_proc
        assert service_stub.instance_variable_get(:@channel_pool).nil?

        mock.verify
      end
    end
  end

  def test_call_rpc_with_channel_pool
    creds = :this_channel_is_insecure
    channel_pool_config = Gapic::ServiceStub::ChannelPool::Configuration.new
    channel_pool_config.channel_count = 2
    rpc_count = 0
    method_stub = Proc.new do |request, options|
      rpc_count += 1
      true
    end
    mock = Minitest::Mock.new
    mock.expect :nil?, false
    (1..2).each do
      mock.expect :nil?, false
      mock.expect :new, mock, ["service:port", creds], channel_args: {}, interceptors: []
    end
    mock.expect :method, method_stub, ["sample_rpc"]

    Gapic::ServiceStub::RpcCall.stub :new, FakeRpcCall.method(:new) do
      service_stub = Gapic::ServiceStub.new mock, endpoint: "service:port", credentials: creds,
                                            channel_pool_config: channel_pool_config
      assert_equal true, service_stub.call_rpc("sample_rpc", nil)
      mock.verify
    end

    assert_equal rpc_count, 1
  end

  def test_call_rpc_without_channel_pool
    creds = :this_channel_is_insecure
    rpc_count = 0
    method_stub = Proc.new do |request, options|
      rpc_count += 1
      true
    end
    mock = Minitest::Mock.new
    mock.expect :nil?, false
    mock.expect :new, mock, ["service:port", creds], channel_args: {}, interceptors: []
    mock.expect :method, method_stub, ["sample_rpc"]

    Gapic::ServiceStub::RpcCall.stub :new, FakeRpcCall.method(:new) do
      service_stub = Gapic::ServiceStub.new mock, endpoint: "service:port", credentials: creds
      assert_equal true, service_stub.call_rpc("sample_rpc", nil)
      mock.verify
    end

    assert_equal rpc_count, 1
  end

  class FakeGrpcStub
    def initialize *args, **kwargs
    end
  end

  def test_default_universe_domain
    creds = FakeCredentials.new
    service_stub = Gapic::ServiceStub.new FakeGrpcStub,
                                          endpoint_template: "myservice.$UNIVERSE_DOMAIN$",
                                          credentials: creds
    assert_equal "googleapis.com", service_stub.universe_domain
    assert_equal "myservice.googleapis.com", service_stub.endpoint
  end

  def test_custom_universe_domain
    creds = FakeCredentials.new universe_domain: "myuniverse.com"
    service_stub = Gapic::ServiceStub.new FakeGrpcStub,
                                          universe_domain: "myuniverse.com",
                                          endpoint_template: "myservice.$UNIVERSE_DOMAIN$",
                                          credentials: creds
    assert_equal "myuniverse.com", service_stub.universe_domain
    assert_equal "myservice.myuniverse.com", service_stub.endpoint
  end

  def test_universe_domain_env
    old_domain = ENV["GOOGLE_CLOUD_UNIVERSE_DOMAIN"]
    ENV["GOOGLE_CLOUD_UNIVERSE_DOMAIN"] = "myuniverse.com"
    begin
      creds = FakeCredentials.new universe_domain: "myuniverse.com"
      service_stub = Gapic::ServiceStub.new FakeGrpcStub,
                                            endpoint_template: "myservice.$UNIVERSE_DOMAIN$",
                                            credentials: creds
      assert_equal "myuniverse.com", service_stub.universe_domain
      assert_equal "myservice.myuniverse.com", service_stub.endpoint
    ensure
      ENV["GOOGLE_CLOUD_UNIVERSE_DOMAIN"] = old_domain
    end
  end

  def test_universe_domain_credentials_mismatch
    creds = FakeCredentials.new universe_domain: "myuniverse.com"
    assert_raises Gapic::UniverseDomainMismatch do
      Gapic::ServiceStub.new FakeGrpcStub,
                             endpoint_template: "myservice.$UNIVERSE_DOMAIN$",
                             credentials: creds
    end
  end

  def test_universe_domain_credentials_with_mismatch_disabled
    creds = FakeCredentialsWithDisabledCheck.new universe_domain: "myuniverse.com"
    service_stub = Gapic::ServiceStub.new FakeGrpcStub,
                                          endpoint_template: "myservice.$UNIVERSE_DOMAIN$",
                                          credentials: creds
    assert_equal "googleapis.com", service_stub.universe_domain
  end

  def test_endpoint_override
    creds = FakeCredentials.new universe_domain: "myuniverse.com"
    service_stub = Gapic::ServiceStub.new FakeGrpcStub,
                                          universe_domain: "myuniverse.com",
                                          endpoint_template: "myservice.$UNIVERSE_DOMAIN$",
                                          endpoint: "myservice.otheruniverse.com",
                                          credentials: creds
    assert_equal "myuniverse.com", service_stub.universe_domain
    assert_equal "myservice.otheruniverse.com", service_stub.endpoint
  end
end
