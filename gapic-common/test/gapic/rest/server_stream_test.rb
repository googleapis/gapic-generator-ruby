# frozen_string_literal: true

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
require "faraday"

class MockProtobufClass
  def self.decode_json str, ignore_unknown_fields: true
    return str
  end
end

#
# Tests for the ServerStream.
#
class ServerStreamTest < Minitest::Test
  def test_server_stream_simple
    enumerable = "[{\"foo\":1},{\"bar\":1}]".chars.to_enum
    stream = ::Gapic::Rest::ServerStream.new MockProtobufClass, enumerable
    assert stream.count == 2
  end

  def test_server_stream_incomplete
    enumerable = "[{\"foo\":1},".chars.to_enum
    stream = ::Gapic::Rest::ServerStream.new MockProtobufClass, enumerable
    assert stream.count == 1
  end

  def test_server_stream_empty
    enumerable = "[]".chars.to_enum
    stream = ::Gapic::Rest::ServerStream.new MockProtobufClass, enumerable
    assert stream.count == 0
  end
end
