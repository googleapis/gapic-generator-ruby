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

class AnnotationPackageTest < AnnotationTest
  def test_garbage
    garbage = api :garbage
    service = garbage.services.find { |s| s.name == "GarbageService" }
    refute_nil service
    file = service.parent
    refute_nil file

    refute_nil file.options
    assert_kind_of Google::Protobuf::FileOptions, file.options
    refute_nil file.options[:client_package]
    assert_kind_of Google::Api::Package, file.options[:client_package]
    assert_equal "Testing Garbage", file.options[:client_package][:title]
    assert_equal %w[Endless Trash], file.options[:client_package][:namespace]
    assert_equal "Forever", file.options[:client_package][:version]

    assert_kind_of Google::Api::Package, file.client_package
    assert_equal "Testing Garbage", file.client_package.title
    assert_equal %w[Endless Trash], file.client_package.namespace
    assert_equal "Forever", file.client_package.version

    # client_package is also exposed on the service
    assert_kind_of Google::Api::Package, service.client_package
    assert_equal "Testing Garbage", service.client_package.title
    assert_equal %w[Endless Trash], service.client_package.namespace
    assert_equal "Forever", service.client_package.version
  end
end
