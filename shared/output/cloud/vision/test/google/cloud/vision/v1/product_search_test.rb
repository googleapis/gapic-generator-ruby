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

require "minitest/autorun"

require "gapic/grpc/service_stub"

require "google/cloud/vision/v1/product_search_service_pb"
require "google/cloud/vision/v1/product_search_service_services_pb"
require "google/cloud/vision/v1/product_search"

class Google::Cloud::Vision::V1::ProductSearch::ClientTest < Minitest::Test
  def setup
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
  end

  def test_create_product_set
    # Create request parameters
    parent = "hello world"
    product_set = {}
    product_set_id = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :create_product_set && !options.nil? &&
            request.parent == "hello world" &&
            Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::ProductSet) == request.product_set &&
            request.product_set_id == "hello world"
        end
      end

      # Call method
      response = client.create_product_set parent: parent, product_set: product_set, product_set_id: product_set_id
      assert_equal mock_response, response

      # Call method with block
      client.create_product_set parent: parent, product_set: product_set, product_set_id: product_set_id do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_list_product_sets
    # Create request parameters
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :list_product_sets && !options.nil? &&
            request.parent == "hello world" &&
            request.page_size == 42 &&
            request.page_token == "hello world"
        end
      end

      # Call method
      response = client.list_product_sets parent: parent, page_size: page_size, page_token: page_token
      assert_equal mock_response, response

      # Call method with block
      client.list_product_sets parent: parent, page_size: page_size, page_token: page_token do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_get_product_set
    # Create request parameters
    name = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :get_product_set && !options.nil? &&
            request.name == "hello world"
        end
      end

      # Call method
      response = client.get_product_set name: name
      assert_equal mock_response, response

      # Call method with block
      client.get_product_set name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_update_product_set
    # Create request parameters
    product_set = {}
    update_mask = {}

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :update_product_set && !options.nil? &&
            Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::ProductSet) == request.product_set &&
            Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask) == request.update_mask
        end
      end

      # Call method
      response = client.update_product_set product_set: product_set, update_mask: update_mask
      assert_equal mock_response, response

      # Call method with block
      client.update_product_set product_set: product_set, update_mask: update_mask do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_delete_product_set
    # Create request parameters
    name = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :delete_product_set && !options.nil? &&
            request.name == "hello world"
        end
      end

      # Call method
      response = client.delete_product_set name: name
      assert_equal mock_response, response

      # Call method with block
      client.delete_product_set name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_create_product
    # Create request parameters
    parent = "hello world"
    product = {}
    product_id = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :create_product && !options.nil? &&
            request.parent == "hello world" &&
            Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::Product) == request.product &&
            request.product_id == "hello world"
        end
      end

      # Call method
      response = client.create_product parent: parent, product: product, product_id: product_id
      assert_equal mock_response, response

      # Call method with block
      client.create_product parent: parent, product: product, product_id: product_id do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_list_products
    # Create request parameters
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :list_products && !options.nil? &&
            request.parent == "hello world" &&
            request.page_size == 42 &&
            request.page_token == "hello world"
        end
      end

      # Call method
      response = client.list_products parent: parent, page_size: page_size, page_token: page_token
      assert_equal mock_response, response

      # Call method with block
      client.list_products parent: parent, page_size: page_size, page_token: page_token do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_get_product
    # Create request parameters
    name = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :get_product && !options.nil? &&
            request.name == "hello world"
        end
      end

      # Call method
      response = client.get_product name: name
      assert_equal mock_response, response

      # Call method with block
      client.get_product name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_update_product
    # Create request parameters
    product = {}
    update_mask = {}

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :update_product && !options.nil? &&
            Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::Product) == request.product &&
            Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask) == request.update_mask
        end
      end

      # Call method
      response = client.update_product product: product, update_mask: update_mask
      assert_equal mock_response, response

      # Call method with block
      client.update_product product: product, update_mask: update_mask do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_delete_product
    # Create request parameters
    name = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :delete_product && !options.nil? &&
            request.name == "hello world"
        end
      end

      # Call method
      response = client.delete_product name: name
      assert_equal mock_response, response

      # Call method with block
      client.delete_product name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_create_reference_image
    # Create request parameters
    parent = "hello world"
    reference_image = {}
    reference_image_id = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :create_reference_image && !options.nil? &&
            request.parent == "hello world" &&
            Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::ReferenceImage) == request.reference_image &&
            request.reference_image_id == "hello world"
        end
      end

      # Call method
      response = client.create_reference_image parent: parent, reference_image: reference_image, reference_image_id: reference_image_id
      assert_equal mock_response, response

      # Call method with block
      client.create_reference_image parent: parent, reference_image: reference_image, reference_image_id: reference_image_id do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_delete_reference_image
    # Create request parameters
    name = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :delete_reference_image && !options.nil? &&
            request.name == "hello world"
        end
      end

      # Call method
      response = client.delete_reference_image name: name
      assert_equal mock_response, response

      # Call method with block
      client.delete_reference_image name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_list_reference_images
    # Create request parameters
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :list_reference_images && !options.nil? &&
            request.parent == "hello world" &&
            request.page_size == 42 &&
            request.page_token == "hello world"
        end
      end

      # Call method
      response = client.list_reference_images parent: parent, page_size: page_size, page_token: page_token
      assert_equal mock_response, response

      # Call method with block
      client.list_reference_images parent: parent, page_size: page_size, page_token: page_token do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_get_reference_image
    # Create request parameters
    name = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :get_reference_image && !options.nil? &&
            request.name == "hello world"
        end
      end

      # Call method
      response = client.get_reference_image name: name
      assert_equal mock_response, response

      # Call method with block
      client.get_reference_image name: name do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_add_product_to_product_set
    # Create request parameters
    name = "hello world"
    product = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :add_product_to_product_set && !options.nil? &&
            request.name == "hello world" &&
            request.product == "hello world"
        end
      end

      # Call method
      response = client.add_product_to_product_set name: name, product: product
      assert_equal mock_response, response

      # Call method with block
      client.add_product_to_product_set name: name, product: product do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_remove_product_from_product_set
    # Create request parameters
    name = "hello world"
    product = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :remove_product_from_product_set && !options.nil? &&
            request.name == "hello world" &&
            request.product == "hello world"
        end
      end

      # Call method
      response = client.remove_product_from_product_set name: name, product: product
      assert_equal mock_response, response

      # Call method with block
      client.remove_product_from_product_set name: name, product: product do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_list_products_in_product_set
    # Create request parameters
    name = "hello world"
    page_size = 42
    page_token = "hello world"

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :list_products_in_product_set && !options.nil? &&
            request.name == "hello world" &&
            request.page_size == 42 &&
            request.page_token == "hello world"
        end
      end

      # Call method
      response = client.list_products_in_product_set name: name, page_size: page_size, page_token: page_token
      assert_equal mock_response, response

      # Call method with block
      client.list_products_in_product_set name: name, page_size: page_size, page_token: page_token do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_import_product_sets
    # Create request parameters
    parent = "hello world"
    input_config = {}

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :import_product_sets && !options.nil? &&
            request.parent == "hello world" &&
            Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::ImportProductSetsInputConfig) == request.input_config
        end
      end

      # Call method
      response = client.import_product_sets parent: parent, input_config: input_config
      assert_equal mock_response, response

      # Call method with block
      client.import_product_sets parent: parent, input_config: input_config do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end

  def test_purge_products
    # Create request parameters
    product_set_purge_config = {}

    mock_stub = MiniTest::Mock.new
    mock_response = {}

    Gapic::ServiceStub.stub :new, mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      2.times do
        mock_stub.expect :call_rpc, mock_response do |name, request, options|
          name == :purge_products && !options.nil? &&
            Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::ProductSetPurgeConfig) == request.product_set_purge_config
        end
      end

      # Call method
      response = client.purge_products product_set_purge_config: product_set_purge_config
      assert_equal mock_response, response

      # Call method with block
      client.purge_products product_set_purge_config: product_set_purge_config do |block_response, operation|
        assert_equal expected_response, block_response
        refute_nil operation
      end
    end
  end
end
