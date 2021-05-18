# frozen_string_literal: true

# Copyright 2021 Google LLC
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
          # The display mode for vanity pharma URLs.
          class VanityPharmaDisplayUrlModeEnum
            include ::Google::Protobuf::MessageExts
            extend ::Google::Protobuf::MessageExts::ClassMethods

            # Enum describing possible display modes for vanity pharma URLs.
            module VanityPharmaDisplayUrlMode
              # Not specified.
              UNSPECIFIED = 0

              # Used for return value only. Represents value unknown in this version.
              UNKNOWN = 1

              # Replace vanity pharma URL with manufacturer website url.
              MANUFACTURER_WEBSITE_URL = 2

              # Replace vanity pharma URL with description of the website.
              WEBSITE_DESCRIPTION = 3
            end
          end
        end
      end
    end
  end
end
