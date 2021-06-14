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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!

require "helper"

require "google/cloud/compute/v1/compute_small_pb"
require "google/cloud/compute/v1/region_instance_group_managers"


class ::Google::Cloud::Compute::V1::RegionInstanceGroupManagers::ClientTest < Minitest::Test
  class ClientStub
    attr_accessor :call_count, :requests

    def initialize response, &block
      @response = response
      @block = block
      @call_count = 0
      @requests = []
    end

    def make_get_request uri:, params: {}, options: {}
      make_http_request :get, uri: uri, body: nil, params: params, options: options
    end

    def make_delete_request uri:, params: {}, options: {}
      make_http_request :delete, uri: uri, body: nil, params: params, options: options
    end

    def make_post_request uri:, body: nil, params: {}, options: {}
      make_http_request :post, uri: uri, body: body, params: params, options: options
    end

    def make_patch_request uri:, body:, params: {}, options: {}
      make_http_request :patch, uri: uri, body: body, params: params, options: options
    end

    def make_put_request uri:, body:, params: {}, options: {}
      make_http_request :put, uri: uri, body: body, params: params, options: options
    end

    def make_http_request *args, **kwargs
      @call_count += 1

      @requests << @block&.call(*args, **kwargs)

      @response
    end
  end

  def test_resize
    # Create test objects.
    client_result = ::Google::Cloud::Compute::V1::Operation.new
    http_response = OpenStruct.new body: client_result.to_json

    call_options = {}

    # Create request parameters for a unary method.
    instance_group_manager = "hello world"
    project = "hello world"
    region = "hello world"
    request_id = "hello world"
    size = 42

    resize_client_stub = ClientStub.new http_response do |verb, uri:, body:, params:, options:|
      assert_equal :post, verb
      assert params.key? "requestId"
      assert params.key? "size"
      assert_nil body
    end

    Gapic::Rest::ClientStub.stub :new, resize_client_stub do
      # Create client
      client = ::Google::Cloud::Compute::V1::RegionInstanceGroupManagers::Rest::Client.new do |config|
        config.credentials = :dummy_value
      end

      # Use hash object
      client.resize({ instance_group_manager: instance_group_manager, project: project, region: region, request_id: request_id, size: size }) do |result, response|
        assert_equal http_response, response
      end

      # Use named arguments
      client.resize instance_group_manager: instance_group_manager, project: project, region: region, request_id: request_id, size: size do |result, response|
        assert_equal http_response, response
      end

      # Use protobuf object
      client.resize ::Google::Cloud::Compute::V1::ResizeRegionInstanceGroupManagerRequest.new(instance_group_manager: instance_group_manager, project: project, region: region, request_id: request_id, size: size) do |result, response|
        assert_equal http_response, response
      end

      # Use hash object with options
      client.resize({ instance_group_manager: instance_group_manager, project: project, region: region, request_id: request_id, size: size }, call_options) do |result, response|
        assert_equal http_response, response
      end

      # Use protobuf object with options
      client.resize(::Google::Cloud::Compute::V1::ResizeRegionInstanceGroupManagerRequest.new(instance_group_manager: instance_group_manager, project: project, region: region, request_id: request_id, size: size), call_options) do |result, response|
        assert_equal http_response, response
      end

      # Verify method calls
      assert_equal 5, resize_client_stub.call_count
    end
  end

  def test_configure
    credentials_token = :dummy_value

    client = block_config = config = nil
    Gapic::Rest::ClientStub.stub :new, nil do
      client = ::Google::Cloud::Compute::V1::RegionInstanceGroupManagers::Rest::Client.new do |config|
        config.credentials = credentials_token
      end
    end

    config = client.configure do |c|
      block_config = c
    end

    assert_same block_config, config
    assert_kind_of ::Google::Cloud::Compute::V1::RegionInstanceGroupManagers::Rest::Client::Configuration, config
  end
end
