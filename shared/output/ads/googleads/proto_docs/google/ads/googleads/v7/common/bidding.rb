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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!


module Google
  module Ads
    module GoogleAds
      module V7
        module Common
          # Commission is an automatic bidding strategy in which the advertiser pays a
          # certain portion of the conversion value.
          # @!attribute [rw] commission_rate_micros
          #   @return [::Integer]
          #     Commission rate defines the portion of the conversion value that the
          #     advertiser will be billed. A commission rate of x should be passed into
          #     this field as (x * 1,000,000). For example, 106,000 represents a commission
          #     rate of 0.106 (10.6%).
          class Commission
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # An automated bidding strategy that raises bids for clicks
          # that seem more likely to lead to a conversion and lowers
          # them for clicks where they seem less likely.
          class EnhancedCpc
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # Manual click-based bidding where user pays per click.
          # @!attribute [rw] enhanced_cpc_enabled
          #   @return [::Boolean]
          #     Whether bids are to be enhanced based on conversion optimizer data.
          class ManualCpc
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # Manual impression-based bidding where user pays per thousand impressions.
          class ManualCpm
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # View based bidding where user pays per video view.
          class ManualCpv
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # An automated bidding strategy to help get the most conversions for your
          # campaigns while spending your budget.
          # @!attribute [rw] target_cpa
          #   @return [::Integer]
          #     The target cost per acquisition (CPA) option. This is the average amount
          #     that you would like to spend per acquisition.
          #
          #     This field is read-only.
          class MaximizeConversions
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # An automated bidding strategy to help get the most conversion value for your
          # campaigns while spending your budget.
          # @!attribute [rw] target_roas
          #   @return [::Float]
          #     The target return on ad spend (ROAS) option. If set, the bid strategy will
          #     maximize revenue while averaging the target return on ad spend. If the
          #     target ROAS is high, the bid strategy may not be able to spend the full
          #     budget. If the target ROAS is not set, the bid strategy will aim to
          #     achieve the highest possible ROAS for the budget.
          class MaximizeConversionValue
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # An automated bid strategy that sets bids to help get as many conversions as
          # possible at the target cost-per-acquisition (CPA) you set.
          # @!attribute [rw] target_cpa_micros
          #   @return [::Integer]
          #     Average CPA target.
          #     This target should be greater than or equal to minimum billable unit based
          #     on the currency for the account.
          # @!attribute [rw] cpc_bid_ceiling_micros
          #   @return [::Integer]
          #     Maximum bid limit that can be set by the bid strategy.
          #     The limit applies to all keywords managed by the strategy.
          # @!attribute [rw] cpc_bid_floor_micros
          #   @return [::Integer]
          #     Minimum bid limit that can be set by the bid strategy.
          #     The limit applies to all keywords managed by the strategy.
          class TargetCpa
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # Target CPM (cost per thousand impressions) is an automated bidding strategy
          # that sets bids to optimize performance given the target CPM you set.
          class TargetCpm
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # An automated bidding strategy that sets bids so that a certain percentage of
          # search ads are shown at the top of the first page (or other targeted
          # location).
          # @!attribute [rw] location
          #   @return [::Google::Ads::GoogleAds::V7::Enums::TargetImpressionShareLocationEnum::TargetImpressionShareLocation]
          #     The targeted location on the search results page.
          # @!attribute [rw] location_fraction_micros
          #   @return [::Integer]
          #     The desired fraction of ads to be shown in the targeted location in micros.
          #     E.g. 1% equals 10,000.
          # @!attribute [rw] cpc_bid_ceiling_micros
          #   @return [::Integer]
          #     The highest CPC bid the automated bidding system is permitted to specify.
          #     This is a required field entered by the advertiser that sets the ceiling
          #     and specified in local micros.
          class TargetImpressionShare
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # An automated bidding strategy that helps you maximize revenue while
          # averaging a specific target return on ad spend (ROAS).
          # @!attribute [rw] target_roas
          #   @return [::Float]
          #     Required. The desired revenue (based on conversion data) per unit of spend.
          #     Value must be between 0.01 and 1000.0, inclusive.
          # @!attribute [rw] cpc_bid_ceiling_micros
          #   @return [::Integer]
          #     Maximum bid limit that can be set by the bid strategy.
          #     The limit applies to all keywords managed by the strategy.
          # @!attribute [rw] cpc_bid_floor_micros
          #   @return [::Integer]
          #     Minimum bid limit that can be set by the bid strategy.
          #     The limit applies to all keywords managed by the strategy.
          class TargetRoas
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # An automated bid strategy that sets your bids to help get as many clicks
          # as possible within your budget.
          # @!attribute [rw] target_spend_micros
          #   @return [::Integer]
          #     The spend target under which to maximize clicks.
          #     A TargetSpend bidder will attempt to spend the smaller of this value
          #     or the natural throttling spend amount.
          #     If not specified, the budget is used as the spend target.
          #     This field is deprecated and should no longer be used. See
          #     https://ads-developers.googleblog.com/2020/05/reminder-about-sunset-creation-of.html
          #     for details.
          # @!attribute [rw] cpc_bid_ceiling_micros
          #   @return [::Integer]
          #     Maximum bid limit that can be set by the bid strategy.
          #     The limit applies to all keywords managed by the strategy.
          class TargetSpend
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end

          # A bidding strategy where bids are a fraction of the advertised price for
          # some good or service.
          # @!attribute [rw] cpc_bid_ceiling_micros
          #   @return [::Integer]
          #     Maximum bid limit that can be set by the bid strategy. This is
          #     an optional field entered by the advertiser and specified in local micros.
          #     Note: A zero value is interpreted in the same way as having bid_ceiling
          #     undefined.
          # @!attribute [rw] enhanced_cpc_enabled
          #   @return [::Boolean]
          #     Adjusts the bid for each auction upward or downward, depending on the
          #     likelihood of a conversion. Individual bids may exceed
          #     cpc_bid_ceiling_micros, but the average bid amount for a campaign should
          #     not.
          class PercentCpc
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods
          end
        end
      end
    end
  end
end
