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
          # Possible ad serving statuses of a campaign.
          class AdServingOptimizationStatusEnum
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods

            # Enum describing possible serving statuses.
            module AdServingOptimizationStatus
              # No value has been specified.
              UNSPECIFIED = 0

              # The received value is not known in this version.
              #
              # This is a response-only value.
              UNKNOWN = 1

              # Ad serving is optimized based on CTR for the campaign.
              OPTIMIZE = 2

              # Ad serving is optimized based on CTR * Conversion for the campaign. If
              # the campaign is not in the conversion optimizer bidding strategy, it will
              # default to OPTIMIZED.
              CONVERSION_OPTIMIZE = 3

              # Ads are rotated evenly for 90 days, then optimized for clicks.
              ROTATE = 4

              # Show lower performing ads more evenly with higher performing ads, and do
              # not optimize.
              ROTATE_INDEFINITELY = 5

              # Ad serving optimization status is not available.
              UNAVAILABLE = 6
            end
          end
        end
      end
    end
  end
end
