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

class FieldPresenterShowcaseTest < PresenterTest
  def presenter method_name
    method_presenter :showcase, "Identity", method_name
  end

  def presenter_for_field method_presenter, field_name
    method_presenter.fields.find { |f| f.name == field_name }
  end

  def test_showcase_User_name_field
    fp = field_presenter :showcase, "google.showcase.v1beta1.User", "name"

    assert_equal "name", fp.name
    assert_equal "@!attribute [rw] name", fp.doc_attribute_type
    assert_equal "::String", fp.output_doc_types
    assert_equal "The resource name of the user.\n", fp.doc_description
    assert_equal "\"hello world\"", fp.default_value
    assert_equal "", fp.type_name
    assert_nil fp.type_name_full
  end

  def test_showcase_User_age_field
    fp = field_presenter :showcase, "google.showcase.v1beta1.User", "age"

    assert_equal "age", fp.name
    assert_equal "@!attribute [rw] age", fp.doc_attribute_type
    assert_equal "::Integer", fp.output_doc_types
    assert_equal "The age of the user in years.\n", fp.doc_description
    assert_equal "42", fp.default_value
    assert_equal "", fp.type_name
    assert_nil fp.type_name_full
    assert fp.proto3_optional?
    assert fp.oneof?
    assert_equal "_age", fp.oneof_name
  end

  def test_showcase_User_create_time_field
    fp = field_presenter :showcase, "google.showcase.v1beta1.User", "create_time"

    assert_equal "create_time", fp.name
    assert_equal "@!attribute [r] create_time", fp.doc_attribute_type
    assert_equal "::Google::Protobuf::Timestamp", fp.output_doc_types
    assert_equal "The timestamp at which the user was created.\n", fp.doc_description
    assert_equal "{}", fp.default_value
    assert_equal ".google.protobuf.Timestamp", fp.type_name
    assert_equal "::Google::Protobuf::Timestamp", fp.type_name_full
  end

  def test_showcase_CreateUser_fields
    mp = presenter "CreateUser"
    assert_equal 1, mp.fields.count

    fp = presenter_for_field mp, "user"
    assert_equal "user", fp.name
    assert_equal "@!attribute [rw] user", fp.doc_attribute_type
    assert_equal "::Google::Showcase::V1beta1::User", fp.output_doc_types
    assert_equal "The user to create.\n", fp.doc_description
    assert_equal "{}", fp.default_value
    assert_equal ".google.showcase.v1beta1.User", fp.type_name
    assert_equal "::Google::Showcase::V1beta1::User", fp.type_name_full
  end

  def test_showcase_ListUsers_fields
    mp = presenter "ListUsers"
    assert_equal 2, mp.fields.count

    fp = presenter_for_field mp, "page_size"
    assert_equal "page_size", fp.name
    assert_equal "@!attribute [rw] page_size", fp.doc_attribute_type
    assert_equal "::Integer", fp.output_doc_types
    assert_equal %q(The maximum number of users to return. Server may return fewer users
than requested. If unspecified, server will pick an appropriate default.
), fp.doc_description
    assert_equal "42", fp.default_value
    assert_equal "", fp.type_name
    assert_nil fp.type_name_full

    fp = presenter_for_field mp, "page_token"
    assert_equal "page_token", fp.name
    assert_equal "@!attribute [rw] page_token", fp.doc_attribute_type
    assert_equal "::String", fp.output_doc_types
    assert_equal %q(The value of google.showcase.v1beta1.ListUsersResponse.next_page_token
returned from the previous call to
`google.showcase.v1beta1.Identity\\ListUsers` method.
), fp.doc_description
    assert_equal "\"hello world\"", fp.default_value
    assert_equal "", fp.type_name
    assert_nil fp.type_name_full
  end
end
