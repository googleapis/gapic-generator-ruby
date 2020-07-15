# frozen_string_literal: true

# Copyright 2020 Google LLC
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

class GemPresenterTest < Minitest::Test
  def test_first_non_common_service
    request = FakeRequest.new
    request.add_file! "google.common.iam" do
      request.add_service! "IamGroot"
    end
    request.add_file! "google.cloud.example" do
      request.add_service! "Hello"
    end
    configuration = {
      common_services: {
        "google.common.iam.IamGroot" => "google.cloud.example.Hello"
      }
    }
    api = Gapic::Schema::Api.new request, configuration: configuration

    presenter = Gapic::Presenters::GemPresenter.new api
    assert_equal "IamGroot", presenter.services.first.address.last
    assert_equal "Hello", presenter.first_non_common_service.address.last
  end

  def test_common_service_sanity_check
    request = FakeRequest.new
    request.add_file! "google.common.iam" do
      request.add_service! "IamGroot"
    end
    request.add_file! "google.cloud.example" do
      request.add_service! "Hello"
    end
    configuration = {
      common_services: {
        "google.common.iam.IamGroot" => "google.cloud.example.Hello",
        "google.common.iam.IamGroot2" => "google.cloud.example.Hello2"
      }
    }
    out, err = capture_subprocess_io do
      Gapic::Schema::Api.new request, configuration: configuration
    end
    assert_equal "", out
    err = err.split("\n")
    assert_equal "WARNING: configured common service google.common.iam.IamGroot2 is not present", err[0]
    assert_equal "WARNING: configured common service delegate google.cloud.example.Hello2 is not present", err[1]
    assert_equal 2, err.size
  end
end
