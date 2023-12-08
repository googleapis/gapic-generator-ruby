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

class GrpcTranscoderTest < Minitest::Test
  def test_errors
    err = assert_raises ::Gapic::Common::Error do
      Gapic::Rest::GrpcTranscoder.new.with_bindings(
        uri_method: :patch,
        uri_template: "{name}",
        matches: [["name", %r{^v1/projects/[^/]+(?:/.*)?$}, true], ["foo", %r{^v1/projects/[^/]+(?:/.*)?$}, true]])
    end
    assert err.message.include? "Binding configuration is incorrect: missing parameter in the URI template."
    
    err = assert_raises ::Gapic::Common::Error do
      Gapic::Rest::GrpcTranscoder.new.with_bindings(uri_method: :patch, uri_template: "{name}", matches: [])
    end
    assert err.message.include? "Binding configuration is incorrect: missing match configuration."

    err = assert_raises ::Gapic::Common::Error do
      Gapic::Rest::GrpcTranscoder.new.with_bindings(uri_method: :patch, uri_template: "f/100", body: "sub_request.name")
    end
    assert err.message =~ /Provided body template `.+` points to a field in a sub-message/

    transcoder = Gapic::Rest::GrpcTranscoder.new
      .with_bindings(uri_method: :get, uri_template: "{name}", body: "nonexisting_name", matches: [["name", %r{^v1/projects/[^/]+(?:/.*)?$}, true]])

    err = assert_raises ::Gapic::Common::Error do
      # value specified in uri_template does not match any regexes
      transcoder.transcode example_request(name: "projects/100")
    end
    assert err.message.include? "Request object does not match any transcoding template."

    err = assert_raises ::Gapic::Common::Error do
      # body value does not exist in the request
      transcoder.transcode example_request(name: "v1/projects/100") 
    end
    assert err.message.include? "Request object does not match any transcoding template."
  end

  def test_uri
    transcoder = Gapic::Rest::GrpcTranscoder.new
      .with_bindings(uri_method: :patch, uri_template: "{sub_request.name}", matches: [["sub_request.name", %r{^v1/instances/[^/]+?$}, true]])
      .with_bindings(
        uri_method: :patch,
        uri_template: "{name}/sub/{sub_request.name}",
        matches: [["name", %r{^v2/projects/[^/]+(?:/.*)?$}, true], ["sub_request.name", %r{^instances/[^/]+?$}, true]])
      .with_bindings(uri_method: :patch, uri_template: "{name}/requests/{id}", matches: [["name", %r{^v3/projects/[^/]+(?:/.*)?$}, true], ["id", %r{^.*$}, true]])

    test_cases = [
      {
        # One binding in the URI template
        request: example_request(id: 11, sub_name: "v1/instances/200"),
        expected: {
          method: :patch,
          uri: "v1/instances/200",
          query_params: ["id=11", "name=", "subRequest.id=0"],
          body: ""
        }
      },
      {
        # Two bindings in the URI template
        request: example_request(id: 12, name: "v2/projects/100", sub_name: "instances/200"),
        expected: {
          method: :patch,
          uri: "v2/projects/100/sub/instances/200",
          query_params: ["id=12", "subRequest.id=0"],
          body: ""
        }
      },
      {
        # Integer in the URI template
        request: example_request(name: "v3/projects/100", id: 13),
        expected: {
          method: :patch,
          uri: "v3/projects/100/requests/13",
          query_params: [],
          body: ""
        }
      },
    ]

    assert_transcoding_matches transcoder, test_cases
  end

  def test_uri_query_string_params_deep_subrequest
    transcoder = Gapic::Rest::GrpcTranscoder.new
      .with_bindings(uri_method: :patch, uri_template: "{sub_request.sub_request.name}", matches: [["sub_request.sub_request.name", %r{^v1/instances/[^/]+?$}, true]])

    request = example_request(id: 14, sub_id: 114)
    request.sub_request.sub_request = example_request(id: 214, name: "v1/instances/300")

    test_cases = [
      {
        # This makes sure that matching in uri template works and that the prefixes are set correctly in query string parameters
        # for deep sub-request fields
        request: request,
        expected: {
          method: :patch,
          uri: "v1/instances/300",
          query_params: ["id=14", "name=", "subRequest.id=114", "subRequest.name=","subRequest.subRequest.id=214"],
          body: ""
        }
      },
    ]

    assert_transcoding_matches transcoder, test_cases
  end

  def test_uri_escaping
    transcoder = Gapic::Rest::GrpcTranscoder.new
      .with_bindings(uri_method: :patch, uri_template: "method/{name}:patch", matches: [["name", %r{^v1/instances/[^/]+?$}, false]])
      .with_bindings(uri_method: :patch, uri_template: "method/{name}:patch", matches: [["name", %r{^v2/instances(?:/.*)?$}, true]])

    test_cases = [
      {
        # The slashes are encoded because preserve_slashes is false in uri binding matches
        request: example_request(id: 15, name: "v1/instances/hello world"),
        expected: {
          method: :patch,
          uri: "method/v1/instances/hello%20world:patch",
          query_params: ["id=15"],
          body: ""
        }
      },
      {
        # The slashes are not encoded because preserve_slashes is true in uri binding matches
        request: example_request(id: 16, name: "v2/instances/hello world"),
        expected: {
          method: :patch,
          uri: "method/v2/instances/hello%20world:patch",
          query_params: ["id=16"],
          body: ""
        }
      },
    ]

    assert_transcoding_matches transcoder, test_cases
  end

  def test_query_string_params
    transcoder = Gapic::Rest::GrpcTranscoder.new
      .with_bindings(uri_method: :get, uri_template: "{name}", matches: [["name", %r{^v1/projects/[^/]+(?:/.*)?$}, true]])

    test_cases = [
      {
        # Baseline. The `name` is excluded from the query params because it is used to construct the URI.
        request: example_request(name: "v1/projects/100"),
        expected: {
          method: :get,
          uri: "v1/projects/100",
          query_params: ["id=0"], 
          body: ""
        }
      },
      {
        # The key name in the query string parameter is camel-cased.
        # Field with name starting with capital case letter is properly capitalized in Query Parameters
        # Enum in the query params
        request: example_request(id: 21, name: "v1/projects/100", maybe_num: 100, ip_protocol: :TCP),
        expected: {
          method: :get,
          uri: "v1/projects/100",
          query_params: ["id=21", "maybeNum=100", "IPProtocol=TCP"], 
          body: ""
        }
      },
      {
        # Field of a subrequest with name starting with capital case letter is properly capitalized in Query Parameters
        request: example_request(id: 22, name: "v1/projects/100", sub_maybe_num: 100, sub_ip_protocol: :TCP),
        expected: {
          method: :get,
          uri: "v1/projects/100",
          query_params: ["id=22", "subRequest.id=0", "subRequest.name=", "subRequest.maybeNum=100", "subRequest.IPProtocol=TCP"],
          body: ""
        }
      },
    ]

    assert_transcoding_matches transcoder, test_cases
  end

  def test_body
    transcoder = Gapic::Rest::GrpcTranscoder.new
      .with_bindings(uri_method: :get, uri_template: "{name}", body: "id", matches: [["name", %r{^v1/projects/[^/]+(?:/.*)?$}, true]])
      .with_bindings(
        uri_method: :get,
        uri_template: "{name}/sub/{sub_request.name}",
        body: "sub_request",
        matches: [["name", %r{^v2/projects/[^/]+(?:/.*)?$}, true], ["sub_request.name", %r{^instances/[^/]+?$}, true]])
      .with_bindings(
        uri_method: :get,
        body: "*",
        uri_template: "{name}/sub/{sub_request.name}",
        matches: [["name", %r{^v3/projects/[^/]+(?:/.*)?$}, true], ["sub_request.name", %r{^instances/[^/]+?$}, true]])
      .with_bindings(uri_method: :get, uri_template: "{name}", body: "IPProtocol", matches: [["name", %r{^v4/projects/[^/]+(?:/.*)?$}, true]])
      .with_bindings(uri_method: :get, uri_template: "{name}", body: "sub_request", matches: [["name", %r{^v5/projects/[^/]+(?:/.*)?$}, true]])

    test_cases = [
      {
        # `body` is a scalar field.
        request: example_request(id: 31, name: "v1/projects/100", maybe_num: 100),
        expected: {
          method: :get,
          uri: "v1/projects/100",
          query_params: ["maybeNum=100"],
          body: "31" 
        }
      },
      {
        # `body` is a message field. `sub.name` is NOT deleted from, even though it is used in the uri.
        # Xref below where body is `*` and `sub.name` IS deleted.
        # Field with name starting with capital case letter is properly capitalized in body.
        request: example_request(id: 32, name: "v2/projects/100", sub_id: 51, sub_name: "instances/200", sub_maybe_num: 100, sub_ip_protocol: :TCP),
        expected: {
          method: :get,
          uri: "v2/projects/100/sub/instances/200",
          query_params: ["id=32"],
          body: '{"id":51,"name":"instances/200","maybeNum":100,"nums":[],"strs":[],"IPProtocol":"TCP"}' # body as message, camel-casing in body fields
        }
      },
      {
        # `body` is `"*"`. `name` and `sub.name` is deleted because they are used in the URI.
        # Field of a subrequest with name starting with capital case letter is properly capitalized in body.
        request: example_request(id: 33, name: "v3/projects/100", sub_id: 51, sub_name: "instances/200", sub_maybe_num: 100, ip_protocol: :TCP),
        expected: {
          method: :get,
          uri: "v3/projects/100/sub/instances/200",
          query_params: [],
          body: '{"id":33,"subRequest":{"id":51,"maybeNum":100,"nums":[],"strs":[]},"nums":[],"strs":[],"IPProtocol":"TCP"}' # body as message, camel-casing in body fields
        }
      },
      {
        # `body` is an enum field.
        request: example_request(id: 34, name: "v4/projects/100", maybe_num: 100, ip_protocol: :TCP ),
        expected: {
          method: :get,
          uri: "v4/projects/100",
          query_params: ["id=34","maybeNum=100"],
          body: '"TCP"'
        }
      },
      {
        # `body` is a nil message field.
        request: example_request(id: 35, name: "v5/projects/100"),
        expected: {
          method: :get,
          uri: "v5/projects/100",
          query_params: ["id=35"],
          body: ""
        }
      },
    ]

    assert_transcoding_matches transcoder, test_cases
  end

  def test_last_one_wins
    transcoder = Gapic::Rest::GrpcTranscoder.new
      .with_bindings(uri_method: :patch, uri_template: "requests/{id}:simple", matches: [["id", %r{^.*$}, true]])
      .with_bindings(uri_method: :put, uri_template: "{name}", body: "id", matches: [["name", %r{^v1/projects/[^/]+(?:/.*)?$}, true]])

    test_cases = [
      {
        # Integer in the URI template
        request: example_request(id: 41),
        expected: {
          method: :patch,
          uri: "requests/41:simple",
          query_params: ["name="],
          body: ""
        }
      },
      {
        # Integer in the URI template
        request: example_request(id: 42, name: "v1/projects/100"),
        expected: {
          method: :put,
          uri: "v1/projects/100",
          query_params: [],
          body: "42"
        }
      },
    ]

    assert_transcoding_matches transcoder, test_cases
  end

  private

  def assert_transcoding_matches transcoder, test_cases
    all_cases_pass = true
    global_err_str = ""
    test_cases.each_with_index do |test_case, i|
      request = test_case[:request]
      expected = test_case[:expected]

      err_str = "Test case ##{i+1}/#{test_cases.length}:\nRequest: \n#{request.pretty_inspect}\nExpected: \n#{expected}"
      
      method, uri, query_params, body = transcoder.transcode request
      case_pass = true
      unless expected[:method] == method
        case_pass = false
        err_str = "#{err_str}\nMethod expected: #{expected[:method]}\nMethod actual  : #{method}"
      end
      unless expected[:uri] == uri
        case_pass = false
        err_str = "#{err_str}\nUri expected: #{expected[:uri]}\nUri actual  : #{uri}"
      end
      unless same_array(expected[:query_params], query_params)
        case_pass = false
        err_str = "#{err_str}\nQuery Params expected:\n#{expected[:query_params]}\nQuery Params actual  :\n#{query_params}"
      end
      unless expected[:body] == body
        case_pass = false
        err_str = "#{err_str}\nBody expected: #{expected[:body]}\nBody actual  : #{body}"
      end

      unless case_pass
        global_err_str = "#{global_err_str}\n#{err_str}"
        all_cases_pass = false
      end
    end
    assert all_cases_pass, global_err_str
  end

  def same_array(expected, actual)
    expected.count == actual.count && 
      expected.sort.zip(actual.sort).inject(true) do |match, pair|
        match && (pair[0] == pair[1])
      end
  end

  def example_request(
    id: nil,
    sub_id: nil,
    name: nil,
    sub_name: nil,
    maybe_num: nil,
    sub_maybe_num: nil,
    ip_protocol: nil,
    sub_ip_protocol: nil
    )

    unless sub_name.nil? && sub_id.nil? && sub_maybe_num.nil? && sub_ip_protocol.nil?
      sub = Gapic::Examples::Transcoding::Request.new id: sub_id, name: sub_name, maybe_num: sub_maybe_num, IPProtocol: sub_ip_protocol
    end
    Gapic::Examples::Transcoding::Request.new id: id, name: name, sub_request: sub, maybe_num: maybe_num, IPProtocol: ip_protocol
  end
end
