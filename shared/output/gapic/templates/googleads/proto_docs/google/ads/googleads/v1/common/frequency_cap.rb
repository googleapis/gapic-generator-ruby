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
        module Common
          # A rule specifying the maximum number of times an ad (or some set of ads) can
          # be shown to a user over a particular time period.
          # @!attribute [rw] key
          #   @return [Google::Ads::Googleads::V1::Common::FrequencyCapKey]
          #     The key of a particular frequency cap. There can be no more
          #     than one frequency cap with the same key.
          # @!attribute [rw] cap
          #   @return [Google::Protobuf::Int32Value]
          #     Maximum number of events allowed during the time range by this cap.
          class FrequencyCapEntry
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # A group of fields used as keys for a frequency cap.
          # There can be no more than one frequency cap with the same key.
          # @!attribute [rw] level
          #   @return [ENUM(FrequencyCapLevel)]
          #     The level on which the cap is to be applied (e.g. ad group ad, ad group).
          #     The cap is applied to all the entities of this level.
          # @!attribute [rw] event_type
          #   @return [ENUM(FrequencyCapEventType)]
          #     The type of event that the cap applies to (e.g. impression).
          # @!attribute [rw] time_unit
          #   @return [ENUM(FrequencyCapTimeUnit)]
          #     Unit of time the cap is defined at (e.g. day, week).
          # @!attribute [rw] time_length
          #   @return [Google::Protobuf::Int32Value]
          #     Number of time units the cap lasts.
          class FrequencyCapKey
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end
        end
      end
    end
  end
end
