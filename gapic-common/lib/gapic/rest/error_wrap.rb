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

require "json"

module Gapic
  module Rest
    ##
    # Encapsulates methods to parse information from Faraday error's response
    # and augment Faraday errors with it to align with Google::Cloud::Error
    # expectations
    #
    module ErrorWrap
      class << self
        def augment_faraday_error! err
          return err unless err.response && err.response.is_a?(Hash)
          msg, status_code = try_parse_from_response err.response

          unless msg.nil? && code.nil?
            class << err
              attr_accessor :message, :status_code
            end

            pre_msg = "An error has occurred when making a REST request: "
            err.message = "#{pre_msg}#{msg}" unless msg.nil?

            err.status_code = status_code unless status_code.nil?
          end

          err
        end

        private

        # @param [Hash] response
        def try_parse_from_response response
          msg = nil
          code = nil

          code = response[:status] if response.key? :status

          if response.key?(:body) && response[:body]
            body_message, body_code = try_parse_from_body response[:body]

            msg ||= body_message
            code ||= body_code
          end

          [msg, code]
        end

        ##
        # Tries to get the error information from the JSON bodies
        #
        # @param [String] body_str
        # @return [Array<String>]
        def try_parse_from_body body_str
          body = JSON.parse body_str
          return [nil, nil] unless !body.nil? &&
                                    body.key?("error") &&
                                    body["error"].is_a?(Hash)

          message = body["error"]["message"] if body["error"].key? "message"
          code = body["error"]["message"] if body["error"].key? "code"

          [message, code]
        end
      end
    end
  end
end
