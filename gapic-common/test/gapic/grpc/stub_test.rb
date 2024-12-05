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

require "test_helper"
require "gapic/grpc"

class GrpcStubTest < Minitest::Spec
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

    def universe_domain
      "googleapis.com"
    end
  end

  module FakeServiceModule
    class Stub
      def initialize *args, **kwargs
        Stub.args = args
        Stub.kwargs = kwargs
      end

      class << self
        attr_accessor :args
        attr_accessor :kwargs
      end
    end
  end

  def test_with_channel
    fake_channel = FakeChannel.new

    Gapic::ServiceStub.new FakeServiceModule::Stub, endpoint: "service:port", credentials: fake_channel

    assert_equal ["service:port", nil], FakeServiceModule::Stub.args
    assert_equal fake_channel, FakeServiceModule::Stub.kwargs[:channel_override]
  end

  def test_with_channel_credentials
    fake_channel_creds = FakeChannelCredentials.new

    Gapic::ServiceStub.new FakeServiceModule::Stub, endpoint: "service:port", credentials: fake_channel_creds

    assert_equal ["service:port", fake_channel_creds], FakeServiceModule::Stub.args
  end

  def test_with_symbol_credentials
    creds = :this_channel_is_insecure

    Gapic::ServiceStub.new FakeServiceModule::Stub, endpoint: "service:port", credentials: creds

    assert_equal ["service:port", creds], FakeServiceModule::Stub.args
  end

  def test_with_credentials
    GRPC::Core::CallCredentials.stub :new, FakeCallCredentials.method(:new) do
      GRPC::Core::ChannelCredentials.stub :new, FakeChannelCredentials.method(:new) do
        Gapic::ServiceStub.new FakeServiceModule::Stub, endpoint: "service:port", credentials: FakeCredentials.new

        assert_kind_of FakeCallCredentials, FakeServiceModule::Stub.args.last
      end
    end
  end

  def test_with_proc
    GRPC::Core::CallCredentials.stub :new, FakeCallCredentials.method(:new) do
      GRPC::Core::ChannelCredentials.stub :new, FakeChannelCredentials.method(:new) do
        credentials_proc = ->{}

        Gapic::ServiceStub.new FakeServiceModule::Stub, endpoint: "service:port", credentials: credentials_proc

        assert_kind_of FakeCallCredentials, FakeServiceModule::Stub.args.last
      end
    end
  end
end
