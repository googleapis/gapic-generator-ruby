# frozen_string_literal: true

# Copyright 2023 Google LLC
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
        module Enums
          # Container for enum describing goal towards which the bidding strategy of an
          # app campaign should optimize for.
          class AppCampaignBiddingStrategyGoalTypeEnum
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods

            # Goal type of App campaign BiddingStrategy.
            module AppCampaignBiddingStrategyGoalType
              # Not specified.
              UNSPECIFIED = 0

              # Used for return value only. Represents value unknown in this version.
              UNKNOWN = 1

              # Aim to maximize the number of app installs. The cpa bid is the
              # target cost per install.
              OPTIMIZE_INSTALLS_TARGET_INSTALL_COST = 2

              # Aim to maximize the long term number of selected in-app conversions from
              # app installs. The cpa bid is the target cost per install.
              OPTIMIZE_IN_APP_CONVERSIONS_TARGET_INSTALL_COST = 3

              # Aim to maximize the long term number of selected in-app conversions from
              # app installs. The cpa bid is the target cost per in-app conversion. Note
              # that the actual cpa may seem higher than the target cpa at first, since
              # the long term conversions haven’t happened yet.
              OPTIMIZE_IN_APP_CONVERSIONS_TARGET_CONVERSION_COST = 4

              # Aim to maximize all conversions' value, i.e. install + selected in-app
              # conversions while achieving or exceeding target return on advertising
              # spend.
              OPTIMIZE_RETURN_ON_ADVERTISING_SPEND = 5
            end
          end
        end
      end
    end
  end
end
