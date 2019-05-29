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
