# frozen_string_literal: true

# Copyright 2021 Google LLC
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

##
# Tests for the REST paged enumerables
#
class RestPagedEnumerableTest < Minitest::Test
  ##
  # Tests that a `PagedEnumerable` can enumerate all pages via `each_page`
  #
  def test_enumerates_all_pages
    api_responses = [
      Gapic::Examples::GoodPagedResponse.new(
        users: [
          Gapic::Examples::User.new(name: "baz"),
          Gapic::Examples::User.new(name: "bif")
        ]
      )
    ]

    fake_client = FakeReGapicClient.new(*api_responses)
    request = Gapic::Examples::GoodPagedRequest.new
    response = Gapic::Examples::GoodPagedResponse.new(
      users:           [
        Gapic::Examples::User.new(name: "foo"),
        Gapic::Examples::User.new(name: "bar")
      ],
      next_page_token: "next"
    )

    options = {}

    rest_paged_enum = Gapic::Rest::PagedEnumerable.new(
      fake_client, :call_rest, "users", request, response, options
    )

    assert_equal [["foo", "bar"], ["baz", "bif"]], rest_paged_enum.each_page.map { |page| page.map(&:name) }
  end

  ##
  # Tests that a `PagedEnumerable` can enumerate all resources via `each`
  #
  def test_enumerates_all_resources
    api_responses = [
      Gapic::Examples::GoodPagedResponse.new(
        users: [
          Gapic::Examples::User.new(name: "baz"),
          Gapic::Examples::User.new(name: "bif")
        ]
      )
    ]

    fake_client = FakeReGapicClient.new(*api_responses)
    request = Gapic::Examples::GoodPagedRequest.new
    response = Gapic::Examples::GoodPagedResponse.new(
      users:           [
        Gapic::Examples::User.new(name: "foo"),
        Gapic::Examples::User.new(name: "bar")
      ],
      next_page_token: "next"
    )

    options = {}

    rest_paged_enum = Gapic::Rest::PagedEnumerable.new(
      fake_client, :call_rest, "users", request, response, options
    )

    assert_equal %w[foo bar baz bif], rest_paged_enum.each.map(&:name)
  end

  ##
  # Tests that a `MappedPagedEnumerable` can enumerate all pages via `each_page`
  # and within each page can access the resources via the `[]` operator and
  # enumberate key-value resource pairs via the `each_mapped_page`
  #
  def test_enumerates_all_pages_map
    api_responses = [
      Gapic::Examples::GoodMappedPagedResponse.new(
        items: {
          "foo" => Gapic::Examples::UsersScopedInfo.new(scoped_info: "hoge"),
          "bar" => Gapic::Examples::UsersScopedInfo.new(scoped_info: "piyo"),
        },
      )
    ]

    fake_client = FakeReGapicClient.new(*api_responses)
    request = Gapic::Examples::GoodPagedRequest.new
    response = Gapic::Examples::GoodMappedPagedResponse.new(
      items: {
        "foo" => Gapic::Examples::UsersScopedInfo.new(scoped_info: "baz"),
        "bar" => Gapic::Examples::UsersScopedInfo.new(scoped_info: "bif"),
      },
      next_page_token: "next"
    )

    options = {}

    rest_map_paged_enum = Gapic::Rest::MappedPagedEnumerable.new(
      fake_client, :call_rest, "items", request, response, options
    )

    foo_list = []
    bar_list = []
    kvp_list = []

    rest_map_paged_enum.each_page do |map_page|
      foo_list << map_page["foo"].scoped_info
      bar_list << map_page["bar"].scoped_info

      map_page.each_mapped_pair do |key, value| 
        kvp_list << [key, value.scoped_info]
      end
    end

    assert_equal ["baz", "hoge"], foo_list
    assert_equal ["bif", "piyo"], bar_list
    assert_equal [["foo", "baz"], ["bar", "bif"], ["foo", "hoge"], ["bar", "piyo"]], kvp_list
  end
end
