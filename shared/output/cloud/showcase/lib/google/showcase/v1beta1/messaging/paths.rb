# frozen_string_literal: true

# Copyright 2018 Google LLC
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
  module Showcase
    module V1beta1
      module Messaging
        module Paths
          ##
          # Create a fully-qualified Blurb resource string.
          #
          # The resource will be in the following format:
          #
          # `rooms/{room_id}/blurbs/{blurb_id}`
          #
          # @param room_id [String]
          # @param blurb_id [String]
          #
          # @return [String]
          def blurb_path room_id:, blurb_id:
            raise ArgumentError, "room_id is required" if room_id.nil?
            raise ArgumentError, "room_id cannot contain /" if %r{/}.match? room_id
            raise ArgumentError, "blurb_id is required" if blurb_id.nil?

            "rooms/#{room_id}/blurbs/#{blurb_id}"
          end

          ##
          # Create a fully-qualified Room resource string.
          #
          # The resource will be in the following format:
          #
          # `rooms/{room_id}`
          #
          # @param room_id [String]
          #
          # @return [String]
          def room_path room_id:
            raise ArgumentError, "room_id is required" if room_id.nil?

            "rooms/#{room_id}"
          end
        end
      end
    end
  end
end
