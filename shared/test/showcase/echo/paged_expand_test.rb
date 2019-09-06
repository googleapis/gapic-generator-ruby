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

class PagedExpandTest < ShowcaseTest
  def setup
    @client = new_echo_client
  end

  def test_paged_expand
    request_content = "The quick brown fox jumps over the lazy dog"

    response_enum = @client.paged_expand content: request_content

    assert_kind_of Gapic::PagedEnumerable, response_enum

    responses_content_array = response_enum.to_a.map(&:content)

    assert_equal request_content, responses_content_array.join(" ")
  end

  def test_page_size
    request_content = "The quick brown fox jumps over the lazy dog"

    response_enum = @client.paged_expand content: request_content, page_size: 2

    assert_kind_of Gapic::PagedEnumerable, response_enum
    assert_kind_of Google::Showcase::V1beta1::PagedExpandResponse, response_enum.page.response
    assert_equal ["The", "quick"], response_enum.page.response.responses.map(&:content)

    response_pages = response_enum.each_page.to_a
    responses_content_array = response_pages.map { |page| page.map(&:content) }

    assert_equal request_content, responses_content_array.join(" ")

    assert_instance_of GRPC::ActiveCall::Operation, response_pages.first.operation
    assert_instance_of GRPC::ActiveCall::Operation, response_pages.last.operation
    refute_equal response_pages.first.operation, response_pages.last.operation
  end

  def test_page_expand_with_block
    request_content = "The quick brown fox jumps over the lazy dog".split(" ").reverse.join(" ")

    @client.paged_expand content: request_content, page_size: 2 do |response_enum, operation|
      assert_kind_of Gapic::PagedEnumerable, response_enum
      assert_equal ["dog", "lazy"], response_enum.page.response.responses.map(&:content)
      assert_instance_of GRPC::ActiveCall::Operation, response_enum.page.operation
      assert_equal operation, response_enum.page.operation
      assert_equal({}, operation.trailing_metadata)

      response_pages = response_enum.each_page.to_a
      responses_content_array = response_pages.map { |page| page.map(&:content) }

      assert_equal request_content, responses_content_array.join(" ")

      assert_instance_of GRPC::ActiveCall::Operation, operation
      assert_instance_of GRPC::ActiveCall::Operation, response_pages.first.operation
      assert_instance_of GRPC::ActiveCall::Operation, response_pages.last.operation
      assert_equal operation, response_pages.first.operation
      refute_equal operation, response_pages.last.operation
    end
  end
end
