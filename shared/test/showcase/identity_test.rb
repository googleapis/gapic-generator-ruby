# frozen_string_literal: true

# Copyright 2018 Google LLC
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
require "google/showcase/v1beta1/identity"
require "grpc"

class IdentityTest < ShowcaseTest
  def setup
    @client = new_identity_client
  end

  def test_user_create
    display_name = "Jane Doe"
    email = "janedoe@example.com"
    nickname = "doe"
    height_feet = 6.2

    user = {
      display_name: display_name,
      email:        email,
      nickname:     nickname,
      height_feet:  height_feet
    }

    response = @client.create_user user: user
    assert_kind_of ::Google::Showcase::V1beta1::User, response
    refute_nil response.name
    assert_equal display_name, response.display_name
    assert_equal email, response.email
    refute response.has_age?
    assert response.has_height_feet?
    assert_equal height_feet, response.height_feet
    assert response.has_nickname?
    assert_equal nickname, response.nickname
  end
end
