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
          # The text that will be displayed in display URL of the text ad when website
          # description is the selected display mode for vanity pharma URLs.
          class VanityPharmaTextEnum
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods

            # Enum describing possible text.
            module VanityPharmaText
              # Not specified.
              UNSPECIFIED = 0

              # Used for return value only. Represents value unknown in this version.
              UNKNOWN = 1

              # Prescription treatment website with website content in English.
              PRESCRIPTION_TREATMENT_WEBSITE_EN = 2

              # Prescription treatment website with website content in Spanish
              # (Sitio de tratamientos con receta).
              PRESCRIPTION_TREATMENT_WEBSITE_ES = 3

              # Prescription device website with website content in English.
              PRESCRIPTION_DEVICE_WEBSITE_EN = 4

              # Prescription device website with website content in Spanish (Sitio de
              # dispositivos con receta).
              PRESCRIPTION_DEVICE_WEBSITE_ES = 5

              # Medical device website with website content in English.
              MEDICAL_DEVICE_WEBSITE_EN = 6

              # Medical device website with website content in Spanish (Sitio de
              # dispositivos médicos).
              MEDICAL_DEVICE_WEBSITE_ES = 7

              # Preventative treatment website with website content in English.
              PREVENTATIVE_TREATMENT_WEBSITE_EN = 8

              # Preventative treatment website with website content in Spanish (Sitio de
              # tratamientos preventivos).
              PREVENTATIVE_TREATMENT_WEBSITE_ES = 9

              # Prescription contraception website with website content in English.
              PRESCRIPTION_CONTRACEPTION_WEBSITE_EN = 10

              # Prescription contraception website with website content in Spanish (Sitio
              # de anticonceptivos con receta).
              PRESCRIPTION_CONTRACEPTION_WEBSITE_ES = 11

              # Prescription vaccine website with website content in English.
              PRESCRIPTION_VACCINE_WEBSITE_EN = 12

              # Prescription vaccine website with website content in Spanish (Sitio de
              # vacunas con receta).
              PRESCRIPTION_VACCINE_WEBSITE_ES = 13
            end
          end
        end
      end
    end
  end
end
