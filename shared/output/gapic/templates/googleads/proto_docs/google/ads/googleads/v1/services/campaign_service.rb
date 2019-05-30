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

module Google
  module Ads
    module GoogleAds
      module V1
        module Services
          # Request message for [CampaignService.GetCampaign][google.ads.googleads.v1.services.CampaignService.GetCampaign].
          # @!attribute [rw] resource_name
          #   @return [String]
          #     The resource name of the campaign to fetch.
          class GetCampaignRequest
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # Request message for [CampaignService.MutateCampaigns][google.ads.googleads.v1.services.CampaignService.MutateCampaigns].
          # @!attribute [rw] customer_id
          #   @return [String]
          #     The ID of the customer whose campaigns are being modified.
          # @!attribute [rw] operations
          #   @return [Google::Ads::GoogleAds::V1::Services::CampaignOperation]
          #     The list of operations to perform on individual campaigns.
          # @!attribute [rw] partial_failure
          #   @return [Boolean]
          #     If true, successful operations will be carried out and invalid
          #     operations will return errors. If false, all operations will be carried
          #     out in one transaction if and only if they are all valid.
          #     Default is false.
          # @!attribute [rw] validate_only
          #   @return [Boolean]
          #     If true, the request is validated but not executed. Only errors are
          #     returned, not results.
          class MutateCampaignsRequest
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # A single operation (create, update, remove) on a campaign.
          # @!attribute [rw] update_mask
          #   @return [Google::Protobuf::FieldMask]
          #     FieldMask that determines which resource fields are modified in an update.
          # @!attribute [rw] create
          #   @return [Google::Ads::GoogleAds::V1::Resources::Campaign]
          #     Create operation: No resource name is expected for the new campaign.
          # @!attribute [rw] update
          #   @return [Google::Ads::GoogleAds::V1::Resources::Campaign]
          #     Update operation: The campaign is expected to have a valid
          #     resource name.
          # @!attribute [rw] remove
          #   @return [String]
          #     Remove operation: A resource name for the removed campaign is
          #     expected, in this format:
          #
          #     `customers/{customer_id}/campaigns/{campaign_id}`
          class CampaignOperation
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # Response message for campaign mutate.
          # @!attribute [rw] partial_failure_error
          #   @return [Google::Rpc::Status]
          #     Errors that pertain to operation failures in the partial failure mode.
          #     Returned only when partial_failure = true and all errors occur inside the
          #     operations. If any errors occur outside the operations (e.g. auth errors),
          #     we return an RPC level error.
          # @!attribute [rw] results
          #   @return [Google::Ads::GoogleAds::V1::Services::MutateCampaignResult]
          #     All results for the mutate.
          class MutateCampaignsResponse
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # The result for the campaign mutate.
          # @!attribute [rw] resource_name
          #   @return [String]
          #     Returned for successful operations.
          class MutateCampaignResult
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end
        end
      end
    end
  end
end
