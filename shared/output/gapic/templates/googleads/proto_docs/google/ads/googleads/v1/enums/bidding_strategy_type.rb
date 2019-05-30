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
        module Enums
          # Container for enum describing possible bidding strategy types.
          class BiddingStrategyTypeEnum
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods

            # Enum describing possible bidding strategy types.
            module BiddingStrategyType
              # Not specified.
              UNSPECIFIED = 0

              # Used for return value only. Represents value unknown in this version.
              UNKNOWN = 1

              # Enhanced CPC is a bidding strategy that raises bids for clicks
              # that seem more likely to lead to a conversion and lowers
              # them for clicks where they seem less likely.
              ENHANCED_CPC = 2

              # Manual click based bidding where user pays per click.
              MANUAL_CPC = 3

              # Manual impression based bidding
              # where user pays per thousand impressions.
              MANUAL_CPM = 4

              # A bidding strategy that pays a configurable amount per video view.
              MANUAL_CPV = 13

              # A bidding strategy that automatically maximizes number of conversions
              # given a daily budget.
              MAXIMIZE_CONVERSIONS = 10

              # An automated bidding strategy that automatically sets bids to maximize
              # revenue while spending your budget.
              MAXIMIZE_CONVERSION_VALUE = 11

              # Page-One Promoted bidding scheme, which sets max cpc bids to
              # target impressions on page one or page one promoted slots on google.com.
              PAGE_ONE_PROMOTED = 5

              # Percent Cpc is bidding strategy where bids are a fraction of the
              # advertised price for some good or service.
              PERCENT_CPC = 12

              # Target CPA is an automated bid strategy that sets bids
              # to help get as many conversions as possible
              # at the target cost-per-acquisition (CPA) you set.
              TARGET_CPA = 6

              # Target CPM is an automated bid strategy that sets bids to help get
              # as many impressions as possible at the target cost per one thousand
              # impressions (CPM) you set.
              TARGET_CPM = 14

              # An automated bidding strategy that sets bids so that a certain percentage
              # of search ads are shown at the top of the first page (or other targeted
              # location).
              TARGET_IMPRESSION_SHARE = 15

              # Target Outrank Share is an automated bidding strategy that sets bids
              # based on the target fraction of auctions where the advertiser
              # should outrank a specific competitor.
              TARGET_OUTRANK_SHARE = 7

              # Target ROAS is an automated bidding strategy
              # that helps you maximize revenue while averaging
              # a specific target Return On Average Spend (ROAS).
              TARGET_ROAS = 8

              # Target Spend is an automated bid strategy that sets your bids
              # to help get as many clicks as possible within your budget.
              TARGET_SPEND = 9
            end
          end
        end
      end
    end
  end
end
