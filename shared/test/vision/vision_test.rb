require "test_helper"

shared_dir = File.dirname File.dirname __dir__
$LOAD_PATH.unshift File.join(shared_dir, "output", "cloud", "vision_v1", "lib")
require "google/cloud/vision/v1"
require "gapic/grpc"

# These tests generally cover universe domain logic
class VisionTest < Minitest::Test
  def new_client
    Google::Cloud::Vision::V1::ImageAnnotator::Client.new do |config|
      config.credentials = :this_channel_is_insecure
      yield config if block_given?
    end
  end

  def new_rest_client
    Google::Cloud::Vision::V1::ImageAnnotator::Rest::Client.new do |config|
      config.credentials = :this_channel_is_insecure
      yield config if block_given?
    end
  end

  def endpoint_for client
    service_stub = client.instance_variable_get :@image_annotator_stub
    if service_stub.instance_of? ::Gapic::ServiceStub
      service_stub.endpoint
    else
      client_stub = service_stub.instance_variable_get :@client_stub
      client_stub.endpoint
    end
  end

  def test_default_ud_grpc
    client = new_client
    assert_equal "googleapis.com", client.universe_domain
    assert_equal "vision.googleapis.com", endpoint_for(client)
  end

  def test_default_ud_rest
    client = new_rest_client
    assert_equal "googleapis.com", client.universe_domain
    assert_equal "vision.googleapis.com", endpoint_for(client)
  end

  def test_configured_ud_grpc
    client = new_client do |config|
      config.universe_domain = "myuniverse1.com"
    end
    assert_equal "myuniverse1.com", client.universe_domain
    assert_equal "vision.myuniverse1.com", endpoint_for(client)
  end

  def test_configured_ud_rest
    client = new_rest_client do |config|
      config.universe_domain = "myuniverse2.com"
    end
    assert_equal "myuniverse2.com", client.universe_domain
    assert_equal "vision.myuniverse2.com", endpoint_for(client)
  end

  def test_env_ud_grpc
    ENV["GOOGLE_CLOUD_UNIVERSE_DOMAIN"] = "myuniverse3.com"
    client = new_client
    assert_equal "myuniverse3.com", client.universe_domain
    assert_equal "vision.myuniverse3.com", endpoint_for(client)
  ensure
    ENV["GOOGLE_CLOUD_UNIVERSE_DOMAIN"] = nil
  end

  def test_env_ud_rest
    ENV["GOOGLE_CLOUD_UNIVERSE_DOMAIN"] = "myuniverse4.com"
    client = new_rest_client
    assert_equal "myuniverse4.com", client.universe_domain
    assert_equal "vision.myuniverse4.com", endpoint_for(client)
  ensure
    ENV["GOOGLE_CLOUD_UNIVERSE_DOMAIN"] = nil
  end

  def test_custom_endpoint_grpc
    client = new_client do |config|
      config.universe_domain = "myuniverse5.com"
      config.endpoint = "custom-vision.myendpoint5.com"
    end
    assert_equal "myuniverse5.com", client.universe_domain
    assert_equal "custom-vision.myendpoint5.com", endpoint_for(client)
  end

  def test_custom_endpoint_rest
    client = new_rest_client do |config|
      config.universe_domain = "myuniverse6.com"
      config.endpoint = "custom-vision.myendpoint6.com"
    end
    assert_equal "myuniverse6.com", client.universe_domain
    assert_equal "custom-vision.myendpoint6.com", endpoint_for(client)
  end
end
