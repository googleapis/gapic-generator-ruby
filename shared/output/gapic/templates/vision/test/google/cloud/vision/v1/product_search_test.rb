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
    @response = {}
    @options = {}
  end

  def test_create_product_set
    # Create request parameters
    parent = "hello world"
    product_set = {}
    product_set_id = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :create_product_set
          has_options = !options.nil?
          has_fields =
            request.parent == "hello world" &&

            Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::ProductSet) == request.product_set &&

            request.product_set_id == "hello world"

          puts "invalid method call: #{name} (expected create_product_set)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.create_product_set parent: parent, product_set: product_set, product_set_id: product_set_id
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.create_product_set(Google::Cloud::Vision::V1::CreateProductSetRequest.new(
                                             parent: parent, product_set: product_set, product_set_id: product_set_id
                                           ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.create_product_set request = { parent: parent, product_set: product_set, product_set_id: product_set_id }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.create_product_set request = Google::Cloud::Vision::V1::CreateProductSetRequest.new(
        parent: parent, product_set: product_set, product_set_id: product_set_id
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.create_product_set({ parent: parent, product_set: product_set, product_set_id: product_set_id }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.create_product_set(Google::Cloud::Vision::V1::CreateProductSetRequest.new(
                                             parent: parent, product_set: product_set, product_set_id: product_set_id
                                           ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.create_product_set request = { parent: parent, product_set: product_set, product_set_id: product_set_id }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.create_product_set request = Google::Cloud::Vision::V1::CreateProductSetRequest.new(
        parent: parent, product_set: product_set, product_set_id: product_set_id
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_list_product_sets
    # Create request parameters
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :list_product_sets
          has_options = !options.nil?
          has_fields =
            request.parent == "hello world" &&

            request.page_size == 42 &&

            request.page_token == "hello world"

          puts "invalid method call: #{name} (expected list_product_sets)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.list_product_sets parent: parent, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.list_product_sets(Google::Cloud::Vision::V1::ListProductSetsRequest.new(
                                            parent: parent, page_size: page_size, page_token: page_token
                                          ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.list_product_sets request = { parent: parent, page_size: page_size, page_token: page_token }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.list_product_sets request = Google::Cloud::Vision::V1::ListProductSetsRequest.new(
        parent: parent, page_size: page_size, page_token: page_token
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.list_product_sets({ parent: parent, page_size: page_size, page_token: page_token }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.list_product_sets(Google::Cloud::Vision::V1::ListProductSetsRequest.new(
                                            parent: parent, page_size: page_size, page_token: page_token
                                          ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.list_product_sets request = { parent: parent, page_size: page_size, page_token: page_token }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.list_product_sets request = Google::Cloud::Vision::V1::ListProductSetsRequest.new(
        parent: parent, page_size: page_size, page_token: page_token
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_get_product_set
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :get_product_set
          has_options = !options.nil?
          has_fields =
            request.name == "hello world"

          puts "invalid method call: #{name} (expected get_product_set)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.get_product_set name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.get_product_set(Google::Cloud::Vision::V1::GetProductSetRequest.new(
                                          name: name
                                        ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.get_product_set request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.get_product_set request = Google::Cloud::Vision::V1::GetProductSetRequest.new(
        name: name
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.get_product_set({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.get_product_set(Google::Cloud::Vision::V1::GetProductSetRequest.new(
                                          name: name
                                        ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.get_product_set request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.get_product_set request = Google::Cloud::Vision::V1::GetProductSetRequest.new(
        name: name
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_update_product_set
    # Create request parameters
    product_set = {}
    update_mask = {}

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :update_product_set
          has_options = !options.nil?
          has_fields =
            Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::ProductSet) == request.product_set &&

            Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask) == request.update_mask

          puts "invalid method call: #{name} (expected update_product_set)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.update_product_set product_set: product_set, update_mask: update_mask
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.update_product_set(Google::Cloud::Vision::V1::UpdateProductSetRequest.new(
                                             product_set: product_set, update_mask: update_mask
                                           ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.update_product_set request = { product_set: product_set, update_mask: update_mask }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.update_product_set request = Google::Cloud::Vision::V1::UpdateProductSetRequest.new(
        product_set: product_set, update_mask: update_mask
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.update_product_set({ product_set: product_set, update_mask: update_mask }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.update_product_set(Google::Cloud::Vision::V1::UpdateProductSetRequest.new(
                                             product_set: product_set, update_mask: update_mask
                                           ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.update_product_set request = { product_set: product_set, update_mask: update_mask }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.update_product_set request = Google::Cloud::Vision::V1::UpdateProductSetRequest.new(
        product_set: product_set, update_mask: update_mask
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_delete_product_set
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :delete_product_set
          has_options = !options.nil?
          has_fields =
            request.name == "hello world"

          puts "invalid method call: #{name} (expected delete_product_set)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.delete_product_set name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.delete_product_set(Google::Cloud::Vision::V1::DeleteProductSetRequest.new(
                                             name: name
                                           ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.delete_product_set request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.delete_product_set request = Google::Cloud::Vision::V1::DeleteProductSetRequest.new(
        name: name
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.delete_product_set({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.delete_product_set(Google::Cloud::Vision::V1::DeleteProductSetRequest.new(
                                             name: name
                                           ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.delete_product_set request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.delete_product_set request = Google::Cloud::Vision::V1::DeleteProductSetRequest.new(
        name: name
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_create_product
    # Create request parameters
    parent = "hello world"
    product = {}
    product_id = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :create_product
          has_options = !options.nil?
          has_fields =
            request.parent == "hello world" &&

            Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::Product) == request.product &&

            request.product_id == "hello world"

          puts "invalid method call: #{name} (expected create_product)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.create_product parent: parent, product: product, product_id: product_id
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.create_product(Google::Cloud::Vision::V1::CreateProductRequest.new(
                                         parent: parent, product: product, product_id: product_id
                                       ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.create_product request = { parent: parent, product: product, product_id: product_id }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.create_product request = Google::Cloud::Vision::V1::CreateProductRequest.new(
        parent: parent, product: product, product_id: product_id
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.create_product({ parent: parent, product: product, product_id: product_id }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.create_product(Google::Cloud::Vision::V1::CreateProductRequest.new(
                                         parent: parent, product: product, product_id: product_id
                                       ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.create_product request = { parent: parent, product: product, product_id: product_id }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.create_product request = Google::Cloud::Vision::V1::CreateProductRequest.new(
        parent: parent, product: product, product_id: product_id
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_list_products
    # Create request parameters
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :list_products
          has_options = !options.nil?
          has_fields =
            request.parent == "hello world" &&

            request.page_size == 42 &&

            request.page_token == "hello world"

          puts "invalid method call: #{name} (expected list_products)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.list_products parent: parent, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.list_products(Google::Cloud::Vision::V1::ListProductsRequest.new(
                                        parent: parent, page_size: page_size, page_token: page_token
                                      ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.list_products request = { parent: parent, page_size: page_size, page_token: page_token }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.list_products request = Google::Cloud::Vision::V1::ListProductsRequest.new(
        parent: parent, page_size: page_size, page_token: page_token
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.list_products({ parent: parent, page_size: page_size, page_token: page_token }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.list_products(Google::Cloud::Vision::V1::ListProductsRequest.new(
                                        parent: parent, page_size: page_size, page_token: page_token
                                      ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.list_products request = { parent: parent, page_size: page_size, page_token: page_token }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.list_products request = Google::Cloud::Vision::V1::ListProductsRequest.new(
        parent: parent, page_size: page_size, page_token: page_token
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_get_product
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :get_product
          has_options = !options.nil?
          has_fields =
            request.name == "hello world"

          puts "invalid method call: #{name} (expected get_product)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.get_product name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.get_product(Google::Cloud::Vision::V1::GetProductRequest.new(
                                      name: name
                                    ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.get_product request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.get_product request = Google::Cloud::Vision::V1::GetProductRequest.new(
        name: name
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.get_product({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.get_product(Google::Cloud::Vision::V1::GetProductRequest.new(
                                      name: name
                                    ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.get_product request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.get_product request = Google::Cloud::Vision::V1::GetProductRequest.new(
        name: name
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_update_product
    # Create request parameters
    product = {}
    update_mask = {}

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :update_product
          has_options = !options.nil?
          has_fields =
            Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::Product) == request.product &&

            Gapic::Protobuf.coerce({}, to: Google::Protobuf::FieldMask) == request.update_mask

          puts "invalid method call: #{name} (expected update_product)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.update_product product: product, update_mask: update_mask
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.update_product(Google::Cloud::Vision::V1::UpdateProductRequest.new(
                                         product: product, update_mask: update_mask
                                       ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.update_product request = { product: product, update_mask: update_mask }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.update_product request = Google::Cloud::Vision::V1::UpdateProductRequest.new(
        product: product, update_mask: update_mask
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.update_product({ product: product, update_mask: update_mask }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.update_product(Google::Cloud::Vision::V1::UpdateProductRequest.new(
                                         product: product, update_mask: update_mask
                                       ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.update_product request = { product: product, update_mask: update_mask }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.update_product request = Google::Cloud::Vision::V1::UpdateProductRequest.new(
        product: product, update_mask: update_mask
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_delete_product
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :delete_product
          has_options = !options.nil?
          has_fields =
            request.name == "hello world"

          puts "invalid method call: #{name} (expected delete_product)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.delete_product name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.delete_product(Google::Cloud::Vision::V1::DeleteProductRequest.new(
                                         name: name
                                       ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.delete_product request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.delete_product request = Google::Cloud::Vision::V1::DeleteProductRequest.new(
        name: name
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.delete_product({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.delete_product(Google::Cloud::Vision::V1::DeleteProductRequest.new(
                                         name: name
                                       ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.delete_product request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.delete_product request = Google::Cloud::Vision::V1::DeleteProductRequest.new(
        name: name
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_create_reference_image
    # Create request parameters
    parent = "hello world"
    reference_image = {}
    reference_image_id = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :create_reference_image
          has_options = !options.nil?
          has_fields =
            request.parent == "hello world" &&

            Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::ReferenceImage) == request.reference_image &&

            request.reference_image_id == "hello world"

          puts "invalid method call: #{name} (expected create_reference_image)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.create_reference_image parent: parent, reference_image: reference_image, reference_image_id: reference_image_id
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.create_reference_image(Google::Cloud::Vision::V1::CreateReferenceImageRequest.new(
                                                 parent: parent, reference_image: reference_image, reference_image_id: reference_image_id
                                               ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.create_reference_image request = { parent: parent, reference_image: reference_image, reference_image_id: reference_image_id }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.create_reference_image request = Google::Cloud::Vision::V1::CreateReferenceImageRequest.new(
        parent: parent, reference_image: reference_image, reference_image_id: reference_image_id
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.create_reference_image({ parent: parent, reference_image: reference_image, reference_image_id: reference_image_id }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.create_reference_image(Google::Cloud::Vision::V1::CreateReferenceImageRequest.new(
                                                 parent: parent, reference_image: reference_image, reference_image_id: reference_image_id
                                               ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.create_reference_image request = { parent: parent, reference_image: reference_image, reference_image_id: reference_image_id }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.create_reference_image request = Google::Cloud::Vision::V1::CreateReferenceImageRequest.new(
        parent: parent, reference_image: reference_image, reference_image_id: reference_image_id
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_delete_reference_image
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :delete_reference_image
          has_options = !options.nil?
          has_fields =
            request.name == "hello world"

          puts "invalid method call: #{name} (expected delete_reference_image)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.delete_reference_image name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.delete_reference_image(Google::Cloud::Vision::V1::DeleteReferenceImageRequest.new(
                                                 name: name
                                               ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.delete_reference_image request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.delete_reference_image request = Google::Cloud::Vision::V1::DeleteReferenceImageRequest.new(
        name: name
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.delete_reference_image({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.delete_reference_image(Google::Cloud::Vision::V1::DeleteReferenceImageRequest.new(
                                                 name: name
                                               ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.delete_reference_image request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.delete_reference_image request = Google::Cloud::Vision::V1::DeleteReferenceImageRequest.new(
        name: name
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_list_reference_images
    # Create request parameters
    parent = "hello world"
    page_size = 42
    page_token = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :list_reference_images
          has_options = !options.nil?
          has_fields =
            request.parent == "hello world" &&

            request.page_size == 42 &&

            request.page_token == "hello world"

          puts "invalid method call: #{name} (expected list_reference_images)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.list_reference_images parent: parent, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.list_reference_images(Google::Cloud::Vision::V1::ListReferenceImagesRequest.new(
                                                parent: parent, page_size: page_size, page_token: page_token
                                              ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.list_reference_images request = { parent: parent, page_size: page_size, page_token: page_token }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.list_reference_images request = Google::Cloud::Vision::V1::ListReferenceImagesRequest.new(
        parent: parent, page_size: page_size, page_token: page_token
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.list_reference_images({ parent: parent, page_size: page_size, page_token: page_token }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.list_reference_images(Google::Cloud::Vision::V1::ListReferenceImagesRequest.new(
                                                parent: parent, page_size: page_size, page_token: page_token
                                              ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.list_reference_images request = { parent: parent, page_size: page_size, page_token: page_token }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.list_reference_images request = Google::Cloud::Vision::V1::ListReferenceImagesRequest.new(
        parent: parent, page_size: page_size, page_token: page_token
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_get_reference_image
    # Create request parameters
    name = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :get_reference_image
          has_options = !options.nil?
          has_fields =
            request.name == "hello world"

          puts "invalid method call: #{name} (expected get_reference_image)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.get_reference_image name: name
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.get_reference_image(Google::Cloud::Vision::V1::GetReferenceImageRequest.new(
                                              name: name
                                            ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.get_reference_image request = { name: name }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.get_reference_image request = Google::Cloud::Vision::V1::GetReferenceImageRequest.new(
        name: name
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.get_reference_image({ name: name }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.get_reference_image(Google::Cloud::Vision::V1::GetReferenceImageRequest.new(
                                              name: name
                                            ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.get_reference_image request = { name: name }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.get_reference_image request = Google::Cloud::Vision::V1::GetReferenceImageRequest.new(
        name: name
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_add_product_to_product_set
    # Create request parameters
    name = "hello world"
    product = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :add_product_to_product_set
          has_options = !options.nil?
          has_fields =
            request.name == "hello world" &&

            request.product == "hello world"

          puts "invalid method call: #{name} (expected add_product_to_product_set)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.add_product_to_product_set name: name, product: product
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.add_product_to_product_set(Google::Cloud::Vision::V1::AddProductToProductSetRequest.new(
                                                     name: name, product: product
                                                   ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.add_product_to_product_set request = { name: name, product: product }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.add_product_to_product_set request = Google::Cloud::Vision::V1::AddProductToProductSetRequest.new(
        name: name, product: product
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.add_product_to_product_set({ name: name, product: product }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.add_product_to_product_set(Google::Cloud::Vision::V1::AddProductToProductSetRequest.new(
                                                     name: name, product: product
                                                   ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.add_product_to_product_set request = { name: name, product: product }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.add_product_to_product_set request = Google::Cloud::Vision::V1::AddProductToProductSetRequest.new(
        name: name, product: product
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_remove_product_from_product_set
    # Create request parameters
    name = "hello world"
    product = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :remove_product_from_product_set
          has_options = !options.nil?
          has_fields =
            request.name == "hello world" &&

            request.product == "hello world"

          puts "invalid method call: #{name} (expected remove_product_from_product_set)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.remove_product_from_product_set name: name, product: product
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.remove_product_from_product_set(Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest.new(
                                                          name: name, product: product
                                                        ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.remove_product_from_product_set request = { name: name, product: product }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.remove_product_from_product_set request = Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest.new(
        name: name, product: product
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.remove_product_from_product_set({ name: name, product: product }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.remove_product_from_product_set(Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest.new(
                                                          name: name, product: product
                                                        ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.remove_product_from_product_set request = { name: name, product: product }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.remove_product_from_product_set request = Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest.new(
        name: name, product: product
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_list_products_in_product_set
    # Create request parameters
    name = "hello world"
    page_size = 42
    page_token = "hello world"

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :list_products_in_product_set
          has_options = !options.nil?
          has_fields =
            request.name == "hello world" &&

            request.page_size == 42 &&

            request.page_token == "hello world"

          puts "invalid method call: #{name} (expected list_products_in_product_set)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.list_products_in_product_set name: name, page_size: page_size, page_token: page_token
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.list_products_in_product_set(Google::Cloud::Vision::V1::ListProductsInProductSetRequest.new(
                                                       name: name, page_size: page_size, page_token: page_token
                                                     ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.list_products_in_product_set request = { name: name, page_size: page_size, page_token: page_token }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.list_products_in_product_set request = Google::Cloud::Vision::V1::ListProductsInProductSetRequest.new(
        name: name, page_size: page_size, page_token: page_token
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.list_products_in_product_set({ name: name, page_size: page_size, page_token: page_token }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.list_products_in_product_set(Google::Cloud::Vision::V1::ListProductsInProductSetRequest.new(
                                                       name: name, page_size: page_size, page_token: page_token
                                                     ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.list_products_in_product_set request = { name: name, page_size: page_size, page_token: page_token }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.list_products_in_product_set request = Google::Cloud::Vision::V1::ListProductsInProductSetRequest.new(
        name: name, page_size: page_size, page_token: page_token
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_import_product_sets
    # Create request parameters
    parent = "hello world"
    input_config = {}

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :import_product_sets
          has_options = !options.nil?
          has_fields =
            request.parent == "hello world" &&

            Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::ImportProductSetsInputConfig) == request.input_config

          puts "invalid method call: #{name} (expected import_product_sets)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.import_product_sets parent: parent, input_config: input_config
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.import_product_sets(Google::Cloud::Vision::V1::ImportProductSetsRequest.new(
                                              parent: parent, input_config: input_config
                                            ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.import_product_sets request = { parent: parent, input_config: input_config }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.import_product_sets request = Google::Cloud::Vision::V1::ImportProductSetsRequest.new(
        parent: parent, input_config: input_config
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.import_product_sets({ parent: parent, input_config: input_config }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.import_product_sets(Google::Cloud::Vision::V1::ImportProductSetsRequest.new(
                                              parent: parent, input_config: input_config
                                            ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.import_product_sets request = { parent: parent, input_config: input_config }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.import_product_sets request = Google::Cloud::Vision::V1::ImportProductSetsRequest.new(
        parent: parent, input_config: input_config
      ), options = @options
      assert_equal @response, response
    end
  end

  def test_purge_products
    # Create request parameters
    product_set_purge_config = {}

    Gapic::ServiceStub.stub :new, @mock_stub do
      # Create client
      client = Google::Cloud::Vision::V1::ProductSearch::Client.new do |config|
        config.credentials = @test_channel
      end

      8.times do
        @mock_stub.expect :call_rpc, @response do |name, request, options|
          has_name = name == :purge_products
          has_options = !options.nil?
          has_fields =
            Gapic::Protobuf.coerce({}, to: Google::Cloud::Vision::V1::ProductSetPurgeConfig) == request.product_set_purge_config

          puts "invalid method call: #{name} (expected purge_products)" unless has_name
          puts "invalid options: #{options} vs #{@options}" unless has_options
          puts "invalid fields" unless has_fields

          has_name && has_options && has_fields
        end
      end

      # Call method (positional / hash)
      response = client.purge_products product_set_purge_config: product_set_purge_config
      assert_equal @response, response

      # Call method (positional / protobuf type)
      response = client.purge_products(Google::Cloud::Vision::V1::PurgeProductsRequest.new(
                                         product_set_purge_config: product_set_purge_config
                                       ))
      assert_equal @response, response

      # Call method (named / hash)
      response = client.purge_products request = { product_set_purge_config: product_set_purge_config }
      assert_equal @response, response

      # Call method (named / protobuf type)
      response = client.purge_products request = Google::Cloud::Vision::V1::PurgeProductsRequest.new(
        product_set_purge_config: product_set_purge_config
      )
      assert_equal @response, response

      # Call method with options (positional / hash)
      response = client.purge_products({ product_set_purge_config: product_set_purge_config }, @options)
      assert_equal @response, response

      # Call method with options (positional / protobuf type)
      response = client.purge_products(Google::Cloud::Vision::V1::PurgeProductsRequest.new(
                                         product_set_purge_config: product_set_purge_config
                                       ), @options)
      assert_equal @response, response

      # Call method with options (named / hash)
      response = client.purge_products request = { product_set_purge_config: product_set_purge_config }, options = @options
      assert_equal @response, response

      # Call method with options (named / protobuf type)
      response = client.purge_products request = Google::Cloud::Vision::V1::PurgeProductsRequest.new(
        product_set_purge_config: product_set_purge_config
      ), options = @options
      assert_equal @response, response
    end
  end
end
