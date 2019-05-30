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
          # An immutable specialization of an Advertising Channel.
          class AdvertisingChannelSubTypeEnum
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods

            # Enum describing the different channel subtypes.
            module AdvertisingChannelSubType
              # Not specified.
              UNSPECIFIED = 0

              # Used as a return value only. Represents value unknown in this version.
              UNKNOWN = 1

              # Mobile app campaigns for Search.
              SEARCH_MOBILE_APP = 2

              # Mobile app campaigns for Display.
              DISPLAY_MOBILE_APP = 3

              # AdWords express campaigns for search.
              SEARCH_EXPRESS = 4

              # AdWords Express campaigns for display.
              DISPLAY_EXPRESS = 5

              # Smart Shopping campaigns.
              SHOPPING_SMART_ADS = 6

              # Gmail Ad campaigns.
              DISPLAY_GMAIL_AD = 7

              # Smart display campaigns.
              DISPLAY_SMART_CAMPAIGN = 8

              # Video Outstream campaigns.
              VIDEO_OUTSTREAM = 9

              # Video TrueView for Action campaigns.
              VIDEO_ACTION = 10

              # Video campaigns with non-skippable video ads.
              VIDEO_NON_SKIPPABLE = 11
            end
          end
        end
      end
    end
  end
end
