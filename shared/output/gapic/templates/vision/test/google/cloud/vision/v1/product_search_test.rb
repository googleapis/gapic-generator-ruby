# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright <YEAR> <COPYRIGHT HOLDER>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require "minitest/autorun"

require "gapic/grpc/service_stub"

require "google/cloud/vision/v1/product_search_service_pb"
require "google/cloud/vision/v1/product_search_service_services_pb"
require "google/cloud/vision/v1/product_search"

class Google::Cloud::Vision::V1::ProductSearch::ClientTest < Minitest::Test
  def setup
    @test_channel = GRPC::Core::Channel.new "localhost:8888", nil, :this_channel_is_insecure
    @mock_stub = MiniTest::Mock.new
    @mock_page_enum = :mock_page_enum
    @response = :mock_response
    @grpc_operation = :mock_grpc_operation
    @options = {}
  end

  def with_stubs
    Gapic::ServiceStub.stub :new, @mock_stub do
      Gapic::PagedEnumerable.stub :new, @mock_page_enum do
        yield
      end
    end
  end

  def test_create_product_set
    # Create request parameters
    parent = "hello world"
    product_set = {}
    product_set_id = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :create_product_set, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.parent
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::ProductSet), request.product_set
          assert_equal "hello world", request.product_set_id

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.create_product_set parent: parent, product_set: product_set, product_set_id: product_set_id do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.create_product_set(Google::Cloud::Vision::V1::CreateProductSetRequest.new(parent: parent, product_set: product_set, product_set_id: product_set_id)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.create_product_set request = { parent: parent, product_set: product_set, product_set_id: product_set_id } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.create_product_set request = Google::Cloud::Vision::V1::CreateProductSetRequest.new({ parent: parent, product_set: product_set, product_set_id: product_set_id }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.create_product_set({ parent: parent, product_set: product_set, product_set_id: product_set_id }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.create_product_set(Google::Cloud::Vision::V1::CreateProductSetRequest.new(parent: parent, product_set: product_set, product_set_id: product_set_id), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.create_product_set(request = { parent: parent, product_set: product_set, product_set_id: product_set_id }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.create_product_set(request = Google::Cloud::Vision::V1::CreateProductSetRequest.new({ parent: parent, product_set: product_set, product_set_id: product_set_id }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_list_product_sets
    # Create request parameters
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :list_product_sets, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.parent
          assert_equal 42, request.page_size
          assert_equal "hello world", request.page_token

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.list_product_sets parent: parent, page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.list_product_sets(Google::Cloud::Vision::V1::ListProductSetsRequest.new(parent: parent, page_size: page_size, page_token: page_token)) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.list_product_sets request = { parent: parent, page_size: page_size, page_token: page_token } do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.list_product_sets request = Google::Cloud::Vision::V1::ListProductSetsRequest.new({ parent: parent, page_size: page_size, page_token: page_token }) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.list_product_sets({ parent: parent, page_size: page_size, page_token: page_token }, @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.list_product_sets(Google::Cloud::Vision::V1::ListProductSetsRequest.new(parent: parent, page_size: page_size, page_token: page_token), @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.list_product_sets(request = { parent: parent, page_size: page_size, page_token: page_token }, options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.list_product_sets(request = Google::Cloud::Vision::V1::ListProductSetsRequest.new({ parent: parent, page_size: page_size, page_token: page_token }), options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_get_product_set
    # Create request parameters
    name = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :get_product_set, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.get_product_set name: name do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.get_product_set(Google::Cloud::Vision::V1::GetProductSetRequest.new(name: name)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.get_product_set request = { name: name } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.get_product_set request = Google::Cloud::Vision::V1::GetProductSetRequest.new({ name: name }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.get_product_set({ name: name }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.get_product_set(Google::Cloud::Vision::V1::GetProductSetRequest.new(name: name), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.get_product_set(request = { name: name }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.get_product_set(request = Google::Cloud::Vision::V1::GetProductSetRequest.new({ name: name }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_update_product_set
    # Create request parameters
    product_set = {}
    update_mask = {}

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :update_product_set, name
          refute_nil options
          refute_nil block
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::ProductSet), request.product_set
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.update_product_set product_set: product_set, update_mask: update_mask do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.update_product_set(Google::Cloud::Vision::V1::UpdateProductSetRequest.new(product_set: product_set, update_mask: update_mask)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.update_product_set request = { product_set: product_set, update_mask: update_mask } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.update_product_set request = Google::Cloud::Vision::V1::UpdateProductSetRequest.new({ product_set: product_set, update_mask: update_mask }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.update_product_set({ product_set: product_set, update_mask: update_mask }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.update_product_set(Google::Cloud::Vision::V1::UpdateProductSetRequest.new(product_set: product_set, update_mask: update_mask), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.update_product_set(request = { product_set: product_set, update_mask: update_mask }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.update_product_set(request = Google::Cloud::Vision::V1::UpdateProductSetRequest.new({ product_set: product_set, update_mask: update_mask }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_delete_product_set
    # Create request parameters
    name = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :delete_product_set, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.delete_product_set name: name do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.delete_product_set(Google::Cloud::Vision::V1::DeleteProductSetRequest.new(name: name)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.delete_product_set request = { name: name } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.delete_product_set request = Google::Cloud::Vision::V1::DeleteProductSetRequest.new({ name: name }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.delete_product_set({ name: name }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.delete_product_set(Google::Cloud::Vision::V1::DeleteProductSetRequest.new(name: name), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.delete_product_set(request = { name: name }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.delete_product_set(request = Google::Cloud::Vision::V1::DeleteProductSetRequest.new({ name: name }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_create_product
    # Create request parameters
    parent = "hello world"
    product = {}
    product_id = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :create_product, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.parent
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::Product), request.product
          assert_equal "hello world", request.product_id

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.create_product parent: parent, product: product, product_id: product_id do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.create_product(Google::Cloud::Vision::V1::CreateProductRequest.new(parent: parent, product: product, product_id: product_id)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.create_product request = { parent: parent, product: product, product_id: product_id } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.create_product request = Google::Cloud::Vision::V1::CreateProductRequest.new({ parent: parent, product: product, product_id: product_id }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.create_product({ parent: parent, product: product, product_id: product_id }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.create_product(Google::Cloud::Vision::V1::CreateProductRequest.new(parent: parent, product: product, product_id: product_id), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.create_product(request = { parent: parent, product: product, product_id: product_id }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.create_product(request = Google::Cloud::Vision::V1::CreateProductRequest.new({ parent: parent, product: product, product_id: product_id }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_list_products
    # Create request parameters
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :list_products, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.parent
          assert_equal 42, request.page_size
          assert_equal "hello world", request.page_token

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.list_products parent: parent, page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.list_products(Google::Cloud::Vision::V1::ListProductsRequest.new(parent: parent, page_size: page_size, page_token: page_token)) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.list_products request = { parent: parent, page_size: page_size, page_token: page_token } do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.list_products request = Google::Cloud::Vision::V1::ListProductsRequest.new({ parent: parent, page_size: page_size, page_token: page_token }) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.list_products({ parent: parent, page_size: page_size, page_token: page_token }, @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.list_products(Google::Cloud::Vision::V1::ListProductsRequest.new(parent: parent, page_size: page_size, page_token: page_token), @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.list_products(request = { parent: parent, page_size: page_size, page_token: page_token }, options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.list_products(request = Google::Cloud::Vision::V1::ListProductsRequest.new({ parent: parent, page_size: page_size, page_token: page_token }), options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_get_product
    # Create request parameters
    name = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :get_product, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.get_product name: name do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.get_product(Google::Cloud::Vision::V1::GetProductRequest.new(name: name)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.get_product request = { name: name } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.get_product request = Google::Cloud::Vision::V1::GetProductRequest.new({ name: name }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.get_product({ name: name }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.get_product(Google::Cloud::Vision::V1::GetProductRequest.new(name: name), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.get_product(request = { name: name }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.get_product(request = Google::Cloud::Vision::V1::GetProductRequest.new({ name: name }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_update_product
    # Create request parameters
    product = {}
    update_mask = {}

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :update_product, name
          refute_nil options
          refute_nil block
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::Product), request.product
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask), request.update_mask

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.update_product product: product, update_mask: update_mask do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.update_product(Google::Cloud::Vision::V1::UpdateProductRequest.new(product: product, update_mask: update_mask)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.update_product request = { product: product, update_mask: update_mask } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.update_product request = Google::Cloud::Vision::V1::UpdateProductRequest.new({ product: product, update_mask: update_mask }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.update_product({ product: product, update_mask: update_mask }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.update_product(Google::Cloud::Vision::V1::UpdateProductRequest.new(product: product, update_mask: update_mask), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.update_product(request = { product: product, update_mask: update_mask }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.update_product(request = Google::Cloud::Vision::V1::UpdateProductRequest.new({ product: product, update_mask: update_mask }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_delete_product
    # Create request parameters
    name = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :delete_product, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.delete_product name: name do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.delete_product(Google::Cloud::Vision::V1::DeleteProductRequest.new(name: name)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.delete_product request = { name: name } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.delete_product request = Google::Cloud::Vision::V1::DeleteProductRequest.new({ name: name }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.delete_product({ name: name }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.delete_product(Google::Cloud::Vision::V1::DeleteProductRequest.new(name: name), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.delete_product(request = { name: name }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.delete_product(request = Google::Cloud::Vision::V1::DeleteProductRequest.new({ name: name }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_create_reference_image
    # Create request parameters
    parent = "hello world"
    reference_image = {}
    reference_image_id = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :create_reference_image, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.parent
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::ReferenceImage), request.reference_image
          assert_equal "hello world", request.reference_image_id

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.create_reference_image parent: parent, reference_image: reference_image, reference_image_id: reference_image_id do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.create_reference_image(Google::Cloud::Vision::V1::CreateReferenceImageRequest.new(parent: parent, reference_image: reference_image, reference_image_id: reference_image_id)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.create_reference_image request = { parent: parent, reference_image: reference_image, reference_image_id: reference_image_id } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.create_reference_image request = Google::Cloud::Vision::V1::CreateReferenceImageRequest.new({ parent: parent, reference_image: reference_image, reference_image_id: reference_image_id }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.create_reference_image({ parent: parent, reference_image: reference_image, reference_image_id: reference_image_id }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.create_reference_image(Google::Cloud::Vision::V1::CreateReferenceImageRequest.new(parent: parent, reference_image: reference_image, reference_image_id: reference_image_id), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.create_reference_image(request = { parent: parent, reference_image: reference_image, reference_image_id: reference_image_id }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.create_reference_image(request = Google::Cloud::Vision::V1::CreateReferenceImageRequest.new({ parent: parent, reference_image: reference_image, reference_image_id: reference_image_id }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_delete_reference_image
    # Create request parameters
    name = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :delete_reference_image, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.delete_reference_image name: name do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.delete_reference_image(Google::Cloud::Vision::V1::DeleteReferenceImageRequest.new(name: name)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.delete_reference_image request = { name: name } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.delete_reference_image request = Google::Cloud::Vision::V1::DeleteReferenceImageRequest.new({ name: name }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.delete_reference_image({ name: name }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.delete_reference_image(Google::Cloud::Vision::V1::DeleteReferenceImageRequest.new(name: name), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.delete_reference_image(request = { name: name }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.delete_reference_image(request = Google::Cloud::Vision::V1::DeleteReferenceImageRequest.new({ name: name }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_list_reference_images
    # Create request parameters
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :list_reference_images, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.parent
          assert_equal 42, request.page_size
          assert_equal "hello world", request.page_token

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.list_reference_images parent: parent, page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.list_reference_images(Google::Cloud::Vision::V1::ListReferenceImagesRequest.new(parent: parent, page_size: page_size, page_token: page_token)) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.list_reference_images request = { parent: parent, page_size: page_size, page_token: page_token } do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.list_reference_images request = Google::Cloud::Vision::V1::ListReferenceImagesRequest.new({ parent: parent, page_size: page_size, page_token: page_token }) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.list_reference_images({ parent: parent, page_size: page_size, page_token: page_token }, @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.list_reference_images(Google::Cloud::Vision::V1::ListReferenceImagesRequest.new(parent: parent, page_size: page_size, page_token: page_token), @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.list_reference_images(request = { parent: parent, page_size: page_size, page_token: page_token }, options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.list_reference_images(request = Google::Cloud::Vision::V1::ListReferenceImagesRequest.new({ parent: parent, page_size: page_size, page_token: page_token }), options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_get_reference_image
    # Create request parameters
    name = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :get_reference_image, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.get_reference_image name: name do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.get_reference_image(Google::Cloud::Vision::V1::GetReferenceImageRequest.new(name: name)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.get_reference_image request = { name: name } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.get_reference_image request = Google::Cloud::Vision::V1::GetReferenceImageRequest.new({ name: name }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.get_reference_image({ name: name }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.get_reference_image(Google::Cloud::Vision::V1::GetReferenceImageRequest.new(name: name), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.get_reference_image(request = { name: name }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.get_reference_image(request = Google::Cloud::Vision::V1::GetReferenceImageRequest.new({ name: name }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_add_product_to_product_set
    # Create request parameters
    name = "hello world"
    product = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :add_product_to_product_set, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name
          assert_equal "hello world", request.product

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.add_product_to_product_set name: name, product: product do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.add_product_to_product_set(Google::Cloud::Vision::V1::AddProductToProductSetRequest.new(name: name, product: product)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.add_product_to_product_set request = { name: name, product: product } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.add_product_to_product_set request = Google::Cloud::Vision::V1::AddProductToProductSetRequest.new({ name: name, product: product }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.add_product_to_product_set({ name: name, product: product }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.add_product_to_product_set(Google::Cloud::Vision::V1::AddProductToProductSetRequest.new(name: name, product: product), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.add_product_to_product_set(request = { name: name, product: product }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.add_product_to_product_set(request = Google::Cloud::Vision::V1::AddProductToProductSetRequest.new({ name: name, product: product }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_remove_product_from_product_set
    # Create request parameters
    name = "hello world"
    product = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :remove_product_from_product_set, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name
          assert_equal "hello world", request.product

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.remove_product_from_product_set name: name, product: product do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.remove_product_from_product_set(Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest.new(name: name, product: product)) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.remove_product_from_product_set request = { name: name, product: product } do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.remove_product_from_product_set request = Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest.new({ name: name, product: product }) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.remove_product_from_product_set({ name: name, product: product }, @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.remove_product_from_product_set(Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest.new(name: name, product: product), @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.remove_product_from_product_set(request = { name: name, product: product }, options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.remove_product_from_product_set(request = Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest.new({ name: name, product: product }), options = @options) do |response, operation|
        assert_equal @response, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_list_products_in_product_set
    # Create request parameters
    name = "hello world"
    page_size = 42
    page_token = "hello world"

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :list_products_in_product_set, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.name
          assert_equal 42, request.page_size
          assert_equal "hello world", request.page_token

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.list_products_in_product_set name: name, page_size: page_size, page_token: page_token do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.list_products_in_product_set(Google::Cloud::Vision::V1::ListProductsInProductSetRequest.new(name: name, page_size: page_size, page_token: page_token)) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.list_products_in_product_set request = { name: name, page_size: page_size, page_token: page_token } do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.list_products_in_product_set request = Google::Cloud::Vision::V1::ListProductsInProductSetRequest.new({ name: name, page_size: page_size, page_token: page_token }) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.list_products_in_product_set({ name: name, page_size: page_size, page_token: page_token }, @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.list_products_in_product_set(Google::Cloud::Vision::V1::ListProductsInProductSetRequest.new(name: name, page_size: page_size, page_token: page_token), @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.list_products_in_product_set(request = { name: name, page_size: page_size, page_token: page_token }, options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.list_products_in_product_set(request = Google::Cloud::Vision::V1::ListProductsInProductSetRequest.new({ name: name, page_size: page_size, page_token: page_token }), options = @options) do |response, operation|
        assert_equal @mock_page_enum, response
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_import_product_sets
    # Create request parameters
    parent = "hello world"
    input_config = {}

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :import_product_sets, name
          refute_nil options
          refute_nil block
          assert_equal "hello world", request.parent
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::ImportProductSetsInputConfig), request.input_config

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.import_product_sets parent: parent, input_config: input_config do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.import_product_sets(Google::Cloud::Vision::V1::ImportProductSetsRequest.new(parent: parent, input_config: input_config)) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.import_product_sets request = { parent: parent, input_config: input_config } do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.import_product_sets request = Google::Cloud::Vision::V1::ImportProductSetsRequest.new({ parent: parent, input_config: input_config }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.import_product_sets({ parent: parent, input_config: input_config }, @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.import_product_sets(Google::Cloud::Vision::V1::ImportProductSetsRequest.new(parent: parent, input_config: input_config), @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.import_product_sets(request = { parent: parent, input_config: input_config }, options = @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.import_product_sets(request = Google::Cloud::Vision::V1::ImportProductSetsRequest.new({ parent: parent, input_config: input_config }), options = @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end

  def test_purge_products
    # Create request parameters
    product_set_purge_config = {}

    with_stubs do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options:, &block|
          assert_equal :purge_products, name
          refute_nil options
          refute_nil block
          assert_equal Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::ProductSetPurgeConfig), request.product_set_purge_config

          block.call(@response, @grpc_operation)

          # hmmm...
          assert_equal 24, 25

          true
        end
      end

      # Call method (positional / hash)
      client.purge_products product_set_purge_config: product_set_purge_config do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (positional / protobuf type)
      client.purge_products(Google::Cloud::Vision::V1::PurgeProductsRequest.new(product_set_purge_config: product_set_purge_config)) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (named / hash)
      client.purge_products request = { product_set_purge_config: product_set_purge_config } do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method (named / protobuf type)
      client.purge_products request = Google::Cloud::Vision::V1::PurgeProductsRequest.new({ product_set_purge_config: product_set_purge_config }) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / hash)
      client.purge_products({ product_set_purge_config: product_set_purge_config }, @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (positional / protobuf type)
      client.purge_products(Google::Cloud::Vision::V1::PurgeProductsRequest.new(product_set_purge_config: product_set_purge_config), @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / hash)
      client.purge_products(request = { product_set_purge_config: product_set_purge_config }, options = @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Call method with options (named / protobuf type)
      client.purge_products(request = Google::Cloud::Vision::V1::PurgeProductsRequest.new({ product_set_purge_config: product_set_purge_config }), options = @options) do |response, operation|
        assert_kind_of Gapic::Operation, response
        assert_equal @response, response.grpc_op
        assert_equal @grpc_operation, operation
      end

      # Verify method calls
      @mock_stub.verify
    end
  end
end
