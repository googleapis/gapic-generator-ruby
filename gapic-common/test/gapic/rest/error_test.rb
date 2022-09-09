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
require "gapic/rest"
require "google/rpc/error_details_pb"
require "json"

class RestErrorTest < Minitest::Test
  def setup
    @status = "PERMISSION_DENIED"
    @status_code = 403
    @err_message = "Compute Engine API has not been used in project 135460398040 before or it is disabled. Enable it by visiting https://console.developers.google.com/apis/api/compute.googleapis.com/overview?project=135460398040 then retry. If you enabled this API recently, wait a few minutes for the action to propagate to our systems and retry."

    @help = ::Google::Rpc::Help.new({
      links: [
        {
          description: "Google developers console API activation",
          url: "https://console.developers.google.com/apis/api/compute.googleapis.com/overview?project=135460398040"
        }
      ]
    })
    @help_any = ::Google::Protobuf::Any.pack @help

    @error_info = ::Google::Rpc::ErrorInfo.new({
      reason: "SERVICE_DISABLED",
      domain: "googleapis.com",
      metadata: {
        consumer: "projects/135460398040",
        service: "compute.googleapis.com"
      }
    })
    @error_info_any = ::Google::Protobuf::Any.pack @error_info

    @body_json_template = <<-JSON
    {
      "error": {
        "code": #{@status_code},
        "message": "#{@err_message}",
        "errors": [
          {
            "message": "foo",
            "domain": "bar",
            "reason": "baz",
            "extendedHelp": "qux"
          }
        ],
        "details": DETAILS_PLACEHOLDER,
        "status": "#{@status}"

      }
    }
    JSON

    @body_json = @body_json_template.gsub(
      "DETAILS_PLACEHOLDER",
      "[\n#{@help_any.to_json},\n#{@error_info_any.to_json}\n]"
    )

    @headers = {"content-type" => "application/json; charset=UTF-8", "content-encoding"=>"gzip"}
  end

  # Tests that a faraday error with a json body
  # is being correctly wrapped, with the Protobuf.any messages unpacked
  def test_wrap_faraday
    faraday_err = OpenStruct.new(
      :message => @err_message,
      :response_body => @body_json,
      :response_headers => @headers,
      :response_status => @status_code
    )

    gapic_err = ::Gapic::Rest::Error.wrap_faraday_error faraday_err

    assert_equal @status_code, gapic_err.status_code
    assert gapic_err.message.include? @err_message
    assert_equal @status, gapic_err.status
    assert_equal @headers, gapic_err.header

    # details should be unpacked
    refute_nil gapic_err.details
    assert gapic_err.details.any?
    grpc_help = gapic_err.details.find {|d| d.is_a? Google::Rpc::Help}
    refute_nil grpc_help
    assert_equal @help.links.first.description, grpc_help.links.first&.description
    assert_equal @help.links.first.url, grpc_help.links.first&.url
  end

  # Tests that the message and the status code from within body
  # override the ones in the faraday error
  def test_body_overrides_error
    faraday_err_msg = "foo"
    faraday_err_code = 200

    faraday_err = OpenStruct.new(
      :message => faraday_err_msg,
      :response_body => @body_json,
      :response_headers => @headers,
      :response_status => faraday_err_code
    )

    gapic_err = ::Gapic::Rest::Error.wrap_faraday_error faraday_err

    assert_equal @status_code, gapic_err.status_code
    assert gapic_err.message.include? @err_message
  end

  # Tests that the message and the status code from the faraday error
  # are used if there are none in body
  def test_faraday_error_applies_by_default
    mangled_json = @body_json.gsub(%r{"code":.*$}, "")
    mangled_json = mangled_json.gsub(%r{"message":.*$}, "")

    faraday_err_msg = "foo"
    faraday_err_code = 200

    faraday_err = OpenStruct.new(
      :message => faraday_err_msg,
      :response_body => mangled_json,
      :response_headers => @headers,
      :response_status => faraday_err_code
    )

    gapic_err = ::Gapic::Rest::Error.wrap_faraday_error faraday_err

    assert_equal faraday_err_code, gapic_err.status_code
    assert gapic_err.message.include? faraday_err_msg
  end

  # Tests that if the details contain hashes that are not
  # Protobuf.Any packed messages they are surfaced as whatever
  # JSON parses them into
  def test_surface_hash_in_details
    hash = {
      "foo" => "bar"
    }

    body_with_hash = @body_json_template.gsub(
      "DETAILS_PLACEHOLDER",
      "[\n#{@help_any.to_json},\n#{hash.to_json}\n]"
    )

    faraday_err = OpenStruct.new(
      :message => @err_message,
      :response_body => body_with_hash,
      :response_headers => @headers,
      :response_status => @status_code
    )

    gapic_err = ::Gapic::Rest::Error.wrap_faraday_error faraday_err

    refute_nil gapic_err.details
    assert gapic_err.details.any?
    grpc_help = gapic_err.details.find {|d| d.is_a? Google::Rpc::Help}
    refute_nil grpc_help

    unpacked_hash = gapic_err.details.find {|d| d.is_a? ::Hash}
    refute_nil unpacked_hash
    assert_equal hash["foo"], unpacked_hash["foo"]
  end

  # Tests that if the details contain objects that are not
  # Protobuf.Any packed messages they are surfaced as whatever
  # JSON parses them into
  def test_surface_object_in_details
    hash = {
      "foo" => "bar"
    }

    int = 3

    body_with_hash = @body_json_template.gsub(
      "DETAILS_PLACEHOLDER",
      "[\n#{@help_any.to_json},\n#{hash.to_json},\n#{int}\n]"
    )

    faraday_err = OpenStruct.new(
      :message => @err_message,
      :response_body => body_with_hash,
      :response_headers => @headers,
      :response_status => @status_code
    )

    gapic_err = ::Gapic::Rest::Error.wrap_faraday_error faraday_err

    refute_nil gapic_err.details
    assert gapic_err.details.any?
    grpc_help = gapic_err.details.find {|d| d.is_a? Google::Rpc::Help}
    refute_nil grpc_help

    unpacked_hash = gapic_err.details.find {|d| d.is_a? ::Hash}
    refute_nil unpacked_hash
    assert_equal hash["foo"], unpacked_hash["foo"]

    unpacked_int = gapic_err.details.find {|d| d.is_a? ::Integer}
    assert_equal int, unpacked_int
  end

  # Tests that if the details is not an array
  # it is still surfaced
  def test_surface_nonarray_details
    int = 3

    body_with_hash = @body_json_template.gsub(
      "DETAILS_PLACEHOLDER",
      "#{int}"
    )

    faraday_err = OpenStruct.new(
      :message => @err_message,
      :response_body => body_with_hash,
      :response_headers => @headers,
      :response_status => @status_code
    )

    gapic_err = ::Gapic::Rest::Error.wrap_faraday_error faraday_err
    assert_equal int, gapic_err.details
  end

  # Tests that if `details` is nil, the wrapping works
  def test_surface_nil_details
    body_with_hash = @body_json_template.gsub(
      "DETAILS_PLACEHOLDER",
      "null"
    )

    faraday_err = OpenStruct.new(
      :message => @err_message,
      :response_body => body_with_hash,
      :response_headers => @headers,
      :response_status => @status_code
    )

    gapic_err = ::Gapic::Rest::Error.wrap_faraday_error faraday_err
    assert_equal @status_code, gapic_err.status_code
    assert gapic_err.message.include? @err_message
    assert_equal @status, gapic_err.status
    assert_equal @headers, gapic_err.header

    assert_nil gapic_err.details
  end

  # Tests that if `details` is absent, the wrapping works
  def test_surface_absent_details
    body_without_details = @body_json_template.gsub(%r{"details":.*$}, "")

    faraday_err = OpenStruct.new(
      :message => @err_message,
      :response_body => body_without_details,
      :response_headers => @headers,
      :response_status => @status_code
    )

    gapic_err = ::Gapic::Rest::Error.wrap_faraday_error faraday_err

    assert_equal @status_code, gapic_err.status_code
    assert gapic_err.message.include? @err_message
    assert_equal @status, gapic_err.status
    assert_equal @headers, gapic_err.header

    assert_nil gapic_err.details
  end
end