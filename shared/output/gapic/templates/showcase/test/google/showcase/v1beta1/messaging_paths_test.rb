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

require "helper"

require "gapic/grpc/service_stub"

require "google/showcase/v1beta1/messaging"

class ::Google::Showcase::V1beta1::Messaging::ClientPathsTest < Minitest::Test
  def test_blurb_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.blurb_path room_id: "value0", blurb_id: "value1"
      assert_equal "rooms/value0/blurbs/value1", path

      path = client.blurb_path user_id: "value0", blurb_id: "value1"
      assert_equal "user/value0/profile/blurbs/value1", path
    end
  end

  def test_room_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.room_path room_id: "value0"
      assert_equal "rooms/value0", path
    end
  end

  def test_user_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::Google::Showcase::V1beta1::Messaging::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.user_path user_id: "value0"
      assert_equal "users/value0", path
    end
  end
end
