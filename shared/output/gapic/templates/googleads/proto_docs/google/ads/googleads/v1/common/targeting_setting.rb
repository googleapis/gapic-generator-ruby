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
          # Settings for the
          # <a href="https://support.google.com/google-ads/answer/7365594">
          # targeting related features</a>, at Campaign and AdGroup level.
          # @!attribute [rw] target_restrictions
          #   @return [Google::Ads::GoogleAds::V1::Common::TargetRestriction]
          #     The per-targeting-dimension setting to restrict the reach of your campaign
          #     or ad group.
          class TargetingSetting
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # The list of per-targeting-dimension targeting settings.
          # @!attribute [rw] targeting_dimension
          #   @return [ENUM(TargetingDimension)]
          #     The targeting dimension that these settings apply to.
          # @!attribute [rw] bid_only
          #   @return [Google::Protobuf::BoolValue]
          #     Indicates whether to restrict your ads to show only for the criteria you
          #     have selected for this targeting_dimension, or to target all values for
          #     this targeting_dimension and show ads based on your targeting in other
          #     TargetingDimensions. A value of 'true' means that these criteria will only
          #     apply bid modifiers, and not affect targeting. A value of 'false' means
          #     that these criteria will restrict targeting as well as applying bid
          #     modifiers.
          class TargetRestriction
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end
        end
      end
    end
  end
end
