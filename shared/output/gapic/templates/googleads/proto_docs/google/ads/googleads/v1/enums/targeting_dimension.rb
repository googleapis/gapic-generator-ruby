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
    module Googleads
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
