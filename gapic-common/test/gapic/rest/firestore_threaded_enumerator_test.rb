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
require "faraday"
require "pp"
require 'pry'
require "googleauth"

ENV["GOOGLE_AUTH_SUPPRESS_CREDENTIALS_WARNINGS"] = "1"

class MockProtobufClass
  def self.decode_json str
    return str
  end
end

#
# Tests for the REST server stream.
#
class FirestoreThreadedEnumeratorTest < Minitest::Test
  def test_thread_enumerator
    in_q = Queue.new
    out_q = Queue.new

    te = Gapic::Rest::ThreadedEnumerator.new do |in_q, out_q|
      (0..9).each do |i|
        in_q.deq
        out_q.enq i
      end

      out_q.enq nil
    end

    (0..9).each do |i|
      assert_equal i, te.next
    end

    assert_raises(StopIteration) do
      te.next
    end
  end

  def test_with_firestore_simple
    @endpoint = "https://firestore.googleapis.com/v1/projects/client-debugging/databases/(default)/documents:runQuery"
    @conn = Faraday.new url: @endpoint do |conn|
        conn.headers = { "Content-Type" => "application/json" }
        conn.request :google_authorization,  ::Google::Auth::Credentials.default
        conn.request :retry
        conn.response :raise_error
        conn.adapter :net_http
    end

    request = <<-JSON 
    { parent: "projects/client-debugging/databases/(default)/documents",
      structuredQuery: {
        endAt: {
          before: true,
          values: [{
            referenceValue: "projects/client-debugging/databases/(default)/documents/ruby_enumberable_stream/zExBtw6XGsPv39HLfITO"
          }]
        },
        from: [{
          allDescendants: true,
          collectionId: "ruby_enumberable_stream",
        }],
        orderBy: [{
          direction: 'ASCENDING',
          field: {
            fieldPath: '__name__'
          }
        }],
      }
    }
    JSON

    in_q = Queue.new
    out_q = Queue.new

    te = Gapic::Rest::ThreadedEnumerator.new do |in_q, out_q|
      @conn.post(@endpoint, request) do |req|
        req.options.on_data = Proc.new do |chunk, overall_received_bytes|
          in_q.deq
          out_q.enq chunk
        end
      end
    end

    chunks = []
    assert_raises(StopIteration) do
      while true
        chunks << te.next
      end
    end

    assert_equal 3, chunks.length
  end

  def test_with_firestore_full
    request = <<-JSON 
    { parent: "projects/client-debugging/databases/(default)/documents",
      structuredQuery: {
        endAt: {
          before: true,
          values: [{
            referenceValue: "projects/client-debugging/databases/(default)/documents/ruby_enumberable_stream/zExBtw6XGsPv39HLfITO"
          }]
        },
        from: [{
          allDescendants: true,
          collectionId: "ruby_enumberable_stream",
        }],
        orderBy: [{
          direction: 'ASCENDING',
          field: {
            fieldPath: '__name__'
          }
        }],
      }
    }
    JSON

    firestore = FirestoreClient.new
    rest_stream = firestore.runQuery(request)
    assert_equal 99, rest_stream.count
  end

  class FirestoreClient
    def initialize
      endpoint = "https://firestore.googleapis.com/"
      @service_stub = FirestoreServiceStub.new endpoint
    end

    # Example method for server streaming code generation.
    def runQuery request
      #headers
      #proto from hash

      rest_stream = Gapic::Rest::ServerStream.new(
        MockProtobufClass,
        Gapic::Rest::ThreadedEnumerator.new do |in_q, out_q|
          @service_stub.runQuery(request) do |chunk|
            in_q.deq
            out_q.enq chunk
          end
        end
      )

      return rest_stream
    end
  end

  class FirestoreServiceStub
    def initialize endpoint
      @client_stub = ::Gapic::Rest::ClientStub.new endpoint: endpoint, credentials: ::Google::Auth::Credentials.default
      @endpoint = endpoint
    end

    def runQuery request, &block
      # instead of transcoding for test
      uri = "v1/projects/client-debugging/databases/(default)/documents:runQuery"
      body = request

      @client_stub.make_http_request(:post, uri: uri,
        body: body,
        params: [],
        options: ::Gapic::CallOptions.new,
        is_streaming: true, 
        &block
      )
    end
  end
end