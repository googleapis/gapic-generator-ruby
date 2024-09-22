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

class ChannelPoolTest < Minitest::Test
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
    def initialize
    end

    def updater_proc
      ->{}
    end
  end

  FakeRpcCall = Class.new do
    def initialize method_stub, **_kwargs
      @method_stub = method_stub
    end

    def call request, options: nil, &block
      @method_stub&.call(request, options)
    end
  end

  def test_with_channel
    fake_channel = FakeChannel.new

    mock = Minitest::Mock.new
    mock.expect :nil?, false
    mock.expect :new, nil, ["service:port", nil], channel_override: fake_channel, interceptors: []

    assert_raises ArgumentError do
      Gapic::ServiceStub::ChannelPool.new mock, endpoint: "service:port", credentials: fake_channel
    end
  end

  def test_with_channel_credentials
    fake_channel_creds = FakeChannelCredentials.new

    mock = Minitest::Mock.new
    mock.expect :nil?, false
    mock.expect :new, nil, ["service:port", fake_channel_creds], channel_args: {}, interceptors: []


    Gapic::ServiceStub::ChannelPool.new mock, endpoint: "service:port", credentials: fake_channel_creds

    mock.verify
  end

  def test_with_symbol_credentials
    creds = :this_channel_is_insecure

    mock = Minitest::Mock.new
    mock.expect :nil?, false
    mock.expect :new, nil, ["service:port", creds], channel_args: {}, interceptors: []

    Gapic::ServiceStub::ChannelPool.new mock, endpoint: "service:port", credentials: creds

    mock.verify
  end

  def test_with_credentials
    GRPC::Core::CallCredentials.stub :new, FakeCallCredentials.method(:new) do
      GRPC::Core::ChannelCredentials.stub :new, FakeChannelCredentials.method(:new) do
        mock = Minitest::Mock.new
        mock.expect :nil?, false
        mock.expect :new, nil, ["service:port", FakeCallCredentials], channel_args: {}, interceptors: []

        Gapic::ServiceStub::ChannelPool.new mock, endpoint: "service:port", credentials: FakeCredentials.new

        mock.verify
      end
    end
  end

  def test_with_proc
    GRPC::Core::CallCredentials.stub :new, FakeCallCredentials.method(:new) do
      GRPC::Core::ChannelCredentials.stub :new, FakeChannelCredentials.method(:new) do
        mock = Minitest::Mock.new
        mock.expect :nil?, false
        mock.expect :new, nil, ["service:port", FakeCallCredentials], channel_args: {}, interceptors: []

        credentials_proc = ->{}

        Gapic::ServiceStub::ChannelPool.new mock, endpoint: "service:port", credentials: credentials_proc

        mock.verify
      end
    end
  end

  def test_channel_config
    creds = :this_channel_is_insecure
    config = Gapic::ServiceStub::ChannelPool::Configuration.new
    config.channel_count = 5
    config.channel_selection = :least_loaded
    mock = Minitest::Mock.new
    (1..5).each do
      mock.expect :nil?, false
      mock.expect :new, nil, ["service:port", creds], channel_args: {}, interceptors: []
    end

    channel_pool = Gapic::ServiceStub::ChannelPool.new mock, endpoint: "service:port", credentials: creds, config: config

    assert_equal 5, channel_pool.instance_variable_get(:@channels).count
    assert_equal :least_loaded, channel_pool.instance_variable_get(:@config).channel_selection

    mock.verify
  end

  def test_call_rpc
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
      channel_pool = Gapic::ServiceStub::ChannelPool.new mock, endpoint: "service:port", credentials: creds
      assert_equal true, channel_pool.call_rpc("sample_rpc", nil)
      mock.verify
    end

    assert_equal rpc_count, 1
  end

  def test_least_loaded
    creds = :this_channel_is_insecure
    thread_pool = Concurrent::FixedThreadPool.new(1)
    rpc_count = 0
    method_stub = Proc.new do |request, options|
      sleep 3
      rpc_count += 1
    end
    config = Gapic::ServiceStub::ChannelPool::Configuration.new
    config.channel_count = 2
    mock = Minitest::Mock.new
    (1..2).each do
      mock.expect :nil?, false
      mock.expect :new, mock, ["service:port", creds], channel_args: {}, interceptors: []
    end
    mock.expect :method, method_stub, ["sample_rpc"]

    Gapic::ServiceStub::RpcCall.stub :new, FakeRpcCall.method(:new) do
      channel_pool = Gapic::ServiceStub::ChannelPool.new mock, endpoint: "service:port", credentials: creds, config: config
      channels = channel_pool.instance_variable_get :@channels
      assert_equal 2, channels.count

      channels.first.instance_variable_set(:@concurrent_streams, 10)
      channels[1].instance_variable_set(:@concurrent_streams, 3)
      req_1 = Concurrent::Promises.future_on thread_pool do
        channel_pool.call_rpc "sample_rpc", nil
      end

      sleep 1
      assert_equal 4, channels[1].instance_variable_get(:@concurrent_streams)
      req_1.wait!
      mock.verify
    end
    assert_equal rpc_count, 1
  end

  def test_on_channel_create_config
    creds = :this_channel_is_insecure
    channel_create_proc_count = 0
    channel_create_proc = Proc.new do |channel|
      assert channel.is_a?(Gapic::ServiceStub::Channel)
      channel_create_proc_count += 1
    end
    config = Gapic::ServiceStub::ChannelPool::Configuration.new
    config.channel_count = 2
    config.on_channel_create = channel_create_proc
    mock = Minitest::Mock.new
    (1..2).each do
      mock.expect :nil?, false
      mock.expect :new, nil, ["service:port", creds], channel_args: {}, interceptors: []
    end



    Gapic::ServiceStub::ChannelPool.new mock, endpoint: "service:port", credentials: creds, config: config

    assert_equal channel_create_proc_count, 2
    mock.verify
  end
end