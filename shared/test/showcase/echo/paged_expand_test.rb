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
require "google/showcase/v1alpha3/echo"
require "grpc"

class PagedExpandTest < ShowcaseTest
  def test_paged_expand
    client = Google::Showcase::V1alpha3::Echo::Client.new(
      credentials: GRPC::Core::Channel.new("localhost:7469", nil, :this_channel_is_insecure)
    )

    request_content = "The quick brown fox jumps over the lazy dog"

    response_enum = client.paged_expand content: request_content

    assert_kind_of Google::Gax::PagedEnumerable, response_enum

    responses_content_array = response_enum.to_a.map(&:content)

    assert_equal request_content, responses_content_array.join(" ")
  end

  def test_page_size
    client = Google::Showcase::V1alpha3::Echo::Client.new(
      credentials: GRPC::Core::Channel.new("localhost:7469", nil, :this_channel_is_insecure)
    )

    request_content = "The quick brown fox jumps over the lazy dog"

    response_enum = client.paged_expand content: request_content, page_size: 2

    assert_kind_of Google::Gax::PagedEnumerable, response_enum
    assert_kind_of Google::Showcase::V1alpha3::PagedExpandResponse, response_enum.page.response
    assert_equal ["The", "quick"], response_enum.page.response.responses.map(&:content)

    responses_content_array = response_enum.to_a.map(&:content)

    assert_equal request_content, responses_content_array.join(" ")
  end
end
