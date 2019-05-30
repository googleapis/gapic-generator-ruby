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
        module Common
          # An automated bidding strategy that raises bids for clicks
          # that seem more likely to lead to a conversion and lowers
          # them for clicks where they seem less likely.
          class EnhancedCpc
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # Manual click-based bidding where user pays per click.
          # @!attribute [rw] enhanced_cpc_enabled
          #   @return [Google::Protobuf::BoolValue]
          #     Whether bids are to be enhanced based on conversion optimizer data.
          class ManualCpc
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # Manual impression-based bidding where user pays per thousand impressions.
          class ManualCpm
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # View based bidding where user pays per video view.
          class ManualCpv
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # An automated bidding strategy that sets bids to help get the most conversions
          # for your campaign while spending your budget.
          class MaximizeConversions
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # An automated bidding strategy which tries to maximize conversion value
          # given a daily budget.
          # @!attribute [rw] target_roas
          #   @return [Google::Protobuf::DoubleValue]
          #     The target return on ad spend (ROAS) option. If set, the bid strategy will
          #     maximize revenue while averaging the target return on ad spend. If the
          #     target ROAS is high, the bid strategy may not be able to spend the full
          #     budget. If the target ROAS is not set, the bid strategy will aim to
          #     achieve the highest possible ROAS for the budget.
          class MaximizeConversionValue
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # An automated bidding strategy which sets CPC bids to target impressions on
          # page one, or page one promoted slots on google.com.
          # @!attribute [rw] strategy_goal
          #   @return [ENUM(PageOnePromotedStrategyGoal)]
          #     The strategy goal of where impressions are desired to be shown on
          #     search result pages.
          # @!attribute [rw] cpc_bid_ceiling_micros
          #   @return [Google::Protobuf::Int64Value]
          #     Maximum bid limit that can be set by the bid strategy.
          #     The limit applies to all keywords managed by the strategy.
          # @!attribute [rw] bid_modifier
          #   @return [Google::Protobuf::DoubleValue]
          #     Bid multiplier to be applied to the relevant bid estimate (depending on
          #     the `strategy_goal`) in determining a keyword's new CPC bid.
          # @!attribute [rw] only_raise_cpc_bids
          #   @return [Google::Protobuf::BoolValue]
          #     Whether the strategy should always follow bid estimate changes, or only
          #     increase.
          #     If false, always sets a keyword's new bid to the current bid estimate.
          #     If true, only updates a keyword's bid if the current bid estimate is
          #     greater than the current bid.
          # @!attribute [rw] raise_cpc_bid_when_budget_constrained
          #   @return [Google::Protobuf::BoolValue]
          #     Whether the strategy is allowed to raise bids when the throttling
          #     rate of the budget it is serving out of rises above a threshold.
          # @!attribute [rw] raise_cpc_bid_when_quality_score_is_low
          #   @return [Google::Protobuf::BoolValue]
          #     Whether the strategy is allowed to raise bids on keywords with
          #     lower-range quality scores.
          class PageOnePromoted
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # An automated bid strategy that sets bids to help get as many conversions as
          # possible at the target cost-per-acquisition (CPA) you set.
          # @!attribute [rw] target_cpa_micros
          #   @return [Google::Protobuf::Int64Value]
          #     Average CPA target.
          #     This target should be greater than or equal to minimum billable unit based
          #     on the currency for the account.
          # @!attribute [rw] cpc_bid_ceiling_micros
          #   @return [Google::Protobuf::Int64Value]
          #     Maximum bid limit that can be set by the bid strategy.
          #     The limit applies to all keywords managed by the strategy.
          # @!attribute [rw] cpc_bid_floor_micros
          #   @return [Google::Protobuf::Int64Value]
          #     Minimum bid limit that can be set by the bid strategy.
          #     The limit applies to all keywords managed by the strategy.
          class TargetCpa
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # Target CPM (cost per thousand impressions) is an automated bidding strategy
          # that sets bids to optimize performance given the target CPM you set.
          class TargetCpm
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # An automated bidding strategy that sets bids so that a certain percentage of
          # search ads are shown at the top of the first page (or other targeted
          # location).
          # Next Id = 4
          # @!attribute [rw] location
          #   @return [ENUM(TargetImpressionShareLocation)]
          #     The targeted location on the search results page.
          # @!attribute [rw] location_fraction_micros
          #   @return [Google::Protobuf::Int64Value]
          #     The desired fraction of ads to be shown in the targeted location in micros.
          #     E.g. 1% equals 10,000.
          # @!attribute [rw] cpc_bid_ceiling_micros
          #   @return [Google::Protobuf::Int64Value]
          #     The highest CPC bid the automated bidding system is permitted to specify.
          #     This is a required field entered by the advertiser that sets the ceiling
          #     and specified in local micros.
          class TargetImpressionShare
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # An automated bidding strategy that sets bids based on the target fraction of
          # auctions where the advertiser should outrank a specific competitor.
          # @!attribute [rw] target_outrank_share_micros
          #   @return [Google::Protobuf::Int32Value]
          #     The target fraction of auctions where the advertiser should outrank the
          #     competitor.
          #     The advertiser outranks the competitor in an auction if either the
          #     advertiser appears above the competitor in the search results, or appears
          #     in the search results when the competitor does not.
          #     Value must be between 1 and 1000000, inclusive.
          # @!attribute [rw] competitor_domain
          #   @return [Google::Protobuf::StringValue]
          #     Competitor's visible domain URL.
          # @!attribute [rw] cpc_bid_ceiling_micros
          #   @return [Google::Protobuf::Int64Value]
          #     Maximum bid limit that can be set by the bid strategy.
          #     The limit applies to all keywords managed by the strategy.
          # @!attribute [rw] only_raise_cpc_bids
          #   @return [Google::Protobuf::BoolValue]
          #     Whether the strategy should always follow bid estimate changes,
          #     or only increase.
          #     If false, always set a keyword's new bid to the current bid estimate.
          #     If true, only updates a keyword's bid if the current bid estimate is
          #     greater than the current bid.
          # @!attribute [rw] raise_cpc_bid_when_quality_score_is_low
          #   @return [Google::Protobuf::BoolValue]
          #     Whether the strategy is allowed to raise bids on keywords with
          #     lower-range quality scores.
          class TargetOutrankShare
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # An automated bidding strategy that helps you maximize revenue while
          # averaging a specific target return on ad spend (ROAS).
          # @!attribute [rw] target_roas
          #   @return [Google::Protobuf::DoubleValue]
          #     Required. The desired revenue (based on conversion data) per unit of spend.
          #     Value must be between 0.01 and 1000.0, inclusive.
          # @!attribute [rw] cpc_bid_ceiling_micros
          #   @return [Google::Protobuf::Int64Value]
          #     Maximum bid limit that can be set by the bid strategy.
          #     The limit applies to all keywords managed by the strategy.
          # @!attribute [rw] cpc_bid_floor_micros
          #   @return [Google::Protobuf::Int64Value]
          #     Minimum bid limit that can be set by the bid strategy.
          #     The limit applies to all keywords managed by the strategy.
          class TargetRoas
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # An automated bid strategy that sets your bids to help get as many clicks
          # as possible within your budget.
          # @!attribute [rw] target_spend_micros
          #   @return [Google::Protobuf::Int64Value]
          #     The spend target under which to maximize clicks.
          #     A TargetSpend bidder will attempt to spend the smaller of this value
          #     or the natural throttling spend amount.
          #     If not specified, the budget is used as the spend target.
          # @!attribute [rw] cpc_bid_ceiling_micros
          #   @return [Google::Protobuf::Int64Value]
          #     Maximum bid limit that can be set by the bid strategy.
          #     The limit applies to all keywords managed by the strategy.
          class TargetSpend
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # A bidding strategy where bids are a fraction of the advertised price for
          # some good or service.
          # @!attribute [rw] cpc_bid_ceiling_micros
          #   @return [Google::Protobuf::Int64Value]
          #     Maximum bid limit that can be set by the bid strategy. This is
          #     an optional field entered by the advertiser and specified in local micros.
          #     Note: A zero value is interpreted in the same way as having bid_ceiling
          #     undefined.
          # @!attribute [rw] enhanced_cpc_enabled
          #   @return [Google::Protobuf::BoolValue]
          #     Adjusts the bid for each auction upward or downward, depending on the
          #     likelihood of a conversion. Individual bids may exceed
          #     cpc_bid_ceiling_micros, but the average bid amount for a campaign should
          #     not.
          class PercentCpc
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end
        end
      end
    end
  end
end
