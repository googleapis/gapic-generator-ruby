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
          # Container for enum with 3-Tier brand safety suitability control.
          class BrandSafetySuitabilityEnum
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods

            # 3-Tier brand safety suitability control.
            module BrandSafetySuitability
              # Not specified.
              UNSPECIFIED = 0

              # Used for return value only. Represents value unknown in this version.
              UNKNOWN = 1

              # This option lets you show ads across all inventory on YouTube and video
              # partners that meet our standards for monetization. This option may be an
              # appropriate choice for brands that want maximum access to the full
              # breadth of videos eligible for ads, including, for example, videos that
              # have strong profanity in the context of comedy or a documentary, or
              # excessive violence as featured in video games.
              EXPANDED_INVENTORY = 2

              # This option lets you show ads across a wide range of content that's
              # appropriate for most brands, such as popular music videos, documentaries,
              # and movie trailers. The content you can show ads on is based on YouTube's
              # advertiser-friendly content guidelines that take into account, for
              # example, the strength or frequency of profanity, or the appropriateness
              # of subject matter like sensitive events. Ads won't show, for example, on
              # content with repeated strong profanity, strong sexual content, or graphic
              # violence.
              STANDARD_INVENTORY = 3

              # This option lets you show ads on a reduced range of content that's
              # appropriate for brands with particularly strict guidelines around
              # inappropriate language and sexual suggestiveness; above and beyond what
              # YouTube's advertiser-friendly content guidelines address. The videos
              # accessible in this sensitive category meet heightened requirements,
              # especially for inappropriate language and sexual suggestiveness. For
              # example, your ads will be excluded from showing on some of YouTube's most
              # popular music videos and other pop culture content across YouTube and
              # Google video partners.
              LIMITED_INVENTORY = 4
            end
          end
        end
      end
    end
  end
end
