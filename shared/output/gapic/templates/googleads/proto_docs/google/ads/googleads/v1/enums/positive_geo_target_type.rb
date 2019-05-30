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
          # Container for enum describing possible positive geo target types.
          class PositiveGeoTargetTypeEnum
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods

            # The possible positive geo target types.
            module PositiveGeoTargetType
              # Not specified.
              UNSPECIFIED = 0

              # The value is unknown in this version.
              UNKNOWN = 1

              # Specifies that either Area of Interest (AOI) or
              # Location of Presence (LOP) may trigger the ad.
              DONT_CARE = 2

              # Specifies that the ad is triggered only if the user's Area of Interest
              # (AOI) matches.
              AREA_OF_INTEREST = 3

              # Specifies that the ad is triggered only if the user's
              # Location of Presence (LOP) matches.
              LOCATION_OF_PRESENCE = 4
            end
          end
        end
      end
    end
  end
end
