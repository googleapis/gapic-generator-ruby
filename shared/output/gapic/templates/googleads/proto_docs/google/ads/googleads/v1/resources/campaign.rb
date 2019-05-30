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
        module Resources
          # A campaign.
          # @!attribute [rw] resource_name
          #   @return [String]
          #     The resource name of the campaign.
          #     Campaign resource names have the form:
          #
          #     `customers/{customer_id}/campaigns/{campaign_id}`
          # @!attribute [rw] id
          #   @return [Google::Protobuf::Int64Value]
          #     The ID of the campaign.
          # @!attribute [rw] name
          #   @return [Google::Protobuf::StringValue]
          #     The name of the campaign.
          #
          #     This field is required and should not be empty when creating new
          #     campaigns.
          #
          #     It must not contain any null (code point 0x0), NL line feed
          #     (code point 0xA) or carriage return (code point 0xD) characters.
          # @!attribute [rw] status
          #   @return [ENUM(CampaignStatus)]
          #     The status of the campaign.
          #
          #     When a new campaign is added, the status defaults to ENABLED.
          # @!attribute [rw] serving_status
          #   @return [ENUM(CampaignServingStatus)]
          #     The ad serving status of the campaign.
          # @!attribute [rw] ad_serving_optimization_status
          #   @return [ENUM(AdServingOptimizationStatus)]
          #     The ad serving optimization status of the campaign.
          # @!attribute [rw] advertising_channel_type
          #   @return [ENUM(AdvertisingChannelType)]
          #     The primary serving target for ads within the campaign.
          #     The targeting options can be refined in `network_settings`.
          #
          #     This field is required and should not be empty when creating new
          #     campaigns.
          #
          #     Can be set only when creating campaigns.
          #     After the campaign is created, the field can not be changed.
          # @!attribute [rw] advertising_channel_sub_type
          #   @return [ENUM(AdvertisingChannelSubType)]
          #     Optional refinement to `advertising_channel_type`.
          #     Must be a valid sub-type of the parent channel type.
          #
          #     Can be set only when creating campaigns.
          #     After campaign is created, the field can not be changed.
          # @!attribute [rw] tracking_url_template
          #   @return [Google::Protobuf::StringValue]
          #     The URL template for constructing a tracking URL.
          # @!attribute [rw] url_custom_parameters
          #   @return [Google::Ads::Googleads::V1::Common::CustomParameter]
          #     The list of mappings used to substitute custom parameter tags in a
          #     `tracking_url_template`, `final_urls`, or `mobile_final_urls`.
          # @!attribute [rw] real_time_bidding_setting
          #   @return [Google::Ads::Googleads::V1::Common::RealTimeBiddingSetting]
          #     Settings for Real-Time Bidding, a feature only available for campaigns
          #     targeting the Ad Exchange network.
          # @!attribute [rw] network_settings
          #   @return [Google::Ads::Googleads::V1::Resources::Campaign::NetworkSettings]
          #     The network settings for the campaign.
          # @!attribute [rw] hotel_setting
          #   @return [Google::Ads::Googleads::V1::Resources::Campaign::HotelSettingInfo]
          #     The hotel setting for the campaign.
          # @!attribute [rw] dynamic_search_ads_setting
          #   @return [Google::Ads::Googleads::V1::Resources::Campaign::DynamicSearchAdsSetting]
          #     The setting for controlling Dynamic Search Ads (DSA).
          # @!attribute [rw] shopping_setting
          #   @return [Google::Ads::Googleads::V1::Resources::Campaign::ShoppingSetting]
          #     The setting for controlling Shopping campaigns.
          # @!attribute [rw] targeting_setting
          #   @return [Google::Ads::Googleads::V1::Common::TargetingSetting]
          #     Setting for targeting related features.
          # @!attribute [rw] geo_target_type_setting
          #   @return [Google::Ads::Googleads::V1::Resources::Campaign::GeoTargetTypeSetting]
          #     The setting for ads geotargeting.
          # @!attribute [rw] campaign_budget
          #   @return [Google::Protobuf::StringValue]
          #     The budget of the campaign.
          # @!attribute [rw] bidding_strategy_type
          #   @return [ENUM(BiddingStrategyType)]
          #     The type of bidding strategy.
          #
          #     A bidding strategy can be created by setting either the bidding scheme to
          #     create a standard bidding strategy or the `bidding_strategy` field to
          #     create a portfolio bidding strategy.
          #
          #     This field is read-only.
          # @!attribute [rw] start_date
          #   @return [Google::Protobuf::StringValue]
          #     The date when campaign started.
          #
          #     This field must not be used in WHERE clauses.
          # @!attribute [rw] end_date
          #   @return [Google::Protobuf::StringValue]
          #     The date when campaign ended.
          #
          #     This field must not be used in WHERE clauses.
          # @!attribute [rw] final_url_suffix
          #   @return [Google::Protobuf::StringValue]
          #     Suffix used to append query parameters to landing pages that are served
          #     with parallel tracking.
          # @!attribute [rw] frequency_caps
          #   @return [Google::Ads::Googleads::V1::Common::FrequencyCapEntry]
          #     A list that limits how often each user will see this campaign's ads.
          # @!attribute [rw] video_brand_safety_suitability
          #   @return [ENUM(BrandSafetySuitability)]
          #     3-Tier Brand Safety setting for the campaign.
          # @!attribute [rw] vanity_pharma
          #   @return [Google::Ads::Googleads::V1::Resources::Campaign::VanityPharma]
          #     Describes how unbranded pharma ads will be displayed.
          # @!attribute [rw] selective_optimization
          #   @return [Google::Ads::Googleads::V1::Resources::Campaign::SelectiveOptimization]
          #     Selective optimization setting for this campaign, which includes a set of
          #     conversion actions to optimize this campaign towards.
          # @!attribute [rw] tracking_setting
          #   @return [Google::Ads::Googleads::V1::Resources::Campaign::TrackingSetting]
          #     Campaign level settings for tracking information.
          # @!attribute [rw] bidding_strategy
          #   @return [Google::Protobuf::StringValue]
          #     Portfolio bidding strategy used by campaign.
          # @!attribute [rw] manual_cpc
          #   @return [Google::Ads::Googleads::V1::Common::ManualCpc]
          #     Standard Manual CPC bidding strategy.
          #     Manual click-based bidding where user pays per click.
          # @!attribute [rw] manual_cpm
          #   @return [Google::Ads::Googleads::V1::Common::ManualCpm]
          #     Standard Manual CPM bidding strategy.
          #     Manual impression-based bidding where user pays per thousand
          #     impressions.
          # @!attribute [rw] manual_cpv
          #   @return [Google::Ads::Googleads::V1::Common::ManualCpv]
          #     A bidding strategy that pays a configurable amount per video view.
          # @!attribute [rw] maximize_conversions
          #   @return [Google::Ads::Googleads::V1::Common::MaximizeConversions]
          #     Standard Maximize Conversions bidding strategy that automatically
          #     maximizes number of conversions given a daily budget.
          # @!attribute [rw] maximize_conversion_value
          #   @return [Google::Ads::Googleads::V1::Common::MaximizeConversionValue]
          #     Standard Maximize Conversion Value bidding strategy that automatically
          #     sets bids to maximize revenue while spending your budget.
          # @!attribute [rw] target_cpa
          #   @return [Google::Ads::Googleads::V1::Common::TargetCpa]
          #     Standard Target CPA bidding strategy that automatically sets bids to
          #     help get as many conversions as possible at the target
          #     cost-per-acquisition (CPA) you set.
          # @!attribute [rw] target_impression_share
          #   @return [Google::Ads::Googleads::V1::Common::TargetImpressionShare]
          #     Target Impression Share bidding strategy. An automated bidding strategy
          #     that sets bids to achieve a desired percentage of impressions.
          # @!attribute [rw] target_roas
          #   @return [Google::Ads::Googleads::V1::Common::TargetRoas]
          #     Standard Target ROAS bidding strategy that automatically maximizes
          #     revenue while averaging a specific target return on ad spend (ROAS).
          # @!attribute [rw] target_spend
          #   @return [Google::Ads::Googleads::V1::Common::TargetSpend]
          #     Standard Target Spend bidding strategy that automatically sets your bids
          #     to help get as many clicks as possible within your budget.
          # @!attribute [rw] percent_cpc
          #   @return [Google::Ads::Googleads::V1::Common::PercentCpc]
          #     Standard Percent Cpc bidding strategy where bids are a fraction of the
          #     advertised price for some good or service.
          # @!attribute [rw] target_cpm
          #   @return [Google::Ads::Googleads::V1::Common::TargetCpm]
          #     A bidding strategy that automatically optimizes cost per thousand
          #     impressions.
          class Campaign
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods

            # The network settings for the campaign.
            # @!attribute [rw] target_google_search
            #   @return [Google::Protobuf::BoolValue]
            #     Whether ads will be served with google.com search results.
            # @!attribute [rw] target_search_network
            #   @return [Google::Protobuf::BoolValue]
            #     Whether ads will be served on partner sites in the Google Search Network
            #     (requires `target_google_search` to also be `true`).
            # @!attribute [rw] target_content_network
            #   @return [Google::Protobuf::BoolValue]
            #     Whether ads will be served on specified placements in the Google Display
            #     Network. Placements are specified using the Placement criterion.
            # @!attribute [rw] target_partner_search_network
            #   @return [Google::Protobuf::BoolValue]
            #     Whether ads will be served on the Google Partner Network.
            #     This is available only to some select Google partner accounts.
            class NetworkSettings
              include Google::Protobuf::MessageExts
              extend Google::Protobuf::MessageExts::ClassMethods
            end

            # Campaign-level settings for hotel ads.
            # @!attribute [rw] hotel_center_id
            #   @return [Google::Protobuf::Int64Value]
            #     The linked Hotel Center account.
            class HotelSettingInfo
              include Google::Protobuf::MessageExts
              extend Google::Protobuf::MessageExts::ClassMethods
            end

            # The setting for controlling Dynamic Search Ads (DSA).
            # @!attribute [rw] domain_name
            #   @return [Google::Protobuf::StringValue]
            #     The Internet domain name that this setting represents, e.g., "google.com"
            #     or "www.google.com".
            # @!attribute [rw] language_code
            #   @return [Google::Protobuf::StringValue]
            #     The language code specifying the language of the domain, e.g., "en".
            # @!attribute [rw] use_supplied_urls_only
            #   @return [Google::Protobuf::BoolValue]
            #     Whether the campaign uses advertiser supplied URLs exclusively.
            # @!attribute [rw] feeds
            #   @return [Google::Protobuf::StringValue]
            #     The list of page feeds associated with the campaign.
            class DynamicSearchAdsSetting
              include Google::Protobuf::MessageExts
              extend Google::Protobuf::MessageExts::ClassMethods
            end

            # Represents a collection of settings related to ads geotargeting.
            # @!attribute [rw] positive_geo_target_type
            #   @return [ENUM(PositiveGeoTargetType)]
            #     The setting used for positive geotargeting in this particular campaign.
            # @!attribute [rw] negative_geo_target_type
            #   @return [ENUM(NegativeGeoTargetType)]
            #     The setting used for negative geotargeting in this particular campaign.
            class GeoTargetTypeSetting
              include Google::Protobuf::MessageExts
              extend Google::Protobuf::MessageExts::ClassMethods
            end

            # The setting for Shopping campaigns. Defines the universe of products that
            # can be advertised by the campaign, and how this campaign interacts with
            # other Shopping campaigns.
            # @!attribute [rw] merchant_id
            #   @return [Google::Protobuf::Int64Value]
            #     ID of the Merchant Center account.
            #     This field is required for create operations. This field is immutable for
            #     Shopping campaigns.
            # @!attribute [rw] sales_country
            #   @return [Google::Protobuf::StringValue]
            #     Sales country of products to include in the campaign.
            #     This field is required for Shopping campaigns. This field is immutable.
            #     This field is optional for non-Shopping campaigns, but it must be equal
            #     to 'ZZ' if set.
            # @!attribute [rw] campaign_priority
            #   @return [Google::Protobuf::Int32Value]
            #     Priority of the campaign. Campaigns with numerically higher priorities
            #     take precedence over those with lower priorities.
            #     This field is required for Shopping campaigns, with values between 0 and
            #     2, inclusive.
            #     This field is optional for Smart Shopping campaigns, but must be equal to
            #     3 if set.
            # @!attribute [rw] enable_local
            #   @return [Google::Protobuf::BoolValue]
            #     Enable local inventory ads. This field may only be set to false for Smart
            #     Shopping Campaigns.
            class ShoppingSetting
              include Google::Protobuf::MessageExts
              extend Google::Protobuf::MessageExts::ClassMethods
            end

            # Selective optimization setting for this campaign, which includes a set of
            # conversion actions to optimize this campaign towards.
            # @!attribute [rw] conversion_actions
            #   @return [Google::Protobuf::StringValue]
            #     The selected set of conversion actions for optimizing this campaign.
            class SelectiveOptimization
              include Google::Protobuf::MessageExts
              extend Google::Protobuf::MessageExts::ClassMethods
            end

            # Campaign level settings for tracking information.
            # @!attribute [rw] tracking_url
            #   @return [Google::Protobuf::StringValue]
            #     The url used for dynamic tracking.
            class TrackingSetting
              include Google::Protobuf::MessageExts
              extend Google::Protobuf::MessageExts::ClassMethods
            end

            # Describes how unbranded pharma ads will be displayed.
            # @!attribute [rw] vanity_pharma_display_url_mode
            #   @return [ENUM(VanityPharmaDisplayUrlMode)]
            #     The display mode for vanity pharma URLs.
            # @!attribute [rw] vanity_pharma_text
            #   @return [ENUM(VanityPharmaText)]
            #     The text that will be displayed in display URL of the text ad when
            #     website description is the selected display mode for vanity pharma URLs.
            class VanityPharma
              include Google::Protobuf::MessageExts
              extend Google::Protobuf::MessageExts::ClassMethods
            end
          end
        end
      end
    end
  end
end
