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
require "gapic/presenters/snippet/client_initialization_presenter"

class ClientInitializationPresenterTest < PresenterTest
  include SnippetTestHelper

  CLIENT_TYPE = "Google::Cloud::MyAPI::V1::MyService::Client"

  def build_client_init_presenter json, phase1: false
    klass = Google::Cloud::Tools::SnippetGen::ConfigLanguage::V1::Snippet::ClientInitialization
    proto = build_proto_fragment klass, json if json
    Gapic::Presenters::SnippetPresenter::ClientInitializationPresenter.new \
      proto, json, phase1: phase1, client_type: CLIENT_TYPE
  end

  def test_message_omitted_phase2
    presenter = build_client_init_presenter nil
    expected = ["client = #{CLIENT_TYPE}.new"]
    assert_equal expected, presenter.render_lines
  end

  def test_message_omitted_phase1
    presenter = build_client_init_presenter nil, phase1: true
    expected = [
      "# Create a client object. The client can be reused for multiple calls.",
      "client = #{CLIENT_TYPE}.new"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_with_endpoint
    json = {
      "customServiceEndpoint" => {
        "schema" => "HTTPS",
        "region" => "apac",
        "host" => "myapi.googleapis.com",
        "port" => 8088
      }
    }
    presenter = build_client_init_presenter json
    expected = [
      "client = #{CLIENT_TYPE}.new do |config|",
      '  config.endpoint = "https://apac-myapi.googleapis.com:8088"',
      "end"
    ]
    assert_equal expected, presenter.render_lines
  end

  def test_with_pre_statements
    json = {
      "preClientInitialization" => [
        "standardOutput" => {
          "value" => {
            "stringValue" => "Hello!"
          }
        }
      ]
    }
    presenter = build_client_init_presenter json
    expected = [
      'puts("Hello!")',
      "client = #{CLIENT_TYPE}.new"
    ]
    assert_equal expected, presenter.render_lines
  end
end
