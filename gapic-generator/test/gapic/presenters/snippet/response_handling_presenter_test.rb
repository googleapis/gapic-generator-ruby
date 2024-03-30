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
require_relative "snippet_test_helper"

class ResponseHandlingPresenterTest < PresenterTest
  include SnippetTestHelper

  RESPONSE_TYPE = "Google::Cloud::MyAPI::V1::MyResponse"
  STANDARD_RESPONSE_NAME = "result"

  def build_simple_presenter json, phase1: false
    klass = Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::SimpleResponseHandling
    proto = build_proto_fragment klass, json if json
    Gapic::Presenters::SnippetPresenter::SimpleResponseHandlingPresenter.new \
      proto, json, response_type: RESPONSE_TYPE, phase1: phase1
  end

  def build_lro_presenter json, phase1: false
    klass = Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::LroResponseHandling
    proto = build_proto_fragment klass, json if json
    Gapic::Presenters::SnippetPresenter::LroResponseHandlingPresenter.new proto, json, phase1: phase1
  end

  def build_streaming_presenter json, phase1: false, response_name: STANDARD_RESPONSE_NAME
    klass = Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::StreamingResponseHandling
    proto = build_proto_fragment klass, json if json
    Gapic::Presenters::SnippetPresenter::StreamingResponseHandlingPresenter.new \
      proto, json, response_name: response_name, base_response_type: RESPONSE_TYPE, phase1: phase1
  end

  def build_paginated_presenter json, phase1: false
    klass = Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::PaginatedResponseHandling
    proto = build_proto_fragment klass, json if json
    Gapic::Presenters::SnippetPresenter::PaginatedResponseHandlingPresenter.new \
      proto, json, paged_response_type: RESPONSE_TYPE, phase1: phase1
  end

  def test_simple_phase1
    presenter = build_simple_presenter nil, phase1: true
    expected = [
      "# The returned object is of type #{RESPONSE_TYPE}.",
      "p #{STANDARD_RESPONSE_NAME}"
    ]
    assert_equal expected, presenter.render_lines
    assert_equal "result", presenter.response_name
  end

  def test_simple_with_no_handling
    json = {}
    presenter = build_simple_presenter json
    assert_empty presenter.render_lines
    assert_nil presenter.response_name
  end

  def test_simple_with_default_handling
    json = {"responseName" => "response"}
    presenter = build_simple_presenter json
    assert_empty presenter.render_lines
    assert_equal "response", presenter.response_name
  end

  def test_lro_phase1
    presenter = build_lro_presenter nil, phase1: true
    expected = [
      "# The returned object is of type Gapic::Operation. You can use it to",
      "# check the status of an operation, cancel it, or wait for results.",
      "# Here is how to wait for a response.",
      "result.wait_until_done! timeout: 60",
      "if result.response?",
      "  p result.response",
      "else",
      '  puts "No response received."',
      "end"
    ]
    assert_equal expected, presenter.render_lines
    assert_equal "result", presenter.response_name
  end

  def test_lro_once
    json = {
      "responseName" => "lro",
      "pollingType" => "ONCE"
    }
    presenter = build_lro_presenter json
    expected = [
      "if lro.response?",
      "  p lro.response",
      "else",
      '  puts "Response not yet arrived."',
      "end"
    ]
    assert_equal expected, presenter.render_lines
    assert_equal "lro", presenter.response_name
  end

  def test_lro_until_completion
    json = {
      "responseName" => "lro",
    }
    presenter = build_lro_presenter json
    expected = [
      "lro.wait_until_done! timeout: 60",
      "if lro.response?",
      "  p lro.response",
      "else",
      '  puts "No response received."',
      "end"
    ]
    assert_equal expected, presenter.render_lines
    assert_equal "lro", presenter.response_name
  end

  def test_lro_no_poll
    json = {
      "responseName" => "lro",
      "pollingType" => "NONE"
    }
    presenter = build_lro_presenter json
    assert_empty presenter.render_lines
    assert_equal "lro", presenter.response_name
  end

  def test_streaming_phase1
    presenter = build_streaming_presenter nil, phase1: true
    expected = [
      "# The returned object is a streamed enumerable yielding elements of type",
      "# #{RESPONSE_TYPE}",
      "result.each do |current_response|",
      "  p current_response",
      "end"
    ]
    assert_equal expected, presenter.render_lines
    assert_equal "result", presenter.response_name
  end

  def test_streaming_with_statements
    json = {
      "currentResponseName" => "item",
      "perStreamResponseStatements" => [
        {
          "standardOutput" => {
            "value" => {
              "nameValue" => {
                "name" => "item",
                "path" => ["address"]
              }
            }
          }
        }
      ]
    }
    presenter = build_streaming_presenter json, response_name: "server_stream"
    expected = [
      "server_stream.each do |item|",
      "  puts(item.address)",
      "end"
    ]
    assert_equal expected, presenter.render_lines
    assert_equal "server_stream", presenter.response_name
  end

  def test_paginated_phase1
    presenter = build_paginated_presenter nil, phase1: true
    expected = [
      "# The returned object is of type Gapic::PagedEnumerable. You can iterate",
      "# over elements, and API calls will be issued to fetch pages as needed.",
      "result.each do |item|",
      "  # Each element is of type #{RESPONSE_TYPE}.",
      "  p item",
      "end"
    ]
    assert_equal expected, presenter.render_lines
    assert_equal "result", presenter.response_name
  end

  def test_paginated_by_item
    json = {
      "responseName" => "elements",
      "byItem" => {
        "itemName" => "elem",
        "perItemStatements" => [
          "standardOutput" => {
            "value" => {
              "nameValue" => {
                "name" => "elem",
                "path" => ["address"]
              }
            }
          }
        ]
      }
    }
    presenter = build_paginated_presenter json
    expected = [
      "elements.each do |elem|",
      "  puts(elem.address)",
      "end"
    ]
    assert_equal expected, presenter.render_lines
    assert_equal "elements", presenter.response_name
  end

  def test_paginated_by_page
    json = {
      "responseName" => "pages",
      "byPage" => {
        "pageName" => "page",
        "perPageStatements" => [
          "standardOutput" => {
            "value" => {
              "stringValue" => "Got new page."
            }
          }
        ],
        "byItem" => {
          "itemName" => "elem",
          "perItemStatements" => [
            "standardOutput" => {
              "value" => {
                "nameValue" => {
                  "name" => "elem",
                  "path" => ["address"]
                }
              }
            }
          ]
        }
      }
    }
    presenter = build_paginated_presenter json
    expected = [
      "pages.each_page do |page|",
      '  puts("Got new page.")',
      "  page.each do |elem|",
      "    puts(elem.address)",
      "  end",
      "end"
    ]
    assert_equal expected, presenter.render_lines
    assert_equal "pages", presenter.response_name
  end
end
