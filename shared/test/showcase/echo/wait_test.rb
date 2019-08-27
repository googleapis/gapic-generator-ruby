# frozen_string_literal: true

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
require "google/showcase/v1beta1/echo"
require "grpc"

class WaitTest < ShowcaseTest
  def setup
    @client = new_echo_client
  end

  def test_wait
    operation = @client.wait ttl: { nanos: 500000 }, success: { content: "hi there!" }

    refute operation.done?
    operation.wait_until_done!

    assert operation.done?
    assert operation.response?
    assert_equal "hi there!", operation.response.content
  end

  def test_wait_error
    operation = @client.wait ttl: { nanos: 500000 }, error: Google::Rpc::Status.new(message: "nope")

    refute operation.done?
    operation.wait_until_done!

    assert operation.done?
    assert operation.error?
    assert_equal "nope", operation.error.message
  end
end
