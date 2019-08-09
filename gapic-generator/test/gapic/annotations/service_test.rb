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

class AnnotationServiceTest < AnnotationTest
  def test_garbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service

    assert_kind_of Google::Protobuf::ServiceOptions, service.options
    garbage_host = "endlesstrash.example.net"
    assert_equal garbage_host, service.options[:default_host]
    garbage_scopes = %w[
      https://endlesstrash.example.net/garbage-admin
      https://endlesstrash.example.net/garbage-read
      https://endlesstrash.example.net/garbage-write
    ]
    assert_equal garbage_scopes.join(","), service.options[:oauth_scopes]

    assert_equal garbage_host, service.host
    assert_equal garbage_scopes, service.scopes
  end

  def test_showcase
    showcase = api :showcase
    service = showcase.services.find { |s| s.name == "Echo" }
    refute_nil service

    assert_kind_of Google::Protobuf::ServiceOptions, service.options
    assert_equal "localhost:7469", service.options[:default_host]
    assert_equal "", service.options[:oauth_scopes]

    assert_equal "localhost:7469", service.host
    assert_empty service.scopes
  end

  def test_speech
    showcase = api :speech
    service = showcase.services.find { |s| s.name == "Speech" }
    refute_nil service

    assert_nil service.options

    assert_nil service.host
    assert_nil service.scopes
  end
end
