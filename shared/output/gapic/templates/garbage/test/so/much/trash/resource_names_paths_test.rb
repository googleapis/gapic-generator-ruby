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

require "so/much/trash/resource_names"

class ::So::Much::Trash::ResourceNames::ClientPathsTest < Minitest::Test
  def test_complex_pattern_non_parent_resource_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::So::Much::Trash::ResourceNames::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.complex_pattern_non_parent_resource_path order_a: "value0", order_b: "value1"
      assert_equal "orders/value0~value1", path
    end
  end

  def test_complex_pattern_request_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::So::Much::Trash::ResourceNames::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.complex_pattern_request_path customer: "value0", item_a_id: "value1", item_b_id: "value2", items_c_id: "value3", details_a_id: "value4", details_b_id: "value5", details_c_id: "value6", extra_id: "value7"
      assert_equal "customers/value0/items/value1.value2~value3/details/value4_value5-value6/extra/value7", path

      path = client.complex_pattern_request_path customer: "value0", extra_id: "value1"
      assert_equal "as/customers/value0/extras/value1", path
    end
  end

  def test_complex_pattern_resource_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::So::Much::Trash::ResourceNames::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.complex_pattern_resource_path customer: "value0", item_a_id: "value1", item_b_id: "value2", items_c_id: "value3"
      assert_equal "customers/value0/items/value1.value2~value3", path
    end
  end

  def test_simple_pattern_non_parent_resource_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::So::Much::Trash::ResourceNames::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.simple_pattern_non_parent_resource_path location: "value0"
      assert_equal "locations/value0", path
    end
  end

  def test_simple_pattern_request_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::So::Much::Trash::ResourceNames::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.simple_pattern_request_path customer: "value0", thing: "value1"
      assert_equal "customers/value0/things/value1", path
    end
  end

  def test_simple_pattern_resource_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::So::Much::Trash::ResourceNames::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.simple_pattern_resource_path customer: "value0"
      assert_equal "customers/value0", path
    end
  end

  def test_star_pattern_request_path
    grpc_channel = ::GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    ::Gapic::ServiceStub.stub :new, nil do
      client = ::So::Much::Trash::ResourceNames::Client.new do |config|
        config.credentials = grpc_channel
      end

      path = client.star_pattern_request_path customer: "value0", path: "value1"
      assert_equal "customers/value0/path/value1", path
    end
  end
end
