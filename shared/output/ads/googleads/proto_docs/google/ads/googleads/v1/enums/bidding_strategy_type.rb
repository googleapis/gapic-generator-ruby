# frozen_string_literal: true

# Copyright 2020 Google LLC
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

              # Commission is an automatic bidding strategy in which the advertiser pays
              # a certain portion of the conversion value.
              COMMISSION = 16

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
              # This enum value is deprecated.
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
              # This enum value is deprecated.
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
