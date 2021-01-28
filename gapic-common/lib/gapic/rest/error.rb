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
    # Encapsulates HTTP error information from the
    # response to the failed REST request
    #
    class Error < StandardError
      attr_accessor :result, :status_code

      # @param [String] msg
      # @param [Hash] result
      def initialize msg = nil, result:
        super_msg = msg
        status_code = nil

        if result.key? :status
          status_code = result[:status]
        end

        if result.key? :body
          message, code = try_parse_from_body result[:body]

          pre_msg = msg.nil? ? "" : "#{msg}: "
          super_msg = "#{pre_msg}: #{message}" if message

          status_code ||= code
        end

        super super_msg
        @status_code = status_code
        @result = result
      end

      ##
      # Tries to get the error information from the JSON bodies
      #
      # @param [String] body_str
      # @return [Array<String>]
      def try_parse_from_body body_str
        body = JSON.parse body_str
        return [nil, nil] unless !body.nil? && body.key?("error")

        message = body["error"]["message"] if body["error"].key? "message"
        code = body["error"]["message"] if body["error"].key? "code"

        [message, code]
      end
    end
  end
end
