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

class ClientCallPresenterTest < PresenterTest
  include SnippetTestHelper

  METHOD_NAME = "do_something_big"
  REQUEST_NAME = "request"
  RESPONSE_NAME = "response"

  def build_client_call_presenter json, phase1: false, streaming: false, response_name: RESPONSE_NAME
    klass = Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::ClientCall
    proto = build_proto_fragment klass, json if json
    Gapic::Presenters::SnippetPresenter::ClientCallPresenter.new \
      proto, json,
      method_name: METHOD_NAME, request_name: REQUEST_NAME, response_name: response_name,
      client_streaming: streaming, server_streaming: streaming, phase1: phase1
  end

  def test_phase1_non_streaming
    presenter = build_client_call_presenter nil, phase1: true
    expected = [
      "# Call the do_something_big method.",
      "#{RESPONSE_NAME} = client.#{METHOD_NAME} #{REQUEST_NAME}"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_phase1_streaming
    presenter = build_client_call_presenter nil, phase1: true, streaming: true
    expected = [
      "# Call the do_something_big method to start streaming.",
      "#{RESPONSE_NAME} = client.#{METHOD_NAME} #{REQUEST_NAME}"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_with_response
    json = {
      "preCall" => [
        "standardOutput" => {
          "value" => {
            "stringValue" => "Making the call!"
          }
        }
      ]
    }
    presenter = build_client_call_presenter json
    expected = [
      'puts("Making the call!")',
      "#{RESPONSE_NAME} = client.#{METHOD_NAME} #{REQUEST_NAME}"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_with_no_response
    json = {
      "preCall" => [
        "standardOutput" => {
          "value" => {
            "stringValue" => "Making the call!"
          }
        }
      ]
    }
    presenter = build_client_call_presenter json, response_name: nil
    expected = [
      'puts("Making the call!")',
      "client.#{METHOD_NAME} #{REQUEST_NAME}"
    ]
    assert_equal expected, presenter.render_lines
  end
end
