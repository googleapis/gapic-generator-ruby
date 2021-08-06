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

class ServicePresenterTest < PresenterTest
  def test_deduped_resources
    request = FakeRequest.new
    request.add_file! "google.common.iam" do
      request.add_message! "Request1" do
        request.set_message_resource! "location.googleapis.com/Location",
                                      ["projects/{project}/locations/{location}"]
      end
      request.add_message! "Request2" do
        request.set_message_resource! "org.googleapis.com/Location",
                                      ["organizations/{organization}/locations/{location}"]
      end
      request.add_service! "IamGroot" do
        request.add_method! "Foo", "google.common.iam.Request1", "google.common.iam.Request1"
        request.add_method! "Bar", "google.common.iam.Request2", "google.common.iam.Request2"
      end
    end
    api = Gapic::Schema::Api.new request
    presenter = Gapic::Presenters::GemPresenter.new api
    service_presenter = presenter.services.first
    assert_equal 2, service_presenter.references.size
    assert_equal 1, service_presenter.deduped_references.size
    patterns = service_presenter.deduped_references[0].patterns
    assert_equal 2, patterns.size
    assert_equal "projects/*/locations/*", patterns[0].pattern_template
    assert_equal "organizations/*/locations/*", patterns[1].pattern_template
  end

  def test_deduped_resources_with_duplicated_patterns
    request = FakeRequest.new
    request.add_file! "google.common.iam" do
      request.add_message! "Request1" do
        request.set_message_resource! "location.googleapis.com/Location",
                                      ["projects/{project}/locations/{location}"]
      end
      request.add_message! "Request2" do
        request.set_message_resource! "org.googleapis.com/Location",
                                      ["projects/{project}/locations/{where}"]
      end
      request.add_service! "IamGroot" do
        request.add_method! "Foo", "google.common.iam.Request1", "google.common.iam.Request1"
        request.add_method! "Bar", "google.common.iam.Request2", "google.common.iam.Request2"
      end
    end
    api = Gapic::Schema::Api.new request
    presenter = Gapic::Presenters::GemPresenter.new api
    service_presenter = presenter.services.first
    assert_equal 2, service_presenter.references.size
    assert_equal 1, service_presenter.deduped_references.size
    patterns = service_presenter.deduped_references[0].patterns
    assert_equal 1, patterns.size
    assert_equal "projects/*/locations/*", patterns[0].pattern_template
  end

  def test_deprecated_service
    presenter = service_presenter :garbage, "DeprecatedService"

    assert_equal 1, presenter.methods.size
    assert_equal "DeprecatedService", presenter.name
    assert_equal true, presenter.is_deprecated?
  end
end
