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

require "helper"
require "google/showcase/v1beta1/echo"
require "grpc"

ENV["GOOGLE_AUTH_SUPPRESS_CREDENTIALS_WARNINGS"] = "true"


class ExpandTest < Minitest::Test
  def setup client=nil
    @client = client
  end

  def test_expand
    return unless @client
    request_content = "The quick brown fox jumps over the lazy dog"

    response_enum = @client.expand content: request_content

    assert_equal request_content, response_enum.to_a.map(&:content).join(" ")
  end

  def new_echo_client
    Google::Showcase::V1beta1::Echo::Client.new do |config|
      config.credentials = GRPC::Core::Channel.new "localhost:7469", nil, :this_channel_is_insecure
    end
  end
  
  def new_echo_rest_client
    Google::Showcase::V1beta1::Echo::Rest::Client.new do |config|
      config.endpoint = "http://localhost:7469"
      config.credentials = :this_channel_is_insecure
    end
  end
end

class ExpandGRPCTest < ExpandTest

  def setup
    super new_echo_client
    # super Google::Showcase::V1beta1::Echo::Client.new
  end

  def test_expand_with_metadata
    request_content = "The quick brown fox jumps over the lazy dog"

    options = Gapic::CallOptions.new metadata: {
      'showcase-trailer': ["a", "b"],
      garbage:            ["xxx"]
    }

    @client.expand({ content: request_content }, options) do |response_enum, operation|
      # TODO: https://github.com/googleapis/gapic-generator-ruby/issues/241
      assert_nil operation.trailing_metadata

      assert_equal request_content, response_enum.to_a.map(&:content).join(" ")
      assert_instance_of GRPC::ActiveCall::Operation, operation

      assert_equal(
        { 'showcase-trailer' => ["a", "b"] },
        operation.trailing_metadata
      )
    end
  end

  ##
  # Testing expand method with error.
  #
  def test_expand_with_error
    ret = nil
    a = []

    ex = assert_raises GRPC::Unknown do
      ret = @client.expand({content: "Sphinx of black quartz, judge my vow.", 
                                 error: {code: 2, message: "Unworthy" }})
      ret.each do |r|
        a << r
      end
    end

    assert_equal ex.code, 2
    assert_match /Unworthy/, ex.message
  end
end

class ExpandRestTest < ExpandTest
  def setup
    super new_echo_rest_client
    # super Google::Showcase::V1beta1::Echo::Rest::Client.new
  end

  ##
  # Testing expand method with error in REST.
  # Its behavior is different from gRPC for Showcase.
  #
  # This test captures a 'stream cut in the middle' behavior.
  # It might be just showcase-rest specific or might be seen somewhere else.
  # It happens when the REST stream ends and there is something left unparsed in the
  # content buffer.
  # This is how it looks in this specific showcase test.
  # The `---` lines separate JSON chunks as they come in from the stream, so there are 3
  # last chunks of a particular stream in this example.
  # The stream is a JSON array of element messages with two fields: `content`
  # and `severity`.
  # At the beginning of the fragment the previous-to-the-last object ends, and the new
  # object begins with the content of `"vow."`. But its `severity` gets mangled by a server-side
  # error. Therefore it remains unparsed in the parsing buffer, and when the HTTP stream ends
  # the parser throws the `Gapic::Common::Error`.
  #
  # --------------------------------------------------
  # severity": "UNNECESSARY"
  # },{
  #   "con
  # --------------------------------------------------
  # tent": "vow.",
  #   "severity": "
  # --------------------------------------------------
  # {"error":{"code":500,"message":"my-error-message","details":[],"Body":"","Header":null,"Errors":null}}UNNECESSARY"
  # }]
  # --------------------------------------------------
  #
  
  def test_expand_with_error
    ret = nil
    a = []
    ex = assert_raises Gapic::Common::Error do
      ret = @client.expand({content: "Sphinx of black quartz, judge my vow.", 
                                 error: {code: 404, message: "my-error-message" }})
      ret.each do |r|
        a << r
      end
    end

    assert_match /Dangling content left/, ex.message
  end
end
