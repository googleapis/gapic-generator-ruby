# Copyright 2019 Google LLC
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

module Google
  module Ads
    module GoogleAds
      module V1
        module Enums
          # The dimensions that can be targeted.
          class TargetingDimensionEnum
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods

            # Enum describing possible targeting dimensions.
            module TargetingDimension
              # Not specified.
              UNSPECIFIED = 0

              # Used for return value only. Represents value unknown in this version.
              UNKNOWN = 1

              # Keyword criteria, e.g. 'mars cruise'. KEYWORD may be used as a custom bid
              # dimension. Keywords are always a targeting dimension, so may not be set
              # as a target "ALL" dimension with TargetRestriction.
              KEYWORD = 2

              # Audience criteria, which include user list, user interest, custom
              # affinity,  and custom in market.
              AUDIENCE = 3

              # Topic criteria for targeting categories of content, e.g.
              # 'category::Animals>Pets' Used for Display and Video targeting.
              TOPIC = 4

              # Criteria for targeting gender.
              GENDER = 5

              # Criteria for targeting age ranges.
              AGE_RANGE = 6

              # Placement criteria, which include websites like 'www.flowers4sale.com',
              # as well as mobile applications, mobile app categories, YouTube videos,
              # and YouTube channels.
              PLACEMENT = 7

              # Criteria for parental status targeting.
              PARENTAL_STATUS = 8

              # Criteria for income range targeting.
              INCOME_RANGE = 9
            end
          end
        end
      end
    end
  end
end
