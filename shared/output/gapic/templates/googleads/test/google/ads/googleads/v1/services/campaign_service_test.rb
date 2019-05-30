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

require "google/ads/googleads/v1/services/campaign_service_pb"
require "google/ads/googleads/v1/services/campaign_service_services_pb"
require "google/ads/googleads/v1/services/campaign_service"

class CustomTestErrorV1 < StandardError; end
# Mock for the GRPC::ClientStub class.
class MockGrpcClientStubV1
  # @param expected_symbol [Symbol] the symbol of the grpc method to be mocked.
  # @param mock_method [Proc] The method that is being mocked.
  def initialize expected_symbol, mock_method
    @expected_symbol = expected_symbol
    @mock_method = mock_method
  end

  # This overrides the Object#method method to return the mocked method when the mocked method
  # is being requested. For methods that aren"t being tested, this method returns a proc that
  # will raise an error when called. This is to assure that only the mocked grpc method is being
  # called.
  #
  # @param symbol [Symbol] The symbol of the method being requested.
  # @return [Proc] The proc of the requested method. If the requested method is not being mocked
  #   the proc returned will raise when called.
  def method symbol
    return @mock_method if symbol == @expected_symbol

    # The requested method is not being tested, raise if it called.
    proc do
      raise "The method #{symbol} was unexpectedly called during the " \
        "test for #{@expected_symbol}."
    end
  end
end

class MockCampaignServiceCredentialsServices < Google::Ads::GoogleAds::V1::Services::CampaignService::Credentials
  def initialize method_name
    @method_name = method_name
  end

  def updater_proc
    proc do
      raise "The method `#{@method_name}` was trying to make a grpc request. This should not " \
          "happen since the grpc layer is being mocked."
    end
  end
end

describe Google::Ads::GoogleAds::V1::Services::CampaignService::Client do
  describe "get_campaign" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Ads::GoogleAds::V1::Services::CampaignService::Client#get_campaign."
    end

    it "invokes get_campaign without error" do
      # Create request parameters
      resource_name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Ads::GoogleAds::V1::Resources::Campaign

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Ads::GoogleAds::V1::Services::GetCampaignRequest, request
        assert_equal Google::Gax::Protobuf.coerce(resource_name, to: ), request.resource_name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :get_campaign, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_campaign"

      Google::Ads::GoogleAds::V1::Services::CampaignService::Stub.stub :new, mock_stub do
        Google::Ads::GoogleAds::V1::Services::CampaignService::Credentials.stub :default, mock_credentials do
          client = Google::Ads::GoogleAds::V1::Services::CampaignService::Client.new

          # Call method
          response = client.get_campaign resource_name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.get_campaign resource_name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes get_campaign with error" do
      # Create request parameters
      resource_name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Ads::GoogleAds::V1::Services::GetCampaignRequest, request
        assert_equal Google::Gax::Protobuf.coerce(resource_name, to: ), request.resource_name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :get_campaign, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_campaign"

      Google::Ads::GoogleAds::V1::Services::CampaignService::Stub.stub :new, mock_stub do
        Google::Ads::GoogleAds::V1::Services::CampaignService::Credentials.stub :default, mock_credentials do
          client = Google::Ads::GoogleAds::V1::Services::CampaignService::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.get_campaign resource_name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "mutate_campaigns" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Ads::GoogleAds::V1::Services::CampaignService::Client#mutate_campaigns."
    end

    it "invokes mutate_campaigns without error" do
      # Create request parameters
      customer_id = "hello world"
      operations = {}
      partial_failure = true
      validate_only = true

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Ads::GoogleAds::V1::Services::MutateCampaignsResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Ads::GoogleAds::V1::Services::MutateCampaignsRequest, request
        assert_equal Google::Gax::Protobuf.coerce(customer_id, to: ), request.customer_id
        assert_equal Google::Gax::Protobuf.coerce(operations, to: Google::Ads::GoogleAds::V1::Services::CampaignOperation), request.operations
        assert_equal Google::Gax::Protobuf.coerce(partial_failure, to: ), request.partial_failure
        assert_equal Google::Gax::Protobuf.coerce(validate_only, to: ), request.validate_only
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :mutate_campaigns, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "mutate_campaigns"

      Google::Ads::GoogleAds::V1::Services::CampaignService::Stub.stub :new, mock_stub do
        Google::Ads::GoogleAds::V1::Services::CampaignService::Credentials.stub :default, mock_credentials do
          client = Google::Ads::GoogleAds::V1::Services::CampaignService::Client.new

          # Call method
          response = client.mutate_campaigns customer_id, operations, partial_failure, validate_only

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.mutate_campaigns customer_id, operations, partial_failure, validate_only do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes mutate_campaigns with error" do
      # Create request parameters
      customer_id = "hello world"
      operations = {}
      partial_failure = true
      validate_only = true

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Ads::GoogleAds::V1::Services::MutateCampaignsRequest, request
        assert_equal Google::Gax::Protobuf.coerce(customer_id, to: ), request.customer_id
        assert_equal Google::Gax::Protobuf.coerce(operations, to: Google::Ads::GoogleAds::V1::Services::CampaignOperation), request.operations
        assert_equal Google::Gax::Protobuf.coerce(partial_failure, to: ), request.partial_failure
        assert_equal Google::Gax::Protobuf.coerce(validate_only, to: ), request.validate_only
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :mutate_campaigns, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "mutate_campaigns"

      Google::Ads::GoogleAds::V1::Services::CampaignService::Stub.stub :new, mock_stub do
        Google::Ads::GoogleAds::V1::Services::CampaignService::Credentials.stub :default, mock_credentials do
          client = Google::Ads::GoogleAds::V1::Services::CampaignService::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.mutate_campaigns customer_id, operations, partial_failure, validate_only
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end
end
