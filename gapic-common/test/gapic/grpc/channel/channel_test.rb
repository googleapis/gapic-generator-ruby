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

class ChannelTest < Minitest::Test
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

    Gapic::ServiceStub::Channel.new mock, endpoint: "service:port", credentials: fake_channel

    mock.verify
  end

  def test_with_channel_credentials
    fake_channel_creds = FakeChannelCredentials.new

    mock = Minitest::Mock.new
    mock.expect :nil?, false
    mock.expect :new, nil, ["service:port", fake_channel_creds], channel_args: {}, interceptors: []

    Gapic::ServiceStub::Channel.new mock, endpoint: "service:port", credentials: fake_channel_creds

    mock.verify
  end

  def test_with_symbol_credentials
    creds = :this_channel_is_insecure

    mock = Minitest::Mock.new
    mock.expect :nil?, false
    mock.expect :new, nil, ["service:port", creds], channel_args: {}, interceptors: []

    Gapic::ServiceStub::Channel.new mock, endpoint: "service:port", credentials: creds

    mock.verify
  end

  def test_with_credentials
    GRPC::Core::CallCredentials.stub :new, FakeCallCredentials.method(:new) do
      GRPC::Core::ChannelCredentials.stub :new, FakeChannelCredentials.method(:new) do
        mock = Minitest::Mock.new
        mock.expect :nil?, false
        mock.expect :new, nil, ["service:port", FakeCallCredentials], channel_args: {}, interceptors: []

        Gapic::ServiceStub::Channel.new mock, endpoint: "service:port", credentials: FakeCredentials.new

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

        Gapic::ServiceStub::Channel.new mock, endpoint: "service:port", credentials: credentials_proc

        mock.verify
      end
    end
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
      channel = Gapic::ServiceStub::Channel.new mock, endpoint: "service:port", credentials: creds
      assert_equal true, channel.call_rpc("sample_rpc", nil)
      mock.verify
    end

    assert_equal rpc_count, 1
  end

  def test_call_rpc_failure
    creds = :this_channel_is_insecure
    method_stub = Proc.new do |request, options|
      raise StandardError.new
    end
    mock = Minitest::Mock.new
    mock.expect :nil?, false
    mock.expect :new, mock, ["service:port", creds], channel_args: {}, interceptors: []
    mock.expect :method, method_stub, ["sample_rpc"]

    Gapic::ServiceStub::RpcCall.stub :new, FakeRpcCall.method(:new) do
      channel = Gapic::ServiceStub::Channel.new mock, endpoint: "service:port", credentials: creds
      assert_raises StandardError do
        channel.call_rpc"sample_rpc", nil
      end
      assert_equal 0,channel.concurrent_streams
      mock.verify
    end
  end

  def test_concurrent_rpc
    creds = :this_channel_is_insecure
    thread_pool = Concurrent::FixedThreadPool.new(2)
    rpc_count = 0
    method_stub = Proc.new do |request, options|
      sleep 3
      rpc_count += 1
    end
    mock = Minitest::Mock.new
    mock.expect :nil?, false
    mock.expect :new, mock, ["service:port", creds], channel_args: {}, interceptors: []
    mock.expect :method, method_stub, ["sample_rpc"]
    mock.expect :method, method_stub, ["sample_rpc"]

    Gapic::ServiceStub::RpcCall.stub :new, FakeRpcCall.method(:new) do
      channel = Gapic::ServiceStub::Channel.new mock, endpoint: "service:port", credentials: creds

      req_1 = Concurrent::Promises.future_on thread_pool do
        channel.call_rpc "sample_rpc", nil
      end
      req_2 = Concurrent::Promises.future_on thread_pool do
        channel.call_rpc "sample_rpc", nil
      end

      sleep 1
      assert_equal 2, channel.concurrent_streams
      req_1.wait!
      req_2.wait!
      assert_equal 0, channel.concurrent_streams
      mock.verify
    end
    assert_equal rpc_count, 2
  end

  def test_on_channel_create
    creds = :this_channel_is_insecure
    channel_count = 0
    channel_create_proc = Proc.new do |channel|
      assert channel.is_a?(Gapic::ServiceStub::Channel)
      channel_count += 1
    end
    mock = Minitest::Mock.new
    mock.expect :nil?, false
    mock.expect :new, mock, ["service:port", creds], channel_args: {}, interceptors: []

    Gapic::ServiceStub::Channel.new mock, endpoint: "service:port", credentials: creds,
                                                on_channel_create: channel_create_proc

    assert_equal channel_count, 1
    mock.verify
  end
end